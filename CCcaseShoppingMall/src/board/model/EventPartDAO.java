package board.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class EventPartDAO implements InterEventPartDAO {

	private DataSource ds;
	private Connection conn; 
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자 
	public EventPartDAO() {
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


	
	//이벤트 중복참여를 막기위해 특정 회원을 eventpart 테이블로 insert
	@Override
	public int insertUser(String eventno, String userid) throws SQLException {
		
		int n =0;
		
		try {
			
			conn= ds.getConnection();
			conn.setAutoCommit(false); 
			
			String sql = " insert into tbl_eventPart(fk_eventno,fk_userid) " + 
						 " values (?,?) ";
			
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, eventno);
			pstmt.setString(2, userid);
			
			n = pstmt.executeUpdate();

			 if(n==1) {
	        	 conn.commit(); // 둘다 업데이트 되어지면 커밋해줌
	         }
			
		}catch(SQLIntegrityConstraintViolationException e){ // 중복되어졌을때 제약조건 위배되기 때문에 exception 처리해줌 그렇게 되면 n=0으로 return되어진다.
			conn.rollback();
		}finally {
			close();
		}

		return n;
		
	}


	//이벤트 당첨 시 500 포인트 증가시켜주기 update
	@Override
	public int updateUserPoint(String userid) throws SQLException {
		int n =0;
		
		try {
			
			conn= ds.getConnection();
		
			
			String sql = " update tbl_member set totalpoint = totalpoint + 500  " + 
						 " where userid= ? ";
			
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			n = pstmt.executeUpdate();

			
			
		}finally {
			close();
		}

		return n;
	}
	
	
	
	
	
}
