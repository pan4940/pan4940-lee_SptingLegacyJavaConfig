package member.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import member.bean.MemberAddressDTO;
import member.bean.MemberDTO;

public interface MemberService {
	
	//회원가입시 아이디 중복체크. 로그인시 CustomUserDetailsService
	public MemberDTO getMemberDtoByMemberId(String member_id);
	
	//회원가입
	public void join(MemberDTO memberDTO);

	public void modifyOK(MemberDTO memberDTO);

	public MemberDTO findIdEmail(Map<String, String> map);

	public MemberDTO findIdPhone(Map<String, String> map);

	public MemberDTO findPwdByEmail(Map<String, String> map);

	public MemberDTO findPwdByPhone(Map<String, String> map);

	public MemberDTO findMemberByID(String member_id);

	public void tempPwdByEmail(HttpSession httpSession, String member_id);

	public void updatePwdAndRank(MemberDTO memberDTO);

	public void tempPwdByPhone(HttpSession httpSession, String member_id);

	public List<MemberDTO> getMemberListByMemberIdAndMemberName(Map<String, String> map);

	public void memberGradeUpdate(Map<String, String> map);

	public MemberDTO socialLogin(String kakaoId);

	public void socialJoin(MemberDTO memberDTO);

	public MemberDTO getMemberByMemberIdAndMemberName(Map<String, String> map);

	public void memberAuthUpdate(Map<String, String> map);

	public void deleteMember(String member_id);

	public MemberAddressDTO getEditAddress(String address_id);

	public void defaultAddressModify(MemberAddressDTO memberAddressDTO);

	public void addressModify(MemberAddressDTO memberAddressDTO);
	
	public void insertAddress(MemberAddressDTO memberAddressDTO);

	public void insertDefaultAddress(MemberAddressDTO memberAddressDTO);

	public List<MemberAddressDTO> getAddressListByMemberID(String member_id);

	public void modifyOrdersOfAddress(MemberAddressDTO memberAddressDTO);

	public void deleteAddressDTO(String address_id);

}
