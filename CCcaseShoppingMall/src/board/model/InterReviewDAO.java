package board.model;

import java.sql.SQLException;
import java.util.*;

public interface InterReviewDAO {
	
	// 페이징처리를 위해서 전체리뷰에 대한 총페이지 개수 알아오기(select)
	int selectTotalPage(Map<String, String> paraMap) throws SQLException;
	
	// 페이징 처리를 한 모든 리부 또는 제품명으로 검색한 리뷰 목록 보여주기
	List<ReviewVO> selectPagingReview(Map<String, String> paraMap) throws SQLException;
	
	// 조회수 증가시키기
	void updateViewCount(String reviewno) throws SQLException;
	
	// reviewimage1(썸네일) 값을 입력받아서 리뷰 1개에 대한 상세정보를 알아오기
	ReviewVO reviewOneDetail(String reviewimage1) throws SQLException;
	
	
	
}
