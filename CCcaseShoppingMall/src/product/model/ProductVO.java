package product.model;

public class ProductVO {

	private String productid;     // 제품번호
	private String productname;   // 제품명
	private String modelname;     // 기종명
	private int fk_mnum;          // 핸드폰회사코드
	private int fk_cnum;          // 카테고리코드
	private int price;            // 제품 정가
	private int salepercent;      // 할인율
	private String pimage1;       // 제품이미지1   이미지파일명
	
	
	public String getProductid() {
		return productid;
	}
	public void setProductid(String productid) {
		this.productid = productid;
	}
	public String getProductname() {
		return productname;
	}
	public void setProductname(String productname) {
		this.productname = productname;
	}
	public String getModelname() {
		return modelname;
	}
	public void setModelname(String modelname) {
		this.modelname = modelname;
	}
	public int getFk_mnum() {
		return fk_mnum;
	}
	public void setFk_mnum(int fk_mnum) {
		this.fk_mnum = fk_mnum;
	}
	public int getFk_cnum() {
		return fk_cnum;
	}
	public void setFk_cnum(int fk_cnum) {
		this.fk_cnum = fk_cnum;
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
	public String getPimage1() {
		return pimage1;
	}
	public void setPimage1(String pimage1) {
		this.pimage1 = pimage1;
	}
	
	
}
