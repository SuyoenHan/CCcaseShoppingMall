package product.model;

import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ProductDAO implements InterProductDAO {

	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private ResultSet rs2;
	
	// 생성자 
	public ProductDAO() {
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semioracle");
		} catch(NamingException e) {
			e.printStackTrace();
		}
	}
	
	
	// 사용한 자원을 반납하는 close() 메소드 생성하기 
	private void close() {
		try {
			if(rs != null)    {rs.close();    rs=null;}
			if(rs2 != null)   {rs2.close();   rs2=null;}
			if(pstmt != null) {pstmt.close(); pstmt=null;}
			if(conn != null)  {conn.close();  conn=null;}
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}

	// =========================== 한수연 시작 ======================================
	// 핸드폰 제조사별  하드케이스 ,젤리케이스 ,범퍼케이스  개수 반환
	@Override
	public int calCntByCompany(int mnum, int cnum) throws SQLException {

		int cnt= 0;
		try {	
			conn=ds.getConnection();
			String sql=" select productid from tbl_product where fk_mnum= ? and fk_cnum= ? ";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, mnum);
			pstmt.setInt(2, cnum);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				cnt++;
			}
			
		}finally {
			close();
		}
		
		return cnt;  // 핸드폰 제조사별, 카테고리별 케이스 개수
	
	}// end of public int calCntByCompany(int mnum, int cnum) throws SQLException {------------------------

	
    // mnum과 cnum이 주어진 경우, 이에 해당하는 기종명 반환 (중복되는 기종명은 1번만 사용)
	@Override
	public List<String> getModelName(String mnum, String cnum) throws SQLException {

		List<String> modelNameList= new ArrayList<>();
		try {	
			conn=ds.getConnection();
			String sql=" select distinct modelname from tbl_product where fk_mnum= ? and fk_cnum= ? ";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(mnum));
			pstmt.setInt(2, Integer.parseInt(cnum));
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				modelNameList.add(rs.getString(1));
			}
			
		}finally {
			close();
		}
		
		return modelNameList;
	
		/* 
	 		해당회사와 카테고리에 일치하는 기종명이 하나도 없는 경우: modelNameList.size() == 0
	 		해당회사와 카테고리에 일치하는 기종명이 하나이상 있는 경우: modelNameList.size() > 0  
		*/
	
	
	} // end of public List<String> getModelName(String mnum, String cnum) throws SQLException {----

	
	// 제품 총페이지 개수 반환 메소드
	@Override
	public int selectTotalPage(Map<String, String> pageMap) throws SQLException {

		int totalPage= 0;
		
		try {
			conn=ds.getConnection();
			String sql= " select ceil(count(*)/?) from tbl_product ";
			
			if(pageMap.get("modelName")!=null  && pageMap.get("modelName")!="") {
				sql+=" where fk_mnum= ? and fk_cnum= ? and modelname like ? ";
			}
			else {
				sql+=" where fk_mnum= ? and fk_cnum= ? ";
			}
			
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(pageMap.get("sizePerPage")));
			pstmt.setInt(2, Integer.parseInt(pageMap.get("mnum")));
			pstmt.setInt(3, Integer.parseInt(pageMap.get("cnum")));
			
			if(pageMap.get("modelName")!=null && pageMap.get("modelName")!="") {
				pstmt.setString(4, pageMap.get("modelName"));
			}
			
			rs=pstmt.executeQuery();
			rs.next();
			
			totalPage= rs.getInt(1);
			
		} finally {
			close();
		}
		
		return totalPage;  // 총페이지 개수
	}// end of public int selectTotalPage(Map<String, String> pageMap) throws SQLException {------

	
	
	// 한페이지에 보여줄 제품정보 메소드
	@Override
	public List<Map<String, String>> selectPagingProduct(Map<String, String> pageMap) throws SQLException{
		
		List<Map<String,String>> pInfoList= new ArrayList<>();
		try {
			conn=ds.getConnection();
			
			String sql= " select productid, productname, modelname, pimage1, price, saleprice, salepercent "+
						" from "+
						" ( "+
						"   select rownum as rno, productid, productname, modelname, pimage1, price, saleprice, salepercent "+
						"   from " +
						"   ( " +
						"      select productid, productname, modelname, pimage1, price, price*(1-salepercent) as saleprice, salepercent*100 as salepercent "+
						"      from tbl_product " ;
						
			
			if(pageMap.get("modelName")!=null && pageMap.get("modelName")!="") {
				sql+=" where fk_mnum= ? and fk_cnum= ? and modelname like ? ";
			}
			else {
				sql+=" where fk_mnum= ? and fk_cnum= ? ";
			}
					
			sql+= "      order by productid ) P "+
				  " ) V " +
				  " where rno between ? and ? ";
			
			pstmt= conn.prepareStatement(sql);
			
			int currentShowPageNo= Integer.parseInt(pageMap.get("currentShowPageNo"));
			int sizePerPage= Integer.parseInt(pageMap.get("sizePerPage"));
			
			pstmt.setInt(1, Integer.parseInt(pageMap.get("mnum")));
			pstmt.setInt(2, Integer.parseInt(pageMap.get("cnum")));
			
			if(pageMap.get("modelName")!=null && pageMap.get("modelName")!="") {
				pstmt.setString(3, pageMap.get("modelName"));
				pstmt.setInt(4,(currentShowPageNo * sizePerPage) - (sizePerPage - 1) );
				pstmt.setInt(5,(currentShowPageNo * sizePerPage));  
			}
			else {
				pstmt.setInt(3,(currentShowPageNo * sizePerPage) - (sizePerPage - 1) );
				pstmt.setInt(4,(currentShowPageNo * sizePerPage));
			}

			rs= pstmt.executeQuery();
			
			
			while(rs.next()) {
		
				Map<String,String> pInfoMap= new HashMap<>();
				
				pInfoMap.put("productid", rs.getString(1));
				pInfoMap.put("productname", rs.getString(2));
				pInfoMap.put("modelname", rs.getString(3));
				pInfoMap.put("pimage1", rs.getString(4));
				pInfoMap.put("price",  String.valueOf(rs.getInt(5)));
				pInfoMap.put("saleprice", String.valueOf(rs.getInt(6)));
				pInfoMap.put("salepercent", String.valueOf(rs.getInt(7)));
				
				// 스펙알아오기
				sql= " select distinct nvl(fk_snum,-1) from tbl_pdetail "+
					 " join tbl_product on fk_productid=productid "+
					 " where productid= ? ";
				
				pstmt= conn.prepareStatement(sql);
				pstmt.setString(1, rs.getString(1));
				
				rs2= pstmt.executeQuery();
				
				// 나올 수 있는 스펙번호의 경우의 수 고려
				int count= 0;  
				int sum= 0;
				while(rs2.next()) {
					count++;
					sum+= rs2.getInt(1);
				}
				
				if(count==3) {
					pInfoMap.put("spec","BEST/NEW");
				}
				else if(count==2) {
		
					switch (sum) {
						case 1:
							pInfoMap.put("spec","BEST/NEW");
							break;
						case 0:
							pInfoMap.put("spec","NEW");
							break;
						case -1:
							pInfoMap.put("spec","BEST");
							break;
					}
				}
				else if(count==1) {
					switch (sum) {
						case 0:
							pInfoMap.put("spec","BEST");
							break;
						case 1:
							pInfoMap.put("spec","NEW");
							break;
					}
				}
				
				pInfoList.add(pInfoMap);
			}
			
		}finally {
			close();
		}
		
		return pInfoList;
		
		/* 
	 		일치하는 제품이 하나도 없는 경우: pInfoList.size() == 0
	 		일치하는 제품이 하나이상 있는 경우: pInfoList.size() > 0  
	   */
		
	} // end of public List<Map<String, String>> selectPagingProduct(Map<String, String> pageMap) throws SQLException{--------

	
	// mnum, cnum이 주어진 경우, 모델그룹별 개수 반환
	@Override
	public List<Map<String,String>> getCntByModel (String mnum, String cnum) throws SQLException{

		List<Map<String,String>> cntList= new ArrayList<>();
		
		try {
			conn=ds.getConnection();
			String sql= " select modelname, nvl(count(*),0) from tbl_product "+
						" where fk_mnum= ? and fk_cnum= ? "+
						" group by modelName ";
					
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(mnum));
			pstmt.setInt(2, Integer.parseInt(cnum));
			
			rs=pstmt.executeQuery();

			while(rs.next()) {
				
				Map<String,String> cntMap= new HashMap<>();
				cntMap.put("modelName", rs.getString(1));
				cntMap.put("cnt", String.valueOf(rs.getInt(2)));
				
				cntList.add(cntMap);
			}
			
		} finally {
			close();
		}

		return cntList;
		
		/* 
 			제품이 하나도 없는 경우: cntList.size() == 0
 			제품이 하나이상 있는 경우: cntList.size() > 0  
		 */
		
	} // end of public List<Map<String,String>> getCntByModel (String mnum, String cnum) throws SQLException{-----

	
	// snum이 주어진 경우, 이에 해당하는 제품정보 반환 메소드
	@Override
	public List<Map<String, String>> selectPInfoBySpec(String snum) throws SQLException {
		
		List<Map<String,String>> pInfoListBySpec= new ArrayList<>();
		
		try {
			
			conn=ds.getConnection();
			String sql= " select distinct productid, productname, modelname, pimage1, price, price*(1-salepercent) as saleprice, salepercent*100 as salepercent, cname "+
						" from tbl_product "+
						" join tbl_pdetail on productid=fk_productid "+
						" join tbl_category on fk_cnum=cnum " + 
						" where fk_snum= ? ";
			
			pstmt= conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(snum));
			
			rs= pstmt.executeQuery();

			while(rs.next()) {
				Map<String,String> pInfoMapBySpec= new HashMap<>();
				
				pInfoMapBySpec.put("productid", rs.getString(1));
				pInfoMapBySpec.put("productname", rs.getString(2));
				pInfoMapBySpec.put("modelname", rs.getString(3));
				pInfoMapBySpec.put("pimage1", rs.getString(4));
				pInfoMapBySpec.put("price",  String.valueOf(rs.getInt(5)));
				pInfoMapBySpec.put("saleprice", String.valueOf(rs.getInt(6)));
				pInfoMapBySpec.put("salepercent", String.valueOf(rs.getInt(7)));
				pInfoMapBySpec.put("cname", rs.getString(8));
				
				// 스펙알아오기
				sql= " select distinct nvl(fk_snum,-1) from tbl_pdetail "+
					 " join tbl_product on fk_productid=productid "+
					 " where productid= ? ";
				
				pstmt= conn.prepareStatement(sql);
				pstmt.setString(1, rs.getString(1));
				
				rs2= pstmt.executeQuery();
				
				// 나올 수 있는 스펙번호의 경우의 수 고려
				int count= 0;  
				int sum= 0;
				while(rs2.next()) {
					count++;
					sum+= rs2.getInt(1);
				}
				
				if(count==3) {
					pInfoMapBySpec.put("spec","BEST/NEW");
				}
				else if(count==2) {
		
					switch (sum) {
						case 1:
							pInfoMapBySpec.put("spec","BEST/NEW");
							break;
						case 0:
							pInfoMapBySpec.put("spec","NEW");
							break;
						case -1:
							pInfoMapBySpec.put("spec","BEST");
							break;
					}
				}
				else if(count==1) {
					switch (sum) {
						case 0:
							pInfoMapBySpec.put("spec","BEST");
							break;
						case 1:
							pInfoMapBySpec.put("spec","NEW");
							break;
					}
				}
				
				pInfoListBySpec.add(pInfoMapBySpec);
			}
		}finally {
			close();
		}
		return pInfoListBySpec;
		
		/* 
			제품이 하나도 없는 경우: pInfoListBySpec.size() == 0
			제품이 하나이상 있는 경우: pInfoListBySpec.size() > 0  
		*/
		
	} // end of public List<Map<String, String>> selectPInfoBySpec(String snum) throws SQLException {---------

	
	
	// productid가 주어진 경우, 이에 해당하는 제품정보 반환 메소드
	@Override
	public Map<String, String> getOnePInfo(String productid) throws SQLException {

		Map<String, String> onePInfoMap= null;
		
		try {
		
			conn=ds.getConnection();
			String sql= " select productid, productname, modelname, pimage1, price, price*(1-salepercent) as saleprice, salepercent*100 as salepercent, cname "+
						" from tbl_product "+
						" join tbl_category on fk_cnum=cnum "+
						" where productid= ? ";
		    pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, productid);		
		    
			rs= pstmt.executeQuery();
			
		    if(rs.next()) {
		    	
		    	onePInfoMap= new HashMap<>();
		    	onePInfoMap.put("productid", rs.getString(1));
		    	onePInfoMap.put("productname", rs.getString(2));
		    	onePInfoMap.put("modelname", rs.getString(3));
		    	onePInfoMap.put("pimage1", rs.getString(4));
		    	onePInfoMap.put("price", String.valueOf(rs.getInt(5)));
		    	onePInfoMap.put("saleprice", String.valueOf(rs.getInt(6)));
		    	onePInfoMap.put("salepercent", String.valueOf(rs.getInt(7)));
		    	onePInfoMap.put("cname", rs.getString(8));
		    }
			
			
		}finally {
			close();
		}
		
		return onePInfoMap;
		
		/* 
		   productid에 해당하는 제품이 존재하지 않는경우: null
		   productid에 해당하는 제품이 존재하는 경우: onePInfoMap   
		*/
	
	}


	
	
	// =========================== 한수연 끝 ======================================

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	
	////////////////////////////////// 백원빈 시작 /////////////////////////////////////////////
	// product테이블에 insert하는 메소드
	@Override
	public String insertProduct(Map<String, String> promap) throws SQLException {
		
		String getSequence = null;
		String getfkproductid = null;

		try {
			
			conn = ds.getConnection();
			String sql = "insert into tbl_product(productid,productname,modelname,fk_mnum,fk_cnum,price,salepercent,pimage1)\n"+
					     "values(?||'-'||?||'-'||seq_product_productid.nextval, ?, ?,?,?,?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, promap.get("fk_mnum"));
			pstmt.setString(2, promap.get("fk_cnum"));
			pstmt.setString(3, promap.get("productname"));
			pstmt.setString(4, promap.get("modelname"));
			pstmt.setInt(5, Integer.parseInt(promap.get("fk_mnum")));
			pstmt.setInt(6, Integer.parseInt(promap.get("fk_cnum")));
			pstmt.setInt(7, Integer.parseInt(promap.get("price")));
			pstmt.setDouble(8, Double.parseDouble(promap.get("salepercent")));
			pstmt.setString(9, promap.get("pimage1"));
			
			int n = pstmt.executeUpdate();
			
			if(n==1) {
				
				sql = " select seq_product_productid.currval "+
					  " from dual ";
				
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					getSequence = rs.getString(1);
					
					sql = " select productid "+
						  " from tbl_product "+
						  " where productid=?||'-'||?||'-'||? ";
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, promap.get("fk_mnum"));
					pstmt.setString(2, promap.get("fk_cnum"));
					pstmt.setString(3, getSequence);
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
						getfkproductid=rs.getString(1);
					}
				}
				
			}
			
		} finally {
			close();
		}
		
		return getfkproductid;
	}
	
	// 기종명 조회해오기(select)
	@Override
	public List<String> getgijongname() throws SQLException {
		
		List<String> gijongList = new ArrayList<>();
		
		try {
			
			conn = ds.getConnection();
			
			// 중복을 제거하는 distinct이용
			String sql = "select distinct modelname "+
						 "from tbl_product ";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {

				gijongList.add(rs.getString(1));
			}
			
			
		} finally {
			close();
		}
		
		return gijongList;
	}
	
	// totalPage 알아오기
	@Override
	public int getTotalPage(Map<String, String> paraMap) throws SQLException {
		
		
		int totalPage=0;
		
		try {
			conn= ds.getConnection();
			String sql= " select ceil(count(*)/?) " + 
					    " from tbl_pdetail ";
			
		
			pstmt= conn.prepareStatement(sql); // int로 안바꿔도 오라클에서 호환사용된다.
			pstmt.setInt(1, Integer.parseInt(paraMap.get("sizePerPage")));
			
			rs=pstmt.executeQuery();
			
			rs.next();
			totalPage= rs.getInt(1);
			
		} finally {
			close();
		}
		
		return totalPage;
		
		
	}
	//////////////////////////////////백원빈 끝/////////////////////////////////////////////



	


	
}
