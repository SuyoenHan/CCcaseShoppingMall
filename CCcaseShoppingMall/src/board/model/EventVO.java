package board.model;

public class EventVO {
 
	private int eventno;				// 이벤트 번호
	private String fk_adminid;	// 이벤트 관리자 아이디
	private String title;				// 이벤트 제목
	private String registerdate; // 이벤트 등록일
	private String startdate;		// 이벤트 시작일
	private String enddate;	// 이벤트 종료일
	private int viewcount;			// 이벤트 조회수
	private String content;			// 이벤트 내용
	
	
	public EventVO() {}
	
	public EventVO(String title, String fk_adminid, String startdate, String enddate, String registerdate, 
			String content) {
		this.title = title;
		this.fk_adminid = fk_adminid;
		this.startdate = startdate;
		this.enddate = enddate;
		this.registerdate = registerdate;
		this.content = content;
	}

	public EventVO(int eventno, String title, String enddate, String content) {
		this.eventno = eventno;
		this.title = title;
		this.enddate = enddate;
		this.content = content;
	}

	public int getEventno() {
		return eventno;
	}
	
	public void setEventno(int eventno) {
		this.eventno = eventno;
	}
	
	public String getFk_adminid() {
		return fk_adminid;
	}
	
	public void setFk_adminid(String fk_adminid) {
		this.fk_adminid = fk_adminid;
	}
	
	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getRegisterdate() {
		return registerdate;
	}
	
	public void setRegisterdate(String registerdate) {
		this.registerdate = registerdate;
	}
	
	public String getStartdate() {
		return startdate;
	}

	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}

	public String getEnddate() {
		return enddate;
	}
	
	public void setEnddate(String endingdate) {
		this.enddate = endingdate;
	}
	
	public int getViewcount() {
		return viewcount;
	}
	
	public void setViewcount(int viewcount) {
		this.viewcount = viewcount;
	}
	
	public String getContent() {
		return content;
	}
	
	public void setContent(String content) {
		this.content = content;
	}

	
	
	
}
