package board.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import board.model.*;
import common.controller.AbstractController;
import member.model.MemberVO;
import order.model.InterODetailDAO;
import order.model.ODetailDAO;
import product.model.InterProductDAO;
import product.model.ProductDAO;
import product.model.ProductDetailVO;


public class ReviewEditAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			
			MultipartRequest mtrequest = null;
			
			// 1. 첨부되어진 파일을 디스크의 어느경로에 업로드 할 것인지 그 경로를 설정해야 한다.
			ServletContext svlCtx = session.getServletContext();
			String imagesDir = svlCtx.getRealPath("/images");
			
			imagesDir = "C:\\Users\\SY HAN\\git\\CCcaseShoppingMall\\CCcaseShoppingMall\\WebContent\\images";
			
			try {
				mtrequest = new MultipartRequest(request, imagesDir, 10*1024*1024, "UTF-8", new DefaultFileRenamePolicy());
			} catch(IOException e) {
				request.setAttribute("message", "업로드 되어질 경로가 잘못되었거나 또는 최대용량 10MB를 초과했으므로 파일업로드 실패함!!");
				request.setAttribute("loc", request.getContextPath()+"/board/reviewWrite.cc"); 
		   	  
				super.setViewPage("/WEB-INF/msg.jsp");
				return; // 종료 
			}
			
			String reviewno= mtrequest.getParameter("reviewno");
			String rvtitle = mtrequest.getParameter("rvtitle");
			String satisfaction = mtrequest.getParameter("satisfaction");
			String reviewimage1 = mtrequest.getFilesystemName("reviewimage1");
			String reviewimage2 = mtrequest.getFilesystemName("reviewimage2");
			String reviewimage3 = mtrequest.getFilesystemName("reviewimage3");
			String rvcontent = mtrequest.getParameter("rvcontent");
			
			rvcontent = rvcontent.replaceAll("<", "&lt;");
			rvcontent = rvcontent.replaceAll(">","&gt;");
			rvcontent = rvcontent.replaceAll("\r\n", "<br>");

			
			ReviewVO rvo = new ReviewVO();
			rvo.setRvtitle(rvtitle);
			rvo.setSatisfaction(Integer.parseInt(satisfaction));
			rvo.setReviewimage1(reviewimage1);
			rvo.setReviewimage2(reviewimage2);
			rvo.setReviewimage3(reviewimage3);
			rvo.setRvcontent(rvcontent);
			rvo.setReviewno(Integer.parseInt(reviewno));
			
			InterReviewDAO rdao = new ReviewDAO();
			
			try {
			int n = rdao.revEditUpdate(rvo);
			
			String message = "";
			String loc = "";
			
			if(n==1) {
				
				super.setRedirect(true);
				super.setViewPage(request.getContextPath()+"/board/reviewOneDetail.cc?reviewno="+reviewno);
				return;
			}
			else {
				message="글 수정에 실패하였습니다.";
				loc="javascript:history.back()";
			}
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			} catch(SQLException e) {
				e.printStackTrace();
				
				super.setRedirect(true);
				super.setViewPage(request.getContextPath() + "/error.cc");
			}
		}
		else {
			
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			String reviewno =  request.getParameter("reviewno");
			InterReviewDAO rdao = new ReviewDAO();
			
			ReviewVO rvo  = rdao.revEditOneView(reviewno);
			String odetailno= rvo.getFk_odetailno();
			
			InterODetailDAO oddao = new ODetailDAO();
			String pnum= oddao.getPnumByOdetailNo(odetailno);
			
			InterProductDAO pdao= new ProductDAO();
			Map<String,String> productInfo= pdao.getProductnameByPnum(pnum);
			request.setAttribute("productInfo", productInfo);
			
			request.setAttribute("rvo", rvo);
			request.setAttribute("productInfo", productInfo);
			
			
			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/board/reviewEdit.jsp");
			
			
		}
	}

}
