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

		@Override
		public List<CouponVO> getCouponList(String userid) throws SQLException {
			
			List<CouponVO> cpList = new ArrayList<>();
			
			try {
				conn = ds.getConnection();
				
				String sql = " select cpno, cpstatus, cpcontent, cpname, cpdiscount, issuedate, expirationdate "
								+ " from tbl_coupon "
								+ " where fk_userid = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setNString(1, userid);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					CouponVO cvo = new CouponVO();
					cvo.setCpno(rs.getString(1));
					cvo.setCpstatus(rs.getInt(2));
					cvo.setCpcontent(rs.getInt(3));
					cvo.setCpname(rs.getString(4));
					cvo.setCpdiscount(rs.getString(5));
					cvo.setIssuedate(rs.getString(6));
					cvo.setExpirationdate(rs.getString(7));
					
					cpList.add(cvo);	
				}
				
			} finally {
				close();
			}
			return cpList;
		}	   
	   
}


