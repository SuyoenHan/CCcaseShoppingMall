package admin.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.controller.AbstractController;
import product.model.*;

public class ProDetailOrUpdateAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		String method = request.getMethod();
		
		if(!"POST".equalsIgnoreCase(method)) {
			
            String goBackURL = request.getParameter("goBackURL");
            request.setAttribute("goBackURL", goBackURL);
			
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
			
			
			String pnum = request.getParameter("pnum");
			
			InterProductDetailDAO pddao = new ProductDetailDAO();
			Map<String,String> detailMap = pddao.proOneDetail(pnum);
			String mapSize= String.valueOf(detailMap.size());
			
			// select해온결과 해당 행이 있을 경우
			if(detailMap.size()>0) {
				
				request.setAttribute("productid", detailMap.get("productid")); 
				request.setAttribute("pnum", detailMap.get("pnum"));
			//	System.out.println("detailMap.get(pnum)"+detailMap.get("pnum"));
				request.setAttribute("productname", detailMap.get("productname"));
				request.setAttribute("mnum", detailMap.get("mnum"));
				request.setAttribute("modelname", detailMap.get("modelname"));
				request.setAttribute("cnum", detailMap.get("cnum"));
				request.setAttribute("price", detailMap.get("price"));
				request.setAttribute("salepercent", detailMap.get("salepercent"));
				request.setAttribute("pname", detailMap.get("pname"));
				request.setAttribute("pcolor", detailMap.get("pcolor"));
				request.setAttribute("pqty", detailMap.get("pqty"));
				request.setAttribute("snum", detailMap.get("snum"));
				request.setAttribute("pinputdate", detailMap.get("pinputdate"));
				request.setAttribute("doption", detailMap.get("doption"));
				request.setAttribute("pcontent", detailMap.get("pcontent"));
				request.setAttribute("imgno", detailMap.get("imgno"));
				request.setAttribute("mapSize", mapSize);
				
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/admin/proDetailOrUpdate.jsp");
			}
			else {
				String message = "해당제품에 대한 수정은 불가합니다.";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/adminMsg.jsp");
			}
		
		}
		else { //POST방식일때
			
			MultipartRequest mtrRequest = null;
			HttpSession session = request.getSession();
			ServletContext svlCtx =  session.getServletContext();
			
			String imagesDir = svlCtx.getRealPath("/images");
			
			imagesDir = "C:\\Users\\SY HAN\\git\\CCcaseShoppingMall\\CCcaseShoppingMall\\WebContent\\images";
			
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
			String imgPlus1 = mtrRequest.getFilesystemName("imgPlus1");     // 제품추가이미지(이미지추가테이블)
			
			String pcontent = mtrRequest.getParameter("pcontent"); 			// 제품설명란(제품상세테이블)
			// 크로스 사이트 스크립트 공격 방지
			pcontent = pcontent.replaceAll("<", "&lt;");
            pcontent = pcontent.replaceAll(">", "&gt;");
            pcontent = pcontent.replaceAll("\r\n", "<br>");
			
			// 히든으로 처리한 input값 가져오기
			String productid = mtrRequest.getParameter("productid");
			String pnum = mtrRequest.getParameter("pnum");
			System.out.println(pnum);
			String imgno = mtrRequest.getParameter("imgno");
			
			Map<String,String> promap = new HashMap<>();
            Map<String,String> pdetailmap = new HashMap<>();
            Map<String,String> plusimgmap = new HashMap<>();
            
            promap.put("productid", productid);
            promap.put("productname", productname);
            promap.put("modelname", modelname);
            promap.put("fk_mnum", fk_mnum);
            promap.put("fk_cnum", fk_cnum);
            promap.put("price", price);
            promap.put("salepercent", salepercent);
            promap.put("pimage1", pimage1);
            
            InterProductDAO pdao = new ProductDAO();
            int n = pdao.updateProduct(promap);
            
            pdetailmap.put("pnum", pnum);
            pdetailmap.put("fk_productid", productid);
            pdetailmap.put("mname", mname);
            pdetailmap.put("modelname", modelname);
            pdetailmap.put("productname", productname);
            pdetailmap.put("pcolor", pcolor);
            pdetailmap.put("pqty", pqty);
            pdetailmap.put("fk_snum", fk_snum);
            pdetailmap.put("pcontent", pcontent);
            pdetailmap.put("pinputdate", pinputdate);
            pdetailmap.put("doption", doption);
            
            InterProductDetailDAO pddao = new ProductDetailDAO();
            int m = pddao.updateProductDetail(pdetailmap);

            plusimgmap.put("imgno", imgno);
            plusimgmap.put("pnum", pnum);
            plusimgmap.put("imgPlus1", imgPlus1);
            
            InterImageFileDAO imagedao = new ImageFileDAO();
            int k = imagedao.updateImage(plusimgmap);
            
          
            
            if(n*m*k==1) {
            	String message = "제품수정에 성공하셨습니다.";
            	String loc =request.getContextPath()+"/admin/productmanage.cc";
            	
            	request.setAttribute("message", message);
            	request.setAttribute("loc", loc);
            	
            	super.setRedirect(false);
            	super.setViewPage("/WEB-INF/adminMsg.jsp");
            }
            
			
		}
	}

}
