package board.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterChRefundDAO {
	
	///////////////// 백원빈 시작 //////////////////////
	
	// 교환및환불 리스트 조회해 오기
	List<Map<String, String>> selectchRefundList() throws SQLException;
	
	
	
	///////////////// 백원빈 끝 //////////////////////	
	
}
