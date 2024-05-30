package com.nexfit.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import com.nexfit.domain.ChellengeDTO;
import com.nexfit.util.DBConn;
import com.nexfit.util.DBUtil;

public class ChellengeDAO {
	private Connection conn = DBConn.getConnection();
	
	public void insertChellenge(ChellengeDTO dto) throws SQLException{
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "INSERT INTO chellenge(chellengeId,ch_subject,ch_content,fee)"
					+" VALUES(chellenge_seq.NEXTVAL, ? , ? , ?)";
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
	
	public List<ChellengeDTO> listChellenge(){
		List<ChellengeDTO> list = new ArrayList<ChellengeDTO>();
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT chellengeId,ch_subject,ch_content,fee"
					+" FROM chellenge"
					+" ORDER BY chellengeId DESC";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ChellengeDTO dto = new ChellengeDTO();
				
				dto.setChellengeId(rs.getLong("chellengeId"));
				dto.setCh_subject(rs.getString("ch_subject"));
				dto.setCh_content(rs.getString("ch_content"));
				dto.setFee(rs.getLong("fee"));
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
			sql = "SELECT NVL(COUNT(*), 0) FROM chellenge";
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
					+ " FROM chellenge";
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
	public List<ChellengeDTO> listChellenge(int offset, int size) {
		List<ChellengeDTO> list = new ArrayList<ChellengeDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();

		try {
			sb.append(" SELECT chellengeId, ch_subject,fee");
			sb.append(" FROM chellenge ");
			sb.append(" ORDER BY chellengeId DESC ");
			sb.append(" OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ");

			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.setInt(1, offset);
			pstmt.setInt(2, size);

			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				ChellengeDTO dto = new ChellengeDTO();

				dto.setChellengeId(rs.getLong("chellengeId"));
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
	public List<ChellengeDTO> listBoard(int offset, int size, String schType, String kwd) {
		List<ChellengeDTO> list = new ArrayList<ChellengeDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();

		try {
			sb.append(" SELECT chellengeId, ch_subject,fee");
			sb.append(" FROM chellenge");
			sb.append(" ORDER BY chellengeId DESC ");
			
			if (schType.equals("all")) {
				sb.append(" WHERE INSTR(ch_subject, ?) >= 1 OR INSTR(ch_content, ?) >= 1 ");
			} else {
				sb.append(" WHERE INSTR(" + schType + ", ?) >= 1 ");
			}
			sb.append(" ORDER BY chellengeId DESC ");
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
				ChellengeDTO dto = new ChellengeDTO();

				dto.setChellengeId(rs.getLong("chellengeId"));
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
	/* public BoardDTO findById(long num) {
		BoardDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT b.num, b.userId, userName, subject, content, reg_date, hitCount, "
					+ "    NVL(boardLikeCount, 0) boardLikeCount "
					+ " FROM bbs b "
					+ " JOIN member1 m ON b.userId = m.userId "
					+ " LEFT OUTER JOIN ("
					+ "      SELECT num, COUNT(*) boardLikeCount FROM bbsLike"
					+ "      GROUP BY num"
					+ " ) bc ON b.num = bc.num"
					+ " WHERE b.num = ? ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new BoardDTO();
				
				dto.setNum(rs.getLong("num"));
				dto.setUserId(rs.getString("userId"));
				dto.setUserName(rs.getString("userName"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setReg_date(rs.getString("reg_date"));
				
				dto.setBoardLikeCount(rs.getInt("boardLikeCount"));				
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
		public void updateBoard(BoardDTO dto) throws SQLException {
			PreparedStatement pstmt = null;
			String sql;

			try {
				sql = "UPDATE bbs SET subject=?, content=? WHERE num=? AND userId=?";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, dto.getSubject());
				pstmt.setString(2, dto.getContent());
				pstmt.setLong(3, dto.getNum());
				pstmt.setString(4, dto.getUserId());
				
				pstmt.executeUpdate();

			} catch (SQLException e) {
				e.printStackTrace();
				throw e;
			} finally {
				DBUtil.close(pstmt);
			}

		}

		// 게시물 삭제
		public void deleteBoard(long num, String userId) throws SQLException {
			PreparedStatement pstmt = null;
			String sql;

			try {
				if (userId.equals("admin")) {
					sql = "DELETE FROM bbs WHERE num=?";
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setLong(1, num);
					
					pstmt.executeUpdate();
				} else {
					sql = "DELETE FROM bbs WHERE num=? AND userId=?";
					
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setLong(1, num);
					pstmt.setString(2, userId);
					
					pstmt.executeUpdate();
				}
			} catch (SQLException e) {
				e.printStackTrace();
				throw e;
			} finally {
				DBUtil.close(pstmt);
			}
		}
		
		*/
		
}
