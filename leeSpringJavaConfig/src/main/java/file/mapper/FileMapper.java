package file.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import file.bean.FileDTO;


@Mapper
public interface FileMapper {
	
	public void boardFileInsert(FileDTO fileDTO);
	
	public void boardFileDelete(String uuid);
	
	public void boardFileDeleteAll(int Board_Num);
	
	public List<FileDTO> findByBoardNum(int board_Num);

	
	public void productFileInsert(FileDTO t);

	public List<FileDTO> findByProductNum(int product_num);

	public void productFileDeleteAll(int product_num);

	public void brandFileInsert(FileDTO t);

	public List<FileDTO> findByBrandNum(int product_category_num);

	public void brandFileDeleteAll(int product_category_num);

	
}
