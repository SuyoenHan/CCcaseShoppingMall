package board.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import board.model.*;
import common.controller.AbstractController;
import member.model.*;

public class ReviewWriteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser != null) {
		
			String method = request.getMethod();
		
			if("GET".equalsIgnoreCase(method)) {
				
				MultipartRequest mtrequest = null;
				
				// 1. 첨부되어진 파일을 디스크의 어느경로에 업로드 할 것인지 그 경로를 설정해야 한다.
				ServletContext svlCtx = session.getServletContext();
				String imagesDir = svlCtx.getRealPath("/images");
				
				imagesDir = "C:\\Users\\User\\git\\CCcaseShoppingMall\\CCcaseShoppingMall\\WebContent\\images";
				
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
				
				
					String rvtitle = mtrequest.getParameter("rvtitle");
					String satisfaction = mtrequest.getParameter("satisfaction");
					String reviewimage1 = mtrequest.getParameter("reviewimage1");
					String reviewimage2 = mtrequest.getParameter("reviewimage2");
					String reviewimage3 = mtrequest.getParameter("reviewimage3");
				
				
				// !!!! 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어코드) 작성하기 !!!! //
				String rvcontent = mtrequest.getParameter("rvcontent");
				
				rvcontent = rvcontent.replaceAll("<", "&lt;");
				rvcontent = rvcontent.replaceAll(">","&gt;");
				rvcontent = rvcontent.replaceAll("\r\n", "<br>");
				
				InterReviewDAO rdao = new ReviewDAO();
				
				int reviewno = rdao.getReviewno(); // 리뷰번호 채번 해오기
				
				ReviewVO rvo = new ReviewVO();
				rvo.setReviewno(reviewno);
				rvo.setRvtitle(rvtitle);
				rvo.setSatisfaction(Integer.parseInt(satisfaction));
				rvo.setReviewimage1(reviewimage1);
				rvo.setReviewimage2(reviewimage2);
				rvo.setReviewimage3(reviewimage3);
				rvo.setRvcontent(rvcontent);
								
				// tbl_review 테이블에 제품정보 insert 하기
				int n = rdao.reviewInsert(rvo);
				
				// === 추가이미지파일이 있다라면 tbl_product_imagefile 테이블에 제품의 추가이미지 파일명 insert 해주기 ===
				int m = 1;
				
				String str_attachCount = mtrequest.getParameter("attachCount");
				
				int attachCount = 0;
				
				if(!"".equals(str_attachCount)) {
					attachCount = Integer.parseInt(str_attachCount);
				}
				
				for(int i=0; i<attachCount; i++) {
					String attachFileName = mtrequest.getFilesystemName("attach"+i);
					
					m = rdao.review_imagefile_Insert(reviewno, attachFileName);
					
					if(m == 0) break;
				}// end of for-------------------------------------
				
				if(n*m == 1) {
					String message ="리뷰 등록이 완료되었습니다.";
					String loc = request.getContextPath()+"/board/reviewList.cc";
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
					// super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
				}
				
			}
			else {	// POST 방식일때
				
				InterReviewDAO rdao = new ReviewDAO();
				List<ReviewVO> revList = rdao.selectRevList();
				request.setAttribute("revList", revList);
				
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/board/reviewWrite.jsp");	
		}
			
		} else {
			String message = "로그인 후 사용하세요.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
	}
}
