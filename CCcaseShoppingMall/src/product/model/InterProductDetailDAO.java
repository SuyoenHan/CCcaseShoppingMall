package product.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterProductDetailDAO {
	
	//////////////////백원빈 작업시작//////////////////
	// 전체제품 조회해오기
	List<Map<String, String>> selectProInfo(Map<String,String> paraMap) throws SQLException;
	
	// 제품상세테이블로 insert하기 + 제품상세번호(primary)알아오기
	String insertProductDetail(Map<String, String> pdetailmap) throws SQLException;
	//////////////////백원빈 작업끝//////////////////


}
