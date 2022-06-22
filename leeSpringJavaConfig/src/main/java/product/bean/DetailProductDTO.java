package product.bean;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;

import com.fasterxml.jackson.annotation.JsonFormat;

import file.bean.FileDTO;
import lombok.Data;


@Data
@Alias(value = "DetailProductDTO")
public class DetailProductDTO {
	private int detail_product_id;
	private int product_num;
	private int product_size_id;
	/* 주문 상태 1이면 주문가능. 0이면 주문 불가  */
	private int status;
	@JsonFormat(pattern = "yyyy/MM/dd")
	private Date legDate;
	private Date updateDate;
	private int addProductsAmount;
	//product, PRODUCT_CATEGORY_LINK, PRODUCTFILE
}
