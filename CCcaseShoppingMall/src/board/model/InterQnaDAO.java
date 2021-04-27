package board.model;

import java.sql.SQLException;
import java.util.*;

public interface InterQnaDAO {

	// 페이징 처리를 한 모든 QNA글 또는 검색한 QNA글 보여주기
	List<QnaVO> selectPagingQna(Map<String, String> paraMap) throws SQLException;
	
	// 페이징처리를 위해서 QNA글에 대한 총페이지 개수 알아오기(select)
	int selectTotalPage(Map<String, String> paraMap) throws SQLException;

	// qna 글 작성하는 메소드
	int writeQna(QnaVO qna) throws SQLException;

}
