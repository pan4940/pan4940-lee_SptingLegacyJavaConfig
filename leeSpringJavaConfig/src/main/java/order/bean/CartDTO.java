package order.bean;

import org.apache.ibatis.type.Alias;
import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Data;

@Component
@Data
@Alias(value = "CartDTO")
public class CartDTO {
	private String member_id;
	private int detail_product_id;
}
