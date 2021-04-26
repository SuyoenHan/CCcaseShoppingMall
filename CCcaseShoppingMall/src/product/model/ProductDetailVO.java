package product.model;

public class ProductDetailVO {
	
	private int pnum;           // 제품상세번호
	private int fk_productid;   // 제품번호
	private String pname;       // 제품상세명
	private String pimage1;     // 대표이미지파일명
	private String pcolor;      // 제품색상
	private int pqty;           // 제품 재고량
	private int price;          // 제품 정가
	private int salepercent;    // 할인율
	private int fk_snum;        // 스펙번호
	private String pcontent;    // 제품설명
	private String pinputdate;  // 제품입고일자
	private int doption;        // 배송조건(유료,무료) 
	
	
	
	public int getPnum() {
		return pnum;
	}
	
	public void setPnum(int pnum) {
		this.pnum = pnum;
	}
	
	public int getFk_productid() {
		return fk_productid;
	}
	
	public void setFk_productid(int fk_productid) {
		this.fk_productid = fk_productid;
	}
	
	public String getPname() {
		return pname;
	}
	
	public void setPname(String pname) {
		this.pname = pname;
	}
	
	public String getPimage1() {
		return pimage1;
	}
	
	public void setPimage1(String pimage1) {
		this.pimage1 = pimage1;
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
	
	public int getPrice() {
		return price;
	}
	
	public void setPrice(int price) {
		this.price = price;
	}
	
	public int getSalepercent() {
		return salepercent;
	}
	
	public void setSalepercent(int salepercent) {
		this.salepercent = salepercent;
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
