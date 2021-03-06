package member.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class CartDAO implements InterCartDAO {

	private DataSource ds;  
	private Connection conn; 
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public CartDAO() {
		
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


   // ============================ 한수연 시작 ===============================
   
   // 선택한 상품  tbl_cart 테이블로 insert 또는 update
   
   @Override
	public int insertUpdateWishList(CartVO ctvo) throws SQLException {
	   
	   int n=0;
	   int m=0;
	   
	   try {
		   
		   conn=ds.getConnection();
		   conn.setAutoCommit(false);
		   
		   String sql="";
		   if(!"-".equals(ctvo.getFk_pnum())) {
	
			   sql= " select cartno from tbl_cart where fk_userid= ? "+
				   	" and fk_productid= ? and fk_pnum= ? ";
		   }
		   else {
			   sql= " select cartno from tbl_cart where fk_userid= ? "+
					" and fk_productid= ? ";
		   }
		   
		   pstmt=conn.prepareStatement(sql);
		   pstmt.setString(1, ctvo.getFk_userid());
		   pstmt.setString(2, ctvo.getFk_productid());
		   
		   if(!"-".equals(ctvo.getFk_pnum())) {
			   pstmt.setString(3, ctvo.getFk_pnum());
		   }
		   
		   rs= pstmt.executeQuery();
		   
		   if(rs.next()) {  // 장바구니 테이블에 존재하는 경우 update
			   
			   int cartno= rs.getInt(1);
			   
			   
			   sql=" update tbl_cart set cinputcnt= cinputcnt+ ? " +
				   " where cartno = ? ";
			   
			   pstmt=conn.prepareStatement(sql);
			   pstmt.setInt(1, ctvo.getCinputcnt());
			   pstmt.setInt(2, cartno);
			   n= pstmt.executeUpdate();   
			   
			   sql=" update tbl_cart set cinputdate= sysdate " +
				   " where cartno = ? ";
				   
				   pstmt=conn.prepareStatement(sql);
				   pstmt.setInt(1, cartno);
				   m= pstmt.executeUpdate();   
				   
			   if((m*n) ==1) {
				   conn.commit();
				   conn.setAutoCommit(true); 
				   n=2;
			   }
			   
		   }
		   
		   else {  // 장바구니 테이블에 존재하지 않는 경우 insert
			 
			   if("-".equals(ctvo.getFk_pnum())) { // 색상을 선택하지 않은 경우
				   sql=" insert into tbl_cart(cartno, fk_userid, fk_productid, cinputcnt, cinputdate) "+
					   " values(seq_cart_cartno.nextval, ?, ?, ?, sysdate) ";
			   }
			   
			   else { // 색상을 선택한 경우
				   sql=" insert into tbl_cart(cartno, fk_userid, fk_productid, cinputcnt, fk_pnum, cinputdate) "+
					   " values(seq_cart_cartno.nextval, ?, ?, ?, ?, sysdate) ";
			   }
   			   
			   pstmt= conn.prepareStatement(sql);
			   pstmt.setString(1, ctvo.getFk_userid());
			   pstmt.setString(2, ctvo.getFk_productid());
			   pstmt.setInt(3, ctvo.getCinputcnt());
			   
			   if(!"-".equals(ctvo.getFk_pnum())) {
				   pstmt.setString(4, ctvo.getFk_pnum());
			   }
			   
			   n= pstmt.executeUpdate();
			   if(n==1) conn.commit();
		   }
		   
	   }finally {
		   close();
	   }
	   
	   return n;
	   
	   /* 
	    	insert 성공: n==1
	    	update 성공: n==2
	    	insert 또는 update 실패: n==0
	   */
	}

   
	// userid가 주어졌을 때 이에 해당하는 장바구니 테이블 행 select
	@Override
	public List<Map<String, String>> selectCartInfo(String userid) throws SQLException {

		List<Map<String, String>> cartInfoList= new ArrayList<>();
		
		try {
			
			conn=ds.getConnection();
			String sql= " select cartno, fk_productid, nvl(fk_pnum,'-') as fk_pnum, cinputcnt "+
						" from tbl_cart "+
						" where fk_userid= ? "+
						" order by cartno desc";

			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				
				Map<String, String> cartInfoMap= new HashMap<>();
				cartInfoMap.put("cartno", String.valueOf(rs.getInt(1)));
				cartInfoMap.put("fk_productid", rs.getString(2));
				cartInfoMap.put("fk_pnum", rs.getString(3));
				cartInfoMap.put("cinputcnt", String.valueOf(rs.getInt(4)));
				
				cartInfoList.add(cartInfoMap);
			}
			
		}finally {
			close();
		}
		
		
		return cartInfoList;
		
		/*
		 	특정회원의 장비구니 정보가 없는 경우: cartInfoList.size()==0
		 	특정회원의 장비구니 정보가 존재하는 경우: cartInfoList.size()>0
		*/
	
	}

	// cartno가 주어졌을 때 해당 행 delete
	@Override
	public int deleteOneRow(int cartno) throws SQLException {
		
		int n=0;
		
		try {
			
			conn=ds.getConnection();
			String sql= " delete from tbl_cart where cartno= ? ";
			pstmt= conn.prepareStatement(sql);
			pstmt.setInt(1, cartno);
			
			n= pstmt.executeUpdate();
			
		}finally{
			close();
		}
		
		return n;
		
		/*
		 	삭제성공: n==1
		 	삭제실패: n==0
		*/
	} // end of public int deleteOneRow(int cartno) throws SQLException {--------

	
	// userid가 주어졌을 떄 이에 해당하는 장바구니 데이터들 모두 delete
	@Override
	public int deleteAllRowByUserId(String userid) throws SQLException {

		int n=0;
	
		try {
			conn=ds.getConnection();
			String sql= " delete from tbl_cart where fk_userid= ? ";
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			n= pstmt.executeUpdate();
	
		}finally {
			close();
		}
	
		return n;
		/*
		 	삭제성공: n>=1
		 	삭제실패: n==0
	    */
	}
	   
   // ============================ 한수연 끝 ===============================	   
	   
}
