package member.model;

public class CouponVO {
	
	private String cpno;						// 쿠폰번호
	private String fk_userid;					// 회원아이디  
	private int cpstatus;						// 0 사용가능, 1 사용완료, 2 소멸
	private int cpcontent;					// 0 무료배송, 1 할인쿠폰
	private String cpname;					// 쿠폰명
	private String cpdiscount;					// 할인율
	private String issuedate;				// 발행일
	private String expirationdate; 	// 만료일(발행일+14)
	
	////////////////////////////////////////////////////////////////
	private String remaindate; // 남은 날짜;
	////////////////////////////////////////////////////////////////
	
	public CouponVO() {}
	
	public CouponVO(String cpno, String fk_userid, int cpstatus, int cpcontent, String cpname, String cpdiscount, 
								  String issuedate, String expirationdate) {
		this.cpno = cpno;
		this.fk_userid = fk_userid;
		this.cpstatus = cpstatus;
		this.cpcontent = cpcontent;
		this.cpname = cpname;
		this.cpdiscount = cpdiscount;
		this.issuedate = issuedate;
		this.expirationdate = expirationdate;
		
	}
	
	public String getCpno() {
		return cpno;
	}
	
	public void setCpno(String cpno) {
		this.cpno = cpno;
	}
	
	public String getFk_userid() {
		return fk_userid;
	}
	
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	
	public int getCpstatus() {
		return cpstatus;
	}
	
	public void setCpstatus(int cpstatus) {
		this.cpstatus = cpstatus;
	}
	
	public int getCpcontent() {
		return cpcontent;
	}
	
	public void setCpcontent(int cpcontent) {
		this.cpcontent = cpcontent;
	}
	
	public String getCpname() {
		return cpname;
	}
	
	public void setCpname(String cpname) {
		this.cpname = cpname;
	}
	
	public String getCpdiscount() {
		return cpdiscount;
	}
	
	public void setCpdiscount(String cpdiscount) {
		this.cpdiscount = cpdiscount;
	}
	
	public String getIssuedate() {
		return issuedate;
	}
	
	public void setIssuedate(String issuedate) {
		this.issuedate = issuedate;
	}
	
	public String getExpirationdate() {
		return expirationdate;
	}
	
	public void setExpirationdate(String expirationdate) {
		this.expirationdate = expirationdate;
	}

	public String getRemaindate() {
		return remaindate;
	}

	public void setRemaindate(String remaindate) {
		this.remaindate = remaindate;
	}

	


	
	
	
	
}
