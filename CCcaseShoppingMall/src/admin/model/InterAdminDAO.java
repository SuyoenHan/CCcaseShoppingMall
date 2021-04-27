package admin.model;

import java.sql.SQLException;
import java.util.Map;

public interface InterAdminDAO {
	
	// 로그인관련 메소드
	AdminVO checkid(Map<String, String> paraMap) throws SQLException;
	
	
	
	
	
}
