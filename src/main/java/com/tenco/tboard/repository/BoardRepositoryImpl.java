package com.tenco.tboard.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tenco.tboard.model.Board;
import com.tenco.tboard.repository.interfaces.BoardRepository;
import com.tenco.tboard.utill.DBUtill;

public class BoardRepositoryImpl implements BoardRepository {

	private static final String SELECT_ALL_BOARDS = " SELECT * FROM board ORDER BY created_at DESC LIMIT ? OFFSET ?  ";
	private static final String COUNT_ALL_BOARDS = " SELECT count(*) as count FROM board ";
	private static final String INSERT_BOARD_SQL = " INSERT INTO board(user_id, title, content) VALUES (?, ?, ?) ";
	private static final String DELETE_BOARD_SQL = " DELETE FROM board WHERE id = ? ";
	private static final String SELECT_BOARD_BY_ID = " SELECT * FROM board WHERE id = ? ";
	private static final String UPDATE_BOARD_SQL = " UPDATE board SET title = ?, content = ? WHERE id = ? ";

	@Override
	public int addBoard(Board board) {
		int rowCount = 0;
		try (Connection conn = DBUtill.getConnection()) {
			conn.setAutoCommit(false);
			try (PreparedStatement pstmt = conn.prepareStatement(INSERT_BOARD_SQL)) {
				pstmt.setInt(1, board.getUserId());
				pstmt.setString(2, board.getTitle());
				pstmt.setString(3, board.getContent());
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
	public int updateBoard(Board board) {
		int rowCount = 0;
		try (Connection conn = DBUtill.getConnection()) {
			System.out.println("123123");
			conn.setAutoCommit(false);
			try (PreparedStatement pstmt = conn.prepareStatement(UPDATE_BOARD_SQL)) {
				System.out.println("title, content, id : " + board.getTitle() + ", " + board.getContent() + ", " + board.getId());
				pstmt.setString(1, board.getTitle());
				pstmt.setString(2, board.getContent());
				pstmt.setInt(3, board.getId());
				rowCount = pstmt.executeUpdate();
				conn.commit();
			} catch (Exception e) {
				conn.rollback();
				e.printStackTrace();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("rowCount : " +rowCount);
		return rowCount;
	}

	@Override
	public void deleteBoard(int id) {
		try (Connection conn = DBUtill.getConnection()) {
			conn.setAutoCommit(false);
			try (PreparedStatement pstmt = conn.prepareStatement(DELETE_BOARD_SQL)) {
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
	public Board getBoardById(int id) {
		Board board = null;
		try (Connection conn = DBUtill.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(SELECT_BOARD_BY_ID)) {
			pstmt.setInt(1, id);
			try (ResultSet rs = pstmt.executeQuery()){
				if (rs.next()) {
					board = Board.builder()
							.id(rs.getInt("id"))
							.userId(rs.getInt("user_id"))
							.title(rs.getString("title"))
							.content(rs.getString("content"))
							.createdAt(rs.getTimestamp("created_at"))
							.build();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return board;
	}

	@Override
	public List<Board> getAllBoards(int limit, int offset) {
		List<Board> boardList = new ArrayList<Board>();
		try (Connection conn = DBUtill.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(SELECT_ALL_BOARDS)) {
			pstmt.setInt(1, limit);
			pstmt.setInt(2, offset);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				boardList.add(
						Board.builder().id(rs.getInt("id")).userId(rs.getInt("user_id")).title(rs.getString("title"))
								.content(rs.getString("content")).createdAt(rs.getTimestamp("created_at")).build());
			}
//			System.out.println("BoardRepositoryImple - 로깅 : " + boardList.size());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return boardList;
	}

	@Override
	public int getTotalBoardCount() {
		int boardCount = 0;
		try (Connection conn = DBUtill.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(COUNT_ALL_BOARDS)) {
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				boardCount = rs.getInt("count");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
//		System.out.println("로깅 total : " + boardCount);
		return boardCount;
	}

}
