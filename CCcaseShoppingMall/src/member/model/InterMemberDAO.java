package member.model;

import java.sql.SQLException;
import java.util.Map;


public interface InterMemberDAO {
	// 회원가입을 해주는 메소드(tbl_member 테이블에 insert)
	int registerMember(MemberVO member) throws SQLException;
	
	//id 중복검사
	boolean idDuplicateCheck(String userid)throws SQLException;

	// email 중복검사 
	boolean emailDuplicateCheck(String email) throws SQLException;
	
	//로그인처리
	MemberVO selectOneMember(Map<String, String> paraMap) throws SQLException;
	//회원정보수정
	int updateMember(MemberVO member)throws SQLException;
	
}
