package product.model;

import java.sql.*;
import java.util.*;

public interface InterProductDAO {

	// =========================== 한수연 시작 ======================================
	
	// 핸드폰 제조사별 케이스 하드케이스 ,젤리케이스 ,범퍼케이스  개수 반환
	int calCntByCompany(int mnum, int cnum) throws SQLException;

	
	// mnum과 cnum이 주어진 경우, 
	// 이에 해당하는 제품번호, 제품명, 기종명, 대표이미지파일명, 제품정가, 할인판매가, 스펙번호 가져오기 (productDetailVO 정보는 하얀색 기준으로..)
	List<Map<String,String>> getProductInfo(String mnum, String cnum) throws SQLException;
	
	
	// mnum과 cnum이 주어진 경우, 이에 해당하는 기종명 반환 (중복되는 기종명은 1번만 사용)
	List<String> getModelName(String mnum, String cnum) throws SQLException;
	
	
	// mnum, cnum, modelName이 주어진 경우, 
    // 이에 해당하는 제품번호, 제품명, 기종명, 대표이미지파일명, 제품정가, 할인판매가, 스펙번호, 할인율 가져오기 (productDetailVO 정보는 하얀색 기준으로..)
	List<Map<String,String>> getProductInfo(String mnum, String cnum, String modelName) throws SQLException;
	
	
	
	
	// =========================== 한수연 끝 ======================================
	
}
