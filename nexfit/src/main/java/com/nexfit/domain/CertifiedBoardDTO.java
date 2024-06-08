package com.nexfit.domain;


public class CertifiedBoardDTO {
	private long certifiedNum;
	private String subject;
	private String reg_date;
	private String content;
	private int acceptance;
	private long boardNumber;
	private long applNumber;
	private String imageFilename;
	private String userId;
	private String nickname;
	private String board_subject;
	private String ch_subject;
	private String ch_content;
	private String board_content;
	
	
	public String getCh_content() {
		return ch_content;
	}
	public void setCh_content(String ch_content) {
		this.ch_content = ch_content;
	}
	public String getBoard_content() {
		return board_content;
	}
	public void setBoard_content(String board_content) {
		this.board_content = board_content;
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
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getImageFilename() {
		return imageFilename;
	}
	public void setImageFilename(String imageFilename) {
		this.imageFilename = imageFilename;
	}
	public long getApplNumber() {
		return applNumber;
	}
	public void setApplNumber(long applNumber) {
		this.applNumber = applNumber;
	}
	

	public long getCertifiedNum() {
		return certifiedNum;
	}
	public void setCertifiedNum(long certifiedNum) {
		this.certifiedNum = certifiedNum;
	}
	
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getAcceptance() {
		return acceptance;
	}
	public void setAcceptance(int acceptance) {
		this.acceptance = acceptance;
	}
	public long getBoardNumber() {
		return boardNumber;
	}
	public void setBoardNumber(long boardNumber) {
		this.boardNumber = boardNumber;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	
	
}
