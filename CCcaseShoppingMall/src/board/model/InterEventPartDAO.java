package board.model;

import java.sql.SQLException;

public interface InterEventPartDAO {

	//이벤트 중복참여를 막기위해 특정 회원을 eventpart 테이블로 insert
	int insertUser(String eventno, String userid) throws SQLException;

	//이벤트 당첨 시 500 포인트 증가시켜주기 update
	int updateUserPoint(String userid) throws SQLException;

}
