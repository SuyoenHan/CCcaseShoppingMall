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
	public void updateViewCount(String faqno) throws SQLException {

		try {
	          conn = ds.getConnection();
	          
	          String sql = " update tbl_faq set fviewcount = fviewcount+1 "+
	        		       " where faqno = ? ";
	          
	          pstmt = conn.prepareStatement(sql);	
	          pstmt.setInt(1, Integer.parseInt(faqno));
	          
	          int n= pstmt.executeUpdate();
	
	          if(n==1) {
				  conn.commit();
			  }
	        
	    } catch (SQLException e) {
			     e.printStackTrace();
		}   finally {
	         close();
	    }
	      
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
	
	
}
