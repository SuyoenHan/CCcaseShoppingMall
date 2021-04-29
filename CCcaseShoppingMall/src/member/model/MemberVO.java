package member.model;

public class MemberVO {

	private String userid;             // 회원아이디
	private String pwd;                //암호 (SHA-256 암호화 대상)
	private String name;               // 회원명
	private String email;              // 이메일 (AES-256 암호화/복호화 대상)
	private String mobile;             // 휴대폰번호 (AES-256 암호화/복호화 대상) 
	private String postcode;           //우편번호
	private String address;            // 주소
	private String detailaddress;      // 상세주소
	private String extraaddress;       //참고항목
	private int totalpoint;            //사용가능한 총포인트 
	private String registerday;        //가입일자 
	private String lastpwdchangedate;  // 마지막으로 암호를 변경한 날짜  
	private int status;                // 회원탈퇴유무   1: 사용가능(가입중) / 0:사용불능(탈퇴) 
	private int	idle;                  //  휴면유무      0: 활동중  /  1 : 휴면중 
	private int fk_grade;              // 회원등급      0: 브라운회원등급  1: 실버회원등급  2: 골드회원등급
	
	private boolean requirePwdChange = false;
	
	public MemberVO() {}
	
	public MemberVO(String userid, String pwd, String name, String email, String mobile, String postcode,
			String address, String detailaddress, String extraaddress) {
		
		this.userid = userid;
		this.pwd = pwd;
		this.name = name;
		this.email = email;
		this.mobile = mobile;
		this.postcode = postcode;
		this.address = address;
		this.detailaddress = detailaddress;
		this.extraaddress = extraaddress;
	}
	public String getUserid() {
		return userid;
	}
	
	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	public String getPwd() {
		return pwd;
	}
	
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getMobile() {
		return mobile;
	}
	
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	
	public String getPostcode() {
		return postcode;
	}
	
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	
	public String getAddress() {
		return address;
	}
	
	public void setAddress(String address) {
		this.address = address;
	}
	
	public String getDetailaddress() {
		return detailaddress;
	}
	
	public void setDetailaddress(String detailaddress) {
		this.detailaddress = detailaddress;
	}
	
	public String getExtraaddress() {
		return extraaddress;
	}
	
	public void setExtraaddress(String extraaddress) {
		this.extraaddress = extraaddress;
	}
	
	public int getTotalpoint() {
		return totalpoint;
	}
	
	public void setTotalpoint(int totalpoint) {
		this.totalpoint = totalpoint;
	}
	
	public String getRegisterday() {
		return registerday;
	}
	
	public void setRegisterday(String registerday) {
		this.registerday = registerday;
	}
	
	public String getLastpwdchangedate() {
		return lastpwdchangedate;
	}
	
	public void setLastpwdchangedate(String lastpwdchangedate) {
		this.lastpwdchangedate = lastpwdchangedate;
	}
	
	public int getStatus() {
		return status;
	}
	
	public void setStatus(int status) {
		this.status = status;
	}
	
	public int getIdle() {
		return idle;
	}
	
	public void setIdle(int idle) {
		this.idle = idle;
	}
	
	public int getFk_grade() {
		return fk_grade;
	}
	
	public void setFk_grade(int fk_grade) {
		this.fk_grade = fk_grade;
	}

	public boolean isRequirePwdChange() {
		return requirePwdChange;
	}
	
	public void setRequirePwdChange(boolean requirePwdChange) {
		this.requirePwdChange = requirePwdChange;
	}
	


	
	
	
	
	
	
	
}