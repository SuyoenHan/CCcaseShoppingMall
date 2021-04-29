package product.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

public interface InterSpecDAO {
	
	
	// =========================== 백원빈 시작 ======================================
	// 카테고리 목록을 조회
	List<HashMap<String, String>> selectSpec() throws SQLException;
	
	
	
	
	// =========================== 백원빈 끝 ======================================
}
