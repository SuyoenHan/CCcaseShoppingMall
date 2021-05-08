package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.CouponDAO;
import member.model.CouponVO;
import member.model.InterCouponDAO;

public class EventCouponInsertAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		
		String method= request.getMethod();
		
		// POST 방식일때만 쿠폰 insert 
		if("POST".equalsIgnoreCase(method)) {
			
			String fk_userid= request.getParameter("fk_userid");
			String cpstatus= request.getParameter("cpstatus");
			String cpcontent= request.getParameter("cpcontent");
			String cpname= request.getParameter("cpname");
			String cpdiscount= request.getParameter("cpdiscount");
			
			CouponVO cpvo= new CouponVO();
			cpvo.setFk_userid(fk_userid);
			cpvo.setCpstatus(Integer.parseInt(cpstatus));
			cpvo.setCpcontent(Integer.parseInt(cpcontent));
			cpvo.setCpname(cpname);
			cpvo.setCpdiscount(cpdiscount);
			
			
			InterCouponDAO cpdao= new CouponDAO();
			int n=cpdao.insertCoupon(cpvo);
			
			/*
		 		insert 성공 시 n==1
		 		insert 실패 시 n==0
			*/
			
			JSONObject jsonObj= new JSONObject();
			jsonObj.put("n", n);
		
			
			String json= jsonObj.toString();
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
			return;
		}
		
		else {
			String message="잘못된 경로로 들어왔습니다.";
			String loc="javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");	
			return;	
		}
		
	}

}
