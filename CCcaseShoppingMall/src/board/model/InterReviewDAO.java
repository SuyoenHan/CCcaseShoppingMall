package board.model;

import java.sql.SQLException;
import java.util.*;


public interface InterReviewDAO {
	
	// 페이징처리를 위해서 전체리뷰에 대한 총페이지 개수 알아오기(select)
	int selectTotalPage(Map<String, String> paraMap) throws SQLException;
	
	// 페이징 처리를 한 모든 리뷰 또는 검색한 리뷰 목록 보여주기
	List<ReviewVO> selectPagingReview(Map<String, String> paraMap) throws SQLException;
	
	// 조회수 증가시키기
	void updateViewCount(String reviewno) throws SQLException;
	
	// reviewimage1(썸네일) 값을 입력받아서 리뷰 1개에 대한 상세정보를 알아오기
	ReviewVO reviewOneDetail(String reviewimage1) throws SQLException;
	
	// tbl_review 테이블에 리뷰정보 insert 하기
	int reviewInsert(ReviewVO rvo) throws SQLException;

	
	
	// 리뷰 글내용 수정을 위해 하나의 리뷰를 select해오기
	ReviewVO revEditOneView(String reviewno) throws SQLException;
	
	// 리뷰 글내용 수정하기(update)
	int revEditUpdate(ReviewVO rvo) throws SQLException;
	
	// 리뷰 글내용 삭제하기(delete)
	int revDeleteOne(ReviewVO rvo) throws SQLException;
	
	// 리뷰 총 개수 알아오기
	int selectRevCnt() throws SQLException;
	
	// 구매한 제품 사진 보여주기
	String selectPurchaseProd(String fk_userid) throws SQLException;
	
	// 구매한 제품명 가져오기
	String getPnameOfProd(String fk_userid) throws SQLException;
	
	
	
	
	
	
	
	

	
	
	
	
}
