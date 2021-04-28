package board.model;

import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class QnaDAO implements InterQnaDAO {
	
	private DataSource ds;
	private Connection conn; 
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자 
	public QnaDAO() {
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

	// 페이징 처리를 한 모든 QNA글 또는 검색한 QNA글 보여주기
	@Override
	public List<QnaVO> selectPagingQna(Map<String, String> paraMap) throws SQLException {
		
		List<QnaVO> qnaList = new ArrayList<>();
		
		try {
			 conn = ds.getConnection();
			 
			 String sql = " select qnano, qtitle, fk_userid, qregisterdate, qviewcount "+
					 			" from " +
					 			" ( "+
					 			"    select rownum AS rno, qnano, qtitle, fk_userid, qregisterdate, qviewcount "+
					 			"    from "+
					 			"    ( "+
					 			"        select qnano, qtitle, fk_userid, qregisterdate, qviewcount "+
					 			"        from tbl_qna " ;
			 
			 	/////////// === 검색어가 있는 경우 시작 === ///////////
			 
				 String colname = paraMap.get("searchType");
				 String searchWord = paraMap.get("searchWord");
				 
				 if( searchWord != null && !searchWord.trim().isEmpty() ) {
					 // 검색어를 입력을 해주는데 공백만이 아닌 실제 검색어를 입력한 경우
					 sql += " where "+colname+" like '%'|| ? ||'%' ";
				 }
				 
				 /////////// === 검색어가 있는 경우 끝 === ///////////
				
				sql += "        order by qregisterdate desc "+
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
				 
				 QnaVO qvo = new QnaVO();
				 qvo.setQnano(rs.getInt(1));
				 qvo.setQtitle(rs.getString(2));
				 qvo.setFk_userid(rs.getString(3));
				 qvo.setQregisterdate(rs.getString(4));
				 qvo.setQviewcount(rs.getInt(5));
				 
				 qnaList.add(qvo);
				 
			 }// end of while(rs.next()) ------------------------------------------------------------------------
			 
		} finally {
			close();
		}		
		return qnaList;
	}

	// 페이징처리를 위해서 QNA글에 대한 총페이지 개수 알아오기(select)
	@Override
	public int selectTotalPage(Map<String, String> paraMap) throws SQLException {
		
		int totalPage = 0;
		
		try {
			 conn = ds.getConnection();
			 
			 String sql = " select ceil( count(*)/? ) "+
					 			" from tbl_qna "; 
			 
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

	// qna 글 작성하기
	@Override
	public int writeQna(QnaVO qna) throws SQLException {

		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " insert into tbl_qna (qnano, fk_userid, fk_productid, email, qtitle, qcontent, qstatus, qnapwd) "+
								" values(seq_qna_qnano.nextval, ?, ?, ?, ?, ?, ?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, qna.getFk_userid());
			pstmt.setString(2, qna.getFk_productid());
			pstmt.setString(3, qna.getEmail());
			pstmt.setString(4, qna.getQtitle());
			pstmt.setString(5, qna.getQcontent());
			pstmt.setString(6, qna.getQstatus());
			pstmt.setString(7, qna.getQnapwd());
			
			n = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}	
		return n;
		
	}

	// 제목(qtitle)으로 qna 글 불러오기
	@Override
	public QnaVO qnaDetail(String qtitle) throws SQLException {
		QnaVO qvo = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select qnano, qtitle, fk_userid, qregisterdate, email, fk_productid, qstatus, qcontent "
							+ " from tbl_qna "
							+ " where qtitle = ? " ;
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, qtitle);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				qvo = new QnaVO();
				
				qvo.setQnano(rs.getInt(1));
				qvo.setQtitle(rs.getString(2));
				qvo.setFk_userid(rs.getString(3));
				qvo.setQregisterdate(rs.getString(4));
				qvo.setEmail(rs.getString(5));
				qvo.setFk_productid(rs.getString(6));
				qvo.setQstatus(rs.getString(7));
				qvo.setQcontent(rs.getString(8));
			}
		} finally {
			close();
		}		
		return qvo;
	}
}
