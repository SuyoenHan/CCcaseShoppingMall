package product.model;

import java.sql.SQLException;

public interface InterCategoryDAO {

	// =========================== 한수연 시작 ======================================
	// 카테코리코드에 해당하는 카테고리명 반환
	String getCname(String cnum) throws SQLException;
	
	// =========================== 한수연 끝 ======================================
}
