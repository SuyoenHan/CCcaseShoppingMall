package board.model;


import java.sql.*;
import java.util.*;

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


	// *** 페이징 처리를 한 모든 FAQ 목록 보여주기 *** //
	@Override
	public List<FaqVO> selectPagingFaq(Map<String, String> paraMap) throws SQLException {
		
		List<FaqVO> faqList = new ArrayList<>();
		
		
		try{
			
			conn= ds.getConnection();
			
			String sql = "select faqno, fk_adminid, ftitle,fregisterdate,fupdatedate,fviewcount,fcontent "+
						 "from "+
						  "( "+
						  "    select rownum as rno, faqno, fk_adminid, ftitle,to_char(fregisterdate, 'yyyy-mm-dd') as fregisterdate ,fupdatedate,fviewcount,fcontent "+
						  "    from "+
						  "    ( "+
						  "        select faqno, fk_adminid, ftitle,fregisterdate,fupdatedate,fviewcount,fcontent "+
						  "        from  tbl_faq "+
						 "        order by faqno desc  "+
						 "    )V "+
						 " )T "+
						 "where rno between ? and ?";
			
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1)); //공식
			pstmt.setInt(2, (currentShowPageNo * sizePerPage) );
			
			
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

	// 페이징처리를 위해서 전체FAQ에 대한 총페이지 개수 알아오기(select)  
	@Override
	public int selectTotalPage(Map<String, String> paraMap) throws SQLException {
		
		 int totalPage = 0;
	      
	      try {
	          conn = ds.getConnection();
	          
	          String sql = " select ceil( count(*)/? ) "+
	  					   " from tbl_faq "+
	  					   " order by faqno desc ";
	          
	          pstmt = conn.prepareStatement(sql);
	          pstmt.setString(1, paraMap.get("sizePerPage") );
	          
	          rs = pstmt.executeQuery();
	          
	          rs.next();
	          
	          totalPage = rs.getInt(1);
	      
	        
	      }   finally {
	         close();
	      }
	      
	      return totalPage;
	}

	
	//조회수 증가시키기
	@Override
	public int updateViewCount(String faqno) throws SQLException {

		int n =0; 
		try {
	          conn = ds.getConnection();
	          
	          String sql = " update tbl_faq set fviewcount = fviewcount+1 "+
	        		       " where faqno = ? ";
	          
	          pstmt = conn.prepareStatement(sql);	
	          pstmt.setInt(1, Integer.parseInt(faqno));
	          
	          n= pstmt.executeUpdate();
	
	          if(n==1) {
				  conn.commit();
			  }
	        
	    } catch (SQLException e) {
			     e.printStackTrace();
		}   finally {
	         close();
	    }
		
		return n ;
	      
	}


	
	
	//조회수 select 해오기 
		@Override
		public String selectViewCount(String faqno) throws SQLException {
			String viewCount = null;
			
			try {
		          conn = ds.getConnection();
		          
			
		          String sql = " select fviewcount " + 
		          				"from tbl_faq " + 
		          				"where faqno= ? ";
		        		 
		          
		          pstmt = conn.prepareStatement(sql);
		          pstmt.setInt( 1, Integer.parseInt((faqno)) );
		          
		          
		           rs= pstmt.executeQuery();
		          
		          if(rs.next()) {
		        	
		        	  viewCount= String.valueOf( rs.getInt(1) );
		        	
				  }
		          
			}catch(SQLException e) {
				e.printStackTrace();
			}finally {
		         close();
		    }  
			
			
			return viewCount;
		}
		
	
	

	// 글쓰기 등록하기
	@Override
	public int faqInsert(FaqVO fvo) throws SQLException {
		int n =0 ;
		
		try {
	          conn = ds.getConnection();
	          
		
	          String sql = " insert into tbl_faq ( faqno, fk_adminid, ftitle, fcontent ) "+
	        		  	   " values( seq_faq_faqno.nextval , ? , ? , ? ) ";
	          
	          pstmt = conn.prepareStatement(sql);
	          pstmt.setString(1, fvo.getFk_adminid());
	          pstmt.setString(2, fvo.getFtitle());
	          pstmt.setString(3, fvo.getFcontent());
	          
	          n = pstmt.executeUpdate();
	          
	          if(n==1) {
				  conn.commit();
			  }
	          
		} catch (SQLException e) {
			     e.printStackTrace();
		}   finally {
	         close();
	    }
		return n;
	}




	//FAQ 글내용 수정을 위해 하나의 FAQ를 select해오기
	@Override
	public FaqVO faqEditOneView(String faqno) throws SQLException {
		
		FaqVO fvo= null;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select faqno, fk_adminid, ftitle, to_char(fregisterdate, 'yyyy-mm-dd'), to_char(fupdatedate, 'yyyy-mm-dd'), fviewcount, fcontent "+
						 " from tbl_faq "+
						 " where faqno= ? ";
						 
			
			pstmt = conn.prepareStatement(sql);		
			pstmt.setString(1, faqno);		
			
				
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) { //
				
				
				fvo = new FaqVO();
				
				fvo.setFaqno(rs.getInt(1));
				fvo.setFk_adminid(rs.getString(2));
				fvo.setFtitle(rs.getString(3));
				fvo.setFregisterdate(rs.getString(4));
				fvo.setFupdatedate(rs.getString(5));
				fvo.setNumber(rs.getInt(6));
				fvo.setFcontent(rs.getString(7));
				
	            
			}
		}finally {
			close();
		}
		
		return fvo;
	}
	
	
	

	//FAQ 글내용 수정하기(UPDATE)
	@Override
	public int faqEditUpdate(FaqVO fvo) throws SQLException {
		int n =0;
		
		try {
	          conn = ds.getConnection();
	          
		
	          String sql =  "update tbl_faq set ftitle = ?  "+
	        		  		"                  , fk_adminid= ? "+
	        		  	    "                  , fupdatedate = sysdate  "+
	        		  	    "                  , fcontent= ?  "+
	        		  	    "where faqno = ?  ";
	        		 
	          
	          pstmt = conn.prepareStatement(sql);
	          pstmt.setString(1, fvo.getFtitle());
	          pstmt.setString(2, fvo.getFk_adminid());
	          pstmt.setString(3, fvo.getFcontent());
	          pstmt.setInt(4, fvo.getFaqno());
	          
	          n = pstmt.executeUpdate();
	          
	          if(n==1) {
				  conn.commit();
			  }
	          
	          
		}   finally {
	         close();
	    }  
		
		
		return n;
	}


	//FAQ 글내용 삭제하기(DELETE)
	@Override
	public int faqDeleteOne(FaqVO fvo) throws SQLException {
		int n =0;
		
		try {
	          conn = ds.getConnection();
	          
		
	          String sql = " delete from tbl_faq "+
	        		  	   " where faqno = ? ";
	        		 
	          
	          pstmt = conn.prepareStatement(sql);
	          pstmt.setInt(1, fvo.getFaqno());
	          
	          
	          n = pstmt.executeUpdate();
	          
	          if(n==1) {
				  conn.commit();
			  }
	          
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
	         close();
	    }  
		
		
		return n;
	}

	
	
	///////////////////////////////// 백원빈 시작 ////////////////////////////////
	
	// FAQ글 갯수 알아오기
	@Override
	public int getFaqCnt() throws SQLException {
		
		int faqCnt = 0;
		
		try {
			
			conn = ds.getConnection();
			String sql = " select count(*) "+
						 " from tbl_faq ";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				faqCnt=rs.getInt(1);
			}
			
		} finally {
			close();
		}

		return faqCnt;
	}
	///////////////////////////////// 백원빈 끝 ////////////////////////////////

	
	
	
	
	
}
