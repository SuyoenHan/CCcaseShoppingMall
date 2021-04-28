package member.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;

public class MemberRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod(); // "GET" 또는 "POST" 
		
		if("GET".equalsIgnoreCase(method)) { 
			// 회원가입창을 띄운다
			//super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/registerMemberForm.jsp");
		}
		
		else {
			// 일반적인 회원으로 회원가입한 경우 라면
			String name = request.getParameter("name");
			String userid = request.getParameter("userid");
			String pwd = request.getParameter("pwd"); 
			String email = request.getParameter("email"); 
			String hp1 = request.getParameter("hp1"); 
			String hp2 = request.getParameter("hp2"); 
			String hp3 = request.getParameter("hp3"); 
			String postcode = request.getParameter("postcode");
			String address = request.getParameter("address"); 
			String detailaddress = request.getParameter("detailAddress"); 
			String extraaddress = request.getParameter("extraAddress"); 
			
			String mobile = hp1 + hp2 + hp3;
			
			MemberVO member = new MemberVO(userid, pwd, name, email, mobile, postcode, address, detailaddress, extraaddress); 
			
			InterMemberDAO dao = new MemberDAO();
			
			int n = dao.registerMember(member);
			
			
			if(n==1) {
				// 회원가입이 성공되면 자동으로 로그인 되도록 하겠다.
				
				request.setAttribute("userid", userid);
				request.setAttribute("pwd", pwd);

			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/member/registerSuccess.jsp");
			}
			else {
				String message = "회원가입 실패";
				String loc = "javascript:history.back()";  // 자바스크립트를 이용한 이전페이지로 이동하는 것.
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			
		}
		
		
	}

}
