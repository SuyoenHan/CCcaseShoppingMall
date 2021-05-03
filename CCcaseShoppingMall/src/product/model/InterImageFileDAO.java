package product.model;

import java.sql.SQLException;
import java.util.*;

public interface InterImageFileDAO {
	
	////////////////////백원빈 작업 시작 ///////////////////////////
	
	// 제품추가이미지 테이블로 insert하기
	int insertPlusImage(Map<String, String> plusimgmap) throws SQLException;
	
	// 제품리스트에서 특정행 클릭 후 이미지테이블 update
	int updateImage(Map<String, String> plusimgmap) throws SQLException;
	////////////////////백원빈 작업 끝 ///////////////////////////
	
	
	// =============== 한수연 작업 시작 =========================
	
	// pnum이 주어진 경우 pnum에 해당하는 제품이미지명 반환 (pnum에 해당하는 행이 1개 이상 존재 할 수도 있다)
	List<Map<String,String>> selectImgFileByPnum(String pnum) throws SQLException;

	
	
	// =============== 한수연 작업 끝 =========================
	
}
