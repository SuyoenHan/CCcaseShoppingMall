package admin.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterAdminDAO {
	
	////////////////////백원빈 시작 ///////////////////////////
	// 로그인관련 메소드
	AdminVO checkid(Map<String, String> paraMap) throws SQLException;
	
	// 전일 총 판매량 메소드
	int getYesterdayPdQty() throws SQLException;
	
	// 금일 총 판매량 메소드
	int getTodayPdQty() throws SQLException;
	
	// 전일 총 판매액 메소드
	List<Map<String,Integer>> getYesterProfitList() throws SQLException;
	
	// 금일 총 판매량 메소드
	List<Map<String,Integer>> getTodayProfitList() throws SQLException;
	
	// 금일 케이스별 판매량
	int getCaseSaleQty(int cnum) throws SQLException;
	
	// 회원 케이스별 회원수 알아오기
	int getCntMember(String sAllMemberCnt) throws SQLException;
	


	////////////////////백원빈 끝 ///////////////////////////	
	
	
	
	
}
