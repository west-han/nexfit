package com.nexfit.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import com.nexfit.domain.ChallengeDTO;
import com.nexfit.util.DBConn;
import com.nexfit.util.DBUtil;

public class ChallengeDAO {
	private Connection conn = DBConn.getConnection();
	
	public void insertChallenge(ChallengeDTO dto) throws SQLException{
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "INSERT INTO challenge(challengeId,ch_subject,ch_content,fee)"
					+" VALUES(challenge_seq.NEXTVAL, ? , ? , ?)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getCh_subject());
			pstmt.setString(2, dto.getCh_content());
			pstmt.setLong(3, dto.getFee());
			
			pstmt.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			DBUtil.close(pstmt);
		}
	}
	
	public List<ChallengeDTO> listChallenge(){
		List<ChallengeDTO> list = new ArrayList<ChallengeDTO>();
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT challengeId,ch_subject,ch_content,fee"
					+" FROM challenge"
					+" ORDER BY challengeId DESC";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ChallengeDTO dto = new ChallengeDTO();
				
				dto.setChallengeId(rs.getLong("challengeId"));
				dto.setCh_subject(rs.getString("ch_subject"));
				dto.setCh_content(rs.getString("ch_content"));
				dto.setFee(rs.getLong("fee"));
				
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}
		
		return list;
	}
	
	
	// 데이터 개수
	public int dataCount() {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT NVL(COUNT(*), 0) FROM challenge";
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
					+ " FROM challenge";
			if (schType.equals("all")) {
				sql += "  WHERE INSTR(ch_subject, ?) >= 1 OR INSTR(ch_content, ?) >= 1 ";
			} else {
				sql += "  WHERE INSTR(" + schType + ", ?) >= 1 ";
			}

			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, kwd);
			if (schType.equals("all")) {
				pstmt.setString(2, kwd);
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
	public List<ChallengeDTO> listChallenge(int offset, int size) {
		List<ChallengeDTO> list = new ArrayList<ChallengeDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();

		try {
			sb.append(" SELECT challengeId, ch_subject,fee");
			sb.append(" FROM challenge ");
			sb.append(" ORDER BY challengeId DESC ");
			sb.append(" OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ");

			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.setInt(1, offset);
			pstmt.setInt(2, size);

			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				ChallengeDTO dto = new ChallengeDTO();

				dto.setChallengeId(rs.getLong("challengeId"));
				dto.setCh_subject(rs.getString("ch_subject"));
				dto.setFee(rs.getLong("fee"));
				
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

	//검색된 게시물 리스트
	public List<ChallengeDTO> listBoard(int offset, int size, String schType, String kwd) {
		List<ChallengeDTO> list = new ArrayList<ChallengeDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();

		try {
			sb.append(" SELECT challengeId, ch_subject,fee");
			sb.append(" FROM challenge");
			sb.append(" ORDER BY challengeId DESC ");
			
			if (schType.equals("all")) {
				sb.append(" WHERE INSTR(ch_subject, ?) >= 1 OR INSTR(ch_content, ?) >= 1 ");
			} else {
				sb.append(" WHERE INSTR(" + schType + ", ?) >= 1 ");
			}
			sb.append(" ORDER BY challengeId DESC ");
			sb.append(" OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ");

			pstmt = conn.prepareStatement(sb.toString());
			
			if (schType.equals("all")) {
				pstmt.setString(1, kwd);
				pstmt.setString(2, kwd);
				pstmt.setInt(3, offset);
				pstmt.setInt(4, size);
			} else {
				pstmt.setString(1, kwd);
				pstmt.setInt(2, offset);
				pstmt.setInt(3, size);
			}

			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				ChallengeDTO dto = new ChallengeDTO();

				dto.setChallengeId(rs.getLong("challengeId"));
				dto.setCh_subject(rs.getString("ch_subject"));
				dto.setFee(rs.getLong("fee"));
				
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


	// 해당 게시물 보기
	public ChallengeDTO findById(long challengeId) {
		ChallengeDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT challengeId,ch_subject,ch_content,fee "
					+ " FROM challenge "
					+ " WHERE challengeId = ? ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, challengeId);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new ChallengeDTO();
				
				dto.setChallengeId(rs.getLong("challengeId"));
				dto.setCh_subject(rs.getString("ch_subject"));
				dto.setCh_content(rs.getString("ch_content"));
				dto.setFee(rs.getLong("fee"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}

		return dto;
	}
	
	// 게시물 수정
		public void updateChallenge(ChallengeDTO dto) throws SQLException {
			PreparedStatement pstmt = null;
			String sql;

			try {
				sql = "UPDATE challenge SET ch_subject=?, ch_content=?, fee=? WHERE challengeId=?";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, dto.getCh_subject());
				pstmt.setString(2, dto.getCh_content());
				pstmt.setLong(3, dto.getFee());
				pstmt.setLong(4, dto.getChallengeId());
				
				pstmt.executeUpdate();

			} catch (SQLException e) {
				e.printStackTrace();
				throw e;
			} finally {
				DBUtil.close(pstmt);
			}

		}

		// 게시물 삭제
		public void deleteChallenge(long challengeId, String userId) throws SQLException {
			PreparedStatement pstmt = null;
			String sql;

			try {
				if (userId.equals("admin")) {
					sql = "DELETE FROM challenge WHERE challengeId=?";
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setLong(1, challengeId);
					
					pstmt.executeUpdate();
				} else { return;
				}
			} catch (SQLException e) {
				e.printStackTrace();
				throw e;
			} finally {
				DBUtil.close(pstmt);
			}
		}
		
		//게시글 선택 삭제
		public void deleteChallenge(long[] nums) throws SQLException {
			PreparedStatement pstmt = null;
			String sql;
			
			try {
				sql = "DELETE FROM challenge WHERE challengeId = ?";
				pstmt = conn.prepareStatement(sql);
				
				for(long challengeId : nums) {
					pstmt.setLong(1, challengeId);
					pstmt.executeUpdate();
				}
			} catch (SQLException e) {
				e.printStackTrace();
				throw e;
			} finally {
				DBUtil.close(pstmt);
			}
		}
		
}
