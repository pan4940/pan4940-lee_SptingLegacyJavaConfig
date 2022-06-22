package product.bean;

import java.util.List;

import org.apache.ibatis.type.Alias;

import file.bean.FileDTO;
import lombok.Data;


@Data
@Alias(value = "ProductCategoryDTO")
public class ProductCategoryDTO {
	
	private int product_category_num;
	private String product_category_name;
	private int product_category_num_ref;
	private String product_category_descrip;
	private int level;
	
	private List<ProductCategoryDTO> productCategoryList;
	private List<FileDTO> fileList;
	
}
