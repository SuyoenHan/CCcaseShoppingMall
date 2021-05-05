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

	
	// 제품리스트에서 특정행의 정보를 뽑아오기(select)
	Map<String, String> proOneDetail(String pnum) throws SQLException;
	
	// 제품리스트에서 특정행 update
	int updateProductDetail(Map<String, String> pdetailmap) throws SQLException;
	
	
	
	
	
	
	// ====================== 한수연 시작 =========================
	
	// 배송옵션이에 따른 제품정보 반환 메소드 
	List<Map<String, String>> selectPInfoByDelivery(String doption) throws SQLException;

	// productid가 주어진 경우, 이에 해당하는 제품상세정보 반환 메소드
	List<Map<String, String>> getOnePDetailInfo(String productid) throws SQLException;
	
	// pnum이 주어진 경우, 이에 해당하는 배송옵션 반환 메소드
	int getDOptionByPnum (String pnum) throws SQLException;

	// pnum이 주어진 경우, 배송옵션과 색깔 반환 메소드
	Map<String,String> getColorDelivery (String pnum) throws SQLException;
	
	// productid와 snum이 주어진 경우 여러 pnum중 snum에 해당하는 제품 1개 행만 반환하는 메소드
	String getPnumBySnum (String productid, String snum) throws SQLException;
	
	// productid와 doption이 주어진 경우 여러 pnum중 doption에 해당하는 제품 1개 행만 반환하는 메소드
	String getPnumByDoption (String productid, String doption) throws SQLException;
	
	// ====================== 한수연 끝 =========================

}
