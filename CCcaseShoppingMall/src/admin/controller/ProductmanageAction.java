package admin.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.model.*;
import common.controller.AbstractController;
import product.model.*;

public class ProductmanageAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		HttpSession session = request.getSession();
		AdminVO avo = (AdminVO)session.getAttribute("adminUser");
		
		
		if(avo == null) {
			String message = "로그인 후 이용가능합니다.";
			String loc = request.getContextPath()+"/admin.cc";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/adminMsg.jsp");
		}
		
		else {
			
			// 일단 내가 보고있는 페이지 no가필요
			// 한페이지당 몇개 보여줄지가 필요한데 나는 10개 5개 3개를 이렇게 보여주기 위해서 또 selece태그에서 받아와야한다.
			String currentShowPageNo = request.getParameter("currentShowPageNo");
			String sizePerPage = request.getParameter("sizePerPage");
			
			// 아래 두 변수는 검색어에 입력을 했을때의 값을 가져오는것이다.
			String searchType = request.getParameter("searchType");
			String searchWord = request.getParameter("searchWord"); 
			
			
			// 검색어가 null 또는 serachType이 null일때  url에서 null이 넘어가는 것의 예외처리 + 페이징 처리 하기 위한것(2페이지를 눌러도 그 검색어로 나오도록)
			if(searchType==null) { // 제일 처음에 페이지가 로딩될때 java로 넘어오니깐 그때는 searchType이 없다. 따라서 그때 url을 보면 null로 나와서 보기 안좋다.
				searchType="";
			}
			if(searchWord==null) { // 이용자가 아무것도 적지않을때, 제일 처음 페이지 로딩될때 그때 searchWord는 null이다.
				searchWord="";
			}
			

			// 맨처음 url로 들어왔을때 get방식이니깐 위의 값들은 없다 (null예외처리)
			// 그리고 추후  get방식으로 sizePerPage을 넘겨줄때 이용자가 장난질을 할 수 있으므로, 내가 보여질 갯수를 정한 값이 아닌것을 아래와 같이 정의한다.
			// 따라서 if문써서 기본값필요
			if(sizePerPage==null ||!("3".equals(sizePerPage) || "5".equals(sizePerPage) || "10".equals(sizePerPage)) ) {
					sizePerPage="10";
				}
			
			if(currentShowPageNo==null) {
				currentShowPageNo ="1";
			}
			
			// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 숫자 아닌 문자를 입력한 경우 또는 
	        //     int 범위를 초과한 숫자를 입력한 경우라면 currentShowPageNo 는 1 페이지로 만들도록 한다. ==== // 
			try {
				Integer.parseInt(currentShowPageNo);
			} catch (NumberFormatException e) {
				currentShowPageNo ="1";
			}

			
			// 아래 변수 3개는 내가 선택한 보여줄 제품개수값, 검색어, searchtype을 보여주기 위해 또 jsp로보내준다. 
			// 받아온 sizePerPage의 값을 다시 setAttribute해서 내가 선택한 값을 드롭박스에 보이도록 하기
			request.setAttribute("sizePerPage", sizePerPage);
			request.setAttribute("searchType", searchType);
			request.setAttribute("searchWord", searchWord);
			
			searchWord = searchWord.toUpperCase();
			
			InterProductDAO pdao = new ProductDAO();
			Map<String,String> paraMap = new HashMap<>();
			paraMap.put("sizePerPage", sizePerPage);
			paraMap.put("currentShowPageNo", currentShowPageNo);
			paraMap.put("searchType", searchType);
			paraMap.put("searchWord", searchWord);
			int totalPage = pdao.getTotalPage(paraMap);
			
			
			InterProductDetailDAO pddao = new ProductDetailDAO();
			List<Map<String,String>> proList = pddao.selectProInfo(paraMap);
			
			// 제품리스트를 가져오는 메소드에서 proList를 가져왔고, 그것을 view단에 보여준다.
			request.setAttribute("proList", proList);
			
			String pageBar= "";
			int blockSize= 5;  // 토막당 보여지는 페이지 개수
			int loop=1;
			int pageNo= ((Integer.parseInt(currentShowPageNo)-1)/blockSize) * blockSize + 1;  // 페이지바에서 처음으로 보여지는 번호 (1,6,11..)
			
			
			// [처음][이전] 만들기
			if(pageNo != 1) {
				pageBar += "&nbsp;<a href='productmanage.cc?currentShowPageNo=1&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[맨처음]</a>&nbsp;"; 
				pageBar += "&nbsp;<a href='productmanage.cc?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[이전]</a>&nbsp;";
			}
			
			while(!(loop>blockSize || pageNo > totalPage) ) {
				if(pageNo == Integer.parseInt(currentShowPageNo)) {
					pageBar += "&nbsp;<span style='padding:2px 4px; font-weight: bold; background-color: #ffff99;'>"+pageNo+"</span>&nbsp;";
				}
				else {
					pageBar += "&nbsp;<a href='productmanage.cc?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>"+pageNo+"</a>&nbsp;";
				}
				
				loop++;
				pageNo++; 
				
			}// end of while-----------------------------
			
			if(pageNo <= totalPage) {
				pageBar += "&nbsp;<a href='productmanage.cc?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[다음]</a>&nbsp;";
				pageBar += "&nbsp;<a href='productmanage.cc?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[마지막]</a>&nbsp;";
			}
			
			request.setAttribute("pageBar", pageBar);

			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/admin/productManage.jsp");
			
		}
		
	}

}
