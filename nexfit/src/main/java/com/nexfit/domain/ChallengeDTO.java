package com.nexfit.domain;

public class ChallengeDTO {
	private long challengeId;
	private String ch_subject;
	private String ch_content;
	private long fee;
	
	
	public long getChallengeId() {
		return challengeId;
	}
	public void setChallengeId(long challengeId) {
		this.challengeId = challengeId;
	}
	public String getCh_subject() {
		return ch_subject;
	}
	public void setCh_subject(String ch_subject) {
		this.ch_subject = ch_subject;
	}
	public String getCh_content() {
		return ch_content;
	}
	public void setCh_content(String ch_content) {
		this.ch_content = ch_content;
	}
	public long getFee() {
		return fee;
	}
	public void setFee(long fee) {
		this.fee = fee;
	}
	
	
}
