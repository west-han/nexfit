package com.nexfit.domain;

public enum Point {
	WRITE_POST(50, "게시글 작성"), 
	WRITE_COMMENT(10, "댓글 작성"), 
	DELETE_POST(-50, "게시글 삭제"), 
	DELETE_COMMENT(-10, "댓글 삭제"),
	LIKED(5, "작성 게시글이 좋아요를 받음"),
	LIKE_CANCELED(5, "작성 게시글에 대한 좋아요가 취소됨");

	private final long value;
	private final String description;
	
	Point(long value, String type) {
		this.value = value;
		this.description = type;
	}
	
	public long getValue() {
		return value;
	}
	public String getDescription() {
		return description;
	}
}