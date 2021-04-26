package board.model;

import member.model.AdminVO;

public class FaqVO {

	private int faqno;         				 // faq 글번호
	private String fk_adminid;      // 작성한 관리자아이디
	private String ftitle;    			     // 제목
	private String fregisterdate;  // 등록일
	private String fupdatedate;    // 최근수정일
	private int number;	        		 // 조회수
	private String  fcontent;           // 내용
	
	public AdminVO adminVO; 	// 관리자VO

	public int getFaqno() {
		return faqno;
	}
	
	public void setFaqno(int faqno) {
		this.faqno = faqno;
	}
	
	public String getFk_adminid() {
		return fk_adminid;
	}
	
	public void setFk_adminid(String fk_adminid) {
		this.fk_adminid = fk_adminid;
	}
	
	public String getFtitle() {
		return ftitle;
	}
	
	public void setFtitle(String ftitle) {
		this.ftitle = ftitle;
	}
	
	public String getFregisterdate() {
		return fregisterdate;
	}
	
	public void setFregisterdate(String fregisterdate) {
		this.fregisterdate = fregisterdate;
	}
	
	public String getFupdatedate() {
		return fupdatedate;
	}
	
	public void setFupdatedate(String fupdatedate) {
		this.fupdatedate = fupdatedate;
	}
	
	public int getNumber() {
		return number;
	}
	
	public void setNumber(int number) {
		this.number = number;
	}
	
	public String getFcontent() {
		return fcontent;
	}
	
	public void setFcontent(String fcontent) {
		this.fcontent = fcontent;
	}

	public AdminVO getAdminVO() {
		return adminVO;
	}

	public void setAdminVO(AdminVO adminVO) {
		this.adminVO = adminVO;
	}
}
