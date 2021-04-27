package board.model;

import admin.model.AdminVO;

public class NoticeVO {

	public int 	noticeno; 					// 공지사항 번호
	public String fk_adminid;		// 작성자
	public String ntitle;					// 제목
	public String nregisterdate;	// 등록일자
	public String nupdatedate;	// 최근수정일자
	public int nviewcount;				// 조회수
	public String ncontent;			// 내용
	
	public AdminVO adminVO; 	// 관리자VO


	public int getNoticeno() {
		return noticeno;
	}
	
	public void setNoticeno(int noticeno) {
		this.noticeno = noticeno;
	}
	
	public String getFk_adminid() {
		return fk_adminid;
	}
	
	public void setFk_adminid(String fk_adminid) {
		this.fk_adminid = fk_adminid;
	}
	
	public String getNtitle() {
		return ntitle;
	}
	
	public void setNtitle(String ntitle) {
		this.ntitle = ntitle;
	}
	
	public String getNregisterdate() {
		return nregisterdate;
	}
	
	public void setNregisterdate(String nregisterdate) {
		this.nregisterdate = nregisterdate;
	}
	
	public String getNupdatedate() {
		return nupdatedate;
	}
	
	public void setNupdatedate(String nupdatedate) {
		this.nupdatedate = nupdatedate;
	}
	
	public int getNviewcount() {
		return nviewcount;
	}
	
	public void setNviewcount(int nviewcount) {
		this.nviewcount = nviewcount;
	}
	
	public String getNcontent() {
		return ncontent;
	}
	
	public void setNcontent(String ncontent) {
		this.ncontent = ncontent;
	}
	
	public AdminVO getAdminVO() {
		return adminVO;
	}

	public void setAdminVO(AdminVO adminVO) {
		this.adminVO = adminVO;
	}

}
