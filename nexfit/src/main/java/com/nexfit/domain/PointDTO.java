	package com.nexfit.domain;

	public class PointDTO {
		private long pointNum;
		private String reg_date;
		private String description;
		private long porintVar;
		private long currentPoint;
		
		public long getPointNum() {
			return pointNum;
		}
		public void setPointNum(long pointNum) {
			this.pointNum = pointNum;
		}
		public String getReg_date() {
			return reg_date;
		}
		public void setReg_date(String reg_date) {
			this.reg_date = reg_date;
		}
		public String getDescription() {
			return description;
		}
		public void setDescription(String description) {
			this.description = description;
		}
		public long getPorintVar() {
			return porintVar;
		}
		public void setPorintVar(long porintVar) {
			this.porintVar = porintVar;
		}
		public long getCurrentPoint() {
			return currentPoint;
		}
		public void setCurrentPoint(long currentPoint) {
			this.currentPoint = currentPoint;
		}
		
	}

