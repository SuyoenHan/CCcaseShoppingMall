package board.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class FaqDAO implements InterFaqDAO {

	private DataSource ds;
	private Connection conn; 
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자 
	public FaqDAO() {
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


	// 모든 faq select 해와서 목록에 보여주기
	@Override
	public List<FaqVO> faqAllView() throws SQLException {
		
		List<FaqVO> faqList = new ArrayList<>();
		
		try{
			
			conn= ds.getConnection();
			
			String sql = " select faqno, fk_adminid, ftitle,fregisterdate,fupdatedate,fviewcount,fcontent "+
					     " from tbl_faq " +
					     " order by fregisterdate desc";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				FaqVO fvo = new FaqVO();
				fvo.setFaqno(rs.getInt(1));
				fvo.setFk_adminid(rs.getString(2));
				fvo.setFtitle(rs.getString(3));
				fvo.setFregisterdate(rs.getString(4));
				fvo.setFupdatedate(rs.getString(5));
				fvo.setNumber(rs.getInt(6));
				fvo.setFcontent(rs.getString(7));
				
				faqList.add(fvo);
				
			}
			
		}finally {
			close();
		}
		
		
		return faqList;
	}
	
	
}
