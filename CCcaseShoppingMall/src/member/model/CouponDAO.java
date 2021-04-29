package member.model;

import java.sql.*;
import java.util.*;

import javax.naming.*;
import javax.sql.DataSource;

public class CouponDAO implements InterCouponDAO {
	
	private DataSource ds;  
	private Connection conn; 
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public CouponDAO() {
		
		Context initContext;
		try {
			initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semioracle");
		
		} catch (NamingException e) {
			e.printStackTrace();
		}
		
	}
	
	// 사용한 자원을 반납하는 close() 메소드 생성하기 
	   private void close(){
	      try {
	         if(rs != null)    {rs.close();    rs=null;}
	         if(pstmt != null) {pstmt.close(); pstmt=null;}
	         if(conn != null)  {conn.close();  conn=null;} // 커넥션도 반납해주어야 함.!!! (튜브쓰고 반납)
	      
	      } catch(SQLException e) {
	         e.printStackTrace();
	      }
	   }

	// 아이디를 가지고 해당 쿠폰 정보 조회해오기
	@Override
	public CouponVO selectCouponByUserid(String userid) throws SQLException {
		
		CouponVO cvo = null;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select cpno, cpstatus, cpcontent, cpname, cpdiscount, issuedate, expirationdate "
							+ " from tbl_coupon "
							+ " where fk_userid= ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				String cpno = rs.getString(1);
				int cpstatus = rs.getInt(2);
				int cpcontent = rs.getInt(3);
				String cpname = rs.getString(4);
				String cpdiscount = rs.getString(5);
				String issuedate = rs.getString(6);
				String expirationdate = rs.getString(7);
				
				cvo = new CouponVO();
				cvo.setCpno(cpno);
				cvo.setCpstatus(cpstatus);
				cvo.setCpcontent(cpcontent);
				cvo.setCpname(cpname);
				cvo.setCpdiscount(cpdiscount);
				cvo.setIssuedate(issuedate);
				cvo.setExpirationdate(expirationdate);
				
			}// end of if-----------------------------
			
		} finally {
			close();
		}
		
		return cvo;
	}

	// 쿠폰 개수 조회하기
	@Override
	public int countCouponQty(String cpstatus) throws SQLException {
		
		int cnt = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select count(*) "
							+ " from tbl_coupon "
							+ " where cpstatus = ? ";
			
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, cpstatus);
			
			 rs = pstmt.executeQuery();
	          
	         rs.next();
			 
	         cnt = rs.getInt(1);
	         
		} finally {
			close();
		}
		
		return cnt;
	}

		
	   
	   
}


