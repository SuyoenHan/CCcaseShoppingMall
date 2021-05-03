package admin.controller;

import java.io.IOException;
import java.util.*;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import admin.model.*;
import common.controller.AbstractController;
import product.model.*;

public class ProductRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		AdminVO avo = (AdminVO)session.getAttribute("adminUser");
		
		if(avo == null) { // 관리자로 로그인을 안했을 경우
			
			String message = "로그인 후 이용가능합니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/adminMsg.jsp");
			
		}
		else { // 관리자로 로그인을 했을경우
			
			String method = request.getMethod();
			
			if(!"POST".equalsIgnoreCase(method)) { //GET방식
				
				// 카테고리 목록 조회해오기
				InterCategoryDAO cdao = new CategoryDAO();
				List<CategoryVO> categoryList = cdao.selectCategory();
				
				request.setAttribute("categoryList", categoryList);
				
				// 스펙목록 조회해오기
				InterSpecDAO sdao = new SpecDAO();
				List<HashMap<String,String>> specList = sdao.selectSpec();
				
				request.setAttribute("specList", specList);
				
				// 회사목록 조회해오기
				InterMobileCompanyDAO codao = new MobileCompanyDAO();
				List<MobileCompanyVO> companyList = codao.selectCompany();
				
				request.setAttribute("companyList", companyList);
				
				// 기종명 조회해오기
				InterProductDAO pdao = new ProductDAO();
				List<String> gijongList = pdao.getgijongname();
				

				if(gijongList.size()>0) {
					request.setAttribute("gijongList", gijongList);
				}
				
				// 색상 드롭박스 만들어주기
				List<String> colorList = new ArrayList<>();
				colorList.add("RED");
				colorList.add("ORANGE");
				colorList.add("YELLOW");
				colorList.add("GREEN");
				colorList.add("BLUE");
				colorList.add("NAVY");
				colorList.add("PURPLE");
				colorList.add("WHITE");
				colorList.add("BLACK");
				colorList.add("PINK");
				colorList.add("GRAY");
				
				request.setAttribute("colorList", colorList);
				
				String productid = request.getParameter("productid");
				
				Map<String,String> getProInfoMap = pdao.getProInfo(productid);
		    	String mapSize= String.valueOf(getProInfoMap.size());
				
		    	/*
		    	 	mapSize==0 인경우 productid에 해당하는 정보 존재하지 않음
		    	 */
		    	
				request.setAttribute("productid", getProInfoMap.get("productid"));
				request.setAttribute("productname",getProInfoMap.get("productname"));
				request.setAttribute("modelname",getProInfoMap.get("modelname"));
				request.setAttribute("pimage1",getProInfoMap.get("pimage1"));
				request.setAttribute("price",getProInfoMap.get("price"));
				request.setAttribute("salepercent",getProInfoMap.get("salepercent"));
				request.setAttribute("fk_cnum",getProInfoMap.get("fk_cnum"));
				request.setAttribute("fk_mnum",getProInfoMap.get("fk_mnum"));
				request.setAttribute("mapSize",mapSize);
		
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/admin/productRegister2.jsp");
					
			} else { // POST방식
				
				MultipartRequest mtrRequest = null;
				session = request.getSession();
				ServletContext svlCtx =  session.getServletContext();
				
				String imagesDir = svlCtx.getRealPath("/images");
				
				imagesDir = "C:\\Users\\BAEK\\git\\CCcaseShoppingMall\\CCcaseShoppingMall\\WebContent\\images";
				
				try {
					mtrRequest = new MultipartRequest(request, imagesDir, 10*1024*1024, "UTF-8", new DefaultFileRenamePolicy());
				} catch (IOException e) {
					request.setAttribute("message", "업로드 되어질 경로가 잘못되었거나 또는 최대용량 10MB를 초과했으므로 파일업로드 실패함!!");
	                request.setAttribute("loc", request.getContextPath()+"/admin/productRegister.cc");
	                
	                super.setViewPage("/WEB-INF/adminMsg.jsp");
	                return; // 종료
				}
				
				String fk_snum = mtrRequest.getParameter("fk_snum");         	// 스펙번호(제품상세테이블)
				String fk_cnum = mtrRequest.getParameter("fk_cnum"); 		 	// 카테고리번호(제품테이블)
				String fk_mnum = mtrRequest.getParameter("fk_mnum"); 		 	// 회사번호(제품테이블)
				
				// 이용자가 입력받은 회사코드를 가지고 회사명을 가지고 오기
				InterMobileCompanyDAO codao = new MobileCompanyDAO();
				String mname = codao.getMname(fk_mnum);
				String productname = mtrRequest.getParameter("productname"); 	// 제품명(제품테이블,제품상세테이블)
				String modelname = mtrRequest.getParameter("modelname"); 	 	// 기종명(제품테이블,제품상세테이블)
				String pcolor = mtrRequest.getParameter("pcolor");              // 색상(제품상세테이블)
				String price = mtrRequest.getParameter("price");         	 	// 제품가격(제품테이블)
				String salepercent = mtrRequest.getParameter("salepercent"); 	// 할인율(제품테이블)
				String pinputdate = mtrRequest.getParameter("pinputdate"); 	 	// 입고일자(제품상세테이블)
				String doption = mtrRequest.getParameter("doption"); 		 	// 배송조건(제품상세테이블)
				String pqty = mtrRequest.getParameter("pqty"); 				    // 재고량(제품상세테이블)
				String pimage1 = mtrRequest.getFilesystemName("pimage1");       // 제품대표이미지(제품테이블)
				String imgPlus1 = mtrRequest.getFilesystemName("imgPlus1"); // 제품추가이미지(이미지추가테이블)
				String pcontent = mtrRequest.getParameter("pcontent"); 			// 제품설명란(제품상세테이블)

				// 크로스 사이트 스크립트 공격 방지
				pcontent = pcontent.replaceAll("<", "&lt;");
	            pcontent = pcontent.replaceAll(">", "&gt;");
	            pcontent = pcontent.replaceAll("\r\n", "<br>");
	            
	            Map<String,String> promap = new HashMap<>();
	            Map<String,String> pdetailmap = new HashMap<>();
	            Map<String,String> plusimgmap = new HashMap<>();
	            
	            // 제품테이블의 DAO로 전달하기 위한 promap productid 
	            // => cnum + mnum + seq
	            promap.put("fk_cnum", fk_cnum);
	            promap.put("fk_mnum", fk_mnum);
	            promap.put("productname", productname.toUpperCase());
	            promap.put("modelname", modelname);
	            promap.put("price", price);
	            promap.put("salepercent", salepercent);
	            promap.put("pimage1", pimage1);
	            
	            // 색상이 달라도 대표이미지는 1개다 ㅇㅋ?
	            
	            InterProductDAO pdao = new ProductDAO();
	            
	            // 아래와 같이 productid를 2개의 경우의 수로 나누는 이유는
	            // 이미 등록된 제품에서 추가정보를 클릭하여 추가색상제품을 만들때
	           
	            String productid = mtrRequest.getParameter("productid");

	            if("x".equalsIgnoreCase(productid)) { // 새상품등록할때.
	            // 제품테이블에 insert작업 + 제품번호(primary) 알아오기.
	            	productid = pdao.insertProduct(promap);
	            }
	            
	            
	            // 제품상세테이블의 DAO로 전달하기 위한 pdetailmap
	            pdetailmap.put("fk_snum", fk_snum);
	            pdetailmap.put("pinputdate", pinputdate);
	            pdetailmap.put("doption", doption);
	            pdetailmap.put("pqty", pqty);
	            pdetailmap.put("pcontent", pcontent);
	            pdetailmap.put("productname", productname.toUpperCase());
	            pdetailmap.put("modelname", modelname);
	            pdetailmap.put("productid", productid);
	            pdetailmap.put("pcolor", pcolor);
	            pdetailmap.put("mname", mname);
	            
	            InterProductDetailDAO pddao = new ProductDetailDAO();

	            // 제품상세테이블로 insert하기 + 제품상세번호(primary)알아오기
	            String getpnum = pddao.insertProductDetail(pdetailmap);
	            

	            // 제품추가이미지테이블로 전달하기위한 plusimgmap
	            plusimgmap.put("imgPlus1", imgPlus1);
	            plusimgmap.put("getpnum", getpnum);

	            // 제품추가이미지테이블로 insert하기
	            InterImageFileDAO ifiledao = new ImageFileDAO();
	            int n = ifiledao.insertPlusImage(plusimgmap);
	            
	            String message = "";
	            String loc = "";
	            if(n==1) {
	            	
	            	message = "제품등록에 성공하셨습니다.";
	            	loc = request.getContextPath()+"/admin/productmanage.cc";
	            }
	            else {
	            	message = "제품등록에 실패하셨습니다.";
	            	loc = request.getContextPath()+"/admin.cc";
	            }
	           
	            request.setAttribute("message", message);
	            request.setAttribute("loc", loc);
	            
	            super.setViewPage("/WEB-INF/adminMsg.jsp");
	            
			}// post방식 끝

			
		}
		
	}

}
