package member.model;

import java.sql.SQLException;
import java.util.*;

public interface InterCouponDAO {
	
	// 아이디를 가지고 해당 쿠폰 정보 조회해오기
	CouponVO selectCouponByUserid(String userid) throws SQLException;

	// 쿠폰 개수 조회하기
	int countCouponQty(String cpstatus) throws SQLException;

}
