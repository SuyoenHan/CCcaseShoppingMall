package admin.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
	
	///////////////////////// 백원빈 시작 ///////////////////////////////
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

	// 전일 총 판매량 알아오는 메소드
	@Override
	public int getYesterdayPdQty() throws SQLException {
		
		int n = 0;
		
		try {
			
			conn = ds.getConnection();
			String sql =" select nvl(sum(odqty),0) "+
						" from tbl_order join tbl_odetail "+
						" on orderno = fk_orderno "+
						" where depositdate between sysdate-2 and sysdate-1 ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
		
			if(rs.next()) {
				n=rs.getInt(1);
			}
			
		} finally {
			close();
		}
		
		return n;
	}

	// 금일 총 판매량 알아오는 메소드
	@Override
	public int getTodayPdQty() throws SQLException {
		
		int n = 0;
		
		try {
			
			conn = ds.getConnection();
			String sql =" select nvl(sum(odqty),0) "+
						" from tbl_order join tbl_odetail "+
						" on orderno = fk_orderno "+
						" where depositdate between sysdate-1 and sysdate ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
		
			if(rs.next()) {
				n=rs.getInt(1);
			}
			
		} finally {
			close();
		}
		
		return n;
	}

	// 전일 총 판매액(입금일 기준) 메소드
	@Override
	public List<Map<String,Integer>> getYesterProfitList() throws SQLException {
		
		List<Map<String,Integer>> getYesterProfitList = new ArrayList<>(); 
		
		try {
			
			conn = ds.getConnection();
			String sql =" select price, odqty "+
						" from tbl_product join tbl_pdetail "+
						" on productid = fk_productid "+
						" join tbl_odetail "+
						" on pnum = fk_pnum "+
						" join tbl_order "+
						" on orderno = fk_orderno "+
						" where depositdate between sysdate-2 and sysdate-1 ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
		
			while(rs.next()) {
				Map<String,Integer> yProfitMap = new HashMap<>();
				yProfitMap.put("yPrice", rs.getInt(1));
				yProfitMap.put("yOdqty", rs.getInt(2));
				
				getYesterProfitList.add(yProfitMap);
			}
			
		} finally {
			close();
		}
		
		return getYesterProfitList;
	}

	// 금일 총 판매액 알아오는 메소드
	@Override
	public List<Map<String, Integer>> getTodayProfitList() throws SQLException {
		
		List<Map<String,Integer>> getTodayProfitList = new ArrayList<>(); 
		
		try {
			
			conn = ds.getConnection();
			String sql =" select price, odqty "+
						" from tbl_product join tbl_pdetail "+
						" on productid = fk_productid "+
						" join tbl_odetail "+
						" on pnum = fk_pnum "+
						" join tbl_order "+
						" on orderno = fk_orderno "+
						" where depositdate between sysdate-1 and sysdate ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
		
			while(rs.next()) {
				Map<String,Integer> tProfitMap = new HashMap<>();
				tProfitMap.put("tPrice", rs.getInt(1));
				tProfitMap.put("tOdqty", rs.getInt(2));
				
				getTodayProfitList.add(tProfitMap);
			}
		
		} finally {
			close();
		}
		
		return getTodayProfitList;
	}

	// 금일 케이스별 판매량
	@Override
	public int getCaseSaleQty(int cnum) throws SQLException {
		
		int qty = 0;
		
		try {
			
			conn = ds.getConnection();
			String sql =" select sum(odqty) "+
						" from tbl_pdetail join tbl_odetail "+
						" on pnum = fk_pnum "+
						" join tbl_product "+
						" on productid = fk_productid "+
						" group by fk_cnum "+
						" having fk_cnum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cnum);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				qty = rs.getInt(1);
			}
			
			
		} finally {
			close();
		}
		
		
		return qty;
	}

	
	// 회원 케이스별 회원수 알아오기
	@Override
	public int getCntMember(String sAllMemberCnt) throws SQLException {
		
		int memberCnt = 0;
		
		try {
			conn = ds.getConnection();
			String sql = " select count(*) "+
						 " from tbl_member ";
			
			sql += sAllMemberCnt;
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				memberCnt = rs.getInt(1);
			}

		} finally {
			close();
		}
		
		return memberCnt;
	}
	
	
	
	
	///////////////////////// 백원빈 끝///////////////////////////////
	
}
