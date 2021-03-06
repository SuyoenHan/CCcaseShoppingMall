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

public class NoticeDAO implements InterNoticeDAO {
	
	private DataSource ds;
	private Connection conn; 
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자 
	public NoticeDAO() {
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

	// *** 페이징 처리를 한 모든 공지사항 목록 보여주기 *** //
	@Override
	public List<NoticeVO> selectPagingNotice(Map<String, String> paraMap) throws SQLException {
		List<NoticeVO> noticeList = new ArrayList<>();
		
		
		try{
			
			conn= ds.getConnection();
			
			String sql = "select noticeno, fk_adminid, ntitle, nregisterdate ,nupdatedate ,nviewcount,ncontent "+
						 "from "+
						  "( "+
						  "    select rownum as rno, noticeno, fk_adminid, ntitle, to_char(nregisterdate, 'yyyy-mm-dd') as nregisterdate, to_char(nupdatedate, 'yyyy-mm-dd') as nupdatedate ,nviewcount,ncontent "+
						  "    from "+
						  "    ( "+
						  "        select noticeno, fk_adminid, ntitle, nregisterdate ,nupdatedate ,nviewcount,ncontent "+
						  "        from  tbl_notice "+
						 "        order by noticeno desc  "+
						 "    )V "+
						 " )T "+
						 " where rno between ? and ?";
			
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1)); //공식
			pstmt.setInt(2, (currentShowPageNo * sizePerPage) );
			
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				NoticeVO nvo = new NoticeVO();
				nvo.setNoticeno(rs.getInt(1));
				nvo.setFk_adminid(rs.getString(2));
				nvo.setNtitle(rs.getString(3));
				nvo.setNregisterdate(rs.getString(4));
				nvo.setNupdatedate(rs.getString(5));
				nvo.setNviewcount(rs.getInt(6));
				nvo.setNcontent(rs.getString(7));
				
				noticeList.add(nvo);
				
			}
			
		}finally {
			close();
		}
		
		
		return noticeList;
	}

	// 페이징처리를 위해서 전체 공지사항에 대한 총페이지 개수 알아오기(select) 
	@Override
	public int selectTotalPage(Map<String, String> paraMap) throws SQLException {
		int totalPage = 0;
	      
	      try {
	          conn = ds.getConnection();
	          
	          String sql = " select ceil( count(*)/? ) "+
	  					   " from tbl_notice "+
	  					   " order by noticeno desc ";
	          
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
	public int updateViewCount(String noticeno) throws SQLException {
		int n=0;
		try {
	          conn = ds.getConnection();
	          
	          String sql = " update tbl_notice set nviewcount = nviewcount+1 "+
	        		       " where noticeno = ? ";
	          
	          pstmt = conn.prepareStatement(sql);	
	          pstmt.setInt(1, Integer.parseInt(noticeno));
	          
	          n= pstmt.executeUpdate();
	
	          if(n==1) {
				  conn.commit();
			  }
	        
	    } catch (SQLException e) {
			     e.printStackTrace();
		}finally {
	         close();
	    }
		
		return n ;
	
	}
	
	
	
	

	//조회수 select 해오기 
	@Override
	public String selectNoticeViewCount(String noticeno) {
		String viewCount = null;
		
		try {
	          conn = ds.getConnection();
	          
		
	          String sql = " select nviewcount " + 
	          				"from tbl_notice " + 
	          				"where noticeno= ? ";
	        		 
	          
	          pstmt = conn.prepareStatement(sql);
	          pstmt.setInt( 1, Integer.parseInt((noticeno)) );
	          
	          
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
		public int noticeInsert(NoticeVO nvo) throws SQLException {
			int n =0 ;
			
			try {
		          conn = ds.getConnection();
		          
			
		          String sql = " insert into tbl_notice ( noticeno, fk_adminid, ntitle, ncontent ) "+
		        		  	   " values( seq_notice_noticeno.nextval , ? , ? , ? ) ";
		          
		          pstmt = conn.prepareStatement(sql);
		          pstmt.setString(1, nvo.getFk_adminid());
		          pstmt.setString(2, nvo.getNtitle());
		          pstmt.setString(3, nvo.getNcontent());
		          
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
		
		
		
		//notice 글내용 수정을 위해 하나의 FAQ를 select해오기
		@Override
		public NoticeVO noticeEditOneView(String noticeno) throws SQLException {
			
			NoticeVO nvo= null;
			
			try {
				
				conn = ds.getConnection();
				
				String sql = " select noticeno, fk_adminid, ntitle, to_char(nregisterdate, 'yyyy-mm-dd'), to_char(nupdatedate, 'yyyy-mm-dd'), nviewcount, ncontent "+   
							 " from tbl_notice "+
							 " where noticeno= ? ";
							 
				
				pstmt = conn.prepareStatement(sql);		
				pstmt.setString(1, noticeno);		
				
					
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) { //
					
					
					nvo = new NoticeVO();
					
					nvo.setNoticeno(rs.getInt(1));
					nvo.setFk_adminid(rs.getString(2));
					nvo.setNtitle(rs.getString(3));
					nvo.setNregisterdate(rs.getString(4));
					nvo.setNupdatedate(rs.getString(5));
					nvo.setNviewcount(rs.getInt(6));
					nvo.setNcontent(rs.getString(7));
					
		            
				}
			}finally {
				close();
			}
			
			return nvo;
		}
		
		
		

		//NOTICE 글내용 수정하기(UPDATE)
		@Override
		public int noticeEditUpdate(NoticeVO nvo) throws SQLException {
			int n =0;
			
			try {
		          conn = ds.getConnection();
		          
			
		          String sql =  "update tbl_notice set ntitle = ?  "+
		        		  		"                  , fk_adminid= ? "+
		        		  	    "                  , nupdatedate = sysdate  "+
		        		  	    "                  , ncontent= ?  "+
		        		  	    "where noticeno = ?  ";
		        		 
		          
		          pstmt = conn.prepareStatement(sql);
		          pstmt.setString(1, nvo.getNtitle());
		          pstmt.setString(2, nvo.getFk_adminid());
		          pstmt.setString(3, nvo.getNcontent());
		          pstmt.setInt(4, nvo.getNoticeno());
		          
		          n = pstmt.executeUpdate();
		          
		          if(n==1) {
					  conn.commit();
				  }
		          
		          
			}catch(SQLException e) {
				e.printStackTrace();
			}
			finally {
		         close();
		    }  
			
			
			return n;
		}


		//FAQ 글내용 삭제하기(DELETE)
		@Override
		public int noticeDeleteOne(NoticeVO nvo) throws SQLException {
			int n =0;
			
			try {
		          conn = ds.getConnection();
		          
			
		          String sql = " delete from tbl_notice "+
		        		  	   " where noticeno = ? ";
		        		 
		          
		          pstmt = conn.prepareStatement(sql);
		          pstmt.setInt(1, nvo.getNoticeno());
		          
		          
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

		//////////////////////////////// 백원빈 시작 ////////////////////////////////////
		// 공지사항 글 갯수 알아오기
		@Override
		public int getNoticeCnt() throws SQLException {
			
			int noticeCnt = 0;
			
			try {
				
				conn = ds.getConnection();
				String sql = " select count(*) "+
							 " from tbl_notice ";
				
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					noticeCnt=rs.getInt(1);
				}
				
			} finally {
				close();
			}
			
			
			return noticeCnt;
		}
		//////////////////////////////백원빈 시작 //////////////////////////////////////



		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	
}
