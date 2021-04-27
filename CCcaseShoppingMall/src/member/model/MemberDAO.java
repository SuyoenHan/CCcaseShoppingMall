package member.model;

import java.io.UnsupportedEncodingException;

import java.security.GeneralSecurityException;
import java.sql.*;
import java.util.Map;

import javax.naming.*;
import javax.sql.DataSource;

import util.security.AES256;
import util.security.SecretMyKey;
import util.security.Sha256;

public class MemberDAO implements InterMemberDAO{

	private DataSource ds;  
	private Connection conn; 
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
		
		    aes= new AES256(SecretMyKey.KEY);
		    
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
	   ////회원가입 
	   
	   @Override
		public int registerMember(MemberVO member) throws SQLException {
			
			int n = 0;
			
			try {
				  conn = ds.getConnection();
				  
				  String sql = "insert into tbl_member(userid, pwd, name, email, mobile, postcode, address, detailaddress, extraaddress) "     
						   + "values(?, ?, ?, ?, ?, ?, ?, ?, ?)"; 
				  
				  pstmt = conn.prepareStatement(sql);
				  
				  pstmt.setString(1, member.getUserid());
				  pstmt.setString(2, Sha256.encrypt(member.getPwd()) ); // 암호를 SHA256 알고리즘으로 단방향 암호화 시킨다.
				  pstmt.setString(3, member.getName());
				  pstmt.setString(4, aes.encrypt(member.getEmail()) );  // 이메일을 AES256 알고리즘으로 양방향 암호화 시킨다.
				  pstmt.setString(5, aes.encrypt(member.getMobile()) ); // 휴대폰번호를 AES256 알고리즘으로 양방향 암호화 시킨다.
				  pstmt.setString(6, member.getPostcode());
				  pstmt.setString(7, member.getAddress());
				  pstmt.setString(8, member.getDetailaddress());
				  pstmt.setString(9, member.getExtraaddress());
				  
				  n = pstmt.executeUpdate();
				  
			} catch(GeneralSecurityException | UnsupportedEncodingException e) {
				e.printStackTrace();
			} finally {
				close();
			}
			
			return n;
		}
	   
	///아이디 중복 검사
	@Override
	public boolean idDuplicateCheck(String userid) throws SQLException {
		boolean isExists = false;
		
		try {
			 conn = ds.getConnection();
			 
			 String sql = " select userid "
			 		    + " from tbl_member "
			 		    + " where userid = ? ";
			 
			 pstmt = conn.prepareStatement(sql); 
			 pstmt.setString(1, userid);
			 
			 rs = pstmt.executeQuery();
			 
			 isExists = rs.next(); // 행이 있으면(중복된 userid) true, 
                                   // 행이 없으면(사용가능한 userid) false
			 
		} finally {
			close();
		}
		
		return isExists;	// TODO Auto-generated method stub
	
	}
	// email 중복검사 
		@Override
		public boolean emailDuplicateCheck(String email) throws SQLException {

			boolean isExist = false;
			
			try {
				conn = ds.getConnection();
				
				String sql = " select email "
						   + " from tbl_member "
						   + " where email = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, aes.encrypt(email));
				
				rs = pstmt.executeQuery();
				
				isExist = rs.next();  // 행이 있으면(중복된 email) true, 
				                      // 행이 없으면(사용가능한 email) false
			} catch (GeneralSecurityException | UnsupportedEncodingException e) {
				e.printStackTrace();
			} finally {
				close();
			}
			
			return isExist;
		}
		
	//로그인 처리
	@Override
	public MemberVO selectOneMember(Map<String, String> paraMap) throws SQLException {
		
		MemberVO member = null;
		
		try {
			 conn = ds.getConnection();
			 
			 String sql = "SELECT userid, name, email, mobile, postcode, address, detailaddress, extraaddress, "+
					 "	totalpoint, registerday, pwdchangegap, nvl( lastlogingap , trunc( months_between(sysdate, registerday) ) ) AS lastlogingap "+
					 "	FROM "+
					 "	 ( "+
					 "	select userid, name, email, mobile, postcode, address, detailaddress, extraaddress,totalpoint, "+
					 "  to_char(registerday, 'yyyy-mm-dd') AS registerday, trunc( months_between(sysdate, lastpwdchangedate) ) AS pwdchangegap "+
					 "	from tbl_member "+
					 "	where status = 1 and userid = ? and pwd = ? "+
					 "  )M "+
					 "	CROSS JOIN "+
					 "	( "+
					 "	 select months_between(sysdate, max(logindate)) AS lastlogingap"+
					 "	 from tbl_loginhistory "+
					 "	 where fk_userid = ? "+
					 "	) H ";
			 
			 pstmt = conn.prepareStatement(sql);
			 
			 pstmt.setString(1, paraMap.get("userid"));
			 pstmt.setString(2, Sha256.encrypt(paraMap.get("pwd")));
			 pstmt.setString(3, paraMap.get("userid"));
			 
			 
			 rs = pstmt.executeQuery();
			 
			 if(rs.next()) {
				 
				 member = new MemberVO();
				 
				 member.setUserid(rs.getString(1));
				 member.setName(rs.getString(2));
				 member.setEmail(aes.decrypt(rs.getString(3)));  // 복호화 
				 member.setMobile(aes.decrypt(rs.getString(4))); // 복호화  
				 member.setPostcode(rs.getString(5));
			     member.setAddress(rs.getString(6));
				 member.setDetailaddress(rs.getString(7));
				 member.setExtraaddress(rs.getString(8));
				 member.setTotalpoint(rs.getInt(9));
				 member.setRegisterday(rs.getString(10));
		
				 if( rs.getInt(11) >= 3 ) {
					// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지났으면 true
					// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지나지 않았으면 false
					 
					member.setRequirePwdChange(true); // 로그인시 암호를 변경해라는 alert 를 띄우도록 할때 사용한다. 
				 }
				
				 if( rs.getInt(12) >= 12 ) {
					 // 마지막으로 로그인 한 날짜시간이 현재시각으로 부터 1년이 지났으면 휴면으로 지정 
					 member.setIdle(1);
					 
					// === tbl_member 테이블의 idle 컬럼의 값을 1 로 변경 하기 === //
					sql = " update tbl_member set idle = 1 "
						+ " where userid = ? ";
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, paraMap.get("userid"));
					
					pstmt.executeUpdate();
				 }
		
				 // ==== tbl_loginhistory(로그인기록) 테이블에 insert 하기 ==== //
				 if(member.getIdle() != 1) {
					 sql = " insert into tbl_loginhistory(fk_userid, clientip) "
					 	 + " values(?, ?) ";
					 
					 pstmt = conn.prepareStatement(sql);
					 pstmt.setString(1, paraMap.get("userid"));
					 pstmt.setString(2, paraMap.get("clientip"));
					 
					 pstmt.executeUpdate();
				 }
			 }
			 
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return member;
	
	}
	
	// 회원정보 변경 
		@Override
		public int updateMember(MemberVO member) throws SQLException {
			
			int n = 0;
			
			try {
				conn = ds.getConnection();
				
				String sql = "update tbl_member set pwd = ? "
						   + "                    , mobile = ? "
						   + "                    , postcode = ? "
						   + "                    , address = ? "
						   + "                    , detailaddress = ? "
						   + "                    , extraaddress = ? "
						   + "where userid = ? "; 
				
				pstmt = conn.prepareStatement(sql);
				
				
				pstmt.setString(1, Sha256.encrypt(member.getPwd()) );
				pstmt.setString(2, aes.encrypt(member.getMobile()) );
				pstmt.setString(3, member.getPostcode() );
				pstmt.setString(4, member.getAddress() );
				pstmt.setString(5, member.getDetailaddress() );
				pstmt.setString(6, member.getExtraaddress() );
				pstmt.setString(7, member.getUserid() );
							
				n = pstmt.executeUpdate();
				
			} catch (GeneralSecurityException | UnsupportedEncodingException e) {
				e.printStackTrace();
			} finally {
				close();
			}
			
			return n;	
		}
	


}
