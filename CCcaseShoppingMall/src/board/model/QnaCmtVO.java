package board.model;

public class QnaCmtVO {

	private int cmtno;						// 답글번호
	private int fk_qnano;					// qna 원글번호
	private String fk_adminid;			// 관리자id
	private String cmtregisterday;		// 등록일
	private String cmtcontent;			// 답변 내용
	
	private QnaVO qvo;

	public QnaCmtVO() {}
	
	public QnaCmtVO(int fk_qnano, String fk_adminid, String cmtcontent) {
		
		this.fk_qnano = fk_qnano;
		this.fk_adminid = fk_adminid;
		this.cmtcontent = cmtcontent;
		
	}
	
	public int getCmtno() {
		return cmtno;
	}

	public void setCmtno(int cmtno) {
		this.cmtno = cmtno;
	}

	public int getFk_qnano() {
		return fk_qnano;
	}

	public void setFk_qnano(int fk_qnano) {
		this.fk_qnano = fk_qnano;
	}

	public String getFk_adminid() {
		return fk_adminid;
	}

	public void setFk_adminid(String fk_adminid) {
		this.fk_adminid = fk_adminid;
	}

	public String getCmtregisterday() {
		return cmtregisterday;
	}

	public void setCmtregisterday(String cmtregisterday) {
		this.cmtregisterday = cmtregisterday;
	}

	public String getCmtcontent() {
		return cmtcontent;
	}

	public void setCmtcontent(String cmtcontent) {
		this.cmtcontent = cmtcontent;
	}

	public QnaVO getQvo() {
		return qvo;
	}

	public void setQvo(QnaVO qvo) {
		this.qvo = qvo;
	}
	
	
}
