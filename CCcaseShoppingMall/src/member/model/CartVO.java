package member.model;

public class CartVO {

	private int cartno;           // 장바구니 번호
	private String fk_userid;     // 회원아이디
	private String fk_pnum;       // 제품상세번호
	private String fk_productid;  // 제품번호
	private int cinputcnt;        // 장바구니에 담긴 수량 (상세상품당) ==> 최대 50개
	private String cinputdate;    // 입력일자
	
	
	public int getCartno() {
		return cartno;
	}
	public void setCartno(int cartno) {
		this.cartno = cartno;
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
	
	public int getCinputcnt() {
		return cinputcnt;
	}
	public void setCinputcnt(int cinputcnt) {
		this.cinputcnt = cinputcnt;
	}
	
	public String getCinputdate() {
		return cinputdate;
	}
	public void setCinputdate(String cinputdate) {
		this.cinputdate = cinputdate;
	}
	
	
	
	
}
