package product.bean;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;

import file.bean.FileDTO;
import lombok.Data;


@Data
@Alias(value = "ProductDTO")
public class ProductDTO {
	private int product_num;
	private String product_name;
	private String brand_name;
	private int cateCode1;
	private int cateCode2;
	private int cateCode3;
	private int brandCategory;
	private int product_price;
	private String product_descrip;
	private Date legDate;
	private Date updateDate;
	
	private ProductSizeDTO productSizeDTO;
	
	
	
	private List<ProductSizeDTO> productSizeList;
	private List<FileDTO> fileList;
	
	
	//product, PRODUCT_CATEGORY_LINK, PRODUCTFILE
}
