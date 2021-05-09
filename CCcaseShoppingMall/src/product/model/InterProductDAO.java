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

	// mnum, cnum이 주어진 경우, 모델그룹별 개수 반환
	List<Map<String,String>> getCntByModel (String mnum, String cnum) throws SQLException;


	// snum이 주어진 경우, 이에 해당하는 제품정보 반환 메소드
	List<Map<String, String>> selectPInfoBySpec(String snum) throws SQLException;
	
	// productid가 주어진 경우, 이에 해당하는 제품정보 반환 메소드
	Map<String, String> getOnePInfo(String productid) throws SQLException;
	
	// 존재하는 productid 모두 조회
	List<String> getProductId() throws SQLException; 
	
	// pnum이 주어진 경우, 이에 해당하는 productname과 pcolor 반환 메소드
	Map<String,String> getProductnameByPnum(String pnum) throws SQLException;
	
	
	// =========================== 한수연 끝 ======================================
	
	
	
	
	
	
	
	
	
	// =========================== 백원빈 시작 ======================================
	// product테이블에 insert하는 메소드
	String insertProduct(Map<String, String> promap) throws SQLException;
	
	// 기종명 조회해오기(select)
	List<String> getgijongname() throws SQLException;
	
	// totalPage 알아오기
	int getTotalPage(Map<String, String> paraMap) throws SQLException;

	// productid를 가져와, 제품등록화면에 값을 넣어주는 메소드
	Map<String, String> getProInfo(String productid) throws SQLException;

	
	
	// productid를 가져와, 제품등록 테이블에 특정행을 업데이트시켜주는 메소드
	int updateProduct(Map<String, String> promap) throws SQLException;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// =========================== 백원빈 끝 ======================================
	
}
