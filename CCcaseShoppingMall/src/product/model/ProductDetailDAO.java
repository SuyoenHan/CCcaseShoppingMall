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
	
	@Override
	public List<Map<String, String>> selectProInfo() throws SQLException {
		
		List<Map<String, String>> proList = new ArrayList<>();
		
		try {
			
			conn = ds.getConnection();
			String sql = "select D.pnum, mname, productname, modelname, pcolor, price, ((1-salepercent)*price) as saleprice, pqty, to_char(pinputdate,'yyyy-mm-dd'), doption\n"+
					"from\n"+
					"(\n"+
					"select *\n"+
					"from tbl_product\n"+
					")P\n"+
					"join\n"+
					"(\n"+
					"select *\n"+
					"from tbl_category\n"+
					")C\n"+
					"on P.fk_cnum = C.cnum\n"+
					"join\n"+
					"(\n"+
					"select *\n"+
					"from tbl_mobilecompany\n"+
					")M\n"+
					"on P.fk_mnum = M.mnum\n"+
					"join\n"+
					"(\n"+
					"select *\n"+
					"from tbl_pdetail\n"+
					")D\n"+
					"on P.productid = D.fk_productid\n"+
					"join\n"+
					"(\n"+
					"select *\n"+
					"from tbl_spec\n"+
					") S\n"+
					"on D.fk_snum = S.snum\n"+
					"join\n"+
					"(\n"+
					"select *\n"+
					"from tbl_imagefile\n"+
					") I\n"+
					"on D.pnum = I.fk_pnum";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				Map<String, String> promap = new HashMap<>();
				
				promap.put("pnum", String.valueOf(rs.getString(1)));
				promap.put("productname", rs.getString(2)+"-"+rs.getString(3)+"-"+rs.getString(4));
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
	//////////////////백원빈 작업끝//////////////////
	
	
	
	
}
