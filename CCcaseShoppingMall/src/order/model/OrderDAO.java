package order.model;

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

import product.model.ProductDetailVO;
import product.model.ProductVO;


public class OrderDAO implements InterOrderDAO {

	
	private DataSource ds;
	private Connection conn; 
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자 
	public OrderDAO() {
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
	
	

	//배송 조회하기
	@Override
	public List<OrderVO> shipStatusView(String orderno) throws SQLException {
		List<OrderVO> ovoList = new ArrayList<>();
		
		try {
			
			conn= ds.getConnection();
			
			String sql = " select O.orderno , productname, pcolor, odqty "+
						 " from tbl_order O Left join tbl_odetail OD "+
						 "      on O.orderno = OD.fk_orderno "+
						 "                left join tbl_pdetail PD "+
						 "      on OD.fk_pnum = PD.pnum "+
						 "                  left join tbl_product P "+
						 "      on PD.fk_productid = P.productid "+
						 " where  orderno = ? ";
			
			pstmt =conn.prepareStatement(sql);
			pstmt.setString(1, orderno);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				OrderVO ovo = new OrderVO();
				
				ovo.setOrderno(rs.getString(1));
				
				ProductVO pvo = new ProductVO();
				pvo.setProductname(rs.getString(2));
				
				ProductDetailVO pdvo = new ProductDetailVO();
				pdvo.setPcolor(rs.getString(3));
				
				ODetailVO odvo = new ODetailVO();
				odvo.setOdqty(rs.getInt(4));
				
				ovo.setPvo(pvo);
				ovo.setPdvo(pdvo);
				ovo.setOdvo(odvo);
				
				
				ovoList.add(ovo);
				
			}
			
			
		}finally {
			close();
		}
		
		return ovoList;
	}


	// 나의 주문내역  더보기페이징 방식으로 select 해오기
	@Override
	public List<OrderVO> selectByOrderList(Map<String, String> paraMap) throws SQLException {
		
		List<OrderVO> orderList = new ArrayList<>();
	      
	      
	      try {
	          conn = ds.getConnection();
	          
	          String sql = " select orderno,  pimage1 , modelname, productname, pcolor, fk_cnum , " + 
	          			   "       fk_userid, totalPrice, orderdate, shipstatus ,shipfee,finalamount ,odqty ,pnum ,odetailno " + 
	          			   " from " + 
	          			   " ( " + 
	          			   " select row_number() over(order by orderdate desc) AS RNO ,O.orderno, pimage1 , P.modelname, P.productname,pcolor, P.fk_cnum , " + 
			          	   "       fk_userid, totalPrice, to_char(orderdate,'yyyy-mm-dd')as orderdate, shipstatus ,shipfee,finalamount ,odqty ,PD.pnum ,odetailno " + 
			          	   " from tbl_order O Left join tbl_odetail OD " + 
			          	   "      on O.orderno = OD.fk_orderno " + 
			          	   "                  left join tbl_pdetail PD " + 
			          	   "      on OD.fk_pnum = PD.pnum " + 
			          	   "                  left join tbl_product P " + 
			          	   "      on PD.fk_productid = P.productid " + 
			          	   " where O.fk_userid= ? and to_char(orderdate,'yyyymm')>= to_char(add_months(sysdate,-3),'yyyymm')  " + 
			          	   " )V " + 
			          	   " where RNO between ? and ? " ;
	          
	          pstmt = conn.prepareStatement(sql);
	          pstmt.setString(1, paraMap.get("fk_userid"));
	          pstmt.setString(2, paraMap.get("start"));
	          pstmt.setString(3,  paraMap.get("end"));
	          
	          
	          rs = pstmt.executeQuery();
	          
	          while( rs.next() ) {
	             
	        	  	 String orderno = rs.getString("orderno");
		             String pimage1 = rs.getString("pimage1");
		             String modelname = rs.getString("modelname");
		             String productname = rs.getString("productname");
		             String pcolor = rs.getString("pcolor");
		             int fk_cnum = rs.getInt("fk_cnum");
		             String fk_userid = rs.getString("fk_userid");
		             int totalPrice = rs.getInt("totalPrice");
		             String orderdate = rs.getString("orderdate");
		             int shipstatus = rs.getInt("shipstatus");
		             int shipfee = rs.getInt("shipfee");
		             int finalamount = rs.getInt("finalamount");
		             int odqty = rs.getInt("odqty");
		             String pnum = rs.getString("pnum");
		             String odetailno = rs.getString("odetailno");
		             
		             
		             OrderVO ovo = new OrderVO();
		             ovo.setOrderno(orderno);
		             ovo.setFk_userid(fk_userid);
		             ovo.setTotalPrice(totalPrice);
		             ovo.setOrderdate(orderdate);
		             ovo.setShipstatus(shipstatus);
		             ovo.setShipfee(shipfee);
		             ovo.setFinalamount(finalamount);
		             
		             ProductVO pvo = new ProductVO();
		             pvo.setPimage1(pimage1);
		             pvo.setModelname(modelname);
		             pvo.setFk_cnum(fk_cnum);
		             pvo.setProductname(productname);
		             
		             ovo.setPvo(pvo);
		             
		             ProductDetailVO pdvo = new ProductDetailVO();
		             pdvo.setPcolor(pcolor);		 
		             pdvo.setPnum(pnum);
		             
		             
		             
		             ODetailVO odvo = new ODetailVO();
		             odvo.setOdqty(odqty);
		             odvo.setOdetailno(odetailno);
		             
		             ovo.setPdvo(pdvo);
		             ovo.setOdvo(odvo);
		             orderList.add(ovo);
		             
	          }      
		             
		             
	                  
	      } catch(SQLException e) {
	    	  e.printStackTrace();
	     }finally {
	         close();
	      }
	      
	      return orderList;
	}


	// Ajax(JSON)를 사용하여 주문내역을 "더보기" 방식으로 페이징처리 해주기 위해  아이디별로 전체개수 알아오기 // 
	@Override
	public int totalOrderListCount(String userid) throws SQLException {
		int totalCount = 0;
	      
	      try {
	          conn = ds.getConnection();
	          
	          String sql = " select count(*) "+
	        		  	   " from tbl_order O left join tbl_odetail OD "+
	        		  	   "      on  O.orderno = OD.fk_orderno "+
	        		  	   " where fk_userid = ? and to_char(orderdate,'yyyymm')>= to_char(add_months(sysdate,-3),'yyyymm')";   
	          
	          pstmt = conn.prepareStatement(sql);
	          pstmt.setString(1, userid);
	          
	          rs = pstmt.executeQuery();
	          
	          rs.next();
	          
	          totalCount = rs.getInt(1);
	          
	      } finally {
	         close();
	      }      
	      
	      return totalCount;
	}
	
	
	////////////////////////// 백원빈 시작 ///////////////////////////////
	//교환 접수시 배송상태 변경해주는 메소드
	@Override
	public int updatestatus(String odetailno) throws SQLException {
		
		int n = 0;
		
		try {
			
			conn = ds.getConnection();
			String sql = " update tbl_odetail set shipstatus = 4 "+
						 " where odetailno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, odetailno);
			
			n = pstmt.executeUpdate();
			
			
		} finally {
			close();
		}

		return n;
	}

	//환불 접수시 배송상태 변경해주는 메소드
	@Override
	
	public int updaterefundstatus(String odetailno) throws SQLException {
		int n = 0;
		
		try {
			
			conn = ds.getConnection();
			String sql = " update tbl_odetail set shipstatus = 5 "+
						 " where odetailno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, odetailno);
			
			n = pstmt.executeUpdate();
			
			
		} finally {
			close();
		}

		return n;
	}
	
	
	
	////////////////////////// 백원빈 끝 ///////////////////////////////	
	
	
	  // =============== 조연재 ===================== //

	// 상품 바로주문시 주문할 상품 정보 불러오기
	@Override
	public OrderVO getOrderDetail(String pnum) throws SQLException {
		OrderVO ovo =new OrderVO();
		
		try {
			 conn = ds.getConnection();
			 
			  String sql = " select pnum, fk_productid, pname, pcolor, P.price, P.salepercent, P.pimage1 "+
					  			 " from tbl_pdetail D "+
					  			 " join tbl_product P "+
					  			 " on P.productid=D.fk_productid " + 
					  			 " where pnum = ? ";
   
			  pstmt = conn.prepareStatement(sql);
			  
			  pstmt.setString(1, pnum);
			  
			  rs = pstmt.executeQuery();
			  
			  while(rs.next()) {
				  
				   ovo.getPdvo().setPnum(rs.getString(1));
				   ovo.getPdvo().setFk_productid(rs.getString(2));
				   ovo.getPdvo().setPname(rs.getString(3));
				   ovo.getPdvo().setPcolor(rs.getString(4));
				   ovo.getPvo().setPrice(rs.getInt(5));
				   ovo.getPvo().setSalepercent(rs.getInt(6));
				   ovo.getPvo().setPimage1(rs.getString(7));	  
				  
			  }
			  
		} finally {
			close();
		}
		
		return ovo;
	}

	
}
