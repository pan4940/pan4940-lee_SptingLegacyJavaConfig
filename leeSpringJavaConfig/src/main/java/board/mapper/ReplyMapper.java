package board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import board.bean.BoardReplyDTO;


@Mapper
public interface ReplyMapper {

	public int write(BoardReplyDTO replyDTO);

	public List<BoardReplyDTO> getList(int board_num);

	public BoardReplyDTO get(int reply_num);

	public int update(BoardReplyDTO replyDTO);

	public int delete(int reply_num);
}
