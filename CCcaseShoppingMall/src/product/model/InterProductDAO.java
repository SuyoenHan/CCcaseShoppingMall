package product.model;

import java.sql.*;
import java.util.*;

public interface InterProductDAO {

	// =========================== 한수연 시작 ======================================
	
	// 핸드폰 제조사별 케이스 하드케이스 ,젤리케이스 ,범퍼케이스  개수 반환
	int calCntByCompany(int mnum, int cnum) throws SQLException;

	// mnum과 cnum이 주어진 경우, 이에 해당하는 기종명 반환 (중복되는 기종명은 1번만 사용)
	List<String> getModelName(String mnum, String cnum) throws SQLException;
	
	// 제품 총페이지 개수 반환 메소드
	int selectTotalPage(Map<String, String> pageMap) throws SQLException;

	// 한페이지에 보여줄 제품정보 메소드
	List<Map<String, String>> selectPagingProduct(Map<String, String> pageMap) throws SQLException;

	

	

	
	
	// =========================== 한수연 끝 ======================================
	
	
	
	
	
	
	
	
	
	
	
	// =========================== 백원빈 시작 ======================================
	// product테이블에 insert하는 메소드
	String insertProduct(Map<String, String> promap) throws SQLException;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// =========================== 백원빈 끝 ======================================
	
}
