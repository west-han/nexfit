package com.nexfit.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.nexfit.domain.BoardDTO;
import com.nexfit.util.DBConn;
import com.nexfit.util.DBUtil;

public class mypageDAO {
	private Connection conn = DBConn.getConnection();
	
	//작성글 갯수
	public int writeCount() {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "select nvl(count(*), 0) from ";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
			}
		} catch (Exception e) {
			
		}finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}
		return result;
	}
	
	public int dataCount(String userId) {
		String[] boardNames = {"freeboard", "withboard", "routineboard","qnaboard"};
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int total = 0;
		for (String name : boardNames) {
			int count = 0;
			String sql = generateQuery(name);
			
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userId);
				
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
					count = rs.getInt(1);
					total += count;
				}
				
			} catch (Exception e) {
				e.printStackTrace();
				
			} finally {
				DBUtil.close(rs);
				DBUtil.close(pstmt);
			}
			
		}
		return total;
	}
	
	private String generateQuery(String boardName) {
		return String.format("SELECT COUNT(*) FROM %s WHERE userId=?", boardName);
	}
}
