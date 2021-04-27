package my.util;

import javax.servlet.http.HttpServletRequest;

public class Myutil {
	// *** ? 다음의 데이터까지 포함한 현재 URL 주소를 알려주는 메소드를 생성 *** //
	public static String getCurrentURL(HttpServletRequest request) {
	
		// 현재 URL 주소가 아래와 같은 것이라면
		// http://localhost:9090/MyMVC/member/memberList.up?currentShowPageNo=6&sizePerPage=10&searchType=name&searchWord=영
		
		String currentURL = request.getRequestURL().toString();
		// http://localhost:9090/MyMVC/member/memberList.up?
		
		String queryString = request.getQueryString();
		// currentShowPageNo=6&sizePerPage=10&searchType=name&searchWord=영 (GET 방식일 경우)
		// null (POST방식일 경우)
		
		if(queryString != null) {
			currentURL += "?" + queryString;
		//	http://localhost:9090/MyMVC/member/memberList.up?currentShowPageNo=6&sizePerPage=10&searchType=name&searchWord=영
		}
		
		String ctxPath = request.getContextPath();
		//		/MyMVC
		
		int beginIndex = currentURL.indexOf(ctxPath) + ctxPath.length();
		//		27 = 									21					+		6
		
		currentURL = currentURL.substring(beginIndex + 1); 
		// member/memberList.up?currentShowPageNo=6&sizePerPage=10&searchType=name&searchWord=영
		
		return currentURL;
	}
	
	
}
