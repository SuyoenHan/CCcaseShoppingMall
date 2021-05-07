package member.controller;

import java.util.HashMap;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import board.model.InterQnaDAO;
import board.model.QnaDAO;
import board.model.QnaVO;
import common.controller.AbstractController;
import my.util.Myutil;
import order.model.InterOrderDAO;
import order.model.OrderDAO;
import order.model.OrderVO;


public class MemberWriteListQnAAction extends AbstractController {

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
		InterQnaDAO qdao = new QnaDAO();
		InterOrderDAO odao = new OrderDAO();
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		paraMap.put("currentShowPageNo", currentShowPageNo);
		
		List<QnaVO> qnaList = qdao.qnaMywrite(paraMap);
		request.setAttribute("qnaList", qnaList);
		
		List<OrderVO> byreview=odao.byreview(paraMap);
        request.setAttribute("byreview",byreview);
		int totalPage = qdao.qnaMywriteTotalPage(userid);
		//System.out.println("~~~확인용~~"+totalPage);

		String pageBar="";
		
		int blockSize =1;
		int loop=1;
		int pageNo=0;
		// pageNo 는 페이지바에서 보여지는 첫번째 번호이다.
		
		
		// !!!! 다음은 pageNo 를 구하는 공식이다. !!!! //    
		pageNo= ( (Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1 ;
		
		//System.out.println(pageNo);
		//***[맨처음] [이전] 만들기***//
		if(pageNo != 1) {
			pageBar += "&nbsp;<a href='memberWriteListQnA.cc?userid="+userid+"&currentShowPageNo=1'>[맨처음]</a>&nbsp;";  
			pageBar += "&nbsp;<a href='memberWriteListQnA.cc?userid="+userid+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a>&nbsp;";
		}
		while( !(loop > blockSize || pageNo > totalPage) ) {
            
            if( pageNo == Integer.parseInt(currentShowPageNo) ) {
               pageBar += "&nbsp;<span style='border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</span>&nbsp;";        
            }
            else {
               pageBar += "&nbsp;<a href='memberWriteListQnA.cc?userid="+userid+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a>&nbsp;";
            }
            
            loop++;
            
            pageNo++; 
            
         }// end of while--------------------------------
		
		if(!(pageNo > totalPage)) {
			pageBar += "&nbsp;<a href='memberWriteListQnA.cc?userid="+userid+"&currentShowPageNo="+pageNo+"'>[다음]</a>&nbsp;";
			pageBar += "&nbsp;<a href='memberWriteListQnA.cc?userid="+userid+"&currentShowPageNo="+totalPage+"'>[마지막]</a>&nbsp;";
		}
		
		request.setAttribute("pageBar", pageBar);
		// 4.
				// *** 현재 페이지를 돌아갈 페이지( goBackURL)로 지정하기 *** //
				String currentURL = Myutil.getCurrentURL(request);
				// 회원조회를 했을시 현재 그 페이지로 그대로 되돌아가기 위한 용도로 쓰인다.

				currentURL = currentURL.replaceAll("&", " ");

				request.setAttribute("goBackURL", currentURL);
			
		super.setViewPage("/WEB-INF/member/memberWriteListQnA.jsp");
	
	}

	
}
