package board.bean;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
@Alias("ReplyDTO")
public class BoardReplyDTO {
	private int reply_num;
	private int board_num;
	private String replyer;
	private String content;
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private Date replyDate;
	private Date updateDate;
}
