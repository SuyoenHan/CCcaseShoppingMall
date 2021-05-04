package board.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class EventDAO implements InterEventDAO {
	
	private DataSource ds;
	private Connection conn; 
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자 
	public EventDAO() {
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
	

	// 페이징 처리를 한 모든 이벤트글 또는 검색한 이벤트글 보여주기
	@Override
	public List<EventVO> selectPagingEvent(Map<String, String> paraMap) throws SQLException {
		
		List<EventVO> eventList = new ArrayList<>();
		
		try {
			 conn = ds.getConnection();
			 
			 String sql = " select eventno, fk_adminid, title, startdate, enddate, registerdate, viewcount "+
					 			" from " +
					 			" ( "+
					 			"    select rownum AS rno, eventno, fk_adminid, title, startdate, enddate, registerdate, viewcount "+
					 			"    from "+
					 			"    ( "+
					 			"        select eventno, fk_adminid, title, startdate, enddate, registerdate, viewcount "+
					 			"        from tbl_event " ;
			 
			 	/////////// === 검색어가 있는 경우 시작 === ///////////
			 
				 String colname = paraMap.get("searchType");
				 String searchWord = paraMap.get("searchWord");
				 
				 if( searchWord != null && !searchWord.trim().isEmpty() ) {
					 // 검색어를 입력을 해주는데 공백만이 아닌 실제 검색어를 입력한 경우
					 sql += " where "+colname+" like '%'|| ? ||'%' ";
				 }
				 
				 /////////// === 검색어가 있는 경우 끝 === ///////////
				
				sql += "        order by registerdate desc "+
			 	 			"    ) V "+
			 				" ) T "+
			 				" where rno between ? and ? "; 
			
			 
			 int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			 int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage")); 
			 
			 pstmt = conn.prepareStatement(sql);
			 
			 if(searchWord!=null && !searchWord.trim().isEmpty()) {// 검색어 있는 경우
				 pstmt.setString(1, searchWord);
				 pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1) );
				 pstmt.setInt(3, (currentShowPageNo * sizePerPage));		 
			 }
			 else {// 검색어 없는 경우
				 pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1) );
				 pstmt.setInt(2, (currentShowPageNo * sizePerPage));		 
			 }
			 
			 rs = pstmt.executeQuery();

			 while(rs.next()) {
		 
				 EventVO evo = new EventVO();
				 evo.setEventno(rs.getInt(1));
				 evo.setFk_adminid(rs.getString(2));
				 evo.setTitle(rs.getString(3));
				 evo.setStartdate(rs.getString(4));
				 evo.setEnddate(rs.getString(5));
				 evo.setRegisterdate(rs.getString(6));
				 evo.setViewcount(rs.getInt(7));
				
				 eventList.add(evo);
			 }// end of while(rs.next()) ------------------------------------------------------------------------
			 
		} finally {
			close();
		}		
		return eventList;
	}

	// 페이징처리를 위해서 이벤트글에 대한 총페이지 개수 알아오기(select)
	@Override
	public int selectTotalPage(Map<String, String> paraMap) throws SQLException {
		
		int totalPage = 0;
		
		try {
			 conn = ds.getConnection();
			 
			 String sql = " select ceil( count(*)/? ) "+
					 			" from tbl_event "; 
			 
			 /////////// === 검색어가 있는 경우 시작 === ///////////
			 
			 String colname = paraMap.get("searchType");
			 String searchWord = paraMap.get("searchWord");
			 
			 if( searchWord != null && !searchWord.trim().isEmpty() ) {
				 // 검색어를 입력을 해주는데 공백만이 아닌 실제 검색어를 입력한 경우
				 sql += " where "+colname+" like '%'|| ? ||'%' ";
			 }
			 
			 /////////// === 검색어가 있는 경우 끝 === ///////////
			 
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, paraMap.get("sizePerPage"));
			 
			 if( searchWord != null && !searchWord.trim().isEmpty() ) {
				 // 검색어를 입력을 해주는데 공백만이 아닌 실제 검색어를 입력한 경우
				 pstmt.setString(2, searchWord);
			 }
			 
			 rs = pstmt.executeQuery();

			 rs.next();
			 
			 totalPage = rs.getInt(1);
			 
		} finally {
			close();
		}	
		return totalPage;
	}

	// 조회수 증가시키기
	@Override
	public void updateViewCount(int eventno) throws SQLException {
		
		try {
			  conn = ds.getConnection();
			  
			  String sql = " update tbl_event set viewcount = viewcount + 1 "
				  	     	 + " where eventno = ? ";
				  
			  pstmt = conn.prepareStatement(sql);
			  pstmt.setInt(1, eventno);
				  
			  int n = pstmt.executeUpdate();
				  
			  if(n==1) {
				  conn.commit();
			  }
			  
		} finally {
			close();
		}	
		
	}

	// 이벤트글 작성하기
	@Override
	public int writeEvent(EventVO evt) throws SQLException {
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " insert into tbl_event (eventno, title, fk_adminid, startdate, enddate, registerdate, content ) "+
								" values(seq_event_eventno.nextval, ?, ?, ?, ?, ?, ? ) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, evt.getTitle());
			pstmt.setString(2, evt.getFk_adminid());
			pstmt.setString(3, evt.getStartdate());			
			pstmt.setString(4, evt.getEnddate());
			pstmt.setString(5, evt.getRegisterdate());
			pstmt.setString(6, evt.getContent());
			
			n = pstmt.executeUpdate();
			
			return n;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}	
		return -1; // 데이터베이스 오류
	}

	// 이벤트글 삭제하기
	@Override
	public int deleteEvent(int eventno) throws SQLException {
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " delete from tbl_event "
							+ " where eventno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, eventno);
			
			n = pstmt.executeUpdate();
			
			if(n==1) {
				  conn.commit();
			  }
			
			return n;
		} finally {
			close();
		}
	}

	// 이벤트글 수정하기
	@Override
	public int editEvent(EventVO evt) throws SQLException {
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " update tbl_event set "
							+ " title=?, content=?, startdate = ?, enddate=? "
							+ " where eventno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, evt.getTitle());
			pstmt.setString(2, evt.getContent());			
			pstmt.setString(3, evt.getStartdate());
			pstmt.setString(4, evt.getEnddate());
			pstmt.setInt(5, evt.getEventno());
			
			n = pstmt.executeUpdate();
			
			return n;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}	
		return -1; // 데이터베이스 오류
	}

	// eventno로 이벤트글 불러오기
	@Override
	public EventVO eventDetail(String eventno) throws SQLException {
		EventVO evo = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select eventno, fk_adminid, title, startdate, enddate, registerdate, content "
							+ " from tbl_event "
							+ " where eventno = ?" ;
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, eventno);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				evo = new EventVO();
				
				evo.setEventno(rs.getInt(1));
				evo.setFk_adminid(rs.getString(2));
				evo.setTitle(rs.getString(3));
				evo.setStartdate(rs.getString(4));
				evo.setEnddate(rs.getString(5));
				evo.setRegisterdate(rs.getString(6));
				evo.setContent(rs.getString(7));

			}
		} finally {
			close();
		}		
		return evo;
	}

	

}
