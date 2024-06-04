package com.nexfit.dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.nexfit.annotation.Controller;
import com.nexfit.domain.SportTypeDTO;
import com.nexfit.util.DBConn;
import com.nexfit.util.DBUtil;

@Controller
public class SportsTypeDAO {
	private Connection conn = DBConn.getConnection();
	
	public void insert(SportTypeDTO dto) throws SQLException, IOException {
		String sql;
		PreparedStatement pstmt = null;
		
		try {
			conn.setAutoCommit(false);
			// 운동 타입 데이터 삽입
			sql = "INSERT INTO sportsTypeBoard(num, name, bodyPart, description, userId, hitCount) "
					+ "VALUES(sportsTypeBoard_seq.NEXTVAL, ?, ?, ?, ?, 0)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getBodyPart());
			pstmt.setString(3, dto.getDescription());
			pstmt.setString(4, dto.getUserId());
			
			pstmt.executeUpdate();
			
			DBUtil.close(pstmt);
			
			// 파일 삽입
			sql = "INSERT INTO sportsType_file(id, filename, num) VALUES(sportsType_file_SEQ.NEXTVAL, ?, sportsTypeBoard_seq.CURRVAL)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getFilename());
			
			pstmt.executeUpdate();
			
			conn.commit();
			
		} catch (Exception e) {
			e.printStackTrace();
			conn.rollback();
			throw e;
		} finally {
			DBUtil.close(pstmt);
			conn.setAutoCommit(true);
		}
	}
	
	public List<SportTypeDTO> list(int offset, int size, String bodyPart, String keyword) throws SQLException {
		StringBuilder sb = new StringBuilder();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<SportTypeDTO> list = new ArrayList<SportTypeDTO>();
		
		try {
			sb.append(" SELECT b.num, name, bodyPart, description, hitCount, id, filename ");
			sb.append(" FROM sportsTypeBoard b ");
			sb.append(" LEFT OUTER JOIN sportsType_File f ON b.num = f.num ");
			
			sb.append(generateWhereClause(bodyPart, keyword));
			
			sb.append(" ORDER BY hitCount DESC, name ASC ");
			sb.append(" OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ");
			
			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.setInt(1, offset);
			pstmt.setInt(2, size);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				SportTypeDTO dto = new SportTypeDTO();
				
				dto.setNum(rs.getLong("num"));
				dto.setName(rs.getString("name"));
				dto.setBodyPart(rs.getString("bodyPart"));
				dto.setDescription(rs.getString("description"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setFilename(rs.getString("filename"));
				
				list.add(dto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		} finally {
			DBUtil.close(pstmt);
			DBUtil.close(rs);
		}
		
		return list;
	}
	
	// TODO: 이렇게 때려박으면 보안 상 취약 -> pstmt setter 메소드 호출하는 코드로 수정하기
	private String generateWhereClause(String bodyPart, String keyword) {
		StringBuilder sb = new StringBuilder();
		boolean b = false;
		
		if (b = !bodyPart.equals("all")) {
			sb.append("WHERE bodyPart = '" + bodyPart + "' ");
		}
		
		if (keyword.length() != 0) {
			sb.append(b ? " AND " : " WHERE " + "INSTR(name, '" + keyword + "') != 0 OR WHERE INSTR(description, '" + keyword + "') != 0 ");
		}

		return sb.toString();
	}
	
	public int dataCount(String bodyPart, String keyword) {
		int count = 0;
		String sql;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			sql = "SELECT NVL(COUNT(*), 0) FROM sportsTypeBoard " + generateWhereClause(bodyPart, keyword);
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				count = rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return count;
	}
	
	public Map<String, String> listBodyPart() {
		String sql;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Map<String, String> map = new HashMap<String, String>();
		
		try {
			sql = "SELECT bodyPart, bodyPartKor FROM bodyParts ORDER BY bodyPartKor";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				map.put(rs.getString(1), rs.getString(2));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}
		
		return map;
	}
	
	public SportTypeDTO findById(long num) {
		String sql;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		SportTypeDTO dto = new SportTypeDTO();
		
		try {
			sql = "SELECT s.num, name, b.bodyPart, bodyPartKor, description, hitCount, filename "
					+ "FROM sportsTypeBoard s "
					+ "JOIN bodyParts b ON s.bodyPart = b.bodyPart "
					+ "LEFT OUTER JOIN sportsType_File f ON s.num = f.num "
					+ "WHERE s.num = ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, num);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				dto.setNum(rs.getLong("num"));
				dto.setName(rs.getString("name"));
				dto.setBodyPart(rs.getString("bodyPart"));
				dto.setBodyPartKor(rs.getString("bodyPartKor"));
				dto.setDescription(rs.getString("description"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setFilename(rs.getString("filename"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}
		
		return dto;
	}
	
	public void delete(long num) throws SQLException {
		String sql;
		PreparedStatement pstmt = null;
		
		try {
			sql = "DELETE FROM sportsTypeBoard WHERE num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, num);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();

			throw e;
		} finally {
			DBUtil.close(pstmt);
		}
	}

	public void update(SportTypeDTO dto) throws SQLException {
		String sql;
		PreparedStatement pstmt = null;
		
		try {
			if (dto.getFilename() != null) {
				sql = "UPDATE sportsType_File SET filename = ? WHERE num = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, dto.getFilename());
				pstmt.setLong(2, dto.getNum());
			} else {
				sql = "INSERT INTO sportsType_File(num, id, filename) VALUES(?, sportsTypeBoard_seq.NEXTVAL, ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setLong(1, dto.getNum());
				pstmt.setString(2, dto.getFilename());
			}
			
			pstmt.executeUpdate();
			
			DBUtil.close(pstmt);
			
			sql = "UPDATE sportsTypeBoard SET name=?, description=?, bodyPart=? WHERE num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getDescription());
			pstmt.setString(3, dto.getBodyPart());
			pstmt.setLong(4, dto.getNum());
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();

			throw e;
		} finally {
			DBUtil.close(pstmt);
		}
	}
	
	public void deleteFile(long num) {
		String sql;
		PreparedStatement pstmt = null;
		
		try {
			sql = "DELETE FROM sportsType_File WHERE num = ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, num);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(pstmt);
		}
	}
}