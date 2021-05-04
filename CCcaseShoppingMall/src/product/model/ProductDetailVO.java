package product.model;

public class ProductDetailVO {
	
	private String pnum;           // 제품상세번호(Primary Key)
	private String fk_productid;   // 제품번호
	private String pname;          // 제품상세명
	private String pcolor;         // 제품컬러
	private int pqty;              //제품 재고량
	private int fk_snum;           // 스펙번호
	private String pcontent;       // 제품설명                                                                                                            
	private String pinputdate;     // 제품입고일자
	private int doption;           // 배송조건  0=무료배송  1= 일반배송
	
	
	
	public String getPnum() {
		return pnum;
	}
	public void setPnum(String pnum) {
		this.pnum = pnum;
	}
	public String getFk_productid() {
		return fk_productid;
	}
	public void setFk_productid(String fk_productid) {
		this.fk_productid = fk_productid;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getPcolor() {
		return pcolor;
	}
	public void setPcolor(String pcolor) {
		this.pcolor = pcolor;
	}
	public int getPqty() {
		return pqty;
	}
	public void setPqty(int pqty) {
		this.pqty = pqty;
	}
	public int getFk_snum() {
		return fk_snum;
	}
	public void setFk_snum(int fk_snum) {
		this.fk_snum = fk_snum;
	}
	public String getPcontent() {
		return pcontent;
	}
	public void setPcontent(String pcontent) {
		this.pcontent = pcontent;
	}
	public String getPinputdate() {
		return pinputdate;
	}
	public void setPinputdate(String pinputdate) {
		this.pinputdate = pinputdate;
	}
	public int getDoption() {
		return doption;
	}
	public void setDoption(int doption) {
		this.doption = doption;
	}
	
	
	
	
	
	
	
}
