package member.model;

import java.io.UnsupportedEncodingException;
import java.sql.*;

import javax.naming.*;
import javax.sql.DataSource;

import util.security.AES256;
import util.security.SecretMyKey;

public class MemberDAO implements InterMemberDAO{

	private DataSource ds;  // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다. 풀장.
	private Connection conn;  //실제 튜브
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes;
	
	//생성자
	public MemberDAO() {
		
		Context initContext;
		try {
			initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semioracle");
		 //   conn = ds.getConnection(); //ds 풀장에서 connection 을 가져오겠다 .. -> 각각의 메소드에서 쓰고 반납해야하는 것. 여기에 안써줌.
		
		    aes= new AES256(SecretMyKey.KEY);
		    //SecretMyKey.KEY는 우리가 만든 비밀키 이다.
		    
		} catch (NamingException e) {
			e.printStackTrace();
		}catch(UnsupportedEncodingException e) {
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
	
	   
	   
	
}
