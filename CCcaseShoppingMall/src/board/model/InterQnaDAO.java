package board.model;

import java.sql.SQLException;
import java.util.*;

public interface InterQnaDAO {

	// 페이징 처리를 한 모든 QNA글 또는 검색한 QNA글 보여주기
	List<QnaVO> selectPagingQna(Map<String, String> paraMap) throws SQLException;
	
	// 페이징처리를 위해서 QNA글에 대한 총페이지 개수 알아오기(select)
	int selectTotalPage(Map<String, String> paraMap) throws SQLException;

	// USER 용 메소드
	// qna 글 작성하기
	int writeQna(QnaVO qna) throws SQLException;
	
	// qna 글 삭제하기
	int deleteQna(int qnano) throws SQLException; 
	
	// qna 글 수정하기
	int editQna(QnaVO qna) throws SQLException; 
	
	// qnano로 qna 글 불러오기
	QnaVO qnaDetail(String qnano) throws SQLException;
	
	// ADMIN 용 메소드
	// qna 답글 작성하기(admin)
	int replyQna(QnaVO qna) throws SQLException;
	
	// qnano로 qna 답글 불러오기
	
	
	// 조회수 증가시키기
	void updateViewCount(int qnano) throws SQLException;

	

}
