package member.model;

public class InterestProductVO {

	private int interestno;     // 관심상품번호
	private String fk_userid;   // 회원아이디
	private String fk_pnum;     // 제품상세번호
	private String fk_productid;
	
	
	public int getInterestno() {
		return interestno;
	}
	public void setInterestno(int interestno) {
		this.interestno = interestno;
	}
	
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	
	public String getFk_pnum() {
		return fk_pnum;
	}
	public void setFk_pnum(String fk_pnum) {
		this.fk_pnum = fk_pnum;
	}
	
	public String getFk_productid() {
		return fk_productid;
	}
	public void setFk_productid(String fk_productid) {
		this.fk_productid = fk_productid;
	}
}
