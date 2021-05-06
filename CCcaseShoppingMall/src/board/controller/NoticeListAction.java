package board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.model.AdminVO;
import board.model.*;
import common.controller.AbstractController;
import my.util.Myutil;

public class NoticeListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		

		HttpSession session = request.getSession();
		AdminVO avo = (AdminVO)session.getAttribute("adminUser");
	
		
		request.setAttribute("avo", avo);
		
		
		String method = request.getMethod();
		
	    if("GET".equalsIgnoreCase(method)) {
		
		
			InterNoticeDAO ndao = new NoticeDAO();
			
			String currentShowPageNo =request.getParameter("currentShowPageNo");
			// currentShowPageNo 은 사용자가 보고자하는 페이지바의 페이지번호 이다.
			String sizePerPage = request.getParameter("sizePerPage");
			// 한 페이지당 화면상에 보여줄 공지사항의 개수
			
			if(currentShowPageNo == null) {
				currentShowPageNo = "1";
			}
			if(sizePerPage == null  || !"7".equals(sizePerPage) ) {
				sizePerPage="7"; // null ,7을 제외한 나머지는 모두 5개만 뜸. url get방식으로 장난칠 수 없게 만들어 준 것이다.
			}
			
			request.setAttribute("currentShowPageNo", currentShowPageNo);
			request.setAttribute("sizePerPage", sizePerPage);
			
			// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 숫자 아닌 문자를 입력한 경우 또는 
	        //     int 범위를 초과한 숫자를 입력한 경우라면 currentShowPageNo 는 1 페이지로 만들도록 한다. ==== // 
			try { //사용자가 장난치는경우 INT값을 넘기는 경우 1페이지10개로 나타나게 해준다.
				Integer.parseInt(currentShowPageNo);
			}catch(NumberFormatException e) {
				currentShowPageNo ="1";
			}
			
			Map<String,String> paraMap =new HashMap<>();
			paraMap.put("currentShowPageNo", currentShowPageNo);
			paraMap.put("sizePerPage", sizePerPage);
			
			
		
			
			// 페이징처리를 위해서 전체회원에 대한 총페이지 개수 알아오기(select) 
			int totalPage =ndao.selectTotalPage(paraMap);
			
			if( Integer.parseInt(currentShowPageNo) > totalPage ) {
				//ex)21페이지가 끝인데 30을 쳤을 경우 무조건 "1"을 주겠다는 말임. 이것을DB에 보낸다는말.
				currentShowPageNo= "1";
				paraMap.put("currentShowPageNo", currentShowPageNo);
			}
			
			
			List<NoticeVO> noticeList = ndao.selectPagingNotice(paraMap);
			
			request.setAttribute("noticeList", noticeList);
			
			// ==페이지바 만들기 ==
			String pageBar = "";
			
			int blockSize = 5;
			// blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다.
			
			int loop = 1;
			// loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(지금은 10개)까지만 증가하는 용도이다. 
			
			int pageNo = 0;
			// pageNo 는 페이지바에서 보여지는 첫번째 번호이다.
			
			// !!!! 다음은 pageNo 를 구하는 공식이다. !!!! //    
			pageNo = ( (Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1 ;
			
			
			if(pageNo != 1) {
				pageBar += "&nbsp;<a href='noticeList.cc?currentShowPageNo=1&sizePerPage="+sizePerPage+"'>[맨처음]</a>&nbsp;";   
				pageBar += "&nbsp;<a href='noticeList.cc?currentShowPageNo="+(pageNo-1) +"&sizePerPage="+sizePerPage+"'>[이전]</a>&nbsp";    
			}
			
			
			while( !(loop > blockSize || pageNo > totalPage ) ) { // loop 가 blockSize보다 커지면 빠져나오라는 말.
				
				if( pageNo == Integer.parseInt(currentShowPageNo) ) {
					pageBar += "&nbsp;<span style='border:solid 1px gray; color:red; padding:2px 4px;'>"+ pageNo + "</span>&nbsp;";    
				}
				else {
					pageBar += "&nbsp;<a href='noticeList.cc?currentShowPageNo="+ pageNo +"&sizePerPage="+sizePerPage+"'> "+ pageNo + "</a>&nbsp;";    
				}
				loop++;
				
				pageNo++; //              1  2  3  4  5  6  7  8  9 10 [다음] [마지막]
						  // [맨처음][이전] 11 12 13 14 15 16 17 18 19 20 [다음] [마지막]
						  // [맨처음][이전] 21 22 23 24 25 26 27 28 29 30 [다음] [마지막]
						  // [맨처음][이전] 31 32 33 34 35 36 37 38 39 40 [다음] [마지막]
						  // [맨처음][이전] 41 42                                                                     
				// 42는 여기까지 나와야 함..(43,44,45...나오면 안됨) pageNo > totalPage 면 빠져나온다는 것을 적어주어야함
			
			}//end of while------------------------------
			
			if( pageNo <= totalPage ) {
				pageBar += "&nbsp;<a href='noticeList.cc?currentShowPageNo="+ pageNo +"&sizePerPage="+sizePerPage+"'>[다음]</a>&nbsp;";    
				pageBar += "&nbsp;<a href='noticeList.cc?currentShowPageNo="+ totalPage +"&sizePerPage="+sizePerPage+"'>[마지막]</a>&nbsp;";    
			}
			
			
			
		  //  *** 현재페이지를 돌아갈 페이지(goBack)로 주소 지정하기 *** //
			String currentURL = Myutil.getCurrentURL(request);
			
			currentURL = currentURL.replaceAll("&", " ");
			
			request.setAttribute("goBackURL", currentURL);
			
			
			//////////////////////////////////////////////////////
						
						
			request.setAttribute("pageBar", pageBar);
			
			
			
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/board/noticeMain.jsp");
			
			if(avo!=null) {
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/board/adminNoticeMain.jsp");
		
			}

	    }
	}    
}
