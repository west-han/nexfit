package com.nexfit.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.nexfit.domain.ChallengeBoardDTO;
import com.nexfit.util.DBConn;
import com.nexfit.util.DBUtil;

public class ChallengeBoardDAO {
	private Connection conn = DBConn.getConnection();
	
	public void insertchBoard(ChallengeBoardDTO dto) throws SQLException{
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "INSERT INTO challengeboard(boardnumber, subject, reg_date, start_date, end_date, content,challengeId,imageFilename)"
					+" VALUES (challengeboard_seq.NEXTVAL, ?, SYSDATE, ?, ?, ? , ?, ?)";
			
			pstmt =conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getStart_date());
			pstmt.setString(3, dto.getEnd_date());
			pstmt.setString(4, dto.getContent());
			pstmt.setLong(5, dto.getChallengeId());
			pstmt.setString(6, dto.getImageFilename());
			
			pstmt.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			DBUtil.close(pstmt);
		}
	} 
	
	//데이터 개수
	public int dataCount() {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT NVL(COUNT(*), 0) FROM challengeboard";
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				result = rs.getInt(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}

		return result;
	}
	
	//검색에서 데이터 개수
	
	public int dataCount(String schType, String kwd) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT NVL(COUNT(*), 0) "
					+ " FROM challengeboard b"
					+ " JOIN challenge c ON b.challengeId=c.challengeId";
			if (schType.equals("all")) {
				sql += "  WHERE INSTR(ch_subject, ?) >= 1 OR INSTR(ch_content, ?) >= 1 OR INSTR(subject, ?) >= 1 OR INSTR(content, ?) >= 1";
			} else {
				sql += "  WHERE INSTR(" + schType + ", ?) >= 1 ";
			}

			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, kwd);
			if (schType.equals("all")) {
				pstmt.setString(2, kwd);
				pstmt.setString(3, kwd);
				pstmt.setString(4, kwd);
			}

			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				result = rs.getInt(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}

		return result;
	}
	
	
	// 게시물 리스트
	
	
	public List<ChallengeBoardDTO> listChallengeboard(int offset, int size) {
		List<ChallengeBoardDTO> list = new ArrayList<ChallengeBoardDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT boardnumber, subject, ch_subject, TO_CHAR(reg_date, 'YYYY-MM-DD') reg_date, "
				    + "TO_CHAR(mod_date, 'YYYY-MM-DD') mod_date, "
				    + "TO_CHAR(start_date, 'YYYY-MM-DD') start_date, "
				    + "TO_CHAR(end_date, 'YYYY-MM-DD') end_date, "
				    + "content, b.challengeId, imageFilename,ch_content "
				    + "FROM challengeboard b "
				    + "JOIN challenge c ON b.challengeId = c.challengeId "
				    + "ORDER BY boardnumber DESC "
				    + "OFFSET ? ROWS FETCH FIRST ? ROWS ONLY";

			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, offset);
			pstmt.setInt(2, size);

			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				ChallengeBoardDTO dto = new ChallengeBoardDTO();

				dto.setBoardNumber(rs.getLong("boardnumber"));
				dto.setSubject(rs.getString("subject"));
				dto.setCh_subject(rs.getString("ch_subject"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setMod_date(rs.getString("mod_date"));
				dto.setStart_date(rs.getString("start_date"));
				dto.setEnd_date(rs.getString("end_date"));
				dto.setContent(rs.getString("content"));
				dto.setChallengeId(rs.getLong("challengeId"));
				dto.setImageFilename(rs.getString("imageFilename"));
				dto.setCh_content(rs.getString("ch_content"));
				
				list.add(dto);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}

		return list;
	}
	
	public List<ChallengeBoardDTO> listChallengeboard(int offset, int size, String schType, String kwd) {
		List<ChallengeBoardDTO> list = new ArrayList<ChallengeBoardDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
			
			StringBuilder sb = new StringBuilder();

			try {
				sb.append("SELECT boardnumber, subject, ch_subject, TO_CHAR(reg_date, 'YYYY-MM-DD') reg_date, ");
				sb.append("TO_CHAR(mod_date, 'YYYY-MM-DD') mod_date, ");
				sb.append("TO_CHAR(start_date, 'YYYY-MM-DD') start_date, ");
				sb.append("TO_CHAR(end_date, 'YYYY-MM-DD') end_date, ");
				sb.append("content, b.challengeId, imageFilename,ch_content ");
				sb.append("FROM challengeboard b ");
				sb.append("JOIN challenge c ON b.challengeId = c.challengeId ");
				if (schType.equals("all")) {
					sb.append(" WHERE INSTR(ch_subject, ?) >= 1 OR INSTR(ch_content, ?) >= 1 OR INSTR(subject, ?) >= 1 OR INSTR(content, ?) >= 1");
				} else if (schType.equals("reg_date")) {
					kwd = kwd.replaceAll("(\\-|\\/|\\.)", "");
					sb.append(" WHERE TO_CHAR(reg_date, 'YYYYMMDD') = ?");
				} else {
					sb.append(" WHERE INSTR(" + schType + ", ?) >= 1 ");
				}
				sb.append("ORDER BY boardnumber DESC ");
				sb.append("OFFSET ? ROWS FETCH FIRST ? ROWS ONLY");	

				pstmt = conn.prepareStatement(sb.toString());
				
				if (schType.equals("all")) {
					pstmt.setString(1, kwd);
					pstmt.setString(2, kwd);
					pstmt.setString(3, kwd);
					pstmt.setString(4, kwd);
					pstmt.setInt(5, offset);
					pstmt.setInt(6, size);
				} else {
					pstmt.setString(1, kwd);
					pstmt.setInt(2, offset);
					pstmt.setInt(3, size);
				}

				rs = pstmt.executeQuery();
			
			while (rs.next()) {
				ChallengeBoardDTO dto = new ChallengeBoardDTO();

				dto.setBoardNumber(rs.getLong("boardnumber"));
				dto.setSubject(rs.getString("subject"));
				dto.setCh_subject(rs.getString("ch_subject"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setMod_date(rs.getString("mod_date"));
				dto.setStart_date(rs.getString("start_date"));
				dto.setEnd_date(rs.getString("end_date"));
				dto.setContent(rs.getString("content"));
				dto.setChallengeId(rs.getLong("challengeId"));
				dto.setImageFilename(rs.getString("imageFilename"));
				dto.setCh_content(rs.getString("ch_content"));
				
				list.add(dto);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}

		return list;
	}
	
	public ChallengeBoardDTO findById(long num) {
		ChallengeBoardDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql =" SELECT boardnumber, subject,ch_subject, TO_CHAR(reg_date, 'YYYY-MM-DD') reg_date, "
					+" TO_CHAR(mod_date, 'YYYY-MM-DD') mod_date, "
					+" TO_CHAR(start_date, 'YYYY-MM-DD') start_date, "
					+" TO_CHAR(end_date, 'YYYY-MM-DD') end_date, "
					+" content, b.challengeId, imageFilename,fee, ch_content "
					+" FROM challengeboard b"
					+" JOIN challenge c ON b.challengeId = c.challengeId "
					+" WHERE boardnumber  = ? ";

			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new ChallengeBoardDTO();
				
				dto.setBoardNumber(rs.getLong("boardnumber"));
				dto.setSubject(rs.getString("subject"));
				dto.setCh_subject(rs.getString("ch_subject"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setMod_date(rs.getString("mod_date"));
				dto.setStart_date(rs.getString("start_date"));
				dto.setEnd_date(rs.getString("end_date"));
				dto.setContent(rs.getString("content"));
				dto.setCh_content(rs.getString("ch_content"));
				dto.setChallengeId(rs.getLong("challengeId"));
				dto.setImageFilename(rs.getString("imageFilename"));
				dto.setFee(rs.getLong("fee"));
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}
		
		return dto;
	}
	
	
	public void updateChboard(ChallengeBoardDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "UPDATE challengeboard SET subject=?, mod_date=?, start_date=?, end_date=?, content=?,challengeId=?, imageFilename=? "
					+ " WHERE boardnumber = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getMod_date());
			pstmt.setString(3, dto.getStart_date());
			pstmt.setString(4, dto.getEnd_date());
			pstmt.setString(5, dto.getContent());
			pstmt.setLong(6, dto.getChallengeId());
			pstmt.setString(7, dto.getImageFilename());
			pstmt.setLong(8, dto.getBoardNumber());
			
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(pstmt);
		}
	}
	
	public void deleteChboard(long boardnum) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "DELETE FROM challengeboard WHERE boardnumber = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, boardnum);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(pstmt);
		}
	}
}
