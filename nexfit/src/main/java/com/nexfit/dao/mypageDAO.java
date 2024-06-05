package com.nexfit.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.nexfit.domain.BoardDTO;
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
				
				sql = "update member_detail set birth=?, email=?, tel=?,zip=?,addr1=?,addr2=?,nickname=?, bio=? where userId=?";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, dto.getBirth());
				pstmt.setString(2, dto.getEmail());
				pstmt.setString(3, dto.getTel());
				pstmt.setString(4, dto.getZip());
				pstmt.setString(5, dto.getAddr1());
				pstmt.setString(6, dto.getAddr2());
				pstmt.setString(7, dto.getNickname());
				pstmt.setString(8, dto.getBio());
				pstmt.setString(9, dto.getUserId());
				
				pstmt.executeUpdate();
				
				pstmt.close();
				pstmt = null;
				
				
				
				
			} catch (SQLException e) {
				e.printStackTrace();
			}finally {
				DBUtil.close(pstmt);
			}
		}
		
		
		//커뮤니티 게시글 리스트 가져오기
		public List<BoardDTO> writeList(int offset, int size,MemberDTO dto){
			List<BoardDTO> list = new  ArrayList<BoardDTO>();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			StringBuilder sb = new StringBuilder();
			
			try {
				sb.append(" select board_name,subject, reg_date, num, hitcount");
				sb.append( " from freeboard ");
				sb.append( " where userid=?");
				sb.append(" union");
				sb.append(" select board_name,subject, reg_date, num, hitcount ");
				sb.append( " from withboard ");
				sb.append( " where userid=?");
				sb.append(" union");
				sb.append(" select board_name,subject, reg_date, num, hitcount ");
				sb.append( " from routineboard ");
				sb.append( " where userid=?");
				sb.append(" union");
				sb.append(" select board_name,subject, reg_date,num, hitcount ");
				sb.append( " from qnaboard ");
				sb.append( " where userid=?");
				sb.append( " order by reg_date desc");
				sb.append( " offset ? rows fetch first ? rows only");
				
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setString(1,dto.getUserId() );
				pstmt.setString(2, dto.getUserId());
				pstmt.setString(3, dto.getUserId());
				pstmt.setString(4, dto.getUserId());
				pstmt.setInt(5, offset);
				pstmt.setInt(6, size);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					BoardDTO dto1 = new BoardDTO();
					dto1.setNum(rs.getInt("num"));
					dto1.setSubject(rs.getString("subject"));
					dto1.setReg_date(rs.getString("reg_date"));
					dto1.setHitCount(rs.getInt("hitCount"));
					dto1.setBoard_name(rs.getString("board_name"));
					list.add(dto1);
				}
				
				
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				DBUtil.close(rs);
				DBUtil.close(pstmt);
			}
			return list;
		}

		
		
		
		
		
		
	
}
