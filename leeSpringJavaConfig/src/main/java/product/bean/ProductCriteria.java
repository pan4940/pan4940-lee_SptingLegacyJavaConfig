package product.bean;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
public class ProductCriteria {
	private int pageNum;
	private int amount;
	
	public ProductCriteria() {
		this(1, 24);
	}

	public ProductCriteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
}
