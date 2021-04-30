package board.controller;



import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.model.AdminVO;
import board.model.*;
import common.controller.AbstractController;


public class FaqwriteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		
		/*
		 * String name = request.getParameter("name"); String userid =
		 * request.getParameter("userid"); String pwd = request.getParameter("pwd");
		 * String email = request.getParameter("email"); String hp1 =
		 * request.getParameter("hp1"); String hp2 = request.getParameter("hp2"); String
		 * hp3 = request.getParameter("hp3"); String postcode =
		 * request.getParameter("postcode"); String address =
		 * request.getParameter("address"); String detailaddress =
		 * request.getParameter("detailAddress"); String extraaddress =
		 * request.getParameter("extraAddress"); String gender =
		 * request.getParameter("gender"); String birthyyyy =
		 * request.getParameter("birthyyyy"); String birthmm =
		 * request.getParameter("birthmm"); String birthdd =
		 * request.getParameter("birthdd");
		 * 
		 * String mobile = hp1 + hp2 + hp3; String birthday = birthyyyy +"-"+ birthmm
		 * +"-"+ birthdd;
		 * 
		 * MemberVO member = new MemberVO(userid, pwd, name, email, mobile, postcode,
		 * address, detailaddress, extraaddress, gender, birthday);
		 * 
		 * InterMemberDAO dao = new MemberDAO();
		 * 
		 * try { int n = dao.registerMember(member);
		 * 
		 * String message = ""; String loc=""; //이동해야할 페이지 경로
		 * 
		 * if(n==1) { message = "회원가입 성공"; loc= request.getContextPath()+"/home.up";
		 * //시작페이지로 이동한다. // /MyMVC/home.up } else { message = "회원가입 실패";
		 * loc="javascript:history.back()";// 자바스크립트를 이용한 이전페이지로 이동하는 것. }
		 * 
		 * request.setAttribute("message", message); request.setAttribute("loc", loc);
		 * 
		 * super.setRedirect(false); super.setViewPage("/WEB-INF/msg.jsp");
		 * 
		 * 
		 * if(n==1) { // 회원가입이 성공되면 자동으로 로그인 되도록 하겠다.
		 * 
		 * request.setAttribute("userid", userid); request.setAttribute("pwd", pwd);
		 * 
		 * // super.setRedirect(false);
		 * super.setViewPage("/WEB-INF/login/registerAfterAutoLogin.jsp"); } else {
		 * String message = "회원가입 실패"; String loc = "javascript:history.back()"; //
		 * 자바스크립트를 이용한 이전페이지로 이동하는 것.
		 * 
		 * request.setAttribute("message", message); request.setAttribute("loc", loc);
		 * 
		 * // super.setRedirect(false); super.setViewPage("/WEB-INF/msg.jsp"); }
		 * 
		 * }catch(SQLException e) { e.printStackTrace();
		 * 
		 * super.setRedirect(true);
		 * super.setViewPage(request.getContextPath()+"/error.up"); }
		 */
		
		HttpSession session = request.getSession();
		AdminVO avo = (AdminVO)session.getAttribute("adminUser");
		
		String method = request.getMethod();
		
		if(!"GET".equalsIgnoreCase(method)) { //POST 방식일때
		
			String ftitle = request.getParameter("ftitle");
	   	    String adminid = request.getParameter("adminid");
	   	    String fregisterdate = request.getParameter("fregisterdate");
	   	    String fcontent = request.getParameter("fcontent");
	   	    
	   	    FaqVO fvo = new FaqVO();
	   	    fvo.setFtitle(ftitle);
	   	    fvo.setFk_adminid(adminid);
	   	    fvo.setFregisterdate(fregisterdate);
	   	    fvo.setFcontent(fcontent);
	   	   //  System.out.println(fcontent);
	   	    
	   	    InterFaqDAO fdao = new FaqDAO();
	   	   
	   	    int n = fdao.faqInsert(fvo);
	   	 
	   	    if(n==1) {
	   	    	
	   	    	
	   	    	String message = "FAQ 글쓰기 성공!.";
				String loc = "/WEB-INF/board/faqList.jsp";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
	   	    }
	   	    
		
		}
		else {//GET 방식일때
			if(avo!=null) {
				
				request.setAttribute("avo", avo);
				System.out.println(avo.getAdminid());
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/board/faqwrite.jsp");
			}
			else {
				String message = "FAQ 글쓰기는 관리자만 접근이 가능합니다.";
				String loc = "javascript:location.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}

		}
	
	}

}
