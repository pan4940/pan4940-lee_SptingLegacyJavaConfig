package member.bean;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;
import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
@Alias(value = "MemberDTO")
public class MemberDTO {
	private String member_id;
	private String member_pwd;
	private String member_name;
	
	private String email;
	private String email_check;
	private Date joinDate;
	private Date updateDate;
	private int mileage;
	
	private String tel1;
	private String tel2;
	private String tel3;
	private String phone1;
	private String phone2;
	private String phone3;
	
	public String getTotalTel() {
		return tel1 + tel2 + tel3;
	}
	
	public String getTotalPhone() {
		return phone1 + phone2 + phone3;
	}
	
	private List<MemberAddressDTO> addressDTOList;
	private List<MemberAuthDTO> memberAuthList;
	
	
	
}
