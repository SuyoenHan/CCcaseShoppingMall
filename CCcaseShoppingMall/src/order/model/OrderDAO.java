package order.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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
	
	
	// 나의 주문내역  select 해오기
	@Override
	public List<OrderVO> myOrderList(String userid) throws SQLException {
		List<OrderVO> orderList = new ArrayList<>();
	      
	      
	      try {
	          conn = ds.getConnection();
	          
	          String sql = "select O.orderno,pimage1 , P.modelname, P.productname, pcolor, P.fk_cnum , " + 
	          			   "       fk_userid, totalPrice, to_char(orderdate,'yyyy-mm-dd')as orderdate, shipstatus ,shipfee,finalamount ,OD.odqty " + 
			          	   " from tbl_order O Left join tbl_odetail OD " + 
			          	   "      on O.orderno = OD.fk_orderno " + 
			          	   "                  left join tbl_pdetail PD " + 
			          	   "      on OD.fk_pnum = PD.pnum " + 
			          	   "                  left join tbl_product P " + 
			          	   "      on PD.fk_productid = P.productid " + 
			          	   " where O.fk_userid= ? and to_char(orderdate,'yyyymm')>= to_char(add_months(sysdate,-3),'yyyymm')  " + 
			          	   " order by orderdate desc ";
	          
	          pstmt = conn.prepareStatement(sql);
	          pstmt.setString(1, userid);
	          
	          
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
		             
		             ovo.setPdvo(pdvo);
		             
		             ODetailVO odvo = new ODetailVO();
		             odvo.setOdqty(odqty);
		             
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

}
