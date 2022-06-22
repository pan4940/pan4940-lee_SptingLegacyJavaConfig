package order.bean;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;
import member.bean.MemberDTO;

@Component
@Data
@Alias(value = "OrderDTO")
public class OrderDTO {
	/* 주문 번호 */
	private String order_id;
	
	/* 주문 회원 아이디 */
	private String member_id;
	
	//주소정보는 회원이 언제던지 변경할 수 있으므로 별로도 저장 필요
	private String zipcode;
	private String addr1;
	private String addr2;
	private String tel1;
	private String tel2;
	private String tel3;
	private String phone1;
	private String phone2;
	private String phone3;
	
	/* 주문 상태 입급 대기중 입금확인 물건 발송 환불 */
	private String status;
	
	/* 배송비 */
	private String deliveryCost;
	
	/* 주문 날짜 */
	@JsonFormat(pattern = "yyyy/MM/dd")
	private Date legDate;
	@JsonFormat(pattern = "yyyy/MM/dd")
	private Date updateDate;
	
	//주문시 남기는 메세지
	private String message;
	
	
	
	/* DB에 저장되지 않는 데이터 */
	
	private MemberDTO memberDTO;
	private int totalPrice;
	private List<DetailOrderDTO> detailOrderDTOList;
	
}
