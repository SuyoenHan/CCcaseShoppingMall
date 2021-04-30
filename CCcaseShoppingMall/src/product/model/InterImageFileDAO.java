package product.model;

import java.sql.SQLException;
import java.util.Map;

public interface InterImageFileDAO {
	
	////////////////////백원빈 작업 시작 ///////////////////////////
	
	// 제품추가이미지 테이블로 insert하기
	int insertPlusImage(Map<String, String> plusimgmap) throws SQLException;
	
	
	////////////////////백원빈 작업 끝 ///////////////////////////
}
