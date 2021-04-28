package admin.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class AdminDAO implements InterAdminDAO {

	private DataSource ds;
	private Connection conn; 
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자 
	public AdminDAO() {
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

	// 로그인 관련 메소드
	@Override
	public AdminVO checkid(Map<String, String> paraMap) throws SQLException {
		AdminVO avo = null;
		
		try {
			
			conn = ds.getConnection();
			String sql = " select adminid,adminpwd,adminname from tbl_admin "
					    +" where adminid=? and adminpwd=? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("adminId"));
			pstmt.setString(2, paraMap.get("adminPwd"));
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				avo = new AdminVO();
				avo.setAdminid(rs.getString(1));
				avo.setAdminpwd(rs.getString(2));
				avo.setAdminname(rs.getString(3));
			}
			
		} finally {
			close();
		}
		
		return avo;
	}
	
}
