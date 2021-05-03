package member.model;

import java.sql.SQLException;
import java.util.*;

public interface InterCartDAO {
	
	// ========================== 한수연 시작 ============================
	// 선택한 상품  tbl_cart 테이블로 insert
	int insertWishList(CartVO ctvo) throws SQLException;

	// userid가 주어졌을 때 이에 해당하는 장바구니 테이블 행 select
	List<Map<String,String>> selectCartInfo(String userid) throws SQLException;
	
	// ========================== 한수연 끝 ============================
}
