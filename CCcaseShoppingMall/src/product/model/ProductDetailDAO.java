package product.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ProductDetailDAO implements InterProductDetailDAO {

	private DataSource ds;
	private Connection conn; 
	private PreparedStatement pstmt;
	private ResultSet rs;
	private ResultSet rs2;
	
	
	// 생성자 
	public ProductDetailDAO() {
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
			if(rs != null)     {rs.close();    rs=null;}
			if(rs2 != null)    {rs2.close();    rs2=null;}
			if(pstmt != null)  {pstmt.close(); pstmt=null;}
			if(conn != null)   {conn.close();  conn=null;}
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}

	
	//////////////////백원빈 작업시작//////////////////
	
	///////////////////////
	// 전체제품 조회해오기
	@Override
	public List<Map<String, String>> selectProInfo(Map<String, String> paraMap) throws SQLException {
		
		List<Map<String, String>> proList = new ArrayList<>();
		
		try {
			
			conn = ds.getConnection(); //pnum = productid+제품상세테이블의 seq
			String sql =" select pnum, mname, pname, modelname, pcolor, price, saleprice, pqty, pinputdate, doption, productname, cname,salepercent,pimage1,productid "+
						" from " + 
						" ( " + 
							" select rownum as rno, pnum, mname, pname, modelname, pcolor, price, saleprice, pqty, pinputdate, doption, productname, cname,salepercent,pimage1,productid "+
							" from " + 
							" ( "+
								" select D.pnum, mname, pname, modelname, pcolor, price, ((1-salepercent)*price) as saleprice, pqty, to_char(pinputdate,'yyyy-mm-dd') as pinputdate,  doption, productname, cname,salepercent,pimage1, productid "+
								" from "+
								" ( "+
								" select * "+
								" from tbl_product "+
								" ) P "+
								" join "+
								" ( "+
								" select * "+
								" from tbl_category "+
								" ) C "+
								" on P.fk_cnum = C.cnum "+
								" join "+
								" ( "+
								" select * "+
								" from tbl_mobilecompany "+
								" ) M "+
								" on P.fk_mnum = M.mnum "+
								" join "+
								" ( "+
								" select * "+
								" from tbl_pdetail "+
								" ) D "+
								" on P.productid = D.fk_productid "+
								" join "+
								" ( "+
								" select * "+
								" from tbl_spec "+
								" ) S "+
								" on D.fk_snum = S.snum "+
								" join "+
								" ( "+
								" select * "+
								" from tbl_imagefile "+
								" ) I "+
								" on D.pnum = I.fk_pnum" +
								" ) V " ;
								
			String colname = paraMap.get("searchType");
			// jsp에서 받아오는 searchType의 value값 
			// pnum(상품번호 => 2000-2-15-2(mnum-cnum-seq_product_productid-seq_pdetail_pnum)     
			// mpmoname(상품명=> LG-아아아케이스-LGV50(mname-productname-modelname)
			// pcolor(색상=> yellow-(pcolor))
			

			String searchWord = paraMap.get("searchWord");					

			if(searchWord!= null && !searchWord.trim().isEmpty()) {
				
				if("pnum".equalsIgnoreCase(colname)) {
					sql+= " where "+colname+" like '%'||?||'%' ";
				}
				else if("pcolor".equalsIgnoreCase(colname)) {
					sql+= " where "+colname+" like '%'||?||'%' ";
				}
				else if("pname".equalsIgnoreCase(colname)){
					sql += " where "+colname+" like '%'||?||'%' ";
				}
				
			}
								
			sql +=	" ) T " +
					" where rno between ? and ? ";
			
			int currentShowPageNo= Integer.parseInt(paraMap.get("currentShowPageNo"));
			int sizePerPage= Integer.parseInt(paraMap.get("sizePerPage"));
			
			pstmt = conn.prepareStatement(sql);
			
			// 검색어가 있는 경우
			if(searchWord!= null && !searchWord.trim().isEmpty()) {

				pstmt.setString(1, searchWord);
				pstmt.setInt(2,(currentShowPageNo * sizePerPage) - (sizePerPage - 1) );
				pstmt.setInt(3,(currentShowPageNo * sizePerPage));
				
			}
			else { // 검색어가 없는 경우
				pstmt.setInt(1,(currentShowPageNo * sizePerPage) - (sizePerPage - 1) );
				pstmt.setInt(2,(currentShowPageNo * sizePerPage));
			}
			rs = pstmt.executeQuery();
			
			
			while(rs.next()) {
				
				Map<String, String> promap = new HashMap<>();
				
				promap.put("pnum", String.valueOf(rs.getString(1)));
				promap.put("pname", rs.getString(3));
				promap.put("pcolor", rs.getString(5));
				promap.put("originalprice", String.valueOf(rs.getInt(6)));
				promap.put("saleprice", String.valueOf(rs.getInt(7)));
				promap.put("pqty", String.valueOf(rs.getInt(8)));
				promap.put("pinputdate", rs.getString(9));
				promap.put("doption", String.valueOf(rs.getInt(10)));
				
				promap.put("mname", rs.getString(2));
				promap.put("productname", rs.getString(11));
				promap.put("cname", rs.getString(12));
				promap.put("salepercent", String.valueOf(rs.getDouble(13)));
				promap.put("pimage1", rs.getString(14));
				promap.put("productid", rs.getString(15));
				
				proList.add(promap);
				
			}// end of while(rs.next()) {
		
		} finally {
			close();
		}
		return proList;
	}	
	////////////////////////////////////////////////
	// 제품상세테이블로 insert하기 + 제품상세번호(primary)알아오기
	@Override
	public String insertProductDetail(Map<String, String> pdetailmap) throws SQLException {
		
		String getSequence = null;
		String getpnum = null;
		
		try {

			conn = ds.getConnection();
			String sql = " insert into tbl_pdetail(pnum,fk_productid,pname,pcolor,pqty,fk_snum,pcontent,pinputdate,doption) "+
						 " values(?||'-'||seq_pdetail_pnum.nextval,?,?,?,?,?,?,?,?) ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pdetailmap.get("productid"));
			pstmt.setString(2, pdetailmap.get("productid"));
			pstmt.setString(3, pdetailmap.get("mname")+"-"+pdetailmap.get("productname")+"-"+pdetailmap.get("modelname"));
			pstmt.setString(4, pdetailmap.get("pcolor"));
			pstmt.setInt(5, Integer.parseInt(pdetailmap.get("pqty")));
			pstmt.setInt(6, Integer.parseInt(pdetailmap.get("fk_snum")));
			pstmt.setString(7, pdetailmap.get("pcontent"));
			pstmt.setString(8, pdetailmap.get("pinputdate"));
			pstmt.setInt(9, Integer.parseInt(pdetailmap.get("doption")));
			
			int n = pstmt.executeUpdate();
			
			if(n==1) {
				
				sql = " select seq_pdetail_pnum.currval "+
					  " from dual ";
				
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					getSequence = rs.getString(1);
					
					sql = " select pnum "+
						  " from tbl_pdetail "+
						  " where pnum=?||'-'||? ";
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, pdetailmap.get("productid"));
					pstmt.setString(2, getSequence);

					rs = pstmt.executeQuery();
					
					if(rs.next()) {
						getpnum=rs.getString(1);
					}
				}		
			}		
		} finally {
			close();
		}	
		return getpnum;
	}
	//////////////////백원빈 작업끝//////////////////


	
	// ======================== 한수연 시작 ===========================
	
	// 배송옵션에 따른 제품정보 반환 메소드 (색상도 고려)
	@Override
	public List<Map<String, String>> selectPInfoByDelivery(String doption) throws SQLException {

		List<Map<String,String>> pInfoListByDOption= new ArrayList<>();
		
		try {
			
			conn=ds.getConnection();
			String sql= " select distinct productid, productname, modelname, pimage1, price, price*(1-salepercent) as saleprice, salepercent*100 as salepercent, cname "+
						" from tbl_product "+
						" join tbl_pdetail on productid=fk_productid "+
						" join tbl_category on fk_cnum=cnum " + 
						" where doption= ? ";
			
			pstmt= conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(doption));
			
			rs= pstmt.executeQuery();

			while(rs.next()) {
				Map<String,String> pInfoMapByDOption= new HashMap<>();
				
				pInfoMapByDOption.put("productid", rs.getString(1));
				pInfoMapByDOption.put("productname", rs.getString(2));
				pInfoMapByDOption.put("modelname", rs.getString(3));
				pInfoMapByDOption.put("pimage1", rs.getString(4));
				pInfoMapByDOption.put("price",  String.valueOf(rs.getInt(5)));
				pInfoMapByDOption.put("saleprice", String.valueOf(rs.getInt(6)));
				pInfoMapByDOption.put("salepercent", String.valueOf(rs.getInt(7)));
				pInfoMapByDOption.put("cname", rs.getString(8));
				
				
				// 색상알아오기 (존재하는 색상들을 문자열로 합쳐서 보내줌)
				sql= " select pcolor from tbl_pdetail "+
					 " join tbl_product on fk_productid= productid "+
					 " where productid= ? ";
				
				pstmt= conn.prepareStatement(sql);
				pstmt.setString(1, rs.getString(1));
				
				rs2= pstmt.executeQuery();
				
				String pcolor= ""; // 색상정보를 담아줄 문자열 
				while(rs2.next()) {
					pcolor+= rs2.getString(1)+" ";   // 문자열을 배열로 만들어서 사용할떄 공백을 -로 replace하고 배열로 나누기
				}
				
				pInfoMapByDOption.put("pcolor",pcolor);   // rs2 사용 끝 
				
				
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
					pInfoMapByDOption.put("spec","BEST/NEW");
				}
				else if(count==2) {
		
					switch (sum) {
						case 1:
							pInfoMapByDOption.put("spec","BEST/NEW");
							break;
						case 0:
							pInfoMapByDOption.put("spec","NEW");
							break;
						case -1:
							pInfoMapByDOption.put("spec","BEST");
							break;
					}
				}
				else if(count==1) {
					switch (sum) {
						case 0:
							pInfoMapByDOption.put("spec","BEST");
							break;
						case 1:
							pInfoMapByDOption.put("spec","NEW");
							break;
					}
				}
				
			
				pInfoListByDOption.add(pInfoMapByDOption);
				
			} // end of while---------------------
			
		} finally {
			close();
		}
		
		return pInfoListByDOption;
		
		/* 
			제품이 하나도 없는 경우: pInfoListByDOption.size() == 0
			제품이 하나이상 있는 경우: pInfoListByDOption.size() > 0  
		*/
		
		
	} // end of public List<Map<String, String>> SelectPInfoByDelivery(String doption) throws SQLException {------

	
	
	// productid가 주어진 경우, 이에 해당하는 제품정보 반환 메소드
	@Override
	public List<Map<String, String>> getOnePDetailInfo(String productid) throws SQLException {
		
		List<Map<String, String>> onePDetailInfoList= new ArrayList<>();;
	
		try {
			
			conn=ds.getConnection();
			String sql= " select pnum, pcolor, pcontent, doption "+
			            " from tbl_pdetail " +
			            " where fk_productid= ? ";
			pstmt= conn.prepareStatement(sql);			
			pstmt.setString(1, productid);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				
				Map<String,String> OnePDetailInfoMap= new HashMap<>();
				OnePDetailInfoMap.put("pnum", rs.getString(1));
				OnePDetailInfoMap.put("pcolor", rs.getString(2));
				OnePDetailInfoMap.put("pcontent", rs.getString(3));
				OnePDetailInfoMap.put("doption", String.valueOf(rs.getInt(4)));
				
				onePDetailInfoList.add(OnePDetailInfoMap);
			}
			
		}finally {
			close();
		}
				
		return onePDetailInfoList;

		/* 
		   productid에 해당하는 제품이 존재하지 않는경우: OnePDetailInfoList.size() == 0  
		   productid에 해당하는 제품이 존재하는 경우: OnePDetailInfoList.size() > 0  
		*/
	
	}

	// pnum이 주어진 경우, 이에 해당하는 배송옵션 반환 메소드
	@Override
	public int getDOptionByPnum(String pnum) throws SQLException {

		int dOption= -1;
	
		try {
			conn=ds.getConnection();
			String sql= " select doption from tbl_pdetail where pnum= ? ";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, pnum);
			
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				dOption= rs.getInt(1);
			}
			
		}finally {
			 close();
		}
		
		return dOption;
		
		/*
		 	존재하지 않는 pnum인 경우: dOption= -1    
		 	무료배송인 pnum인 경우:  dOption= 0   
		 	유료배송인 pnum인 경우: dOption= 1
		*/
	}


	// ======================== 한수연 끝 ===========================	
	
	
	
	
}
