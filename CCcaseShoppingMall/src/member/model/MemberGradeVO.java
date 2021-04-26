package member.model;

public class MemberGradeVO {
	private int grade;     // 회원등급      0: 브라운회원등급  1: 실버회원등급  2: 골드회원등급
	private int ppercent;
	
	
	public int getGrade() {
		return grade;
	}
	
	public void setGrade(int grade) {
		this.grade = grade;
	}
	
	public int getPpercent() {
		return ppercent;
	}
	
	public void setPpercent(int ppercent) {
		this.ppercent = ppercent;
	} 
	
	
	
}
