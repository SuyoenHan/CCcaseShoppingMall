package board.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterChRefundDAO {
	
	///////////////// 백원빈 시작 //////////////////////
	
	// 교환및환불 리스트 조회해 오기
	List<Map<String, String>> selectchRefundList() throws SQLException;
	
	// 교환및환불 접수 시 교환 및 환불테이블에 insert작업
	int insertChRefund(Map<String, String> paraMap) throws SQLException;
	
	// 관리자가 승인 시 해당행을 테이블에서 delete하는 작업
	int deleteView(String fk_odetailno,Integer shipstatus) throws SQLException;
	
	
	
	///////////////// 백원빈 끝 //////////////////////	
	
}
