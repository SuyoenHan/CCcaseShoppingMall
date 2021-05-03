package board.model;

import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import product.model.ImageFileVO;
import product.model.ProductDetailVO;
import product.model.SpecVO;

public class ReviewDAO implements InterReviewDAO {
	
	private DataSource ds;
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자
	public ReviewDAO() {
		try {
			Context initContext = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("jdbc/semioracle");
		} catch(NamingException e) {
			e.printStackTrace();
		}
	}
	
	// 사용한 자원을 반납하는 close() 메소드 생성하기 
	private void close() {
		try {
			if(rs != null) {rs.close(); rs=null;}
			if(pstmt != null) {pstmt.close(); pstmt=null;}
			if(conn != null) {conn.close(); conn=null;}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	// 페이징처리를 위해서 전체리뷰에 대한 총페이지 개수 알아오기(select)
	@Override
	public int selectTotalPage(Map<String, String> paraMap) throws SQLException {
		int totalPage = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select ceil( count(*)/? ) "
							+ " from tbl_review ";
			
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

	// 페이징 처리를 한 모든 리부 또는 제품명으로 검색한 리뷰 목록 보여주기
	@Override
	public List<ReviewVO> selectPagingReview(Map<String, String> paraMap) throws SQLException {
		List<ReviewVO> revList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select reviewno, reviewimage1, fk_pname, rvtitle, rvcontent, rregisterdate "
							+ " from "
							+ " ( "
							+ " select reviewno, reviewimage1, fk_pname, rvtitle, rvcontent, to_char(rregisterdate,'yyyy-mm-dd') as rregisterdate "
							+ " from tbl_review ";
							
			// ==== 검색어가 있는 경우 시작 ==== //
			 String colname = paraMap.get("searchType");
			 String searchWord = paraMap.get("searchWord");
							
			if(searchWord != null && !searchWord.trim().isEmpty()) {
				sql += " where " + colname + " like '%'|| ? ||'%' "; 
			}
			 
			 // ==== 검색어가 있는 경우 끝 ==== //
			
			sql += " order by reviewno desc "
				    + " ) V "
				    + " where reviewno between ? and ? ";
			
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			int sizePerPage = 	Integer.parseInt(paraMap.get("sizePerPage"));
			
			pstmt = conn.prepareStatement(sql);
			
			if(searchWord != null &&!searchWord.trim().isEmpty()) {
				 // 검색어를 입력해주는데 공백이 아닌 실제 검색어를 입력한 경우
				 pstmt.setString(1, searchWord);
				 pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1) ); // 공식
				 pstmt.setInt(3, (currentShowPageNo * sizePerPage) ); // 공식 
			}
			 else {
				 pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1) ); // 공식
				 pstmt.setInt(2, (currentShowPageNo * sizePerPage) ); // 공식 
			 }
			
			rs = pstmt.executeQuery();
			 
			 while(rs.next()) {
				 
				 ReviewVO rvo = new ReviewVO();
				 rvo.setReviewimage1(rs.getString(1));
				 rvo.setFk_pname(rs.getString(2));
				 rvo.setRvtitle(rs.getString(3));
				 rvo.setRvcontent(rs.getString(4));
				 rvo.setRregisterdate(rs.getString(5));
				 
				 revList.add(rvo);
			 }// end of while(rs.next())------------------------------------------------
			
		} finally {
			close();
		}
		
		return revList;
	}
	
	// 조회수 증가시키기
	@Override
	public void updateViewCount(String reviewno) throws SQLException {
		
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " update tbl_review set rviewcount = rviewcount+1"
							+ " where reviewno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(reviewno));
			
			n = pstmt.executeUpdate();
			
			if(n==1) {
				conn.commit();
			}
			
		} finally {
			close();
		}
		
	}
	
	// reviewimage1(썸네일) 값을 입력받아서 리뷰 1개에 대한 상세정보를 알아오기
	@Override
	public ReviewVO reviewOneDetail(String rvtitle) throws SQLException {
		
		ReviewVO rvo = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select reviewimage1, reviewimage2, reviewimage3, rvtitle, rvcontent, fk_pname, "
							+ " to_char(rregisterdate,'yyyy-mm-dd') as rregisterdate, to_char(rupdatedate,'yyyy-mm-dd') as rupdatedate, rviewcount "
							+ " from tbl_review "
							+ " where reviewimage1 = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rvtitle);
			
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				rvo = new ReviewVO();
				
				rvo.setReviewimage1(rs.getString(1));
				rvo.setReviewimage2(rs.getString(2));
				rvo.setReviewimage3(rs.getString(3));
				rvo.setRvtitle(rs.getString(4));
				rvo.setRvcontent(rs.getString(5));
				rvo.setFk_pname(rs.getString(6));
				rvo.setRregisterdate(rs.getString(7));
				rvo.setRupdatedate(rs.getString(8));
				rvo.setRviewcount(rs.getInt(9));
				
			}
			
		} finally {
			close();
		}
		
		return rvo;
	}
	
	// tbl_review 테이블에 리뷰정보 insert 하기
	@Override
	public int reviewInsert(ReviewVO rvo) throws SQLException {
		
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " insert into(reviewno, fk_odetailno, rvtitle, rvcontent, satisfaction,reviewimage1,reviewimage2, reviewimage3, fk_pname) "
					+ " values(seq_pdetail_reviewno.nextval,?,?,?,?,?,?,?,?) ";
					
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1,rvo.getFk_odetailno());
			pstmt.setString(1,rvo.getRvtitle());
			pstmt.setString(3, rvo.getRvcontent());
			pstmt.setInt(4, rvo.getSatisfaction());
			pstmt.setString(5, rvo.getReviewimage1());
			pstmt.setString(6, rvo.getReviewimage2());
			pstmt.setString(7, rvo.getReviewimage3());
			pstmt.setString(8, rvo.getFk_pname());
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return n;
	}
	
	// 구매한 제품 정보 가져오기(select)
	@Override
	public ReviewVO selectProdOne(String fk_pname) throws SQLException {
		
		ReviewVO rvo = null;
		
		try {
			conn = ds.getConnection();
			
			
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,fk_pname);
					
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				ProductDetailVO pdvo = new ProductDetailVO();
				pdvo.setPname(rs.getString(2));
				pdvo.setPrice(rs.getInt(3));
				
				SpecVO svo = new SpecVO();
				svo.setSname(rs.getString(4));
				
				
				
				
				
				
				
			}
			
		} finally {
			close();
		}
		
		return null;
	}
	
	
	
	
	
	
	
	
	
}
