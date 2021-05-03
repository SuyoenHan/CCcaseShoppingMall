package order.model;

import member.model.MemberVO;
import product.model.ProductDetailVO;
import product.model.ProductVO;

public class OrderVO {

	
	private String orderno;       // 주문번호
	private String fk_userid;     // 회원아이디
	private int totalPrice;       // 상품총액
	private String orderdate;     // 주문일
	private String shipstartdate; // 배송시작일
	private String shipenddate;   // 배송완료일
	private String depositdate;   // 입금일
	private int shipstatus;       // 배송상태 (0 입금대기 / 1 입금완료 / 2 배송중 / 3 배송완료 / 4 구매확정 / 5 교환  6 환불)
			                      // => 교환 및 환불 접수일, 시작일, 완료일은 교환/환불 테이블에 있어서 일단 제외
	private int shipfee;          // 배송비
	private int finalamount;      // 최종주문금액 (상품총액+배송비-할인금액)
	
	private MemberVO mvo;
	private ODetailVO odvo;
	private ProductDetailVO pdvo;
	private ProductVO pvo;
	
	public OrderVO() {
		// TODO Auto-generated constructor stub
	}
	

	public OrderVO(String orderno, String fk_userid, int totalPrice, String orderdate, String shipstartdate,
			String shipenddate, String depositdate, int shipstatus, int shipfee, int finalamount, MemberVO mvo,
			ODetailVO odvo, ProductDetailVO pdvo, ProductVO pvo) {
		super();
		this.orderno = orderno;
		this.fk_userid = fk_userid;
		this.totalPrice = totalPrice;
		this.orderdate = orderdate;
		this.shipstartdate = shipstartdate;
		this.shipenddate = shipenddate;
		this.depositdate = depositdate;
		this.shipstatus = shipstatus;
		this.shipfee = shipfee;
		this.finalamount = finalamount;
		this.mvo = mvo;
		this.odvo = odvo;
		this.pdvo = pdvo;
		this.pvo = pvo;
	}

	

	public String getOrderno() {
		return orderno;
	}
	
	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}
	
	public String getFk_userid() {
		return fk_userid;
	}
	
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	
	public int getTotalPrice() {
		return totalPrice;
	}
	
	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}
	
	public String getOrderdate() {
		return orderdate;
	}
	
	public void setOrderdate(String orderdate) {
		this.orderdate = orderdate;
	}
	
	public String getShipstartdate() {
		return shipstartdate;
	}
	
	public void setShipstartdate(String shipstartdate) {
		this.shipstartdate = shipstartdate;
	}
	
	public String getShipenddate() {
		return shipenddate;
	}
	
	public void setShipenddate(String shipenddate) {
		this.shipenddate = shipenddate;
	}
	
	public String getDepositdate() {
		return depositdate;
	}
	
	public void setDepositdate(String depositdate) {
		this.depositdate = depositdate;
	}
	
	public int getShipstatus() {
		return shipstatus;
	}
	
	public void setShipstatus(int shipstatus) {
		this.shipstatus = shipstatus;
	}
	
	public int getShipfee() {
		return shipfee;
	}
	
	public void setShipfee(int shipfee) {
		this.shipfee = shipfee;
	}
	
	public int getFinalamount() {
		return finalamount;
	}
	
	public void setFinalamount(int finalamount) {
		this.finalamount = finalamount;
	}


	public MemberVO getMvo() {
		return mvo;
	}


	public void setMvo(MemberVO mvo) {
		this.mvo = mvo;
	}


	public ODetailVO getOdvo() {
		return odvo;
	}


	public void setOdvo(ODetailVO odvo) {
		this.odvo = odvo;
	}


	public ProductDetailVO getPdvo() {
		return pdvo;
	}


	public void setPdvo(ProductDetailVO pdvo) {
		this.pdvo = pdvo;
	}


	public ProductVO getPvo() {
		return pvo;
	}


	public void setPvo(ProductVO pvo) {
		this.pvo = pvo;
	}
	
	
	
	
	
	
}
