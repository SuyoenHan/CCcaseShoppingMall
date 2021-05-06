package member.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class InterestProductDAO implements InterInterestProductDAO {
	
	private DataSource ds;  
	private Connection conn; 
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public InterestProductDAO() {
		
		Context initContext;
		try {
			initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semioracle");
		
		} catch (NamingException e) {
			e.printStackTrace();
		}
		
	}
	
	// 사용한 자원을 반납하는 close() 메소드 생성하기 
	   private void close(){
	      try {
	         if(rs != null)    {rs.close();    rs=null;}
	         if(pstmt != null) {pstmt.close(); pstmt=null;}
	         if(conn != null)  {conn.close();  conn=null;} // 커넥션 반납
	      
	      } catch(SQLException e) {
	         e.printStackTrace();
	      }
	   }
	
	   
	// ========================== 한수연 시작 =====================================   
	   
	// 특정상품을 관심상품 테이블에 insert (중복된다면 insert 불가)
	@Override
	public int insertInterestProduct(InterestProductVO ipvo) throws SQLException {

		int n=0;
		try {
			
			conn=ds.getConnection();
			String sql="";
			
			if("-".equals(ipvo.getFk_pnum())) { // 색상을 선택하지 않은 경우
				
				sql= " select interestno from tbl_interestp "+
					 " where fk_userid= ? and fk_productid= ? ";
				
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, ipvo.getFk_userid());
				pstmt.setString(2, ipvo.getFk_productid());
				
				rs= pstmt.executeQuery();
				if(rs.next()) { // 중복 행이 존재하는 경우
					n=2;
				}
				else {
					sql= " insert into tbl_interestp(interestno, fk_userid, fk_productid) "+
					     " values(seq_interestp_interestno.nextval, ?, ? ) ";
					
					pstmt=conn.prepareStatement(sql);
					pstmt.setString(1, ipvo.getFk_userid());
					pstmt.setString(2, ipvo.getFk_productid());
					n= pstmt.executeUpdate();
				}
			} // end of if("-".equals(ipvo.getFk_pnum())) {---------------------------------

			else { // 색상을 선택한 경우
				
				sql= " select interestno from tbl_interestp "+
				     " where fk_userid= ? and fk_productid= ? and fk_pnum= ? ";
					
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, ipvo.getFk_userid());
				pstmt.setString(2, ipvo.getFk_productid());
				pstmt.setString(3, ipvo.getFk_pnum());	
				
				rs= pstmt.executeQuery();
				if(rs.next()) { // 중복 행이 존재하는 경우
					n=2;
				}
				else {
					sql= " insert into tbl_interestp(interestno, fk_userid, fk_productid, fk_pnum) "+
						 " values(seq_interestp_interestno.nextval, ?, ?, ? ) ";
					
					pstmt=conn.prepareStatement(sql);
					pstmt.setString(1, ipvo.getFk_userid());
					pstmt.setString(2, ipvo.getFk_productid());
					pstmt.setString(3, ipvo.getFk_pnum());
					
					n= pstmt.executeUpdate();
				}
			} // end of else---------------------------------
			
		}finally {
			close();
		}
		
		return n;
		
		 /*
		 	insert 성공: n==1
		 	이미 존재하는 행으로 insert 실패: n==2
		 	insert 실패: n==0
		 */
		
	}// end of public int insertInterestProduct(InterestProductVO ipvo) throws SQLException {------

	
	// userid가 주어졌을 때 이에 해당하는 관심상품 테이블 행 select
	@Override
	public List<Map<String, String>> selectInterestPInfo(String userid) throws SQLException {
		
		List<Map<String, String>> interestPInfoList= new ArrayList<>();
		
		try {
			
			conn=ds.getConnection();
			String sql= " select interestno, fk_productid, nvl(fk_pnum,'-') as fk_pnum "+
						" from tbl_interestp "+
						" where fk_userid= ? ";

			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				
				Map<String, String> interestPInfoMap= new HashMap<>();
				interestPInfoMap.put("interestno", String.valueOf(rs.getInt(1)));
				interestPInfoMap.put("fk_productid", rs.getString(2));
				interestPInfoMap.put("fk_pnum", rs.getString(3));
				
				interestPInfoList.add(interestPInfoMap);
			}
			
		}finally {
			close();
		}
		
		return interestPInfoList;
		
		/*
		 	특정회원의 관심상품 정보가 없는 경우: interestPInfoList.size()==0
		 	특정회원의 관심상품 정보가 존재하는 경우: interestPInfoList.size()>0
		*/
		
	}// end of public List<Map<String, String>> selectInterestPInfo(String userid) throws SQLException {-----

	
	// interestno가 주어졌을 때 이에 해당하는 관심상품 행 delete
	@Override
	public int deleteOneRow(int interestno) throws SQLException {
	
		int n=0;
		try {
			conn=ds.getConnection();
			String sql= " delete from tbl_interestp where interestno= ? ";
			pstmt= conn.prepareStatement(sql);
			pstmt.setInt(1, interestno);
			n= pstmt.executeUpdate();
		}finally{
			close();
		}
		
		return n;
		
		/*
		 	삭제성공: n==1
		 	삭제실패: n==0
		*/
	
	}// end of public int deleteOneRow(int interestno) throws SQLException {
	
	
	// ========================== 한수연 끝 ===================================== 
}
