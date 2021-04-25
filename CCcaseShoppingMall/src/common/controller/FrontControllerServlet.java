package common.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(
		description = "사용자가 웹에서 *.cc를 했을경우 응답해주는 서블릿", 
		urlPatterns = { "*.cc" }, 
		initParams = { 
				@WebInitParam(name = "propertyConfig", value ="Command.properties", description = "*.cc에 대한 클래스의 매핑파일")
		})

public class FrontControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	Map<String, Object> cmdMap = new HashMap<>();

	public void init(ServletConfig config) throws ServletException {

		String props= config.getInitParameter("propertyConfig");
		// System.out.println("확인용 props => " +props);  
	
		String realFolder="/WEB-INF";
		ServletContext context= config.getServletContext();
		// System.out.println("확인용 context => " +context); 
		
		String realFilePath= context.getRealPath(realFolder)+File.separator+props;
		// System.out.println("확인용 realFilePath => " +realFilePath); 
		
		try {
			FileInputStream fis= null;
			fis= new FileInputStream(realFilePath);
			
			Properties pr= new Properties();
			pr.load(fis); 
		 
			Enumeration<Object> en= pr.keys();
			
			while(en.hasMoreElements()) {
				String key= (String) en.nextElement(); 
				// System.out.println("확인용 key => "+key);
				// System.out.println("확인용 value => " + pr.getProperty(key));
				
				String className= pr.getProperty(key);
				
				if(className!=null) {
					className= className.trim();
					Class<?> cls= Class.forName(className);
					
					Object obj= cls.newInstance();
					cmdMap.put(key,obj);
				} // end of if------
			} // end of while--------------
			
		} catch (FileNotFoundException e) { // value와 일치하는 파일이 없는경우
			System.out.println(">>>C:/Users/SY HAN/git/CCcaseShoppingMall/CCcaseShoppingMall/WebContent/WEB-INF/Command.properties 파일이 없습니다<<<");
			e.printStackTrace();
		} catch(IOException e) { // pr.load(fis)의 exception 처리
			e.printStackTrace();
		} catch(ClassNotFoundException e) { // Class.forName(className)의 exception 처리
			System.out.println(">>> 문자열로 명명되어진 클래스가 존재하지 않습니다.");
			e.printStackTrace();
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	} // end of public void init(ServletConfig config) throws ServletException------------------------------------

	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		requestProcess(request,response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		requestProcess(request,response);
	}

	
	private void requestProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    
		String uri= request.getRequestURI(); 
	    String key= uri.substring(request.getContextPath().length());
	    
	    // 다형성을 이용하여 객체 생성
	    AbstractController action= (AbstractController) cmdMap.get(key);
	    if(action == null) { // key에 해당하는 클래스가 존재하지 않는 경우
	    	System.out.println(">>> "+key+" URL 패턴에 매핑된 클래스는 없습니다.");
	    }
	    else { // key에 해당하는 클래스가 존재하는 경우
	    	try {
	    		
			   request.setCharacterEncoding("UTF-8"); // POST 방식의 한글깨지는 현상 방지
			   
			   action.execute(request, response); // 오버라이딩으로 사용할 메소드
			   boolean bool= action.isRedirect();
			   String viewPage= action.getViewPage();
				
				if(!bool) { // view단 페이지로 forward
					if(viewPage!=null) {
						RequestDispatcher dispatcher= request.getRequestDispatcher(viewPage);
						dispatcher.forward(request, response);
					}
				}
				else { // sendRedirect(웹브라우저의 URL 이동)
					if(viewPage!=null) {
						response.sendRedirect(viewPage);
					}
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
	    }
	
	} // end of private void requestProcess(HttpServletRequest request, HttpServletResponse response)------------
	
}
