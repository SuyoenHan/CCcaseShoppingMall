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
			
			String sql = " select chRefundno, odetailno,pnum,pname,fk_userid,to_char(cregisterdate,'yyyy-mm-dd'),sortno,whycontent "+
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
				
				chRefundList.add(chRefundMap);
				
			}// end of while
			
			
		} finally {
			close();
		}
		
		
		return chRefundList;
	}
	
	/////////////////// 백원빈 시작 /////////////////////////////////	
	
	
	
	
	
}
