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
	public int countAvalCpQty(String string, String userid) throws SQLException {
		int acnt = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select count(*) "
							+ " from tbl_coupon "
							+ " where cpstatus = ? and fk_userid = ? ";
			
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setInt(1, 0);
			 pstmt.setNString(2, userid);
			
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
	public int countUnavalCpQty(String string, String string1, String userid) throws SQLException {
		int ucnt = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select count(*) "
							+ " from tbl_coupon "
							+ " where fk_userid = ? and cpstatus in(?,?) ";
			
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, userid);
			 pstmt.setString(2, "1");
			 pstmt.setString(3, "2");
			 
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
			
			String sql = " select cpno, cpstatus, cpcontent, cpname, cpdiscount, issuedate, expirationdate, remain "
							+ " from "
							+ " ( "
							+ " select rownum as rno, cpno, cpstatus, cpcontent, cpname, cpdiscount, to_char(issuedate, 'yyyy-mm-dd') as issuedate, to_char(expirationdate, 'yyyy-mm-dd') as expirationdate, trunc(expirationdate-sysdate) as remain "
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
				cvo.setRemaindate(rs.getString("remain"));
				
				cpList.add(cvo);
				
			}
	        
		} finally {
			close();
		}
		
		return cpList;
	}
	
	
	///////////////////// 백원빈 시작 /////////////////////////////
	
    // 주문시 사용가능한 쿠폰 조회해오기
	@Override
	public List<Map<String, String>> selectAvailCoupon(String fk_userid) throws SQLException {
		
		List<Map<String, String>> couponList = new ArrayList<>();
		
		try {
			
			conn = ds.getConnection();
			String sql = " select cpno, cpname, cpdiscount "+
						 " from tbl_coupon "+
						 " where fk_userid= ? and cpstatus =0 ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fk_userid);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				Map<String,String> couponMap = new HashMap<>();
				couponMap.put("cpno", rs.getString(1));
				couponMap.put("cpname", rs.getString(2));
				couponMap.put("cpdiscount", String.valueOf(rs.getDouble(3)));
				couponList.add(couponMap);
			}
			
			
		} finally {
			close();
		}
		
		
		
		return couponList;
		
	}
	
	
	// 쿠폰번호를 가지고 할인율을 가져오는 메소드
	@Override
	public String getCouponsale(String cpno) throws SQLException {
		
		String cpdiscount ="";
		
		try {
			
			conn = ds.getConnection();
			String sql = " select cpdiscount "+
						 " from tbl_coupon "+
						 " where cpno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cpno);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {				
				cpdiscount = String.valueOf(rs.getDouble(1));
			}
			
		} finally {
			close();
		}

		return cpdiscount;
	}
	

	///////////////////// 백원빈 끝 /////////////////////////////

	
	// ==================== 한수연 시작 =========================
	
	// 이벤트로 발급된 쿠폰 insert 메소드 
	@Override
	public int insertCoupon(CouponVO cpvo) throws SQLException {

		int n=0;
		try {
			conn=ds.getConnection();
			String sql= " insert into tbl_coupon(cpno, fk_userid, cpstatus,cpcontent, cpname, cpdiscount) "+
						" values (seq_coupon_cpno.nextval, ?, ?, ?, ?, ? ) ";
			
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, cpvo.getFk_userid());
			pstmt.setInt(2, cpvo.getCpstatus());
			pstmt.setInt(3, cpvo.getCpcontent());
			pstmt.setString(4, cpvo.getCpname());
			pstmt.setDouble(5,Double.parseDouble(cpvo.getCpdiscount()));
			
			n= pstmt.executeUpdate();
			
		}finally{
			close();
		}
		
		return n;
		
		 /*
		 	insert 성공 시 n==1
		 	insert 실패 시 n==0
		 */
	}
  
	// ==================== 한수연 끝 =========================   
}


