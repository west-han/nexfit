package com.nexfit.domain;

import java.util.List;

public class CertifiedBoardDTO {
	private long certifiedNum;
	private String subject;
	private String reg_date;
	private String content;
	private int acceptance;
	private long boardNumber;
	private long applNumber;
	private String imageFilename;
	
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
