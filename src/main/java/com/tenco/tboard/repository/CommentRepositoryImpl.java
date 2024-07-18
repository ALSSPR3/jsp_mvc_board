package com.tenco.tboard.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.tenco.tboard.model.Comment;
import com.tenco.tboard.repository.interfaces.CommentRepository;
import com.tenco.tboard.utill.DBUtill;

public class CommentRepositoryImpl implements CommentRepository {

	private static final String INSERT_COMMENT_SQL = " INSERT INTO comments (board_id, user_id, content) VALUES (?, ?, ?) ";
	private static final String DELETE_COMMENT_SQL = " DELETE FROM comments WHERE id = ? ";
	private static final String SELEECT_COMMENT_BY_ID = " SELECT * FROM comments WHERE id = ? ";
	private static final String SELEECT_COMMENTS_BY_BOARD_ID = " SELECT c.* , u.username FROM comments as c JOIN users AS u ON c.user_id = u.id WHERE board_id = ? ORDER BY created_at DESC ";
	private static final String UPDATE_COMMNET_SQL = " UPDATE comments SET content = ? WHERE id = ? ";

	@Override
	public int addComment(Comment comment) {
		int rowCount = 0;
		try (Connection conn = DBUtill.getConnection()) {
			conn.setAutoCommit(false);
			try (PreparedStatement pstmt = conn.prepareStatement(INSERT_COMMENT_SQL)) {
				pstmt.setInt(1, comment.getBoardId());
				pstmt.setInt(2, comment.getUserId());
				pstmt.setString(3, comment.getContent());
				rowCount = pstmt.executeUpdate();
				conn.commit();
			} catch (Exception e) {
				conn.rollback();
				e.printStackTrace();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rowCount;
	}

	@Override
	public void deleteComment(int id) {
		try (Connection conn = DBUtill.getConnection()) {
			conn.setAutoCommit(false);
			try (PreparedStatement pstmt = conn.prepareStatement(DELETE_COMMENT_SQL)) {
				pstmt.setInt(1, id);
				pstmt.executeUpdate();
				conn.commit();
			} catch (Exception e) {
				conn.rollback();
				e.printStackTrace();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public Comment getCommentById(int id) {
		Comment comment = null;
		try (Connection conn = DBUtill.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(SELEECT_COMMENT_BY_ID)) {
			pstmt.setInt(1, id);
			try (ResultSet rs = pstmt.executeQuery();) {
				if (rs.next()) {
					comment = new Comment(rs.getInt("id"), rs.getInt("board_id"), rs.getInt("user_id"),
							rs.getString("content"), rs.getTimestamp("created_at"), rs.getString("username"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return comment;
	}

	@Override
	public List<Comment> getCommentsByBoardId(int boardId) {
		List<Comment> commentList = new ArrayList<Comment>();
		try (Connection conn = DBUtill.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(SELEECT_COMMENTS_BY_BOARD_ID)) {
			pstmt.setInt(1, boardId);
			try (ResultSet rs = pstmt.executeQuery();) {
				while (rs.next()) {
					Comment comment = new Comment(rs.getInt("id"), rs.getInt("board_id"), rs.getInt("user_id"),
							rs.getString("content"), rs.getTimestamp("created_at"), rs.getString("username"));
					commentList.add(comment);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return commentList;
	}

	@Override
	public int updateComment(Comment comment) {
		int rowCount = 0;
		try (Connection conn = DBUtill.getConnection()) {
			conn.setAutoCommit(false);
			try (PreparedStatement pstmt = conn.prepareStatement(UPDATE_COMMNET_SQL)) {
				pstmt.setString(1, comment.getContent());
				pstmt.setInt(2, comment.getId());
				rowCount = pstmt.executeUpdate();
				conn.commit();
			} catch (Exception e) {
				conn.rollback();
				e.printStackTrace();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rowCount;
	}

}
