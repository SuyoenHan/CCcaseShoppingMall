package board.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterEventDAO {

	// 페이징 처리를 한 모든 이벤트글 또는 검색한 이벤트글 보여주기
	List<EventVO> selectPagingEvent(Map<String, String> paraMap) throws SQLException;
	
	// 페이징처리를 위해서 이벤트글에 대한 총페이지 개수 알아오기(select)
	int selectTotalPage(Map<String, String> paraMap) throws SQLException;

	// 조회수 증가시키기
	void updateViewCount(int eventno) throws SQLException;
	
	// 이벤트글 작성하기
	int writeEvent(EventVO evt) throws SQLException;
	
	// 이벤트글 삭제하기
	int deleteEvent(int eventno) throws SQLException; 
	
	// 이벤트글 수정하기
	int editEvent(EventVO evt) throws SQLException; 
	
	// eventno로 event글 불러오기
	EventVO eventDetail(String eventno) throws SQLException;
	
	// eventno로 이전 event글 불러오기
	EventVO prevEvent(String eventno) throws SQLException;
	
	// eventno로 다음 event글 불러오기
	EventVO nextEvent(String eventno) throws SQLException;

	// ============ 한수연 시작 ==================
	
	// 해당 eventno가 존재하는지 확인하는 메소드
	int checkEventno(String eventno) throws SQLException;
	
	// ============ 한수연 끝 ==================
	
}
