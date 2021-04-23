package testsample;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class TestSampleDAO {

	private DataSource ds;
	private Connection conn;  
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public TestSampleDAO() {
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

	
	 public String testFunc() throws SQLException {
		 
		 String str="";
		 try {
			 conn=ds.getConnection();
			 String sql= " select * from tbl_test ";
			 pstmt= conn.prepareStatement(sql);
			 rs= pstmt.executeQuery();
			 
			 if(rs.next()) {
				 str= rs.getString(1) + " " +rs.getInt(2);
			 }
			 
		 } finally {
			 close();
		 }
		 
		 return str;
	 }
	
}
