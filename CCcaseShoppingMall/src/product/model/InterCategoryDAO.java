package product.model;

import java.sql.SQLException;
import java.util.List;

public interface InterCategoryDAO {

	// =========================== 한수연 시작 ======================================
	// 카테코리코드에 해당하는 카테고리명 반환
	String getCname(String cnum) throws SQLException;
	// =========================== 한수연 끝 ======================================
	
	// =========================== 백원빈 시작 ======================================
	// 카테고리 목록 조회해오기
	List<CategoryVO> selectCategory() throws SQLException;
	// =========================== 백원빈 끝 ======================================

	
}
