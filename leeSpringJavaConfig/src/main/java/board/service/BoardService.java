package board.service;

import java.util.List;
import java.util.Map;

import board.bean.BoardDTO;
import file.bean.FileDTO;



public interface BoardService {
	
	public List<BoardDTO> getBoardList(int board_category_num);

	public List<BoardDTO> getListWithPaging(Map<String, String> map);

	public void writePOST(BoardDTO boardDTO);

	public BoardDTO get(int board_num);

	public void boardReplyWrite(BoardDTO boardDTO);

	public int getTotalCount(String board_category_num);

	public void modify(BoardDTO boardDTO);

	public void delete(int board_num);

	public void writeSelectKey(BoardDTO boardDTO);

	public List<BoardDTO> getPostList(int board_category_num);
	
	public List<FileDTO> getFileList(int board_num);

	public BoardDTO getNewPost();

	public List<BoardDTO> getProductReview(int product_number);

	public List<BoardDTO> getNavPostBoardDTO();



}
