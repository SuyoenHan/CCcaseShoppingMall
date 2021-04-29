package product.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterProductDetailDAO {
	
	//////////////////백원빈 작업시작//////////////////
	// 전체제품 조회해오기
	List<Map<String, String>> selectProInfo() throws SQLException;
	//////////////////백원빈 작업끝//////////////////
}
