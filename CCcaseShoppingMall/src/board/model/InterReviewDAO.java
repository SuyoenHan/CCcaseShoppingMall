package board.model;

import java.sql.SQLException;
import java.util.*;

import product.model.ProductVO;


public interface InterReviewDAO {
	
	// 페이징처리를 위해서 전체리뷰에 대한 총페이지 개수 알아오기(select)
	int selectTotalPage(Map<String, String> paraMap) throws SQLException;
	
	// 페이징 처리를 한 모든 리뷰 또는 검색한 리뷰 목록 보여주기
	List<ReviewVO> selectPagingReview(Map<String, String> paraMap) throws SQLException;
	
	// 조회수 증가시키기
	void updateViewCount(String reviewno) throws SQLException;
	
	// reviewimage1(썸네일) 값을 입력받아서 리뷰 1개에 대한 상세정보를 알아오기
	ReviewVO reviewOneDetail(String reviewno) throws SQLException;
	
	// tbl_review 테이블에 리뷰정보 insert 하기
	int reviewInsert(ReviewVO rvo) throws SQLException;

	// 리뷰 글내용 수정을 위해 하나의 리뷰를 select해오기
	ReviewVO revEditOneView(String reviewno) throws SQLException;
	
	// 리뷰 글내용 수정하기(update)
	int revEditUpdate(ReviewVO rvo) throws SQLException;
	
	// 리뷰 글내용 삭제하기(delete)
	int revDeleteOne(String reviewno) throws SQLException;
	
	// 리뷰 총 개수 알아오기
	int selectRevCnt() throws SQLException;

	//내가 쓴 리뷰 조회 해오기
	List<ReviewVO> reviewMywrite(Map<String, String> paraMap)throws SQLException;
	
	//내가 쓴 리뷰 조회 페이징 처리
	int reviewMywriteTotalPage(String userid)throws SQLException;
	
	// 구매한 제품 사진 보여주기
	String selectPurchaseProd(String fk_userid) throws SQLException;
	
	// 구매한 제품명 가져오기
	String getPnameOfProd(String fk_odetailno) throws SQLException;

	// 해당 리뷰의 구매 제품 가져오기 
	ProductVO selectProduct(String reviewno) throws SQLException;
	
	// 특정 회원이 특정 리뷰에 대해 도움이돼요 투표하기(insert) 
	int likeAdd(Map<String, String> paraMap) throws SQLException;
	
	// 특정 리뷰에 대한 도움이 돼요 투표 결과(select)
	int getLikeCnt(String reviewno) throws SQLException;

	// 해당 리뷰의 구매 제품 스펙번호 가져오기
	int getSnumByReviewno(String odetailno) throws SQLException;
	
	// 쓰여진 리뷰 내용 받아오기
	ReviewVO getReviewContents(String userid, String reviewno) throws SQLException;

	// 리뷰번호 채번 해오기
	int getReviewno() throws SQLException;
	
	// tbl_review 테이블에 제품의 추가 이미지 파일명 update 해주기
	int review_imagefile_Insert(int reviewno, String attachFileName) throws SQLException;

	// 리뷰 목록을 조회해오기
	List<ReviewVO> selectRevList() throws SQLException;
	
	
	String getReviewno2(String userid) throws SQLException;
	

	
	
	
	
	
	
	
	

	
	
	
	
}
