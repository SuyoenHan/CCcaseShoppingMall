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
			 
			 String sql = " select qnano, qtitle, fk_userid, qregisterdate, qviewcount, qnapwd, qstatus "+
					 			" from " +
					 			" ( "+
					 			"    select rownum AS rno, qnano, qtitle, fk_userid, qregisterdate, qviewcount, qnapwd, qstatus "+
					 			"    from "+
					 			"    ( "+
					 			"        select qnano, qtitle, fk_userid, qregisterdate, qviewcount, qnapwd, qstatus "+
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
				 qvo.setQnapwd(rs.getString(6));
				 qvo.setQstatus(rs.getString(7));
				 
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

   // 조회수 증가시키기
   @Override
   public void updateViewCount(int qnano) throws SQLException {
      
      try {
           conn = ds.getConnection();
           
           String sql = " update tbl_qna set qviewcount = qviewcount + 1 "
                          + " where qnano = ? ";
              
           pstmt = conn.prepareStatement(sql);
           pstmt.setInt(1, qnano);
              
           int n = pstmt.executeUpdate();
              
           if(n==1) {
              conn.commit();
           }
           
      } finally {
         close();
      }   
      
   }// end of public void updateViewCount(int qnano)---------------------------------
   
   
   // USER 용 메소드
   // qna 글 작성하기(tbl_qna에 insert)
   @Override
   public int writeQna(QnaVO qna) throws SQLException {

      int n = 0;
      
      try {
         conn = ds.getConnection();
         
         String sql = " insert into tbl_qna (qnano, qtitle, fk_userid, email, qcontent, qstatus, qnapwd, fk_productid ) "+
                        " values(seq_qna_qnano.nextval, ?, ?, ?, ?, ?, ?, ?) ";
         
         pstmt = conn.prepareStatement(sql);
         
         pstmt.setString(1, qna.getQtitle());
         pstmt.setString(2, qna.getFk_userid());
         pstmt.setString(3, qna.getEmail());
         pstmt.setString(4, qna.getQcontent());         
         pstmt.setString(5, qna.getQstatus());
         pstmt.setString(6, qna.getQnapwd());
         pstmt.setString(7, qna.getFk_productid());
         
         n = pstmt.executeUpdate();
         
         return n;
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         close();
      }   
      return -1; // 데이터베이스 오류
   }
   
   // qna 글 삭제하기
   @Override
   public int deleteQna(int qnano) throws SQLException{
      int n = 0;
      
      try {
         conn = ds.getConnection();
         
         String sql = " delete from tbl_qna "
                     + " where qnano = ? ";
         
         pstmt = conn.prepareStatement(sql);
         
         pstmt.setInt(1, qnano);
         
         n = pstmt.executeUpdate();
         
         if(n==1) {
              conn.commit();
           }
         
         return n;
      } finally {
         close();
      }
   }
   
   // qna 글 수정하기
   @Override
   public int editQna(QnaVO qna) throws SQLException {
      int n = 0;
      
      try {
         conn = ds.getConnection();
         
         String sql = " update tbl_qna set "
                     + " qtitle=?, qcontent=?, fk_productid=? "
                     + " where qnano = ? ";
         
         pstmt = conn.prepareStatement(sql);
         
         pstmt.setString(1, qna.getQtitle());
         pstmt.setString(2, qna.getQcontent());         
         pstmt.setString(3, qna.getFk_productid());
         pstmt.setInt(4, qna.getQnano());
         
         n = pstmt.executeUpdate();
         
         return n;
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         close();
      }   
      return -1; // 데이터베이스 오류
   }

   // 글번호(qnano)로 qna 글 불러오기
   @Override
   public QnaVO qnaDetail(String qnano) throws SQLException {
      QnaVO qvo = null;
      
      try {
         conn = ds.getConnection();
         
         String sql = " select qnano, qtitle, fk_userid, qregisterdate, email, fk_productid, qstatus, qcontent "
                     + " from tbl_qna "
                     + " where qnano = ?" ;
         
         pstmt = conn.prepareStatement(sql);
         
         pstmt.setString(1, qnano);
         
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


   // ADMIN 용 메소드
   // qna 답글 작성하기(tbl_qnacmt에 insert)
   @Override
   public int replyQna(QnaCmtVO qcvo) throws SQLException {

      int n = 0;
      
      try {
         conn = ds.getConnection();
         
         String sql = " insert into tbl_qnacmt (cmtno, fk_qnano, fk_adminid, cmtcontent) "+
                        " values(seq_qnacmt_cmtno.nextval, ?, ?, ?) ";
         
         pstmt = conn.prepareStatement(sql);
         
         pstmt.setInt(1, qcvo.getFk_qnano());
         pstmt.setString(2, qcvo.getFk_adminid());
         pstmt.setString(3, qcvo.getCmtcontent());

         n = pstmt.executeUpdate();
         
         return n;
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         close();
      }   
      return -1; // 데이터베이스 오류
   }// end of public int replyQna(QnaCmtVO qcvo) throws SQLException--------------------

   // qnano로 qna 답글 불러오기
   @Override
   public List<QnaCmtVO> getCmtList(String fk_qnano) throws SQLException {
      
      List<QnaCmtVO> cmtList = new ArrayList<>();
      
      try {
         conn = ds.getConnection();
         
         String sql = " select C.cmtno, C.fk_adminid, C.cmtregisterday, C.cmtcontent "+
                        " from "+
                        " ( "+
                        "  select cmtno, fk_qnano, fk_adminid, cmtregisterday, cmtcontent "+
                        "  from tbl_qnacmt "+
                        "  where fk_qnano= ? "+
                        " ) C JOIN tbl_qna Q "+
                        " ON C.fk_qnano = Q.qnano ";
         
         pstmt = conn.prepareStatement(sql);
         
         pstmt.setString(1, fk_qnano);
         
         rs = pstmt.executeQuery();
         
         while(rs.next()) {
            
            QnaCmtVO qcvo = new QnaCmtVO();
            
            qcvo.setCmtno(rs.getInt(1));
            qcvo.setFk_adminid(rs.getString(2));
            qcvo.setCmtregisterday(rs.getString(3));
            qcvo.setCmtcontent(rs.getString(4));
            
            cmtList.add(qcvo);

         }
      } finally {
         close();
      }      
      return cmtList;
   }// end of public List<QnaCmtVO> cmtList(String fk_qnano) throws SQLException

   // qna 답글 삭제하기
   @Override
   public int deleteQnaRep(int cmtno) throws SQLException {
      int n = 0;
      
      try {
         conn = ds.getConnection();
         
         String sql = " delete from tbl_qnacmt "
                     + " where cmtno = ? ";
         
         pstmt = conn.prepareStatement(sql);
         
         pstmt.setInt(1, cmtno);
         
         n = pstmt.executeUpdate();
         
         if(n==1) {
              conn.commit();
           }
         
         return n;
      } finally {
         close();
      }
   }


   //마이페이지 게시물관리에서 내가쓴 글 보기
	@Override
	public List<QnaVO> qnaMywrite(Map<String, String> paraMap) throws SQLException {
		 List<QnaVO> qnaList = new ArrayList<>();
		  
	      try {
	          conn = ds.getConnection();
	          
	          String sql = " select qnano, qtitle, fk_userid, qregisterdate, qviewcount   "+
	        		  " from ( select rownum AS rno, qnano, qtitle, fk_userid, qregisterdate, qviewcount "+
	        		  " from "+
	        		  " (   select qnano, qtitle, fk_userid, qregisterdate, qviewcount  "+
	        		  "     from tbl_qna "+
	        		  "     where fk_userid= ? "+
	        		  "     order by qregisterdate desc "+
	        		  " ) V 	                  "+
	        		  " ) T   "+
	        		  " where rno between ? and ? ";

	          
	          pstmt = conn.prepareStatement(sql);
	          
	          int currentShowPageNo = Integer.parseInt( paraMap.get("currentShowPageNo") );
	          int sizePerPage = 5; 
	          
	          pstmt.setString(1, paraMap.get("userid"));
	          pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1)); // 공식
	          pstmt.setInt(3, (currentShowPageNo * sizePerPage)); // 공식 
	          
	          rs = pstmt.executeQuery();
	
	          while(rs.next()) {
	             
	             QnaVO qvo = new QnaVO();
	             qvo.setQnano(rs.getInt("qnano"));
	             qvo.setQtitle(rs.getString("qtitle"));
	             qvo.setFk_userid(rs.getString("fk_userid"));
	             qvo.setQregisterdate(rs.getString("qregisterdate"));
	             qvo.setQviewcount(rs.getInt("qviewcount"));
	             
	             qnaList.add(qvo);
	            
	          }// end of while(rs.next()) ------------------------------------------------------------------------
	          
	      } finally {
	         close();
	      }      
	      return qnaList;
	  
	}



	///페이징 처리
	@Override
	public int qnaMywriteTotalPage(String userid) throws SQLException {
	  int totalPage = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " select ceil(count(*)/5) "  // 10 이 sizePerPage 이다.
	                  + " from tbl_qna "
	                  + " where fk_userid = ? "; 
	         
	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setString(1, userid);
	               
	         rs = pstmt.executeQuery();
	         
	         rs.next();
	         
	         totalPage = rs.getInt(1);
	         
	      } finally {
	         close();
	      }      
	      
	      return totalPage;
	}


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	///////////// 백원빈 시작////////////////////
	@Override
	public int getCntQnaCmt(String sCntQna) throws SQLException {
		
		int cntQnaCmt = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select count(*) ";
			sql += sCntQna;
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				cntQnaCmt=rs.getInt(1);
			}
			
		} finally {
			close();
		}
		
		
		return cntQnaCmt;
	}
	
	
	///////////// 백원빈 끝////////////////////	
}