package com.nexfit.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.nexfit.domain.MemberDTO;
import com.nexfit.util.DBConn;
import com.nexfit.util.DBUtil;

public class mypageDAO {
	private Connection conn = DBConn.getConnection();
	
	//작성글 갯수

	
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
				DBUtil.close(rs);
				DBUtil.close(pstmt);
				
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
	
	//작성 댓글 갯수

	
		public int replyCount(String userId) {
			String[] boardNames = {"freeboard_reply", "withboard_reply", "routineboard_reply", "qnaboard_reply"};
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			
			int total = 0;
			for (String name : boardNames) {
				int rpl_count = 0;
				String sql = generateQuery(name);
				
				try {
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, userId);
					
					rs = pstmt.executeQuery();
					
					if (rs.next()) {
						rpl_count = rs.getInt(1);
						total += rpl_count;
					}
					DBUtil.close(rs);
					DBUtil.close(pstmt);
				} catch (Exception e) {
					e.printStackTrace();
					
				} finally {
					DBUtil.close(rs);
					DBUtil.close(pstmt);
				}
				
			}
			return total;
		}
		
		
		//회원정보 수정
		public void updateMember(MemberDTO dto) throws SQLException{
			PreparedStatement pstmt = null;
			String sql;
			
			try {
				sql = "update member set password=?, username=?, modify_date=SYSDATE  WHERE userId=?";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, dto.getUserPwd());
				pstmt.setString(2, dto.getUserName());
				pstmt.setString(3, dto.getUserId());
				
				pstmt.executeUpdate();
				
				pstmt.close();
				pstmt = null;
				
				sql = "update member_detail set birth=?, email=?, tel=?,zip=?,addr1=?,addr2=?,nickname=?";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, dto.getBirth());
				pstmt.setString(2, dto.getEmail());
				pstmt.setString(3, dto.getTel());
				pstmt.setString(4, dto.getZip());
				pstmt.setString(5, dto.getAddr1());
				pstmt.setString(6, dto.getAddr2());
				pstmt.setString(7, dto.getNickname());
				
				pstmt.executeUpdate();
				
				pstmt.close();
				pstmt = null;
				
				sql = "insert into member_detail(nickname) values (?)";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, dto.getNickname());
				
				pstmt.executeUpdate();
				conn.commit();
				
				
			} catch (SQLException e) {
				e.printStackTrace();
			}finally {
				DBUtil.close(pstmt);
			}
		}
	
}
