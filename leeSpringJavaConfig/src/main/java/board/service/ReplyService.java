package board.service;

import java.util.List;

import board.bean.BoardReplyDTO;


public interface ReplyService {
	
	
	public int write(BoardReplyDTO replyDTO);

	public List<BoardReplyDTO> getList(int board_number);

	public BoardReplyDTO get(int reply_num);

	public int update(BoardReplyDTO replyDTO);

	public int delete(int reply_num);




}
