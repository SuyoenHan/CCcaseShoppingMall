package board.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import board.model.InterReviewDAO;
import board.model.ReviewDAO;
import board.model.ReviewVO;
import common.controller.AbstractController;
import member.model.MemberVO;
import order.model.InterODetailDAO;
import order.model.ODetailDAO;
import product.model.InterProductDAO;
import product.model.ProductDAO;

public class ReviewWriteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser != null ) {
		
			String method = request.getMethod();
		
			if(!"GET".equalsIgnoreCase(method)) {
				
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
				
				// cos.jar 라이브러리에서 제공하는 MultipartRequest 객체의 getFilesystemName("form에서의 첨부파일 name명") 메소드를 사용 한다. 
				// 이때 업로드 된 파일이 없는 경우에는 null을 반환한다.		  
					String odetailno = mtrequest.getParameter("odetailno");
					String rvtitle = mtrequest.getParameter("rvtitle");
					String satisfaction = mtrequest.getParameter("satisfaction");
					String reviewimage1 = mtrequest.getFilesystemName("reviewimage1");
					// System.out.println(reviewimage1);
					String reviewimage2 = mtrequest.getFilesystemName("reviewimage2");
					String reviewimage3 = mtrequest.getFilesystemName("reviewimage3");
					String fk_userid = mtrequest.getParameter("fk_userid");
					String fk_pname = mtrequest.getParameter("fk_pname");
					//System.out.println(reviewimage1);
					
				// !!!! 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어코드) 작성하기 !!!! //
				String rvcontent = mtrequest.getParameter("rcontent");
				
				rvcontent = rvcontent.replaceAll("<", "&lt;");
				rvcontent = rvcontent.replaceAll(">","&gt;");
				rvcontent = rvcontent.replaceAll("\r\n", "<br>");
	
				InterReviewDAO rdao = new ReviewDAO();
				
				ReviewVO rvo = new ReviewVO();
				rvo.setRvtitle(rvtitle);
				rvo.setSatisfaction(Integer.parseInt(satisfaction));
				rvo.setReviewimage1(reviewimage1);
				rvo.setReviewimage2(reviewimage2);
				rvo.setReviewimage3(reviewimage3);
				rvo.setRvcontent(rvcontent);
				rvo.setFk_odetailno(odetailno);
				rvo.setFk_userid(fk_userid);
				rvo.setFk_pname(fk_pname);
				
				
				// tbl_review 테이블에 제품정보 insert 하기
				int n = rdao.reviewInsert(rvo);
		/*		
				// === 추가이미지파일이 있다라면 tbl_product_imagefile 테이블에 제품의 추가이미지 파일명 insert 해주기 ===
				int m = 1;
				
				String str_attachCount = mtrequest.getParameter("attachCount");
				
				int attachCount = 0;
				
				if(!"".equals(str_attachCount)) {
					attachCount = Integer.parseInt(str_attachCount);
				}
				
				for(int i=0; i<attachCount; i++) {
					String attachFileName = mtrequest.getFilesystemName("attach"+i);
					
					m = rdao.review_imagefile_Insert(odetailno, attachFileName);
					
					if(m == 0) break;
				}// end of for-------------------------------------
		*/
				
				if(n == 1) {
					String message ="리뷰 등록이 완료되었습니다.";
					String loc = request.getContextPath()+"/board/reviewList.cc";
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
					// super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
				}
				
			}
			else {	
				
				String odetailno = request.getParameter("odetailno");
				request.setAttribute("odetailno", odetailno);
				
				InterODetailDAO oddao = new ODetailDAO();
				String pnum= oddao.getPnumByOdetailNo(odetailno);
				
				InterProductDAO pdao= new ProductDAO();
				Map<String,String> productInfo= pdao.getProductnameByPnum(pnum);
				request.setAttribute("productInfo", productInfo);
				
				
				// super.setRedirect(false);
				super.setViewPage("/WEB-INF/board/reviewWrite.jsp");	
		}
	}
		
	}
}