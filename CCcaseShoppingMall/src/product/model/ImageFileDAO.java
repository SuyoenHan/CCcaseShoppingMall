package product.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ImageFileDAO implements InterImageFileDAO {
	
	private DataSource ds;
	private Connection conn; 
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자 
	public ImageFileDAO() {
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
	
	
	////////////////////백원빈 작업 시작 ///////////////////////////
	
	// 제품추가이미지 테이블로 insert하기
	@Override
	public int insertPlusImage(Map<String, String> plusimgmap) throws SQLException {
		
		int n = 0;
		
		try {
			
			conn = ds.getConnection();
			String sql = " insert into tbl_imagefile(imgno,fk_pnum,imgPlus1) "+
						 " values(seq_imagefile_imgno.nextval,?,?) ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,plusimgmap.get("getpnum"));
			pstmt.setString(2,plusimgmap.get("imgPlus1"));
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		
		
		return n;
	}
	
	////////////////////백원빈 작업 끝 ///////////////////////////
	

}
