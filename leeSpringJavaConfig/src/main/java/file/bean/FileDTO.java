package file.bean;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias(value = "FileDTO")
public class FileDTO {
	private int id;
	private String fileName;
	private String uploadPath;
	private String uuid;
	private int linked_num;
}
