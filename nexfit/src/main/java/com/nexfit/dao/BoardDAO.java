package com.nexfit.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.nexfit.domain.BoardDTO;
import com.nexfit.domain.ReplyDTO;
import com.nexfit.util.DBConn;
import com.nexfit.util.DBUtil;

public class BoardDAO {
	private Connection conn = DBConn.getConnection();

	// 데이터 추가
	public void insertBoard(BoardDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "INSERT INTO freeboard(num, userId, categoryId, subject, content, hitCount, reg_date) "
					+ " VALUES (freeboard_seq.NEXTVAL, ?, ?, ?, ?, 0, SYSDATE)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getUserId());
			pstmt.setInt(2, dto.getCategoryId());
			pstmt.setString(3, dto.getSubject());
			pstmt.setString(4, dto.getContent());

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
			sql = "SELECT NVL(COUNT(*), 0) FROM freeboard";
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

	public int dataCount(String schType, String kwd) {
	    int result = 0;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql;

	    try {
	        sql = "SELECT NVL(COUNT(*), 0) "
	                + " FROM freeboard f "
	                + " JOIN member_detail m ON f.userId = m.userId ";
	        
	        if (schType.equals("all")) {
	            sql += " WHERE INSTR(subject, ?) > 0 OR INSTR(content, ?) > 0 OR INSTR(categoryId, ?) > 0";
	        } else if (schType.equals("reg_date")) {
	            kwd = kwd.replaceAll("(\\-|\\/|\\.)", "");
	            sql += " WHERE TO_CHAR(reg_date, 'YYYYMMDD') = ? ";
	        } else {
	            sql += " WHERE INSTR(" + schType + ", ?) > 0 ";
	        }

	        pstmt = conn.prepareStatement(sql);
	        
	        if (schType.equals("all")) {
	            pstmt.setString(1, kwd);
	            pstmt.setString(2, kwd);
	            pstmt.setString(3, kwd);
	        } else {
	            pstmt.setString(1, kwd);
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
	public List<BoardDTO> listBoard(int offset, int size) {
	    List<BoardDTO> list = new ArrayList<BoardDTO>();
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    StringBuilder sb = new StringBuilder();

	    try {
	        sb.append("SELECT f.num, nickname, categoryName, subject, content, hitCount, TO_CHAR(reg_date, 'YYYY-MM-DD') reg_date, ");
	        sb.append("(SELECT COUNT(*) FROM freeBoard_Reply r WHERE r.num = f.num) AS replyCount, ");
	        sb.append("(SELECT COUNT(*) FROM freeBoard_Like l WHERE l.num = f.num) AS boardLikeCount ");
	        sb.append("FROM freeBoard f ");
	        sb.append("JOIN member_detail m ON m.userId = f.userId ");
	        sb.append("JOIN freeboard_category c ON f.categoryId = c.categoryId ");
	        sb.append("ORDER BY f.num DESC ");
	        sb.append("OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ");

	        pstmt = conn.prepareStatement(sb.toString());
	        pstmt.setInt(1, offset);
	        pstmt.setInt(2, size);

	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            BoardDTO dto = new BoardDTO();

	            dto.setNum(rs.getLong("num"));
	            dto.setCategoryName(rs.getString("categoryName"));
	            dto.setNickname(rs.getString("nickname"));
	            dto.setSubject(rs.getString("subject"));
	            dto.setHitCount(rs.getInt("hitCount"));
	            dto.setReg_date(rs.getString("reg_date"));
	            dto.setReplyCount(rs.getInt("replyCount"));
	            dto.setBoardLikeCount(rs.getInt("boardLikeCount"));

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
	public List<BoardDTO> listBoard(int offset, int size, String schType, String kwd) {
	    List<BoardDTO> list = new ArrayList<BoardDTO>();
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    StringBuilder sb = new StringBuilder();

	    try {
	        sb.append("SELECT f.num, nickname, f.categoryId, categoryName, subject, content, hitCount, TO_CHAR(reg_date, 'YYYY-MM-DD') reg_date, ");
	        sb.append("(SELECT COUNT(*) FROM freeBoard_reply r WHERE r.num = f.num) AS replyCount, ");
	        sb.append("(SELECT COUNT(*) FROM freeBoard_Like l WHERE l.num = f.num) AS boardLikeCount ");
	        sb.append("FROM freeBoard f ");
	        sb.append("JOIN member_detail m ON m.userId = f.userId ");
	        sb.append("JOIN freeboard_category c ON f.categoryId = c.categoryId ");
	        if (schType.equals("all")) {
	            sb.append("WHERE INSTR(subject, ?) >= 1 OR INSTR(content, ?) >= 1 OR INSTR(f.categoryId, ?) >= 1 ");
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
	            BoardDTO dto = new BoardDTO();

	            dto.setNum(rs.getLong("num"));
	            dto.setCategoryName(rs.getString("categoryName"));
	            dto.setCategoryId(rs.getInt("categoryId"));
	            dto.setNickname(rs.getString("nickname"));
	            dto.setSubject(rs.getString("subject"));
	            dto.setHitCount(rs.getInt("hitCount"));
	            dto.setReg_date(rs.getString("reg_date"));
	            dto.setReplyCount(rs.getInt("replyCount"));
	            dto.setBoardLikeCount(rs.getInt("boardLikeCount"));

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
	
	
	
	// 카테고리별 게시물 리스트
	public List<BoardDTO> listBoard(int offset, int size, String category) {
	    List<BoardDTO> list = new ArrayList<>();
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    StringBuilder sb = new StringBuilder();

	    try {
	        sb.append("SELECT f.num, f.categoryId, c.categoryName, m.nickname, subject, hitCount, ");
	        sb.append("      TO_CHAR(reg_date, 'YYYY-MM-DD') reg_date, ");
	        sb.append("      NVL(replyCount, 0) replyCount, ");
	        sb.append("      NVL(boardLikeCount, 0) boardLikeCount ");
	        sb.append(" FROM freeboard f ");
	        sb.append(" JOIN member_detail m ON f.userId = m.userId ");
	        sb.append(" JOIN freeboard_category c ON f.categoryId = c.categoryId ");
	        sb.append(" LEFT OUTER JOIN ( ");
	        sb.append("     SELECT num, COUNT(*) replyCount ");
	        sb.append("     FROM freeboard_Reply ");
	        sb.append("     GROUP BY num ");
	        sb.append(" ) r ON f.num = r.num ");
	        sb.append(" LEFT OUTER JOIN ( ");
	        sb.append("     SELECT num, COUNT(*) boardLikeCount ");
	        sb.append("     FROM freeboard_Like ");
	        sb.append("     GROUP BY num ");
	        sb.append(" ) l ON f.num = l.num ");
	        if (!category.equals("전체")) {
	            sb.append(" WHERE f.categoryId = ? ");
	        }
	        sb.append(" ORDER BY f.num DESC ");
	        sb.append(" OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ");

	        pstmt = conn.prepareStatement(sb.toString());
	        int parameterIndex = 1;
	        if (!category.equals("전체")) {
	            pstmt.setInt(parameterIndex++, Integer.parseInt(category));
	        }
	        pstmt.setInt(parameterIndex++, offset);
	        pstmt.setInt(parameterIndex, size);

	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            BoardDTO dto = new BoardDTO();
	            dto.setNum(rs.getLong("num"));
	            dto.setCategoryId(rs.getInt("categoryId"));
	            dto.setCategoryName(rs.getString("categoryName"));
	            dto.setNickname(rs.getString("nickname"));
	            dto.setSubject(rs.getString("subject"));
	            dto.setHitCount(rs.getInt("hitCount"));
	            dto.setReg_date(rs.getString("reg_date"));
	            dto.setReplyCount(rs.getInt("replyCount"));
	            dto.setBoardLikeCount(rs.getInt("boardLikeCount"));
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

	// 특정 카테고리의 데이터 개수
	public int dataCountByCategory(String category) {
	    int result = 0;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql;

	    try {
	        sql = "SELECT NVL(COUNT(*), 0) FROM freeboard WHERE categoryId = ?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, Integer.parseInt(category));

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
	
	

	// 조회수 증가하기
	public void updateHitCount(long num) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "UPDATE freeboard SET hitCount=hitCount+1 WHERE num=?";
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

	// 해당 게시물 보기
	public BoardDTO findById(long num) {
		BoardDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT f.num, f.userId, nickname, subject, content, reg_date, hitCount, "
					+ "    NVL(boardLikeCount, 0) boardLikeCount "
					+ " FROM freeboard f "
					+ " JOIN member_detail m ON f.userId = m.userId "
					+ " LEFT OUTER JOIN ("
					+ "      SELECT num, COUNT(*) boardLikeCount FROM freeboard_Like"
					+ "      GROUP BY num"
					+ " ) bc ON f.num = bc.num"
					+ " WHERE f.num = ? ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new BoardDTO();
				
				dto.setNum(rs.getLong("num"));
				dto.setUserId(rs.getString("userId"));
				dto.setNickname(rs.getString("nickname"));
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

	// 이전글
	public BoardDTO findByPrev(long num, String schType, String kwd) {
		BoardDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();

		try {
			if (kwd != null && kwd.length() != 0) {
				sb.append(" SELECT num, subject ");
				sb.append(" FROM freeboard f ");
				sb.append(" JOIN member_detail m ON f.userId = m.userId ");
				sb.append(" WHERE ( num > ? ) ");
				if (schType.equals("all")) {
					sb.append("   AND ( INSTR(subject, ?) >= 1 OR INSTR(content, ?) >= 1 ) ");
				} else if (schType.equals("reg_date")) {
					kwd = kwd.replaceAll("(\\-|\\/|\\.)", "");
					sb.append("   AND ( TO_CHAR(reg_date, 'YYYYMMDD') = ? ) ");
				} else {
					sb.append("   AND ( INSTR(" + schType + ", ?) >= 1 ) ");
				}
				sb.append(" ORDER BY num ASC ");
				sb.append(" FETCH FIRST 1 ROWS ONLY ");

				pstmt = conn.prepareStatement(sb.toString());
				
				pstmt.setLong(1, num);
				pstmt.setString(2, kwd);
				if (schType.equals("all")) {
					pstmt.setString(3, kwd);
				}
			} else {
				sb.append(" SELECT num, subject ");
				sb.append(" FROM freeboard ");
				sb.append(" WHERE num > ? ");
				sb.append(" ORDER BY num ASC ");
				sb.append(" FETCH FIRST 1 ROWS ONLY ");

				pstmt = conn.prepareStatement(sb.toString());
				
				pstmt.setLong(1, num);
			}

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new BoardDTO();
				
				dto.setNum(rs.getLong("num"));
				dto.setSubject(rs.getString("subject"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}

		return dto;
	}

	// 다음글
	public BoardDTO findByNext(long num, String schType, String kwd) {
		BoardDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();

		try {
			if (kwd != null && kwd.length() != 0) {
				sb.append(" SELECT num, subject ");
				sb.append(" FROM freeboard f ");
				sb.append(" JOIN member_detail m ON f.userId = m.userId ");
				sb.append(" WHERE ( num < ? ) ");
				if (schType.equals("all")) {
					sb.append("   AND ( INSTR(subject, ?) >= 1 OR INSTR(content, ?) >= 1 ) ");
				} else if (schType.equals("reg_date")) {
					kwd = kwd.replaceAll("(\\-|\\/|\\.)", "");
					sb.append("   AND ( TO_CHAR(reg_date, 'YYYYMMDD') = ? ) ");
				} else {
					sb.append("   AND ( INSTR(" + schType + ", ?) >= 1 ) ");
				}
				sb.append(" ORDER BY num DESC ");
				sb.append(" FETCH FIRST 1 ROWS ONLY ");

				pstmt = conn.prepareStatement(sb.toString());
				
				pstmt.setLong(1, num);
				pstmt.setString(2, kwd);
				if (schType.equals("all")) {
					pstmt.setString(3, kwd);
				}
			} else {
				sb.append(" SELECT num, subject ");
				sb.append(" FROM freeboard ");
				sb.append(" WHERE num < ? ");
				sb.append(" ORDER BY num DESC ");
				sb.append(" FETCH FIRST 1 ROWS ONLY ");

				pstmt = conn.prepareStatement(sb.toString());
				
				pstmt.setLong(1, num);
			}

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new BoardDTO();
				
				dto.setNum(rs.getLong("num"));
				dto.setSubject(rs.getString("subject"));
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
			sql = "UPDATE freeboard SET categoryId=?, subject=?, content=? WHERE num=? AND userId=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, dto.getCategoryId());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setLong(4, dto.getNum());
			pstmt.setString(5, dto.getUserId());
			
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
				sql = "DELETE FROM freeboard WHERE num=?";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setLong(1, num);
				
				pstmt.executeUpdate();
			} else {
				sql = "DELETE FROM freeboard WHERE num=? AND userId=?";
				
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
	
	// 로그인 유저의 게시글 공감 유무
	public boolean isUserBoardLike(long num, String userId) {
		boolean result = false;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT num, userId FROM freeboard_Like WHERE num = ? AND userId = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, num);
			pstmt.setString(2, userId);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}
		
		return result;
	}
	
	// 게시물의 공감 추가
	public void insertBoardLike(long num, String userId) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "INSERT INTO freeboard_Like(num, userId) VALUES (?, ?)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, num);
			pstmt.setString(2, userId);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			DBUtil.close(pstmt);
		}
	}
	
	// 게시글 공감 삭제
	public void deleteBoardLike(long num, String userId) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "DELETE FROM freeboard_Like WHERE num = ? AND userId = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, num);
			pstmt.setString(2, userId);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			DBUtil.close(pstmt);
		}
	}
	
	// 게시물의 공감 개수
	public int countBoardLike(long num) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT NVL(COUNT(*), 0) FROM freeboard_Like WHERE num=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
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

	// 게시물의 댓글 및 답글 추가
	public void insertReply(ReplyDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "INSERT INTO freeboard_Reply(replyNum, num, userId, content, answer, reg_date) "
					+ " VALUES (freeboard_Reply_seq.NEXTVAL, ?, ?, ?, ?, SYSDATE)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, dto.getNum());
			pstmt.setString(2, dto.getUserId());
			pstmt.setString(3, dto.getContent());
			pstmt.setLong(4, dto.getAnswer());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			DBUtil.close(pstmt);
		}
		
	}

	// 게시물의 댓글 개수
	public int dataCountReply(long num) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT NVL(COUNT(*), 0) "
					+ " FROM freeboard_Reply "
					+ " WHERE num = ? AND answer = 0";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
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

	// 게시물 댓글 리스트
	public List<ReplyDTO> listReply(long num, int offset, int size) {
		List<ReplyDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();
		
		try {
			sb.append(" SELECT r.replyNum, r.userId, nickname, num, content, r.reg_date, ");
			sb.append("     NVL(answerCount, 0) answerCount ");
			sb.append(" FROM freeboard_Reply r ");
			sb.append(" JOIN member m ON r.userId = m.userId ");
			sb.append(" JOIN member_detail d ON d.userId = m.userId ");
			sb.append(" LEFT OUTER  JOIN (");
			sb.append("	    SELECT answer, COUNT(*) answerCount ");
			sb.append("     FROM freeboard_Reply ");
			sb.append("     WHERE answer != 0 ");
			sb.append("     GROUP BY answer ");
			sb.append(" ) a ON r.replyNum = a.answer ");
			sb.append(" WHERE num = ? AND r.answer=0 ");
			sb.append(" ORDER BY r.replyNum DESC ");
			sb.append(" OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ");

			
			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.setLong(1, num);
			pstmt.setInt(2, offset);
			pstmt.setInt(3, size);

			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ReplyDTO dto = new ReplyDTO();
				
				dto.setReplyNum(rs.getLong("replyNum"));
				dto.setNum(rs.getLong("num"));
				dto.setUserId(rs.getString("userId"));
				dto.setNickname(rs.getString("nickname")); 
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setAnswerCount(rs.getInt("answerCount"));
				
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

	public ReplyDTO findByReplyId(long replyNum) {
		ReplyDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT replyNum, num, r.userId, nickname, content, r.reg_date "
					+ " FROM freeboard_reply r  "
					+ " JOIN member m ON r.userId = m.userId "
					+ " JOIN member_detail d ON d.userId = m.userId "
					+ " WHERE replyNum = ? ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, replyNum);

			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				dto=new ReplyDTO();
				
				dto.setReplyNum(rs.getLong("replyNum"));
				dto.setNum(rs.getLong("num"));
				dto.setUserId(rs.getString("userId"));
				dto.setNickname(rs.getString("nickname"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getString("reg_date"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}
		
		return dto;
	}
	
	
	// 게시물의 댓글 삭제
	public void deleteReply(long replyNum, String userId) throws SQLException {
			PreparedStatement pstmt = null;
			String sql;
			
			if(! userId.equals("admin")) {
				ReplyDTO dto = findByReplyId(replyNum);
				if(dto == null || (! userId.equals(dto.getUserId()))) {
					return;
				}
			}
			
			try {
				sql = "DELETE FROM freeBoard_Reply "
						+ " WHERE replyNum IN  "
						+ " (SELECT replyNum FROM freeBoard_Reply START WITH replyNum = ?"
						+ "     CONNECT BY PRIOR replyNum = answer)";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setLong(1, replyNum);
				
				pstmt.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
				throw e;
			} finally {
				DBUtil.close(pstmt);
			}		
		}
	
	
	// 댓글의 답글 리스트
	public List<ReplyDTO> listReplyAnswer(long answer) {
			List<ReplyDTO> list = new ArrayList<>();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			StringBuilder sb=new StringBuilder();
			
			try {
				sb.append(" SELECT replyNum, num, r.userId, nickname, content, r.reg_date, answer ");
				sb.append(" FROM freeboard_Reply r ");
				sb.append(" JOIN member m ON r.userId = m.userId ");
				sb.append(" JOIN member_detail d ON d.userId = m.userId ");
				sb.append(" WHERE answer = ? ");
				sb.append(" ORDER BY replyNum DESC ");
				pstmt = conn.prepareStatement(sb.toString());
				
				pstmt.setLong(1, answer);

				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					ReplyDTO dto=new ReplyDTO();
					
					dto.setReplyNum(rs.getLong("replyNum"));
					dto.setNum(rs.getLong("num"));
					dto.setUserId(rs.getString("userId"));
					dto.setNickname(rs.getString("nickname"));
					dto.setContent(rs.getString("content"));
					dto.setReg_date(rs.getString("reg_date"));
					dto.setAnswer(rs.getLong("answer"));
					
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
		
	// 댓글의 답글 개수
	public int dataCountReplyAnswer(long answer) {
			int result = 0; 
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql;
			
			try {
				sql = "SELECT NVL(COUNT(*), 0) "
						+ " FROM freeBoard_Reply WHERE answer = ?";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setLong(1, answer);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					result=rs.getInt(1);
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				DBUtil.close(rs);
				DBUtil.close(pstmt);
			}
			
			return result;
		}
	
	
	
}
