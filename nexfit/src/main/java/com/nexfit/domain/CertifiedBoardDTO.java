package com.nexfit.domain;

import java.util.List;

public class CertifiedBoardDTO {
	private long certifiedNum;
	private String certiSubject;
	private String reg_date;
	private String content;
	private int acceptance;
	private long boardNumber;
	
	private long certimgId;
	private String filename;
	private List<String> imageFiles;
	
	
	public long getCertimgId() {
		return certimgId;
	}
	public void setCertimgId(long certimgId) {
		this.certimgId = certimgId;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public List<String> getImageFiles() {
		return imageFiles;
	}
	public void setImageFiles(List<String> imageFiles) {
		this.imageFiles = imageFiles;
	}
	public long getCertifiedNum() {
		return certifiedNum;
	}
	public void setCertifiedNum(long certifiedNum) {
		this.certifiedNum = certifiedNum;
	}
	public String getCertiSubject() {
		return certiSubject;
	}
	public void setCertiSubject(String certiSubject) {
		this.certiSubject = certiSubject;
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
	
	
}
