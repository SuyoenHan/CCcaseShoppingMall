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

	
	
	
	
	
	
	
	
	
	
	
	// ====================== 한수연 시작 =========================
	
	// 배송옵션이에 따른 제품정보 반환 메소드 (색상도 고려)
	List<Map<String, String>> selectPInfoByDelivery(String doption) throws SQLException;

	// productid가 주어진 경우, 이에 해당하는 제품상세정보 반환 메소드
	List<Map<String, String>> getOnePDetailInfo(String productid) throws SQLException;
	
	// pnum이 주어진 경우, 이에 해당하는 배송옵션 반환 메소드
	int getDOptionByPnum (String pnum) throws SQLException;
	
	// ====================== 한수연 끝 =========================

}
