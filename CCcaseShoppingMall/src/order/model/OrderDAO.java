package order.model;

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
	
	
	
	// pnum을 가지고, 주문페이지에서 필요한 정보 뽑아오기(select)
	@Override
	public Map<String, String> manyOrderPageInfo(String string) throws SQLException {
		
		Map<String, String> paraMap = new HashMap<>();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select pnum, productname, modelname, pcolor, price, price*(1-salepercent) as saleprice, pimage1, doption,fk_productid "+
						 " from tbl_pdetail D "+
						 " join tbl_product P "+
						 " on P.productid=D.fk_productid "+
						 " where pnum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			  
			pstmt.setString(1, string);
			  
			rs = pstmt.executeQuery();
			  
			if(rs.next()) {
				
				paraMap.put("pnum", rs.getString(1));
				paraMap.put("productname", rs.getString(2));
				paraMap.put("modelname", rs.getString(3));
				paraMap.put("pcolor", rs.getString(4));
				paraMap.put("price", String.valueOf(rs.getInt(5)));
				paraMap.put("saleprice", String.valueOf(rs.getInt(6)));
				paraMap.put("pimage1", rs.getString(7));
				paraMap.put("doption", rs.getString(8));
				paraMap.put("fk_productid", rs.getString(9));
				
				
			}
		} finally {
			close();
		}
	
		return paraMap;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	////////////////////////// 백원빈 끝 ///////////////////////////////	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	 // =============== 조연재 ===================== //

	// 상품 바로주문시 주문할 상품 정보 불러오기
	@Override
	public Map<String,String> oneOrderPageInfo(String pnum) throws SQLException {
		
		 Map<String,String> paraMap = null;
		
		try {
			 conn = ds.getConnection();
			 
			  String sql = " select pnum, fk_productid, pname, pcolor, price, salepercent, pimage1, productname, modelname,doption "+
					  	   " from tbl_pdetail D "+
					  	   " join tbl_product P "+
					  	   " on P.productid=D.fk_productid " + 
					  	   " where pnum = ? ";
   
			  pstmt = conn.prepareStatement(sql);
			  
			  pstmt.setString(1, pnum);
			  
			  rs = pstmt.executeQuery();
			  
			  if(rs.next()) {
				  
				  paraMap = new HashMap<>();
				  
				  paraMap.put("pnum", rs.getString(1));
				  paraMap.put("fk_productid", rs.getString(2));
				  paraMap.put("pname", rs.getString(3));
				  paraMap.put("pcolor", rs.getString(4));
				  paraMap.put("price", String.valueOf(rs.getInt(5)));
				  paraMap.put("salepercent", String.valueOf(rs.getDouble(6)));
				  paraMap.put("pimage1", rs.getString(7));
				  paraMap.put("productname", rs.getString(8));
				  paraMap.put("modelname", rs.getString(9));
				  paraMap.put("doption", rs.getString(10));
				  

			  }
			  
		} finally {
			close();
		}
		
		return paraMap;
	}
	
	// 상품 주문완료 후 주문 테이블에 insert
	@Override
	public int insertNewOrder(Map<String, String> paraMap) throws SQLException {
//			int isSuccess = 0;
			int n1=0; //, n2=0, n3=0, n4=0, n5=0;
			
			try {
				conn = ds.getConnection();
		          
		        conn.setAutoCommit(false); // 수동커밋
		        
		        // 2. 주문 테이블에 채번해온 주문전표, 로그인한 사용자, 현재시각을 insert 하기(수동커밋처리)
		        String sql = " insert into tbl_order(orderno, fk_userid, totalPrice, shipfee, finalamount) "
		        				+ " values(seq_order_orderno.nextval, ?, ?, ?, ?) ";
	         
		         pstmt = conn.prepareStatement(sql);
		         pstmt.setString(1, paraMap.get("fk_userid"));
		         pstmt.setString(2, paraMap.get("totalPrice"));
		         pstmt.setString(3, paraMap.get("shipfee"));
		         pstmt.setString(4, paraMap.get("finalamount"));
		         
		         
	         n1 = pstmt.executeUpdate();
	         System.out.println("~~~~~~n1 : " + n1);
		    	         
	         // 3. 주문상세 테이블에 채번해온 주문전표, 제품번호, 주문량, 주문금액을 insert 하기(수동커밋처리)
/*
	         if(n1 == 1) {
	         	 String[] pnumArr = (String[]) paraMap.get("pnumArr");
	             String[] odqtyArr = (String[]) paraMap.get("odqtyArr");
	             String[] pdetailpriceArr = (String[]) paraMap.get("pdetailpriceArr");
	             
	             int cnt = 0;
	             for(int i=0; i<odetailnoArr.length; i++) {
	                sql = " insert into tbl_odetail (odetailno, fk_orderno, fk_pnum, odqty , shipstatus, pdetailprice)  "  
	                   + " values(SEQ_ODETAIL_ODETAILNO.nextval, ?, to_number(?), to_number(?), 0, to_number(?)) ";
	                
	                 pstmt = conn.prepareStatement(sql);
	                 pstmt.setString(1, (String)paraMap.get("orderno"));
	                 pstmt.setString(2, pnumArr[i]);
	                 pstmt.setString(3, odqtyArr[i]);
	                 
	                 pstmt.executeUpdate();
	                 cnt++;
	             }// end of for----------------------
	             
	             if(cnt == odetailnoArr.length) {
	                n2=1;
	             }
	             System.out.println("~~~~~~n2 : " + n2);
	             
	          }// end of if---------------------------
	*/         
			} catch(SQLException e) {
				
			} finally {
				close();
			}
			return n1;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//###################조승진 시작########################//
	
	//게시물 관리에서 리뷰작성 가능하도록 불러오기
	
	@Override
	public List<OrderVO> byreview(Map<String, String> paraMap) throws SQLException {
		List<OrderVO> reviewList = new ArrayList<>();
	      
	      try {
	          conn = ds.getConnection();

				String sql = "select  pimage1 , modelname, productname,fk_userid,orderdate, shipstatus ,pnum ,odetailno \n"+
							" from "+
							" ( "+
							" select O.orderno, pimage1 , P.modelname, P.productname,fk_userid, to_char(orderdate,'yyyy-mm-dd')as orderdate, shipstatus ,PD.pnum ,odetailno "+
							" from tbl_order O Left join tbl_odetail OD "+
							"on O.orderno = OD.fk_orderno  "+
							" left join tbl_pdetail PD "+
							" on OD.fk_pnum = PD.pnum  "+
							" left join tbl_product P  "+
							" on PD.fk_productid = P.productid "+
							"where O.fk_userid= ? and shipstatus=4 "+
							")V ";
	          
	          pstmt = conn.prepareStatement(sql);
	          pstmt.setString(1, paraMap.get("userid"));

	          rs = pstmt.executeQuery();
	          
	          while( rs.next() ) {
	             
		             String pimage1 = rs.getString("pimage1");
		             String modelname = rs.getString("modelname");
		             String productname = rs.getString("productname");
		             String orderdate = rs.getString("orderdate");
		             String pnum = rs.getString("pnum");
		             String odetailno = rs.getString("odetailno");	             
		             
		             OrderVO ovo = new OrderVO();
		             ovo.setOrderdate(orderdate);

		             ProductVO pvo = new ProductVO();
		             pvo.setPimage1(pimage1);
		             pvo.setModelname(modelname);
		             pvo.setProductname(productname);
		            
		             ovo.setPvo(pvo);
		             
		             ProductDetailVO pdvo = new ProductDetailVO();		 
		             pdvo.setPnum(pnum);

		             
		             ODetailVO odvo = new ODetailVO();
		             odvo.setOdetailno(odetailno);
		             
		             ovo.setPdvo(pdvo);
		             ovo.setOdvo(odvo);
		             
		             reviewList.add(ovo);
	          }      
		            
	      } catch(SQLException e) {
	    	  e.printStackTrace();
	     }finally {
	         close();
	      }
	      
	      return reviewList;
	}
	//###################조승진 종료########################//



}
