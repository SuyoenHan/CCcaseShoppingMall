package order.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import member.model.MemberVO;

public interface InterOrderDAO {

	// 나의 주문내역  더보기 페이징 방식으로 select 해오기 -3개월 내의
	List<OrderVO> selectByOrderList(Map<String, String> paraMap) throws SQLException;

	// Ajax(JSON)를 사용하여 주문내역을 "더보기" 방식으로 페이징처리 해주기 위해  아이디별로 전체개수 알아오기-3개월내의 // 
	int totalOrderListCount(String userid) throws SQLException;
	
	//배송 조회하기
	List<OrderVO> shipStatusView(String orderno) throws SQLException;
	
	/////////////////////////// 백원빈 시작 ///////////////////////////////
	//교환 접수시 배송상태 변경해주는 메소드
	int updatestatus(String orderno) throws SQLException;
	
	//환불 접수시 배송상태 변경해주는 메소드
	int updaterefundstatus(String orderno) throws SQLException;

	/////////////////////////// 백원빈 끝 ///////////////////////////////	

	
}
