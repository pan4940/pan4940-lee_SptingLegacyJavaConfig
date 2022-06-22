package product.bean;

import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias(value = "ProductSizeDTO")
public class ProductSizeDTO {
	
	private int product_size_id;
	
	//상의
	private String product_size; //사이즈명 모든 품목이 사용한다. 
	private String product_top_length;	//상의 기장
	private String product_shoulder;	// 어깨
	private String product_chest;		//가슴 
	private String product_sleeve;		//소매
	
	//하의
	private String product_waist_width; //
	private String product_thigh_width;
	private String product_bottom_length;
	private String product_ankle_circumference;
	private String product_front_rise;
	
	
	//모자
	private String product_cap_length;
	private String product_cap_circumference;
	private String product_cap_depth;
	
	
	//상의 하의 모자 외에는 다 os로 표기
	private int product_num;
	
	private DetailProductDTO detailProductDTO;
	private List<DetailProductDTO> detailProductDTOList;
	
}
