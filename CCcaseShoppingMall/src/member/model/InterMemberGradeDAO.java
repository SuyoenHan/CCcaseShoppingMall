package member.model;

import java.sql.SQLException;

public interface InterMemberGradeDAO {

	// ===================== 한수연 시작 ==========================
	
	// 회원아이디가 주어진 경우, 적립률 반환 
	int getPointPercent(String userid) throws SQLException;
	
	// ===================== 한수연 끝 ==========================
}
