package com.nexfit.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.nexfit.domain.QnaBoardDTO;
import com.nexfit.util.DBConn;
import com.nexfit.util.DBUtil;

public class QnaBoardDAO {
	private Connection conn = DBConn.getConnection();
	
	// 데이터 추가
		public void insertBoard(QnaBoardDTO dto) throws SQLException {
			PreparedStatement pstmt = null;
			String sql;

			try {
				sql = "INSERT INTO qnaBoard(num, userId, subject, content, hitCount, reg_date) "
						+ " VALUES (qnaBoard_seq.NEXTVAL, ?, ?, ?, 0, SYSDATE)";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, dto.getUserId());
				pstmt.setString(2, dto.getSubject());
				pstmt.setString(3, dto.getContent());

				pstmt.executeUpdate();

			} catch (SQLException e) {
				e.printStackTrace();
				throw e;
			} finally {
				DBUtil.close(pstmt);
			}
		}
		
		
		// 데이터 개수
		public int dataCount() {
			int result = 0;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql;

			try {
				sql = "SELECT NVL(COUNT(*), 0) FROM qnaBoard";
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
		
		
		// 검색에서의 데이터 개수
		public int dataCount(String schType, String kwd) {
			int result = 0;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql;

			try {
				sql = "SELECT NVL(COUNT(*), 0) "
						+ " FROM qnaBoard q "
						+ " JOIN member_detail m ON q.userId = m.userId ";
				if (schType.equals("all")) {
					sql += "  WHERE INSTR(subject, ?) >= 1 OR INSTR(content, ?)";
				} else if (schType.equals("reg_date")) {
					kwd = kwd.replaceAll("(\\-|\\/|\\.)", "");
					sql += "  WHERE TO_CHAR(reg_date, 'YYYYMMDD') = ? ";
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
		
		
		// 검색 없는 경우 게시물 리스트
		public List<QnaBoardDTO> listBoard(int offset, int size) {
		    List<QnaBoardDTO> list = new ArrayList<QnaBoardDTO>();
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;
		    StringBuilder sb = new StringBuilder();

		    try {
		        sb.append("SELECT q.num, nickname, subject, content, hitCount, TO_CHAR(reg_date, 'YYYY-MM-DD') reg_date, ");
		        sb.append("(SELECT COUNT(*) FROM qnaBoard_Reply r WHERE r.num = q.num) AS replyCount ");
		        sb.append("FROM qnaboard q ");
		        sb.append("JOIN member_detail m ON m.userId = q.userId ");
		        sb.append("ORDER BY q.num DESC ");
		        sb.append("OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ");

		        pstmt = conn.prepareStatement(sb.toString());
		        pstmt.setInt(1, offset);
		        pstmt.setInt(2, size);

		        rs = pstmt.executeQuery();
		        while (rs.next()) {
		            QnaBoardDTO dto = new QnaBoardDTO();

		            dto.setNum(rs.getLong("num"));
		            dto.setNickname(rs.getString("nickname"));
		            dto.setSubject(rs.getString("subject"));
		            dto.setHitCount(rs.getInt("hitCount"));
		            dto.setReg_date(rs.getString("reg_date"));
		            dto.setReplyCount(rs.getInt("replyCount"));

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
		
		
		// 검색 있는 경우 게시물 리스트
		public List<QnaBoardDTO> listBoard(int offset, int size, String schType, String kwd) {
		    List<QnaBoardDTO> list = new ArrayList<QnaBoardDTO>();
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;
		    StringBuilder sb = new StringBuilder();

		    try {
		        sb.append("SELECT q.num, nickname, subject, content, hitCount, TO_CHAR(reg_date, 'YYYY-MM-DD') reg_date, ");
		        sb.append("(SELECT COUNT(*) FROM qnaBoard_reply r WHERE r.num = q.num) AS replyCount ");
		        sb.append("FROM qnaBoard q ");
		        sb.append("JOIN member_detail m ON m.userId = q.userId ");
		        
		        if (schType.equals("all")) {
		            sb.append("WHERE INSTR(subject, ?) >= 1 OR INSTR(content, ?) >= 1 ");
		        } else if (schType.equals("reg_date")) {
		            kwd = kwd.replaceAll("(\\-|\\/|\\.)", "");
		            sb.append("WHERE TO_CHAR(reg_date, 'YYYYMMDD') = ?");
		        } else {
		            sb.append("WHERE INSTR(" + schType + ", ?) >= 1 ");
		        }
		        sb.append("ORDER BY f.num DESC ");
		        sb.append("OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ");

		        pstmt = conn.prepareStatement(sb.toString());
		        
		        if (schType.equals("all")) {
		            pstmt.setString(1, kwd);
		            pstmt.setString(2, kwd);
		            pstmt.setString(3, kwd);
		            pstmt.setInt(4, offset);
		            pstmt.setInt(5, size);
		        } else {
		            pstmt.setString(1, kwd);
		            pstmt.setInt(2, offset);
		            pstmt.setInt(3, size);
		        }

		        rs = pstmt.executeQuery();
		        
		        while (rs.next()) {
		            QnaBoardDTO dto = new QnaBoardDTO();

		            dto.setNum(rs.getLong("num"));
		            dto.setNickname(rs.getString("nickname"));
		            dto.setSubject(rs.getString("subject"));
		            dto.setHitCount(rs.getInt("hitCount"));
		            dto.setReg_date(rs.getString("reg_date"));
		            dto.setReplyCount(rs.getInt("replyCount"));

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
		
		
		// 조회수 증가하기
		public void updateHitCount(long num) throws SQLException {
			PreparedStatement pstmt = null;
			String sql;

			try {
				sql = "UPDATE qnaBoard SET hitCount=hitCount+1 WHERE num=?";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setLong(1, num);
				
				pstmt.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
				throw e;
			} finally {
				DBUtil.close(pstmt);
			}

		}

}
