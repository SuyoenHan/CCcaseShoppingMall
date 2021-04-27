package product.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class CategoryDAO implements InterCategoryDAO {

	private DataSource ds;
	private Connection conn; 
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자 
	public CategoryDAO() {
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

	// =========================== 한수연 시작 ======================================
	// 카테코리코드에 해당하는 카테고리명 반환
	@Override
	public String getCname(String cnum) throws SQLException {
		
		String cname=null;
		
		try {
			conn=ds.getConnection();
			String sql= " select cname from tbl_category where cnum= ? ";
			
			/*
			  	cnum==1 인 경우 하드케이스
			  	cnum==2 인 경우 젤리케이스
			  	cnum==3 인 경우 범퍼케이스
			  	cnum==4 인 경우 악세사리
			*/
			
			pstmt= conn.prepareStatement(sql);
			pstmt.setInt(1,Integer.parseInt(cnum));
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				cname=rs.getString(1);
			}
			
		}finally {
			close();
		}
		
		return cname;
		
		/*
		 	cname==null 인 경우 cnum에 해당하는 카테고리명이 존재하지 않음
		 	cname!=null 인 경우 cnum에 해당하는 카테고리명 존재
		 */
	}
	// =========================== 한수연 끝 ======================================
}
