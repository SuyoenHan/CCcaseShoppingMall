package member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.InterReviewDAO;
import board.model.ReviewDAO;
import board.model.ReviewVO;
import common.controller.AbstractController;
import my.util.Myutil;

public class MemberWriteListReviewAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String userid = request.getParameter("userid");
		
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		
		if(currentShowPageNo == null) {
			currentShowPageNo="1";// 한 페이지당 화면상에 보여줄 제품의 개수는 10 으로 한다. sizePerPage 는 ProductDAO 에서 상수로 설정해 두었음.
		}
		
		try {
				Integer.parseInt(currentShowPageNo);
		}catch (NumberFormatException e) {
			currentShowPageNo="1";
		}
		InterReviewDAO rdao = new ReviewDAO();
		
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		paraMap.put("currentShowPageNo", currentShowPageNo);
		
		List<ReviewVO> revList= rdao.reviewMywrite(paraMap);
		request.setAttribute("revList", revList);
		
		int totalPage = rdao.reviewMywriteTotalPage(userid);
		//System.out.println("확인용 totalPage=>"+totalPage);
		String pageBar="";
		
		int blockSize = 1;
		int loop=1;
		int pageNo=0;
		// pageNo 는 페이지바에서 보여지는 첫번째 번호이다.
		
		
		// !!!! 다음은 pageNo 를 구하는 공식이다. !!!! //    
		pageNo= ( (Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1 ;
		
		//System.out.println(pageNo);
		//***[맨처음] [이전] 만들기***//
		if(pageNo != 1) {
			pageBar += "&nbsp;<a href='memberWriteListReview.cc?userid="+userid+"&currentShowPageNo=1'>[맨처음]</a>&nbsp;";  
			pageBar += "&nbsp;<a href='memberWriteListReview.cc?userid="+userid+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a>&nbsp;";
		}
		while( !(loop > blockSize || pageNo > totalPage) ) {
            
            if( pageNo == Integer.parseInt(currentShowPageNo) ) {
               pageBar += "&nbsp;<span style='border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</span>&nbsp;";        
            }
            else {
               pageBar += "&nbsp;<a href='memberWriteListReview.cc?userid="+userid+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a>&nbsp;";
            }
            
            loop++;
            
            pageNo++; 
            
         }// end of while--------------------------------
		
		if(!(pageNo > totalPage)) {
			pageBar += "&nbsp;<a href='memberWriteListReview.cc?userid="+userid+"&currentShowPageNo="+pageNo+"'>[다음]</a>&nbsp;";
			pageBar += "&nbsp;<a href='memberWriteListReview.cc?userid="+userid+"&currentShowPageNo="+totalPage+"'>[마지막]</a>&nbsp;";
		}
		
		request.setAttribute("pageBar", pageBar);
			
		String currentURL = Myutil.getCurrentURL(request);
				

		currentURL = currentURL.replaceAll("&", " ");

		request.setAttribute("goBackURL", currentURL);
		
		super.setViewPage("/WEB-INF/member/memberWriteListReview.jsp");
	}

}
