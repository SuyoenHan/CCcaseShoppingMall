package member.model;

import java.sql.SQLException;
import java.util.*;

public interface InterCouponDAO {
	
	// 사용가능 쿠폰 개수
	int countAvalCpQty(String string) throws SQLException;

	// 사용불가 쿠폰 개수
	int countUnavalCpQty(String string) throws SQLException;
	
	// 아이디를 가지고 해당 쿠폰 정보 조회해오기
	List<CouponVO> selectCouponList(Map<String, String> paraMap) throws SQLException;
	
	
	

}
