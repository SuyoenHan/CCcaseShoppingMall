package board.model;

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

public class ChRefundDAO implements InterChRefundDAO {
	
	private DataSource ds;
	private Connection conn; 
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자 
	public ChRefundDAO() {
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

	
	/////////////////// 백원빈 시작 /////////////////////////////////
	
	// 교환 및 환불리스트 가져오기(select)
	@Override
	public List<Map<String, String>> selectchRefundList() throws SQLException {
		
		List<Map<String, String>> chRefundList = new ArrayList<>();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select chRefundno, odetailno,pnum,pname,fk_userid,to_char(cregisterdate,'yyyy-mm-dd'),sortno,whycontent,orderno "+
						 " from tbl_order join tbl_odetail "+
						 " on orderno = fk_orderno "+
						 " join tbl_pdetail "+
						 " on pnum  = fk_pnum "+
						 " join tbl_chRefund "+
						 " on odetailno = fk_odetailno ";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				Map<String, String> chRefundMap = new HashMap<>();
				chRefundMap.put("chRefundno", String.valueOf(rs.getInt(1)));
				chRefundMap.put("odetailno", rs.getString(2));
				chRefundMap.put("pnum", rs.getString(3));
				chRefundMap.put("pname", rs.getString(4));
				chRefundMap.put("fk_userid", rs.getString(5));
				chRefundMap.put("cregisterdate", rs.getString(6));
				chRefundMap.put("sortno", String.valueOf(rs.getInt(7)));
				chRefundMap.put("whycontent", rs.getString(8));
				chRefundMap.put("orderno", rs.getString(9));
				
				
				chRefundList.add(chRefundMap);
				
			}// end of while
			
			
		} finally {
			close();
		}
		
		
		return chRefundList;
	}

	
	// 교환및환불 접수 시 교환 및 환불테이블에 insert작업
	@Override
	public int insertChRefund(Map<String, String> paraMap) throws SQLException {
		
		int n =0;
		
		try {
			
			conn = ds.getConnection();
			String sql = " insert into tbl_chRefund(chRefundno,fk_odetailno,sortno,whycontent) "+
						 " values(seq_chRefund_chRefundno.nextval,? ,?, ? ) ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("fk_odetailno"));
			pstmt.setInt(2, Integer.parseInt(paraMap.get("sortno")));
			pstmt.setString(3, paraMap.get("whycontent"));
			
			n = pstmt.executeUpdate();

		} finally {
			close();
		}

		return n;
	}

	// 관리자가 승인 시 해당 테이블에서 delete해주는 작업
	@Override
	public int deleteView(String fk_odetailno,Integer shipstatus) throws SQLException {

		int n = 0;
		
		try {
			
			conn = ds.getConnection();
			conn.setAutoCommit(false);
			
			String sql = " update tbl_odetail set shipstatus = ? "+
					  	 " where odetailno = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, shipstatus);
			pstmt.setString(2, fk_odetailno);
			
			int m = pstmt.executeUpdate();
			
			
			if(m==1) {
				
			sql = " delete from tbl_chRefund "+
				  " where fk_odetailno = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fk_odetailno);
			
			n = pstmt.executeUpdate();
				
			}
			
			if(n==1) {
				conn.commit();
			}
			else {
				conn.rollback();
			}

		} finally {
			close();
		}

		return n;
	}
	
	
	/////////////////// 백원빈 끝 /////////////////////////////////	
	
}
