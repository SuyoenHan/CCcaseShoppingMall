package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class EventEditAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String goBackURL = request.getParameter("goBackURL");
		request.setAttribute("goBackURL", goBackURL); 

//   super.setRedirect(false);
        super.setViewPage("/WEB-INF/board/eventEdit.jsp");
	}

}
