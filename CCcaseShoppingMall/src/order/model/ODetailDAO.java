package order.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ODetailDAO implements InterODetailDAO{

	
	private DataSource ds;
	private Connection conn; 
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자 
	public ODetailDAO() {
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
	
	
	// ================== 한수연 시작 ================
	
	// odetailno로 tbl_odetail에서 fk_pnum 가져오는 메소드
	@Override
	public String getPnumByOdetailNo(String odetailno) throws SQLException {

		String pnum="";
	
		try {
			conn=ds.getConnection();
			String sql= " select fk_pnum from tbl_odetail where odetailno= ? ";
			pstmt= conn.prepareStatement(sql);
			
			pstmt.setString(1, odetailno);
			rs= pstmt.executeQuery();
			
			if(rs.next()) pnum= rs.getString(1);
			
		}finally {
			close();
		}
	
		return pnum;
	}

	// ================== 한수연 끝 ================
	
}
