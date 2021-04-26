package product.model;

public class CategoryVO {

	private int    cnum;   // 카테고리 대분류 번호
	private String cname;  // 카테고리명
	
	public CategoryVO() { }

	public int getCnum() {
		return cnum;
	}

	public void setCnum(int cnum) {
		this.cnum = cnum;
	}

	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}
	
	
	

}
