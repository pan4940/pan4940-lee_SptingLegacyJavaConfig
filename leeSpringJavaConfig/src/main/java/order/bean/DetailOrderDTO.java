package order.bean;


import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import product.bean.DetailProductDTO;

@Data
@Alias(value = "DetailOrderDTO")
public class DetailOrderDTO {
	private int detail_order_id;
	private String order_id;
	private int detail_product_id;
	private int product_price;
	private Date legDate; 
	private Date updateDate;
	
	private DetailProductDTO detailProductDTO;
}
