package product.model;

import java.sql.SQLException;

public interface InterMobileCompanyDAO {

	// =========================== 한수연 시작 ======================================
	// 핸드폰제조회사코드에 해당하는 회사명 반환
	String getMname(String mnum) throws SQLException;
	
	// =========================== 한수연 끝 ======================================

}
