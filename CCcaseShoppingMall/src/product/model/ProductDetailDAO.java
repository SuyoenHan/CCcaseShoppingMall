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
			if(rs != null)    {rs.close();    rs=null;}
			if(pstmt != null) {pstmt.close(); pstmt=null;}
			if(conn != null)  {conn.close();  conn=null;}
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
			
			conn = ds.getConnection();
			String sql =" select pnum, mname, pname, modelname, pcolor, price, saleprice, pqty, pinputdate, doption "+
						" from " + 
						" ( " + 
							" select rownum as rno, pnum, mname, pname, modelname, pcolor, price, saleprice, pqty, pinputdate, doption "+
							" from " + 
							" ( "+
								" select D.pnum, mname, pname, modelname, pcolor, price, ((1-salepercent)*price) as saleprice, pqty, to_char(pinputdate,'yyyy-mm-dd') as pinputdate,  doption "+
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
			pstmt.setString(1, pdetailmap.get("fk_productid"));
			pstmt.setString(2, pdetailmap.get("fk_productid"));
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
					pstmt.setString(1, pdetailmap.get("fk_productid"));
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


	
	
	
	
	
}
