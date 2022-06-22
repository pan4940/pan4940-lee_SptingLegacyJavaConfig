package board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import board.bean.BoardReplyDTO;
import board.mapper.ReplyMapper;



@Service
public class ReplyServiceImpl implements ReplyService {
	
	@Autowired
	private ReplyMapper replyMapper;
	
	@Override
	public int write(BoardReplyDTO replyDTO) {
		
		return replyMapper.write(replyDTO);
	}
	
	@Override
	public List<BoardReplyDTO> getList(int board_number) {
		return replyMapper.getList(board_number);
	}
	
	@Override
	public BoardReplyDTO get(int reply_num) {
		return replyMapper.get(reply_num);
	}
	
	@Override
	public int update(BoardReplyDTO replyDTO) {
		
		return replyMapper.update(replyDTO);
	}
	
	@Override
	public int delete(int reply_num) {
		return replyMapper.delete(reply_num);
	}
}
