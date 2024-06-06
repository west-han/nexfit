package com.nexfit.domain;


public class Ch_applFormDTO {
	private long applNumber;
	private String appl_date;
	private String appl_State;
	private int appl_Score;
	private String compl_Date;
	private String coment;
	private long boardNumber;
	private String userId;
	private String ch_subject;
	private String fee;
	private String subject;
	private String nickname;
	
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getCh_subject() {
		return ch_subject;
	}
	public void setCh_subject(String ch_subject) {
		this.ch_subject = ch_subject;
	}
	public String getFee() {
		return fee;
	}
	public void setFee(String fee) {
		this.fee = fee;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public long getApplNumber() {
		return applNumber;
	}
	public void setApplNumber(long applNumber) {
		this.applNumber = applNumber;
	}
	public String getAppl_date() {
		return appl_date;
	}
	public void setAppl_date(String appl_date) {
		this.appl_date = appl_date;
	}
	public String getAppl_State() {
		return appl_State;
	}
	public void setAppl_State(String appl_State) {
		this.appl_State = appl_State;
	}
	public int getAppl_Score() {
		return appl_Score;
	}
	public void setAppl_Score(int appl_Score) {
		this.appl_Score = appl_Score;
	}
	public String getCompl_Date() {
		return compl_Date;
	}
	public void setCompl_Date(String compl_Date) {
		this.compl_Date = compl_Date;
	}
	
	public String getComent() {
		return coment;
	}
	public void setComent(String coment) {
		this.coment = coment;
	}
	public long getBoardNumber() {
		return boardNumber;
	}
	public void setBoardNumber(long boardNumber) {
		this.boardNumber = boardNumber;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	
	
}
