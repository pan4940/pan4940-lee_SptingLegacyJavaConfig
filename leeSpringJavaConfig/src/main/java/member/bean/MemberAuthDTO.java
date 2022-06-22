package member.bean;

import org.apache.ibatis.type.Alias;
import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Data;

@Component
@Data
@AllArgsConstructor
@Alias(value = "MemberAuthDTO")
public class MemberAuthDTO {
	private String member_id;
	private String authority;
	
	public MemberAuthDTO() {
	}
}
