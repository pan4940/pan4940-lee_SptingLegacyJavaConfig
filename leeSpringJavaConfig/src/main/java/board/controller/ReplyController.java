package board.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import board.bean.BoardReplyDTO;
import board.service.ReplyService;



@RequestMapping("/reply")
@Controller
//@RestController
/* 왜 그런지는 모르겠으나 RestController로 해야 get.jsp의 showList바로 동작함 
 답 : write()에도 @ResponseBody붙이니 정상 작동
 write()시에도 ajax써서 그런것이 아닌가 생각함...
 
 */
public class ReplyController {
	
	@Autowired
	private ReplyService replyService;
	
	@PostMapping("/write")
	@ResponseBody
	public void write(BoardReplyDTO replyDTO) {
		replyService.write(replyDTO);
	}
	
	
	@PostMapping("/list")
	@ResponseBody
	public List<BoardReplyDTO> getList(int board_num) {
		List<BoardReplyDTO> list = replyService.getList(board_num);
		return list;
	}
	
	
	@PostMapping("/get")
	@ResponseBody
	public BoardReplyDTO get(int reply_num) {
		return replyService.get(reply_num);
	}
	
	@PostMapping("/update")
	@ResponseBody
	public void update(BoardReplyDTO replyDTO) {
		replyService.update(replyDTO);
	}
	
	
	@PostMapping("/delete")
	@ResponseBody
	public void delete(int reply_num) {
		replyService.delete(reply_num);
	}
	
	
	
}
