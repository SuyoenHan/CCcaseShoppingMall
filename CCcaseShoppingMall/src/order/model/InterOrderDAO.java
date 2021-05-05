package order.model;

import java.sql.SQLException;
import java.util.List;

import member.model.MemberVO;

public interface InterOrderDAO {

	
	// 나의 주문내역  select 해오기
	List<OrderVO> myOrderList(String userid) throws SQLException;

	//배송 조회하기
	List<OrderVO> shipStatusView(String orderno) throws SQLException;

	
}
