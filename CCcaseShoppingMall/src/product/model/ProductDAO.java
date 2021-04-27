package product.model;

import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ProductDAO implements InterProductDAO {

	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn; 
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자 
	public ProductDAO() {
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

	// =========================== 한수연 시작 ======================================
	// 핸드폰 제조사별  하드케이스 ,젤리케이스 ,범퍼케이스  개수 반환
	@Override
	public int calCntByCompany(int mnum, int cnum) throws SQLException {

		int cnt= 0;
		try {	
			conn=ds.getConnection();
			String sql=" select productid from tbl_product where fk_mnum= ? and fk_cnum= ? ";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, mnum);
			pstmt.setInt(2, cnum);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				cnt++;
			}
			
		}finally {
			close();
		}
		
		return cnt;  // 핸드폰 제조사별, 카테고리별 케이스 개수
	
	}// end of public int calCntByCompany(int mnum, int cnum) throws SQLException {------------------------

	
	// mnum과 cnum이 주어진 경우, 
	// 이에 해당하는 제품번호, 제품명, 기종명, 대표이미지파일명, 제품정가, 할인판매가, 스펙번호 가져오기 (productDetailVO 정보는 하양색 기준으로..)
	@Override
	public List<Map<String,String>> getProductInfo(String mnum, String cnum) throws SQLException {

		List<Map<String,String>> pInfoList= new ArrayList<>();
		
		try {
			conn=ds.getConnection();
			
			String sql=" select productid, productname, modelname, pimage1, price " + 
					   "      , price*(1-salepercent) as saleprice, fk_snum, salepercent*100 as salepercent " + 
					   " from " + 
					   " (select productid, productname, modelname, fk_mnum, fk_cnum from tbl_product) P " + 
					   " join " + 
					   " (select pimage1, fk_productid, price, salepercent, nvl(fk_snum,-1) as fk_snum from tbl_pdetail where pcolor='white') D " + 
					   " on P.productid = D.fk_productid " +
					   " where fk_mnum= ? and fk_cnum= ? ";
			
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(mnum));
			pstmt.setInt(2, Integer.parseInt(cnum));
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				
				Map<String,String> pInfoMap= new HashMap<>();
				
				String productid= rs.getString(1);
				String productname= rs.getString(2);
				String modelname= rs.getString(3);
				String pimage1= rs.getString(4);
				String price= String.valueOf(rs.getInt(5));
				String saleprice= String.valueOf(rs.getInt(6));
				
				pInfoMap.put("productid", productid);
				pInfoMap.put("productname", productname);
				pInfoMap.put("modelname", modelname);
				pInfoMap.put("pimage1", pimage1);
				pInfoMap.put("price", price);
				pInfoMap.put("saleprice", saleprice);
				
				String fk_snum= String.valueOf(rs.getInt(7)); // fk_snum이 0이면 BEST 상품, 1이면 NEW 상품, -1이면 해당없음
				pInfoMap.put("fk_snum", fk_snum);
				
				String salepercent= String.valueOf(rs.getInt(8));
				pInfoMap.put("salepercent", salepercent);
				
				pInfoList.add(pInfoMap);
			}
			
		} finally {
			close();
		}
		
		
		return pInfoList;
		
		/* 
		 	해당회사와 카테고리에 일치하는 제품이 하나도 없는 경우: pInfoList.size() == 0
		 	해당회사와 카테고리에 일치하는 제품이 하나이상 있는 경우: pInfoList.size() > 0  
		*/
		
	} // end of public List<Map<String,String>> getProductInfo(String mnum, String cnum) throws SQLException {------
	
	
	
    // mnum과 cnum이 주어진 경우, 이에 해당하는 기종명 반환 (중복되는 기종명은 1번만 사용)
	@Override
	public List<String> getModelName(String mnum, String cnum) throws SQLException {

		List<String> modelNameList= new ArrayList<>();
		try {	
			conn=ds.getConnection();
			String sql=" select distinct modelname from tbl_product where fk_mnum= ? and fk_cnum= ? ";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(mnum));
			pstmt.setInt(2, Integer.parseInt(cnum));
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				modelNameList.add(rs.getString(1));
			}
			
		}finally {
			close();
		}
		
		return modelNameList;
	
		/* 
	 		해당회사와 카테고리에 일치하는 기종명이 하나도 없는 경우: modelNameList.size() == 0
	 		해당회사와 카테고리에 일치하는 기종명이 하나이상 있는 경우: modelNameList.size() > 0  
		*/
	
	
	} // end of public List<String> getModelName(String mnum, String cnum) throws SQLException {----


	
	// mnum, cnum, modelName이 주어진 경우, 
    // 이에 해당하는 제품번호, 제품명, 기종명, 대표이미지파일명, 제품정가, 할인판매가, 스펙번호 가져오기 (productDetailVO 정보는 하얀색 기준으로..)
	@Override
	public List<Map<String, String>> getProductInfo(String mnum, String cnum, String modelName) throws SQLException {

		List<Map<String,String>> pInfoList= new ArrayList<>();
		
		try {
			conn=ds.getConnection();
			
			String sql=" select productid, productname, modelname, pimage1, price " +
				       " , price*(1-salepercent) as saleprice, fk_snum, salepercent*100 as salepercent " + 
				       " from " +
				       " (select productid, productname, modelname, fk_mnum, fk_cnum from tbl_product) P " +
				       " join " +
				       " (select pimage1, fk_productid, price, salepercent, nvl(fk_snum,-1) as fk_snum from tbl_pdetail where pcolor='white') D " +
				       " on P.productid = D.fk_productid " +
				       " where fk_mnum= ? and fk_cnum= ? and modelname= ? ";
			
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(mnum));
			pstmt.setInt(2, Integer.parseInt(cnum));
			pstmt.setString(3, modelName);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				
				Map<String,String> pInfoMap= new HashMap<>();
				
				String productid= rs.getString(1);
				String productname= rs.getString(2);
				String modelname= rs.getString(3);
				String pimage1= rs.getString(4);
				String price= String.valueOf(rs.getInt(5));
				String saleprice= String.valueOf(rs.getInt(6));
				
				pInfoMap.put("productid", productid);
				pInfoMap.put("productname", productname);
				pInfoMap.put("modelname", modelname);
				pInfoMap.put("pimage1", pimage1);
				pInfoMap.put("price", price);
				pInfoMap.put("saleprice", saleprice);
				
				String fk_snum= String.valueOf(rs.getInt(7)); // fk_snum이 0이면 BEST 상품, 1이면 NEW 상품, -1이면 해당없음
				pInfoMap.put("fk_snum", fk_snum);
				
				String salepercent= String.valueOf(rs.getInt(8));
				pInfoMap.put("salepercent", salepercent);
				
				pInfoList.add(pInfoMap);
	
			}
			
		} finally {
			close();
		}
		
		
		return pInfoList;
		
		/* 
		 	해당회사, 카테고리, 기종명에 일치하는 제품이 하나도 없는 경우: pInfoList.size() == 0
		 	해당회사, 카테고리, 기종명에 일치하는 제품이 하나이상 있는 경우: pInfoList.size() > 0  
		*/
		
	} // end of public List<Map<String, String>> getProductInfo(String mnum, String cnum, String modelName) throws SQLException {----

		
	// =========================== 한수연 끝 ======================================

	

	
	
	
}
