package board.bean;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
public class BoardCriteria {
	private int pageNum;
	private int amount;
	
	public BoardCriteria() {
		this(1, 10);
	}

	public BoardCriteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
}
