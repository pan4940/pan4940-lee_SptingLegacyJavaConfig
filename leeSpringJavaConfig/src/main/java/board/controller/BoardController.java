package board.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import board.bean.BoardDTO;
import board.bean.BoardCriteria;
import board.bean.BoardPageDTO;
import board.service.BoardService;
import file.bean.FileDTO;
import security.domain.CustomUser;



@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	private BoardService boardService; 
	
	//리스트 조회 및 출력
	@GetMapping("/list")
	public String list(@RequestParam Map<String, String> map, Model model) {
		String board_category_num = map.get("board_category_num");
		if (Integer.parseInt(board_category_num) == 7) {
			
			List<BoardDTO> list = boardService.getPostList(Integer.parseInt(board_category_num));
			model.addAttribute("board_category_num", board_category_num);
			
			for (BoardDTO boardDTO : list) {
				boardDTO.setFileList(boardService.getFileList(boardDTO.getBoard_num()));
			}
			
			model.addAttribute("list", list);
			model.addAttribute("display", "/WEB-INF/views/board/post.jsp");
			return "index";
		
		} else {
			String pageNum = map.get("pageNum");
			String amount = map.get("amount");
			
			BoardCriteria criteria = new BoardCriteria(Integer.parseInt(pageNum), Integer.parseInt(amount));
			
			List<BoardDTO> list = boardService.getListWithPaging(map);
			int total = boardService.getTotalCount(board_category_num);
			model.addAttribute("pageDTO", new BoardPageDTO(criteria, total));
			model.addAttribute("board_category_num", board_category_num);
			model.addAttribute("list", list);
			
			model.addAttribute("display", "/WEB-INF/views/board/list.jsp");
			return "index";
		}
	}
	
	
	
	
	
	//원글작성
	@GetMapping("/write")
	public String writeForm(@RequestParam Map<String, String> map, Model model) {
		model.addAttribute("map", map);
		model.addAttribute("display", "/WEB-INF/views/board/write.jsp");
		return "index";
		
	}
	
	@PostMapping("/write")
	public String write(@RequestParam Map<String, String> map, 
						@ModelAttribute BoardDTO boardDTO, 
						RedirectAttributes redirectAttributes) {
		
		int board_category_num = Integer.parseInt(map.get("board_category_num")); 
		
		if (board_category_num == 7) {
			System.out.println(boardDTO);
			List<FileDTO> list = boardDTO.getFileList();
			boardService.writePOST(boardDTO);
			redirectAttributes.addAttribute("board_category_num", map.get("board_category_num"));
			return "redirect:/board/list";
		}
		
		boardService.writeSelectKey(boardDTO);
		redirectAttributes.addAttribute("board_category_num", map.get("board_category_num"));
		redirectAttributes.addAttribute("pageNum", "1");
		redirectAttributes.addAttribute("amount", map.get("amount"));
		
		redirectAttributes.addAttribute("display", "/WEB-INF/views/board/list.jsp");
		return "redirect:/board/list";
	}
	
	
	//게시물 조회
	//board_category_num, board_num, pageNum, amount넘겨받음. 
	@GetMapping("/get")
	public String get(@RequestParam Map<String, String> map, Model model) {
		
		int board_category_num = Integer.parseInt(map.get("board_category_num"));
		int board_num = Integer.parseInt(map.get("board_num")) ;
		
		if (board_category_num == 7) {
			BoardDTO boardDTO = boardService.get(board_num);
			List<FileDTO> list = boardService.getFileList(board_num);
			boardDTO.setFileList(list);
			
			model.addAttribute("map", map);
			model.addAttribute("boardDTO", boardDTO);
			
			model.addAttribute("display", "/WEB-INF/views/board/single.jsp");
			return "index";
		}
		
		BoardDTO boardDTO = boardService.get(board_num);
		model.addAttribute("map", map);
		model.addAttribute("boardDTO", boardDTO);
		
		model.addAttribute("display", "/WEB-INF/views/board/get.jsp");
		return "index";
		
		//return "/board/get";
	}
	
	
	
	
	//글 수정 페이지로 이동
	@GetMapping("/modify")
	public String modifyForm(@RequestParam Map<String, String> map, Model model) {
		int board_category_num = Integer.parseInt(map.get("board_category_num"));
		
		BoardDTO boardDTO = boardService.get(Integer.parseInt(map.get("board_num")));
		
		if (board_category_num == 7) {
			boardDTO.setFileList(boardService.getFileList(boardDTO.getBoard_num()));
		}
		
		model.addAttribute("map", map);
		model.addAttribute("boardDTO", boardDTO);
		
		model.addAttribute("display", "/WEB-INF/views/board/modify.jsp");
		return "index";
		
		//return "/board/modify";
	}
	
	//글 수정
	@PostMapping("/modify")
	public String modify(@RequestParam Map<String, String> map, 
			@ModelAttribute BoardDTO boardDTO, 
			RedirectAttributes redirectAttributes) {
		boardService.modify(boardDTO);
		redirectAttributes.addAttribute("board_category_num", map.get("board_category_num"));
		redirectAttributes.addAttribute("pageNum", map.get("pageNum"));
		redirectAttributes.addAttribute("amount", map.get("amount"));
		
		redirectAttributes.addAttribute("display", "/WEB-INF/views/board/list.jsp");
		return "redirect:/board/list";
		//return "index";
	}
	
	//답글 작성 페이지로 이동
	@GetMapping("/replyWrite")
	public String replyWriteForm(@RequestParam Map<String, String> map, Model model) {
		BoardDTO boardDTO = boardService.get(Integer.parseInt(map.get("board_num")));
		model.addAttribute("map", map);
		model.addAttribute("boardDTO", boardDTO);
		
		model.addAttribute("display", "/WEB-INF/views/board/reply.jsp");
		return "index";
	}
	
	@PostMapping("/boardReplyWrite")
	public String boardReplyWrite(@RequestParam Map<String, String> map, 
								  @ModelAttribute BoardDTO boardDTO,
								  RedirectAttributes redirectAttributes) {
		
		boardDTO.setParant_num(boardDTO.getBoard_num());
		boardService.boardReplyWrite(boardDTO);
		
		//댓글 작성후 원글이 있는 페이지로 이동
		redirectAttributes.addAttribute("board_category_num", map.get("board_category_num"));
		redirectAttributes.addAttribute("pageNum", map.get("pageNum"));
		redirectAttributes.addAttribute("amount", map.get("amount"));
		
		redirectAttributes.addAttribute("display", "/WEB-INF/views/board/list.jsp");
		return "redirect:/board/list";
		//return "index";
	}
	
	@Transactional(rollbackFor = Exception.class)
	@PostMapping("/delete")
	public String delete(@RequestParam Map<String, String> map, 
			//@ModelAttribute BoardDTO boardDTO, 
			RedirectAttributes redirectAttributes) {
		int board_num = Integer.parseInt(map.get("board_num")) ;
		List<FileDTO> fileList = boardService.getFileList(board_num);
		
		if (fileList != null) {
			deleteFiles(fileList);
		}
		
		boardService.delete(board_num);
		
		redirectAttributes.addAttribute("board_category_num", map.get("board_category_num"));
		redirectAttributes.addAttribute("pageNum", map.get("pageNum"));
		redirectAttributes.addAttribute("amount", map.get("amount"));
		redirectAttributes.addAttribute("display", "/WEB-INF/views/board/list.jsp");
		//return "index";
		return "redirect:/board/list";
	}
	
	
	//게시물의 첨부파일 불러옴
	@PostMapping("/getFileList")
	@ResponseBody
	public List<FileDTO> getFileList(int board_num) {
		return boardService.getFileList(board_num);
	}
	
	
	//게시물 삭제시 첨부파일 삭제
	public void deleteFiles(List<FileDTO> fileList) {
		if (fileList == null || fileList.size() == 0) {
			return;
		}
		
		fileList.forEach(t -> {
			try {
				Path file = Paths.get("C:\\thec\\" + t.getUploadPath() + "\\" + t.getUuid() + "_" + t.getFileName());
				Files.deleteIfExists(file);
			} catch (IOException e) {
				System.out.println("delete file error " + e.getMessage());
			}
		});
	}
	
	//메인페이지 post 관련 메소드. 가장 최근에 등록한 post 정보. boardDTO가져온다. 
	
	@PostMapping("/getNewPost")
	@ResponseBody
	public BoardDTO getNewPost() {
		return boardService.getNewPost();
	}
	
	@PostMapping("/getProductReview")
	@ResponseBody
	public List<BoardDTO> getProductReview(@RequestParam int product_num) {
		return boardService.getProductReview(product_num);
	}
	
	
	@GetMapping("/secret")
	public String secret(Authentication authentication ,@RequestParam Map<String, String> map, Model model) {
		
		try {
			CustomUser customUser = (CustomUser) authentication.getPrincipal();
			
			int board_num = Integer.parseInt(map.get("board_num"));
			BoardDTO boardDTO = boardService.get(board_num);
			
			if (customUser.getUsername().equals(boardDTO.getMember_id()) || customUser.getAuthorities().toString().contains("ROLE_ADMIN")) {
				//memberDTO.getRank_num() == 3 || boardDTO.getMember_id().equals(member_id)
				
				model.addAttribute("map", map);
				get(map, model);
			}
		
		} catch (Exception e) {
			System.out.println(e.getMessage());
			
			int board_num = Integer.parseInt(map.get("board_num"));
			BoardDTO boardDTO = boardService.get(board_num);
			
			if (map.get("pwd") != null && map.get("pwd").equals(boardDTO.getPwd())) {
				model.addAttribute("display", "/WEB-INF/views/board/secret.jsp");
				model.addAttribute("map", map);
			} else {
				map.remove("pwd");
				model.addAttribute("map", map);
				get(map, model);
			} 
			
			
		}
		
		return "/index";
	}
	
	@PostMapping("/getNavPostBoardDTO")
	@ResponseBody
	public List<BoardDTO> getNavPostBoardDTO() {
		return boardService.getNavPostBoardDTO();
	}
}
