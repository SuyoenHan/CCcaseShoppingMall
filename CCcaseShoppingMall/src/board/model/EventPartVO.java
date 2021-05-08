package board.model;

import member.model.MemberVO;

public class EventPartVO {

	private int fk_eventno;     // 이벤트 번호
	private String fk_userid;   // 이벤트참여자 (회원아이디)
	
	private EventVO evo;
	private MemberVO mvo;

	
	public EventPartVO() {}

	
	public EventPartVO(int fk_eventno, String fk_userid, EventVO evo, MemberVO mvo) {
		super();
		this.fk_eventno = fk_eventno;
		this.fk_userid = fk_userid;
		this.evo = evo;
		this.mvo = mvo;
	}


	public int getFk_eventno() {
		return fk_eventno;
	}

	
	public void setFk_eventno(int fk_eventno) {
		this.fk_eventno = fk_eventno;
	}

	
	public String getFk_userid() {
		return fk_userid;
	}

	
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}

	
	public EventVO getEvo() {
		return evo;
	}


	public void setEvo(EventVO evo) {
		this.evo = evo;
	}


	public MemberVO getMvo() {
		return mvo;
	}


	public void setMvo(MemberVO mvo) {
		this.mvo = mvo;
	}
	
	
	
	
}
