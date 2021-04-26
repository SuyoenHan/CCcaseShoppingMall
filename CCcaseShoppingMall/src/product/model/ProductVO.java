package product.model;

public class ProductVO {

	private int  productid;  	//  제품번호
	private String productname; //제품명
	private String modelname;   //기종명
	private MobilecompanyVO mobilevo;  // 핸드폰회사VO 
	private CategoryVO categvo; // 카테고리VO 
	
	
	
	
	public ProductVO() { }



	public int getProductid() {
		return productid;
	}



	public void setProductid(int productid) {
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



	public CategoryVO getCategvo() {
		return categvo;
	}



	public void setCategvo(CategoryVO categvo) {
		this.categvo = categvo;
	}



	public MobilecompanyVO getMobilevo() {
		return mobilevo;
	}



	public void setMobilevo(MobilecompanyVO mobilevo) {
		this.mobilevo = mobilevo;
	}
	
	
}
