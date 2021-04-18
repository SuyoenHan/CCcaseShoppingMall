<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="header.jsp"/>
<jsp:include page="leftSide.jsp"/>

<link rel="stylesheet" href="css/mainMenu(Each).css" />

<%-- 세부메뉴 클릭시, 페이지 이동 후 화면 표기해주는 html작성 --%>
<div id="contents">
	<div id="showall_contentsup">
		<div id="hardCase">하드케이스</div>
		
		<%-- 하드케이스 세부내용 --%>
		<div class="case_detail"> 
			<div id=hard_samsung class ="company_case">
					<div class="company_case_detail">삼성</div>
					<div> <span class="model">갤럭시 S21</span> <span class="modelCount">(30)</span> </div>  
					<div> <span class="model">갤럭시 S21+</span> <span class="modelCount">(30)</span> </div>
					<div> <span class="model">갤럭시 S10</span> <span class="modelCount">(30)</span> </div>
					<div> <span class="model">갤럭시 노트 20</span> <span class="modelCount">(30)</span> </div>
					<div> <span class="model">갤럭시 노트 10</span> <span class="modelCount">(30)</span> </div>
					<div> <span class="model">갤럭시 S9</span> <span class="modelCount">(30)</span> </div>
					<div> <span class="model">갤럭시 S9+</span> <span class="modelCount">(30)</span> </div>
					<div> <span class="model">갤럭시 S8</span> <span class="modelCount">(30)</span> </div>
					<div> <span class="model">갤럭시 S8+</span> <span class="modelCount">(30)</span> </div>
					<div> <span class="model">갤럭시 Z Flip</span> <span class="modelCount">(30)</span> </div>
					<br><br><br>				
			</div>
					
		</div>
		
		<div class="case_detail"> 
			<div id=hard_apple class ="company_case">
					<div class="company_case_detail">애플</div>
					<div> <span class="model">아이폰 12 pro</span> <span class="modelCount">(30)</span> </div>  
					<div> <span class="model">아이폰 12</span> <span class="modelCount">(30)</span> </div>
					<div> <span class="model">아이폰 12 mini</span> <span class="modelCount">(30)</span> </div>
					<div> <span class="model">아이폰 11 pro</span> <span class="modelCount">(30)</span> </div>
					<div> <span class="model">아이폰 11</span> <span class="modelCount">(30)</span> </div>
					<div> <span class="model">아이폰 SE2</span> <span class="modelCount">(30)</span> </div>
					<div> <span class="model">아이폰 XS</span> <span class="modelCount">(30)</span> </div>
					<div> <span class="model">아이폰 X</span> <span class="modelCount">(30)</span> </div>
					<div> <span class="model">아이폰 8 Plus</span> <span class="modelCount">(30)</span> </div>
					<div> <span class="model">아이폰 8</span> <span class="modelCount">(30)</span> </div>
					<div> <span class="model">아이폰 7</span> <span class="modelCount">(30)</span> </div>
					<div> <span class="model">아이폰 7 Plus</span> <span class="modelCount">(30)</span> </div>
					<div> <span class="model">아이폰 6s</span> <span class="modelCount">(30)</span> </div>				
			</div>		
		</div>
		
		<div class="case_detail"> 
			<div id=hard_Lg class ="company_case">
					<div class="company_case_detail">애플</div>
					<div> <span class="model">LG Wing</span> <span class="modelCount">(30)</span> </div>  
					<div> <span class="model">LG Velvet</span> <span class="modelCount">(30)</span> </div>
					<div> <span class="model">LG V50</span> <span class="modelCount">(30)</span> </div>
					<div> <span class="model">LG V40</span> <span class="modelCount">(30)</span> </div>
					<div> <span class="model">LG V30</span> <span class="modelCount">(30)</span> </div>
					<div> <span class="model">LG V20</span> <span class="modelCount">(30)</span> </div>
					<div> <span class="model">LG G7</span> <span class="modelCount">(30)</span> </div>
					<div> <span class="model">LG G6</span> <span class="modelCount">(30)</span> </div>
					<br><br><br><br><br>				
			</div>		
		</div>
		
		<div class="case_detail" style="border-right: none;"> 	
			<div id=hard_Lg class ="company_case">
					<div class="company_case_detail">기타</div>
					<div> <span class="model">redmi 3s</span> <span class="modelCount">(30)</span> </div>  
					<div> <span class="model">redmi note3</span> <span class="modelCount">(30)</span> </div>
					<div> <span class="model">redmi Pro</span> <span class="modelCount">(30)</span> </div>
					<br><br><br><br><br><br><br><br><br><br>
			</div>		
		</div>
			
	</div>
</div> 

<jsp:include page="rightSide.jsp"/>
<jsp:include page="footer.jsp"/>
