package board.model;

public class ChRefundVO {
	
	// field
	private int chRefundno;      	// 일련번호
	private String fk_odetailno; 	// 주문번호
	private int sortno; 			// 구분(0:교환 1:환불)
	private String cregisterdate; 	// 접수일
	private String whycontent; 		// 사유
	
	
	
	
	// method
	public int getChRefundno() {
		return chRefundno;
	}
	
	public void setChRefundno(int chRefundno) {
		this.chRefundno = chRefundno;
	}
	
	public String getFk_odetailno() {
		return fk_odetailno;
	}
	
	public void setFk_odetailno(String fk_odetailno) {
		this.fk_odetailno = fk_odetailno;
	}
	
	public int getSortno() {
		return sortno;
	}
	
	public void setSortno(int sortno) {
		this.sortno = sortno;
	}
	
	public String getCregisterdate() {
		return cregisterdate;
	}
	
	public void setCregisterdate(String cregisterdate) {
		this.cregisterdate = cregisterdate;
	}
	
	public String getWhycontent() {
		return whycontent;
	}
	
	public void setWhycontent(String whycontent) {
		this.whycontent = whycontent;
	}
	
}
