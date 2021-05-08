package order.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterOrderDAO {

	// 나의 주문내역  더보기 페이징 방식으로 select 해오기 -3개월 내의
	List<OrderVO> selectByOrderList(Map<String, String> paraMap) throws SQLException;

	// Ajax(JSON)를 사용하여 주문내역을 "더보기" 방식으로 페이징처리 해주기 위해  아이디별로 전체개수 알아오기-3개월내의 // 
	int totalOrderListCount(String userid) throws SQLException;
	
	//배송 조회하기
	List<OrderVO> shipStatusView(String orderno) throws SQLException;
	
	/////////////////////////// 백원빈 시작 ///////////////////////////////
	//교환 접수시 배송상태 변경해주는 메소드
	int updatestatus(String odetailno) throws SQLException;
	
	//환불 접수시 배송상태 변경해주는 메소드
	int updaterefundstatus(String odetailno) throws SQLException;
	
	// pnum을 가지고, 주문페이지에서 필요한 정보 뽑아오기(select)
	Map<String, String> manyOrderPageInfo(String string) throws SQLException;
	
	
	// 주문번호를 채번하는 메소드
	String getOrderno() throws SQLException;
	
	// 즉시구매시 여러 테이블에 insert 및  등등 작업
	int orderAdd(Map<String, String> para2Map) throws SQLException;
	
	// 장바구니에서 한개 상품만 구매 시 여러 테이블에 insert 및  등등 작업
	int oneCartorder(Map<String, String> para2Map) throws SQLException;
	
	// 장바구니에 여러 제품이 들어왔을 경우 주문했을때 테이블 작업
	int manyOrderAdd(Map<String, Object> paraMap) throws SQLException;
	
	/////////////////////////// 백원빈 끝 ///////////////////////////////	

	
	
	
	
	
	
	
	// ================== 조연재 시작 ===================== //

	// 상품 바로주문시 주문할 상품 정보 불러오기
	Map<String,String> oneOrderPageInfo(String pnum) throws SQLException;
	
	
	
	
	
	
	//###################조승진 시작########################//
	//리뷰 가능한 상품 불러오기
	List<OrderVO> byreview(Map<String, String> paraMap) throws SQLException;
	//###################조승진 끝########################//
	
	




	
}
