package member.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterInterestProductDAO {

	// ========================== 한수연 시작 ===================================== 
	
	// 특정상품을 관심상품 테이블에 insert(중복된다면 insert 불가)
	int insertInterestProduct(InterestProductVO ipvo) throws SQLException;

	// userid가 주어졌을 때 이에 해당하는 관심상품 테이블 행 select
	List<Map<String, String>> selectInterestPInfo(String userid) throws SQLException;

	// interestno가 주어졌을 때 이에 해당하는 관심상품 행 delete
	int deleteOneRow(int interestno) throws SQLException;

	// ========================== 한수연 끝 ===================================== 
}
