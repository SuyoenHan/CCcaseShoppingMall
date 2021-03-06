package product.model;

import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ImageFileDAO implements InterImageFileDAO {
	
	private DataSource ds;
	private Connection conn; 
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자 
	public ImageFileDAO() {
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
	
	
	////////////////////백원빈 작업 시작 ///////////////////////////
	
	// 제품추가이미지 테이블로 insert하기
	@Override
	public int insertPlusImage(Map<String, String> plusimgmap) throws SQLException {
		
		int n = 0;
		
		try {
			
			conn = ds.getConnection();
			String sql = " insert into tbl_imagefile(imgno,fk_pnum,imgPlus1,imgPlus2,imgPlus3) "+
						 " values(seq_imagefile_imgno.nextval,?,?,?,?) ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,plusimgmap.get("getpnum"));
			pstmt.setString(2,plusimgmap.get("imgPlus1"));
			pstmt.setString(3,plusimgmap.get("imgPlus2"));
			pstmt.setString(4,plusimgmap.get("imgPlus3"));
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		
		
		return n;
	}
	
	// 제품리스트에서 특정행 클릭 후 이미지테이블 update
	@Override
	public int updateImage(Map<String, String> plusimgmap) throws SQLException {
		int n = 0;
		
		try {
			conn = ds.getConnection();
			String sql = "update tbl_imagefile set imgPlus1=? "+
						 "where imgno=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, plusimgmap.get("imgPlus1"));
			pstmt.setInt(2, Integer.parseInt(plusimgmap.get("imgno")));
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}

		return n;
	}
	
	////////////////////백원빈 작업 끝 ///////////////////////////
	
	
	// ========================== 한수연 작업 시작 =======================================
	
	// pnum이 주어진 경우 pnum에 해당하는 제품이미지명 반환 (pnum에 해당하는 행이 1개 이상 존재 할 수도 있다)
	@Override
	public List<Map<String, String>> selectImgFileByPnum(String pnum) throws SQLException {

		List<Map<String, String>> imgFileByPnumList= new ArrayList<>();
		
		try {
			
			conn=ds.getConnection();
			String sql= " select imgplus1, nvl(imgplus2,'noimage.png') as imgplus2, nvl(imgplus3,'noimage.png') as imgplus3 "+
						" from tbl_imagefile "+
						" where fk_pnum= ? ";
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, pnum);
			
			rs= pstmt.executeQuery();
			
			while(rs.next()) {
				
				Map<String, String> ImgFileByPnumMap= new HashMap<>();
				ImgFileByPnumMap.put("imgplus1",rs.getString(1));
				ImgFileByPnumMap.put("imgplus2",rs.getString(2));
				ImgFileByPnumMap.put("imgplus3",rs.getString(3));
				
				 imgFileByPnumList.add(ImgFileByPnumMap);			
			}
					
		} finally {
			close();
		}

		return imgFileByPnumList;
		
		/* 
		   pnum에 해당하는 추가이미지가 존재하지 않는경우: imgFileByPnumList.size() == 0
		   pnum에 해당하는 추가이미지가 존재하는 경우: imgFileByPnumList.size() > 0    
		*/
	}


		
		
		
   // ========================== 한수연 작업 끝 =======================================
	
}
