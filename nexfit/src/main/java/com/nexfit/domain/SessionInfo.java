package com.nexfit.domain;

public class SessionInfo {
	private String userId;
	private String userName;
	private String nickname;
	private String reg_date;
	private int userRoll;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public int getUserRoll() {
		return userRoll;
	}
	public void setUserRoll(int userRoll) {
		this.userRoll = userRoll;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	
	
}
