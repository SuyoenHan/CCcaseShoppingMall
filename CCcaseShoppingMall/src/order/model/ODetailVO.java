package order.model;

public class ODetailVO {

	private String odetailno;     //  주문상세일련번호 
	private String  fk_orderno;   //주문번호
	private String  fk_pnum;      // 제품상세번호
	private int odqty;            // 제품상세구매수량
	
	
	public String getOdetailno() {
		return odetailno;
	}
	public void setOdetailno(String odetailno) {
		this.odetailno = odetailno;
	}
	public String getFk_orderno() {
		return fk_orderno;
	}
	public void setFk_orderno(String fk_orderno) {
		this.fk_orderno = fk_orderno;
	}
	public String getFk_pnum() {
		return fk_pnum;
	}
	public void setFk_pnum(String fk_pnum) {
		this.fk_pnum = fk_pnum;
	}
	public int getOdqty() {
		return odqty;
	}
	public void setOdqty(int odqty) {
		this.odqty = odqty;
	}
	
	
	
}
