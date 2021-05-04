package board.model;

import java.sql.SQLException;
import java.util.*;

public interface InterQnaDAO {

	// 페이징 처리를 한 모든 QNA글 또는 검색한 QNA글 보여주기
	List<QnaVO> selectPagingQna(Map<String, String> paraMap) throws SQLException;
	
	// 페이징처리를 위해서 QNA글에 대한 총페이지 개수 알아오기(select)
	int selectTotalPage(Map<String, String> paraMap) throws SQLException;

	// 조회수 증가시키기
	void updateViewCount(int qnano) throws SQLException;
	
	// USER 용 메소드
	// qna 글 작성하기
	int writeQna(QnaVO qna) throws SQLException;
	
	// qna 글 삭제하기
	int deleteQna(int qnano) throws SQLException; 
	
	// qna 글 수정하기
	int editQna(QnaVO qna) throws SQLException; 
	
	// qnano로 qna 글 불러오기
	QnaVO qnaDetail(String qnano) throws SQLException;
	
	// qnano로 이전 qna 글 불러오기
	QnaVO prevQna(String qnano) throws SQLException;
	
	// qnano로 다음 qna 글 불러오기
	QnaVO nextQna(String qnano) throws SQLException;
	
	// ADMIN 용 메소드
	// qna 답글 작성하기(admin)
	int replyQna(QnaCmtVO qcvo) throws SQLException;
	
	// fk_qnano로 qna 답글 불러오기
	List<QnaCmtVO> getCmtList(String fk_qnano) throws SQLException;

	// qna 답글 삭제하기
	int deleteQnaRep(int cmtno) throws SQLException; 
		

	//마이페이지에서 내가 쓴 게시물 보기
	QnaVO qnaMywrite(String userid) throws SQLException;

}
