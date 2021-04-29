package board.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterNoticeDAO {

	// *** 페이징 처리를 한 모든 공지사항 목록 보여주기 *** //
	List<NoticeVO> selectPagingNotice(Map<String, String> paraMap) throws SQLException;

	// 페이징처리를 위해서 전체 공지사항에 대한 총페이지 개수 알아오기(select)  
	int selectTotalPage(Map<String, String> paraMap) throws SQLException;

	//조회수 증가시키기
	void updateViewCount(String noticeno) throws SQLException; 

}
