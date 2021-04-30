package board.model;

import admin.model.AdminVO;
import member.model.MemberVO;

public class QnaVO {
	
	private int qnano;            		//qna순번
	private String fk_userid;     		//작성자
	private String fk_productid;     // 제품번호
	private String qtitle;         		// 제목
	private String qregisterdate;  	// 등록일
	private String qupdatedate;   	// 수정일
	private int qviewcount;        	// 조회수
	private String qcontent;      	   // 글내용
	private String email;				// 이메일
	private String qstatus;           	   // 공개여부  
	private String qnapwd;           // 글 비밀번호
	
	public MemberVO memberVO;
	public AdminVO adminVO;
	
	public QnaVO() {}
	
	public QnaVO(String qtitle, String fk_userid, String email, String fk_productid, String qstatus, String qnapwd, String qcontent) {

		this.qtitle = qtitle;
		this.fk_userid = fk_userid;
		this.email = email;
		this.fk_productid =fk_productid;
		this.qstatus = qstatus;
		this.qnapwd = qnapwd;
		this.qcontent = qcontent;
		
	}

	public QnaVO(int qnano, String qtitle, String fk_productid, String qcontent) {
		
		this.qnano = qnano;
		this.qtitle = qtitle;
		this.fk_productid =fk_productid;
		this.qcontent = qcontent;
	}

	public int getQnano() {
		return qnano;
	}
	
	public void setQnano(int qnano) {
		this.qnano = qnano;
	}
	
	public String getFk_userid() {
		return fk_userid;
	}
	
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	
	public String getFk_productid() {
		return fk_productid;
	}
	
	public void setFk_productid(String fk_productid) {
		this.fk_productid = fk_productid;
	}
	
	public String getQtitle() {
		return qtitle;
	}
	
	public void setQtitle(String qtitle) {
		this.qtitle = qtitle;
	}
	
	public String getQregisterdate() {
		return qregisterdate;
	}
	
	public void setQregisterdate(String qregisterdate) {
		this.qregisterdate = qregisterdate;
	}
	
	public String getQupdatedate() {
		return qupdatedate;
	}
	
	public void setQupdatedate(String qupdatedate) {
		this.qupdatedate = qupdatedate;
	}
	
	public int getQviewcount() {
		return qviewcount;
	}
	
	public void setQviewcount(int qviewcount) {
		this.qviewcount = qviewcount;
	}
	
	public String getQcontent() {
		return qcontent;
	}
	
	public void setQcontent(String qcontent) {
		this.qcontent = qcontent;
	}
	
	public String getQstatus() {
		return qstatus;
	}
	
	public void setQstatus(String qstatus) {
		this.qstatus = qstatus;
	}
	
	public String getQnapwd() {
		return qnapwd;
	}
	
	public void setQnapwd(String qnapwd) {
		this.qnapwd = qnapwd;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public MemberVO getMemberVO() {
		return memberVO;
	}

	public void setMemberVO(MemberVO memberVO) {
		this.memberVO = memberVO;
	}

	public AdminVO getAdminVO() {
		return adminVO;
	}

	public void setAdminVO(AdminVO adminVO) {
		this.adminVO = adminVO;
	}
	
	
}
