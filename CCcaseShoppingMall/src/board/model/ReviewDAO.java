package board.model;

import java.sql.*;

import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import product.model.ProductVO;

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

	// 페이징 처리를 한 모든 리뷰 또는 검색한 리뷰 목록 보여주기
	@Override
	public List<ReviewVO> selectPagingReview(Map<String, String> paraMap) throws SQLException {
		List<ReviewVO> revList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select reviewno, pimage1, fk_userid, reviewimage1, fk_pname, rvtitle, rvcontent, rregisterdate, rviewcount "+
					" from "+
					" ( "+
					" select rno, pimage1, reviewno, fk_userid, reviewimage1, fk_pname, rvtitle, rvcontent, to_char(rregisterdate,'yyyy-mm-dd') as rregisterdate, rviewcount "+
					" from "+
					" ( "+
					" select rownum as rno, pimage1, reviewno, fk_userid, reviewimage1, fk_pname, rvtitle, rvcontent, rregisterdate, rviewcount "+
					" from tbl_review R "+
					" JOIN tbl_product P "+
					" ON R.fk_pname = P.productname "+
					" order by rno desc "+
					" ) V ";
				
			// ==== 검색어가 있는 경우 시작 ==== //
			String searchType = paraMap.get("searchType");
			String searchWord = paraMap.get("searchWord");
							
			if(searchWord != null && !searchWord.trim().isEmpty()) {
				sql += " where " + searchType + " like '%'|| ? ||'%' "; 
			}
			 
			 // ==== 검색어가 있는 경우 끝 ==== //
			
			sql += " ) T "+ " where rno between ? and ?";;
			
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			int sizePerPage = 10;
			
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
				 rvo.setReviewno(rs.getInt(1));
				 rvo.setPimage1(rs.getString(2));
				 rvo.setFk_userid(rs.getString(3));
				 rvo.setReviewimage1(rs.getString(4));
				 rvo.setFk_pname(rs.getString(5));
				 rvo.setRvtitle(rs.getString(6));
				 rvo.setRvcontent(rs.getString(7));
				 rvo.setRregisterdate(rs.getString(8));
				 rvo.setRviewcount(rs.getInt(9));
				 
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
			pstmt.setString(1, reviewno);
			
			n = pstmt.executeUpdate();
			
			if(n==1) {
				conn.commit();
			}
			
		} finally {
			close();
		}
		
	}
	
	// reviewimage1(썸네일) 값을 입력받아서 사진 리뷰 1개에 대한 상세정보를 알아오기
	@Override
	public ReviewVO reviewOneDetail(String reviewno) throws SQLException {
		
		ReviewVO rvo = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select rvtitle, rvcontent, fk_pname,  reviewimage1, reviewimage2, reviewimage3, "
							+ " to_char(rregisterdate,'yyyy-mm-dd') as rregisterdate, to_char(rupdatedate,'yyyy-mm-dd') as rupdatedate, rviewcount, fk_userid, fk_odetailno "
							+ " from tbl_review "
							+ " where reviewno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, reviewno);
			
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				rvo = new ReviewVO();
				
				rvo.setRvtitle(rs.getString(1));
				rvo.setRvcontent(rs.getString(2));
				rvo.setFk_pname(rs.getString(3));
				rvo.setReviewimage1(rs.getString(4));
				rvo.setReviewimage2(rs.getString(5));
				rvo.setReviewimage3(rs.getString(6));
				rvo.setRregisterdate(rs.getString(7));
				rvo.setRupdatedate(rs.getString(8));
				rvo.setRviewcount(rs.getInt(9));
				rvo.setFk_userid(rs.getString(10));
				rvo.setFk_odetailno(rs.getString(11));
				
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
			
			String sql = " insert into(reviewno, fk_userid, fk_odetailno, rvtitle, rvcontent, satisfaction, reviewimage1, reviewimage2, reviewimage3, fk_pname) "
							+ " values(seq_review_reviewno.nextval,?,?,?,?,?,?,?,?,?) ";
					
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, rvo.getFk_userid());
			pstmt.setString(2, rvo.getFk_odetailno());
			pstmt.setString(3,rvo.getRvtitle());
			pstmt.setString(4, rvo.getRvcontent());
			pstmt.setInt(5, rvo.getSatisfaction());
			pstmt.setString(6, rvo.getReviewimage1());
			pstmt.setString(7, rvo.getReviewimage2());
			pstmt.setString(8, rvo.getReviewimage3());
			pstmt.setString(9, rvo.getFk_pname());
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return n;
	}
	
	//리뷰 글내용 수정을 위해 하나의 리뷰를 select해오기
		@Override
		public ReviewVO revEditOneView(String reviewno) throws SQLException {
			
			ReviewVO rvo = null;
			
			try {
				conn = ds.getConnection();
				
				String sql = " select reviewno, rvtitle, satisfaction, rvcontent, reviewimage1, reviewimage2, reviewimage3 "
								+ " from tbl_review"
								+ " where reviewno = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, reviewno);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					
					rvo = new ReviewVO();
					
					rvo.setReviewno(rs.getInt(1));
					rvo.setRvtitle(rs.getString(2));
					rvo.setSatisfaction(rs.getInt(3));
					rvo.setRvcontent(rs.getString(4));
					rvo.setReviewimage1(rs.getString(5));
					rvo.setReviewimage2(rs.getString(6));
					rvo.setReviewimage3(rs.getString(7));
					
				}
				
			} finally {
				close();
			}
			
			return rvo;
		}
	
	// 리뷰 내용 수정하기(update)
	@Override
	public int revEditUpdate(ReviewVO rvo) throws SQLException {
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " update tbl_review set rvtitle = ? "
																+ " , satisfaction = ? "
																+ " , rupdatedate = sysdate "
																+ " , rvcontent = ? "
																+ " where reviewno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rvo.getRvtitle());
			pstmt.setInt(2, rvo.getSatisfaction());
			pstmt.setString(4, rvo.getRvcontent());
			pstmt.setInt(4, rvo.getReviewno());
			
			n = pstmt.executeUpdate();
			
			if(n==1) {
				conn.commit();
			}
			
		} finally {
			close();
		}
		return n;
	}
	
	// 리뷰 글내용 삭제하기(delete)
	@Override
	public int revDeleteOne(ReviewVO rvo) throws SQLException {
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " delete from tbl_review "
							+ " where reviewno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rvo.getReviewno());
			
			n = pstmt.executeUpdate();
			
			if(n==1) {
				conn.commit();
			}
			
		} finally {
			close();
		}
		return n;
	}
	
	// 사진리뷰 총 개수 알아오기
	@Override
	public int selectRevCnt() throws SQLException {
		int rtotalCnt = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = "select count(*) "+
								"from tbl_review "+
								"where reviewimage1 is not null or reviewimage2 is not null " +
							    " or reviewimage3 is not null";

			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			rtotalCnt = rs.getInt(1);
			
		} finally {
			close();
		}
		return rtotalCnt;
	}

	//내가 쓴 리뷰 조회
	@Override
	public List<ReviewVO> reviewMywrite(Map<String, String> paraMap) throws SQLException {
		List<ReviewVO> revList = new ArrayList<>();
		  
	      try {
	          conn = ds.getConnection();
	          
	          String sql = " select reviewno, fk_userid,fk_pname, rvtitle, rvcontent, rregisterdate, rviewcount "+
	        		  " from ( select rownum AS rno,  reviewno, fk_userid,fk_pname, rvtitle, rvcontent, rregisterdate, rviewcount "+
	        		  " from "+
	        		  " ( "+
	        		  " select reviewno, fk_userid, fk_pname, rvtitle, rvcontent, rregisterdate, rviewcount "+
	        		  " from tbl_review "+
	        		  " where fk_userid= ? "+
	        		  " order by reviewno desc "+
	        		  " ) V "+
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
	             
	        	  ReviewVO rvo = new ReviewVO();
					 rvo.setReviewno(rs.getInt(1));
					 rvo.setFk_userid(rs.getString(2));
					 rvo.setFk_pname(rs.getString(3));
					 rvo.setRvtitle(rs.getString(4));
					 rvo.setRvcontent(rs.getString(5));
					 rvo.setRregisterdate(rs.getString(6));
					 rvo.setRviewcount(rs.getInt(7));
		
	             revList.add(rvo);
	            
	          }// end of while(rs.next()) ------------------------------------------------------------------------
	          
	      } finally {
	         close();
	      }      
	      return revList ;
	  
	}

	@Override
	public int reviewMywriteTotalPage(String userid) throws SQLException {
		
		int totalPage = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " select ceil(count(*)/5) "  // 10 이 sizePerPage 이다.
	                  + " from tbl_review "
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
	
	// 구매한 제품 사진 보여주기
	@Override
	public String selectPurchaseProd(String fk_userid) throws SQLException {
		
		String pimage1 = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = "select pimage1 "+
								"from "+
								"(select odetailno, fk_userid, fk_pnum "+
								"from tbl_review R "+
								"join tbl_odetail O "+
								"on R.fk_odetailno = O.odetailno "+
								")A "+
								"JOIN "+
								"(select pimage1, pnum "+
								"from tbl_pdetail P "+
								"join tbl_product D "+
								"on P.pname = D.productname "+
								")B "+
								"ON A.fk_pnum = B.pnum "+
								"where A.fk_userid = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1 , fk_userid);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				pimage1 = rs.getString(1);
			}
			
		} finally {
			close();
		}
		
		return pimage1;
	}
	
	// 구매한 제품명 가져오기
	@Override
	public String getPnameOfProd(String fk_userid) throws SQLException {
		
		String fk_pname = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select fk_pname "
							+ " from tbl_review "
							+ " where fk_userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fk_userid);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			fk_pname = rs.getString(1); 
			
		} finally {
			close();
		}
		return fk_pname;

	}
	
	// 해당 리뷰의 구매 제품 가져오기 
	@Override
	public ProductVO selectProduct(String reviewno) throws SQLException {
		
		ProductVO pvo = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select pimage1, productname, price "
							+ " from "
							+ " ( "
							+ " select pimage1, productname, price "
							+ " from tbl_product P "
							+ " join tbl_review R "
							+ " on P.productname = R.fk_pname "
							+ " where reviewno = ? "
							+ " ) V ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(reviewno));
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				pvo = new ProductVO();
				
				pvo.setPimage1(rs.getString(1));
				pvo.setProductname(rs.getString(2));
				pvo.setPrice(rs.getInt(3));
			}
			
		} finally {
			close();
		}
		return pvo;
	}
	
	// 특정 회원이 특정 리뷰에 대해 도움이돼요 투표하기(insert) 
		@Override
		public int likeAdd(Map<String, String> paraMap) throws SQLException {
			
			int n = 0;
			
			try {
				conn = ds.getConnection();
				
				String sql = " insert into tbl_likecnt "
								+ " where fk_userid = ? and reviewno = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, paraMap.get("userid"));
				pstmt.setString(2, paraMap.get("reviewno"));
				
				n = pstmt.executeUpdate();
				
				if(n==1) {
					conn.commit();
				}
			
			} catch(SQLIntegrityConstraintViolationException e ) {
				conn.rollback();
			} finally {
				close();
			}
			
			return n;
		}
	
	// 특정 리뷰에 대한 도움이 돼요 투표 결과(select)
	@Override
	public int getLikeCnt(String reviewno) throws SQLException {
		
		int likecnt = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select "
							+ " (select count(*) "
							+ " from tbl likecnt "
							+ " where reviewno = ?) as likecnt "
							+ " from dual ";
							 
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, reviewno);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			likecnt = rs.getInt(1);
			
		} finally {
			close();
		}
		return likecnt;
	}
	
	
	// 해당 리뷰의 구매 제품 스펙번호 가져오기
	@Override
	public int getSnumByReviewno(String odetailno) throws SQLException {

		int snum= -1;
		
		try {
			conn=ds.getConnection();
			String sql=" select fk_snum from tbl_pdetail " +
						" join ( select fk_pnum from tbl_review join tbl_odetail on ? =odetailno ) R " +
						" on pnum=fk_pnum ";
			
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, odetailno);
					
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				snum=rs.getInt(1);
			}
			
		}finally{
			close();
		}
		
		return snum;
		 
		 /*
		 		snum=-1  해당 pnum 또는 odetailno 존재하지 않음
		 		snum=0  베스트상품
		 		snum=1    신상품
		 */
		
	} // end of public int getSnumByReviewno(String odetailno) throws SQLException {-----------
	
	// 쓰여진 리뷰 내용 받아오기
	@Override
	public ReviewVO getReviewContents(String userid, String reviewno) throws SQLException {
		ReviewVO rvo = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select reviewno, fk_userid, rvtitle, rvcontent, satisfaction, fk_pname, rregisterdate, rviewcount"
							+ " from tbl_review "
							+ " where fk_userid = ? and reviewno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setString(2, reviewno);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				rvo = new ReviewVO();
				rvo.setReviewno(rs.getInt(1));
				rvo.setFk_userid(rs.getString(2));
				rvo.setRvtitle(rs.getString(3));
				rvo.setRvcontent(rs.getString(4));
				rvo.setSatisfaction(rs.getInt(5));
				rvo.setFk_pname(rs.getString(6));
				rvo.setRregisterdate(rs.getString(7));
				rvo.setRviewcount(rs.getInt(8));
				
			}
			
		} finally {
			close();
		}
		
		return rvo;
	}

	
	


}
