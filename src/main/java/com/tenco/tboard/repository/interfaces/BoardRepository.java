package com.tenco.tboard.repository.interfaces;

import java.util.List;

import com.tenco.tboard.model.Board;

public interface BoardRepository {
	
	int addBoard(Board board);
	int updateBoard(Board board);
	void deleteBoard(int id);
	Board getBoardById(int id);
	List<Board> getAllBoards(int limit, int offset);
	int getTotalBoardCount();
}
