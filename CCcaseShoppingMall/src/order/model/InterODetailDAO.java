package order.model;

import java.sql.SQLException;

public interface InterODetailDAO {

	// =========== 한수연 시작 =====================
	
	// odetailno로 tbl_odetail에서 fk_pnum 가져오는 메소드
	String getPnumByOdetailNo(String odetailno) throws SQLException;
	
	// =========== 한수연 끝 =====================
}
