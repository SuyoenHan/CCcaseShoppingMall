package order.model;

import java.sql.SQLException;
import java.util.List;


public interface InterOrderDAO {
	
	// 나의 주문내역  select 해오기
	List<OrderVO> myOrderList(String userid) throws SQLException;

	
	
	
	
	
	
	
}
