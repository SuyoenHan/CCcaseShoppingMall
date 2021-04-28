package member.model;

import java.sql.SQLException;
import java.util.List;
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

	
	
	///////////////////////////////////////////////////////////////////////////////////////////김지우(회원조회)
	// *** 페이징 처리를 한 모든 회원 또는 검색한 회원 목록 보여주기 *** //
	List<MemberVO> selectPagingMember(Map<String, String> paraMap) throws SQLException;
			
	// 페이징처리를 위해서 전체회원에 대한 총페이지 개수 알아오기(select)  
	int selectTotalPage(Map<String, String> paraMap) throws SQLException;
			
	// userid 값을 입력받아서 회원 1명에 대한 상세정보를 알아오기
	MemberVO memberOneDetail(String userid) throws SQLException;
	

	//회원정보수정
	int updateMember(MemberVO member)throws SQLException;

	
}
