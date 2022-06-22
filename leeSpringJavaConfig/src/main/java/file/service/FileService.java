package file.service;

import java.util.List;

import file.bean.FileDTO;


public interface FileService {
	public void boardFileInsert(FileDTO fileDTO);
	
	public void boardFileDelete(String uuid);
	
	public void boardFileDeleteAll(int Board_Num);
	
	public List<FileDTO> findByBoardNum(int Board_Num);
}
