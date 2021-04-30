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
	
	// 사용가능 쿠폰 개수
	@Override
	public int countAvalCpQty(String string) throws SQLException {
		int acnt = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select count(*) "
							+ " from tbl_coupon "
							+ " where cpstatus = ? ";
			
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setInt(1, 0);
			
			 rs = pstmt.executeQuery();
	          
	         rs.next();
			 
	         acnt = rs.getInt(1);
	         
		} finally {
			close();
		}
		
		return acnt;
	}

	// 사용불가 쿠폰 개수
	@Override
	public int countUnavalCpQty(String string) throws SQLException {
		int ucnt = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select count(*) "
							+ " from tbl_coupon "
							+ " where cpstatus = ? ";
			
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setInt(1, 1);
			
			 rs = pstmt.executeQuery();
	          
	         rs.next();
			 
	         ucnt = rs.getInt(1);
	         
		} finally {
			close();
		}
		
		return ucnt;
	}


	
	@Override
	public List<CouponVO> selectCouponList(Map<String, String> paraMap) throws SQLException {
		List<CouponVO> cpList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select cpno, cpstatus, cpcontent, cpname, cpdiscount, issuedate, expirationdate "
							+ " from "
							+ " ( "
							+ " select rownum as rno, cpno, cpstatus, cpcontent, cpname, cpdiscount, to_char(issuedate, 'yyyy-mm-dd') as issuedate, to_char(expirationdate, 'yyyy-mm-dd') as expirationdate "
							+ " from "
							+ " ( "
							+ " select cpno, cpstatus, cpcontent, cpname, cpdiscount, issuedate, expirationdate "
							+ " from tbl_coupon ";
			
			if("1".equals(paraMap.get("cpstatus"))) { // 사용완료 및 소멸 쿠폰목록 조회
				sql+= " where fk_userid = ? and (cpstatus= ? or cpstatus=2 ) ";
			}
			else { // 사용가능 쿠폰목록 조회
				sql+=" where fk_userid = ? and cpstatus= ? ";
			}
			
			sql+= " order by issuedate "
				+ " ) V "
				+ " ) T "
				+ " where rno between ? and ? ";
			
			int currentShowPageNo = Integer.parseInt( paraMap.get("currentShowPageNo") );
	        int sizePerPage = 10; // 한 페이지당 화면상에 보여줄 제품의 개수는 10 으로 한다.
			
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, paraMap.get("userid"));
	        pstmt.setInt(2, Integer.parseInt(paraMap.get("cpstatus")));
	        pstmt.setInt(3, (currentShowPageNo * sizePerPage) - (sizePerPage - 1)); //공식
			pstmt.setInt(4, (currentShowPageNo * sizePerPage) );
	        
	        rs = pstmt.executeQuery();
	        
	        while(rs.next()) {
				CouponVO cvo = new CouponVO();
				cvo.setCpno(rs.getString("cpno"));
				cvo.setCpstatus(rs.getInt("cpstatus"));
				cvo.setCpcontent(rs.getInt("cpcontent"));
				cvo.setCpname(rs.getString("cpname"));
				cvo.setCpdiscount(rs.getString("cpdiscount"));
				cvo.setIssuedate(rs.getString("issuedate"));
				cvo.setExpirationdate(rs.getString("expirationdate"));
				
				cpList.add(cvo);
			}
	        
		} finally {
			close();
		}
		
		return cpList;
	}
		
	   
	   
}


