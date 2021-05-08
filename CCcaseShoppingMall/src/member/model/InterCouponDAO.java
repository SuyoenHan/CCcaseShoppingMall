package member.model;

import java.sql.SQLException;
import java.util.*;

public interface InterCouponDAO {
	
	// 사용가능 쿠폰 개수
	int countAvalCpQty(String string, String userid) throws SQLException;

	// 사용불가 쿠폰 개수
	int countUnavalCpQty(String string, String string1, String userid) throws SQLException;
	
	// 아이디를 가지고 해당 쿠폰 정보 조회해오기
	List<CouponVO> selectCouponList(Map<String, String> paraMap) throws SQLException;
	
	//////////////////////////// 백원빈 시작///////////////////////////////
	// 주문시 사용가능한 쿠폰 조회해오기
	List<Map<String, String>> selectAvailCoupon(String fk_userid) throws SQLException;
	
	// 쿠폰번호를 가지고 할인율을 가져오는 메소드
	String getCouponsale(String cpno) throws SQLException;
	//////////////////////////   백원빈   끝///////////////////////////////

	
	// ======================= 한수연 시작 ===============================
	
	// 이벤트로 발급된 쿠폰 insert 메소드 
	int insertCoupon(CouponVO cpvo) throws SQLException;
	
	// ======================= 한수연 끝 ===============================
	
	
	

}
