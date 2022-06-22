package member.mapper;

import java.util.List;
import java.util.Map;


import member.bean.MemberAddressDTO;
import member.bean.MemberAuthDTO;
import member.bean.MemberDTO;

public interface MemberMapper {

	public MemberDTO getMemberDtoByMemberId(String member_id);

	public void join(MemberDTO memberDTO);

	public void modifyOK(MemberDTO memberDTO);

	public MemberDTO findIdEmail(Map<String, String> map);

	public MemberDTO findIdPhone(Map<String, String> map);

	public MemberDTO findPwdByEmail(Map<String, String> map);

	public MemberDTO findPwdByPhone(Map<String, String> map);

	public MemberDTO findMemberByID(String member_id);

	public void updatePwdAndRank(MemberDTO memberDTO);

	public List<MemberDTO> getMemberListByMemberIdAndMemberName(Map<String, String> map);

	public void memberGradeUpdate(Map<String, String> map);

	public MemberDTO socialLogin(String kakaoId);

	public void authRegister(MemberAuthDTO memberAuthDTO);

	public void insertAddress(MemberAddressDTO memberAddressDTO);

	public MemberDTO getMemberByMemberIdAndMemberName(Map<String, String> map);

	public void memberAuthUpdate(Map<String, String> map);

	public void deleteMember(String member_id);

	public MemberAddressDTO getEditAddress(String address_id);

	public void defaultAddressModify(MemberAddressDTO memberAddressDTO);

	public void addressModify(MemberAddressDTO memberAddressDTO);

	public void insertDefaultAddress(MemberAddressDTO memberAddressDTO);

	public List<MemberAddressDTO> getAddressListByMemberID(String member_id);

	public void modifyOrdersOfAddress(MemberAddressDTO memberAddressDTO);

	public void deleteAddressDTO(String address_id);

	

}
