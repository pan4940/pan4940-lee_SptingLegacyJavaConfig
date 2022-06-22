package board.bean;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;

import com.fasterxml.jackson.annotation.JsonFormat;

import file.bean.FileDTO;
import lombok.Data;


@Data
@Alias("BoardDTO")
public class BoardDTO {
	private int board_num;
	private String member_id;
	private String member_name;
	private String subject;
	private String content;
	private int group_num; //글의 그룹
	private int layer; //댓글 계층
	private int orders; // 레벨당 순서
	private int parant_num; // 부모글 번호. 이것이 있어야 계속 댓글 달때 어느 게시물에 대한 댓글인지 식별가능
	private int hit; //조회수
	@JsonFormat(pattern = "yyyy/MM/dd")
	private Date regDate;
	private Date updateDate;
	private int board_category_num;
	private int reply;
	private String pwd;
	private String product_num;
	private List<FileDTO> fileList;
}
