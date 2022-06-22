package member.bean;

import org.apache.ibatis.type.Alias;
import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Data;

@Component
@Data
@AllArgsConstructor
@Alias(value = "MemberAddressDTO")
public class MemberAddressDTO {
	private String address_id;
	private String member_id;
	private String zipcode;
	private String addr1;
	private String addr2;
	private String orders;
	
	public MemberAddressDTO() {}
	
	
}
