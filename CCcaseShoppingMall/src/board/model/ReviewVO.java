package board.model;

public class ReviewVO {
	private int reviewno; 					// 리뷰순번
	private String fk_odetailno; 		// 주문상세일련번호
	private String rvtitle; 					// 글제목
	private String rvcontent; 			// 글내용
	private String rregisterdate; 		// 작성일자
	private String rupdatedate; 		// 최근수정일
	private int rviewcount; 				// 조회수
	private int satisfaction; 				// 만족도 (1 별한개 / 1.5 별한개반 ... 5 별다섯개)
	private String reviewimage1; 	// 리뷰이미지1  
	private String reviewimage2; 	// 리뷰이미지2
	private String reviewimage3; 	// 리뷰이미지3
	private String fk_pname; 			// 제품상세명
	private int likecount; 					// 도움됩니다 숫자     
	
	public ReviewVO () {
		
	}
	
	
	public int getReviewno() {
		return reviewno;
	}
	
	public void setReviewno(int reviewno) {
		this.reviewno = reviewno;
	}
	public String getFk_odetailno() {
		return fk_odetailno;
	}
	
	public void setFk_odetailno(String fk_odetailno) {
		this.fk_odetailno = fk_odetailno;
	}
	
	public String getRvtitle() {
		return rvtitle;
	}
	
	public void setRvtitle(String rvtitle) {
		this.rvtitle = rvtitle;
	}
	
	public String getRvcontent() {
		return rvcontent;
	}
	
	public void setRvcontent(String rvcontent) {
		this.rvcontent = rvcontent;
	}
	
	public String getRregisterdate() {
		return rregisterdate;
	}
	
	public void setRregisterdate(String rregisterdate) {
		this.rregisterdate = rregisterdate;
	}
	
	public String getRupdatedate() {
		return rupdatedate;
	}
	
	public void setRupdatedate(String rupdatedate) {
		this.rupdatedate = rupdatedate;
	}
	
	public int getRviewcount() {
		return rviewcount;
	}
	
	public void setRviewcount(int rviewcount) {
		this.rviewcount = rviewcount;
	}
	
	public int getSatisfaction() {
		return satisfaction;
	}
	
	public void setSatisfaction(int satisfaction) {
		this.satisfaction = satisfaction;
	}
	
	public String getReviewimage1() {
		return reviewimage1;
	}
	
	public void setReviewimage1(String reviewimage1) {
		this.reviewimage1 = reviewimage1;
	}
	
	public String getReviewimage2() {
		return reviewimage2;
	}
	
	public void setReviewimage2(String reviewimage2) {
		this.reviewimage2 = reviewimage2;
	}
	
	public String getReviewimage3() {
		return reviewimage3;
	}
	
	public void setReviewimage3(String reviewimage3) {
		this.reviewimage3 = reviewimage3;
	}
	
	public String getFk_pname() {
		return fk_pname;
	}
	
	public void setFk_pname(String fk_pname) {
		this.fk_pname = fk_pname;
	}
	
	public int getLikecount() {
		return likecount;
	}
	
	public void setLikecount(int likecount) {
		this.likecount = likecount;
	}
	
	
	
	
	
}
