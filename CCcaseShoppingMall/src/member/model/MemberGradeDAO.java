package member.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class MemberGradeDAO implements InterMemberGradeDAO {

	private DataSource ds;
	private Connection conn; 
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자 
	public MemberGradeDAO() {
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


	
	// ===================== 한수연 시작 ==========================
	
	// 회원아이디가 주어진 경우, 적립률 반환 
	@Override
	public double getPointPercent(String userid) throws SQLException {

		double pointPercent=0;
		try {
			
			conn=ds.getConnection();
			String sql= " select ppercent from tbl_grade "+
						" join (select fk_grade from tbl_member where userid= ? ) "+
						" on grade= fk_grade ";
			
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			rs=pstmt.executeQuery();
			if(rs.next())  pointPercent= rs.getDouble(1);
			
		}finally {
			close();
		}
		
		return pointPercent;
		
	} // end of public double getPointPercent(String userid) throws SQLException {-------
		
	// ===================== 한수연 끝 ==========================
	
}
