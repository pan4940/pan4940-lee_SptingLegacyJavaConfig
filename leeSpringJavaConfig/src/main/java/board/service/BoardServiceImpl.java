package board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import board.bean.BoardDTO;
import board.mapper.BoardMapper;
import file.bean.FileDTO;
import file.mapper.FileMapper;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardMapper boardMapper;
	
	@Autowired
	private FileMapper fileMapper;
	
	
	@Override
	public List<BoardDTO> getBoardList(int board_category_num) {
		
		return boardMapper.getBoardList(board_category_num);
	}
	
	
	@Override
	public List<BoardDTO> getPostList(int board_category_num) {
		return boardMapper.getPostList(board_category_num);
	}
	
	@Override
	public List<BoardDTO> getListWithPaging(Map<String, String> map) {
		List<BoardDTO> list = boardMapper.getListWithPaging(map);
		return list;
	}
	
	
	@Override
	@Transactional(rollbackFor = Exception.class)
	public void writePOST(BoardDTO boardDTO) {
		if (boardDTO.getFileList() == null || boardDTO.getFileList().size() <= 0) {
			return;
		}
		boardMapper.write(boardDTO);
		boardDTO.getFileList().forEach(t -> {
			t.setLinked_num(boardDTO.getBoard_num());
			fileMapper.boardFileInsert(t);
		});
	}
	
	@Override
	@Transactional(rollbackFor = Exception.class)
	public void modify(BoardDTO boardDTO) {
		fileMapper.boardFileDeleteAll(boardDTO.getBoard_num());
		boardMapper.modify(boardDTO);
		
		if (boardDTO.getFileList() != null) {
			
			boardDTO.getFileList().forEach(t -> {
				t.setLinked_num(boardDTO.getBoard_num());
				fileMapper.boardFileInsert(t);
			});
		}
	}
	
	@Override
	public BoardDTO get(int board_num) {
		BoardDTO boardDTO = boardMapper.get(board_num);
		return boardDTO;
	}
	
	@Override
	public void boardReplyWrite(BoardDTO boardDTO) {
		//원글
		boardMapper.boardReplyWrite(boardDTO);
	}
	
	@Override
	public int getTotalCount(String board_category_num) {
		return boardMapper.getTotalCount(board_category_num);
	}
	
	
	@Transactional(rollbackFor = Exception.class)
	@Override
	public void delete(int board_num) {
		fileMapper.boardFileDeleteAll(board_num);
		boardMapper.delete(board_num);
	}
	
	
	
	@Override
	public void writeSelectKey(BoardDTO boardDTO) {
		boardMapper.writeSelectKey(boardDTO);
	}
	
	@Override
	public List<FileDTO> getFileList(int board_num) {
		return fileMapper.findByBoardNum(board_num);
	}
	
	@Override
	public BoardDTO getNewPost() {
		BoardDTO boardDTO = boardMapper.getNewPost();
		boardDTO.setFileList(fileMapper.findByBoardNum(boardDTO.getBoard_num()));
		return boardDTO;
	}
	
	@Override
	public List<BoardDTO> getProductReview(int product_number) {
		
		return boardMapper.getProductReview(product_number);
	}
	
	
	@Override
	public List<BoardDTO> getNavPostBoardDTO() {
		List<BoardDTO> list = boardMapper.getNavPostBoardDTO();
		for (BoardDTO boardDTO : list) {
			boardDTO.setFileList(fileMapper.findByBoardNum(boardDTO.getBoard_num()));
		}
		return list;
	}
}
