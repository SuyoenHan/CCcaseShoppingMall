package product.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class SpecDAO implements InterSpecDAO {
	
	private DataSource ds;
	private Connection conn; 
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자 
	public SpecDAO() {
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semioracle");
		} catch(NamingException e) {
			e.printStackTrace();
		}
	}
	
	
	// 사용한 자원을 반납하는 close() 메소드 생성하기 
	private void close() {
		try {
			if(rs != null)    {rs.close();    rs=null;}
			if(pstmt != null) {pstmt.close(); pstmt=null;}
			if(conn != null)  {conn.close();  conn=null;}
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}

	
	// 스펙목록 조회해오기
	@Override
	public List<HashMap<String, String>> selectSpec() throws SQLException {
		
		List<HashMap<String, String>> specList = new ArrayList<>();
		
		
		try {
			
			conn = ds.getConnection();
			String sql = " select snum, sname "+
						 " from tbl_spec" ;
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				HashMap<String,String> map = new HashMap<>();
				map.put("snum", String.valueOf(rs.getInt(1)));
				map.put("sname", rs.getString(2));
				
				specList.add(map);
			}
			
		} finally {
			close();
		}
		return specList;
	}
	
	
	
	
	
}
