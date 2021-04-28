package product.model;

import java.sql.SQLException;
import java.util.List;

public interface InterMobileCompanyDAO {

	// =========================== 한수연 시작 ======================================
	// 핸드폰제조회사코드에 해당하는 회사명 반환
	String getMname(String mnum) throws SQLException;

	
	// =========================== 한수연 끝 ======================================
	
	// =========================== 백원빈 시작 ======================================
	// 회사목록 조회 
	List<MobileCompanyVO> selectCompany() throws SQLException;
	// =========================== 백원빈 끝 ======================================

}
