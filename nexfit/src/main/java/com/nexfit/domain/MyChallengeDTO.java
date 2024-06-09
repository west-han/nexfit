package com.nexfit.domain;

public class MyChallengeDTO {
	private String board_subject;
	private int appl_score;
	private String appl_state;
	private String compl_date;
	private String appl_date;
	private String start_date;
	private String end_date;
	private String ch_subject;
	private long applNumber;
	private int fee;
	private int requiredAc;
	
	
	public int getFee() {
		return fee;
	}
	public void setFee(int fee) {
		this.fee = fee;
	}
	public long getApplNumber() {
		return applNumber;
	}
	public void setApplNumber(long applNumber) {
		this.applNumber = applNumber;
	}
	

	public int getRequiredAc() {
		return requiredAc;
	}
	public void setRequiredAc(int requiredAc) {
		this.requiredAc = requiredAc;
	}
	
	public String getCh_subject() {
		return ch_subject;
	}
	public void setCh_subject(String ch_subject) {
		this.ch_subject = ch_subject;
	}
	public String getBoard_subject() {
		return board_subject;
	}
	public void setBoard_subject(String board_subject) {
		this.board_subject = board_subject;
	}

	public int getAppl_score() {
		return appl_score;
	}
	public void setAppl_score(int appl_score) {
		this.appl_score = appl_score;
	}
	public String getAppl_state() {
		return appl_state;
	}
	public void setAppl_state(String appl_state) {
		this.appl_state = appl_state;
	}
	public String getCompl_date() {
		return compl_date;
	}
	public void setCompl_date(String compl_date) {
		this.compl_date = compl_date;
	}
	public String getAppl_date() {
		return appl_date;
	}
	public void setAppl_date(String appl_date) {
		this.appl_date = appl_date;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	
	
}
