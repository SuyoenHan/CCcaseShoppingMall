package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import board.model.*;
import common.controller.AbstractController;

public class LikeCountAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String reviewno = request.getParameter("reviewno");
		
		InterReviewDAO rdao = new ReviewDAO();
		int likecnt = rdao.getLikeCnt(reviewno);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("likecnt", likecnt);
		
		String json = jsonObj.toString();
		request.setAttribute("json", json);
		
//		super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonview.jsp");
	}

}
