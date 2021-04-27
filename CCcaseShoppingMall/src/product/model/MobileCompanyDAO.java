package product.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class MobileCompanyDAO implements InterMobileCompanyDAO {

	private DataSource ds;
	private Connection conn; 
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자 
	public MobileCompanyDAO() {
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

	// =========================== 한수연 시작 ======================================
	// 핸드폰제조회사코드에 해당하는 회사명 반환
	@Override
	public String getMname(String mnum) throws SQLException {
		
		String mname=null;
		
		try {
			conn=ds.getConnection();
			String sql= " select mname from tbl_mobilecompany where mnum= ? ";
			
			/*
			  	mnum==1000 인 경우 삼성
			  	mnum==2000 인 경우 애플
			  	mnum==3000 인 경우 LG
			*/
			
			pstmt= conn.prepareStatement(sql);
			pstmt.setInt(1,Integer.parseInt(mnum));
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				mname=rs.getString(1);
			}
			
		}finally {
			close();
		}
		
		return mname;
		
		 /*
		 	mname==null 인 경우 mnum에 해당하는 회사명이 존재하지 않음
		 	mname!=null 인 경우 mnum에 해당하는 회사명 존재
		 */
		
	} // end of public String getMname(String mnum) throws SQLException {-----------------
	// =========================== 한수연 끝 ======================================
}
