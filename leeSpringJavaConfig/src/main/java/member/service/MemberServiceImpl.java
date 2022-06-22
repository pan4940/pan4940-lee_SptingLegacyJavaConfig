package member.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import member.bean.MemberAddressDTO;
import member.bean.MemberAuthDTO;
import member.bean.MemberDTO;
import member.controller.MyAuthentication;
import member.mapper.MemberMapper;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Override
	public MemberDTO getMemberDtoByMemberId(String member_id) {
		return memberMapper.getMemberDtoByMemberId(member_id);
	}
	
	
	
	@Override
	@Transactional(rollbackFor = {Exception.class})
	public void join(MemberDTO memberDTO) {
		memberMapper.join(memberDTO);
		//주소 등록
		List<MemberAddressDTO> addressDTOs = memberDTO.getAddressDTOList();
		insertAddress(addressDTOs.get(0));
		
		//auth 관련 등록
		List<MemberAuthDTO> list = new ArrayList<>();
		list.add(0, new MemberAuthDTO(memberDTO.getMember_id(), "ROLE_MEMBER"));
		for (MemberAuthDTO memberAuthDTO : list) {
			memberMapper.authRegister(memberAuthDTO);
		}
	}
	
	@Override
	public void insertAddress(MemberAddressDTO memberAddressDTO) {
		memberMapper.insertAddress(memberAddressDTO);
	}
	
	@Override
	public void insertDefaultAddress(MemberAddressDTO memberAddressDTO) {
		memberMapper.insertDefaultAddress(memberAddressDTO);
	}
	
	@Override
	public void socialJoin(MemberDTO memberDTO) {
		System.out.println("input joinMemberDTO : "  + memberDTO);
		
		memberDTO.setEmail_check("1");
		memberDTO.setMileage(2000);
		System.out.println("output joinMemberDTO : "  + memberDTO);
		memberMapper.join(memberDTO);
	}
	
	@Override
	public void modifyOK(MemberDTO memberDTO) {
		memberMapper.modifyOK(memberDTO);
	}
	
	@Override
	public MemberDTO findIdEmail(Map<String, String> map) {
		return memberMapper.findIdEmail(map);
	}
	
	@Override
	public MemberDTO findIdPhone(Map<String, String> map) {
		return memberMapper.findIdPhone(map);
	}
	
	@Override
	public MemberDTO findPwdByEmail(Map<String, String> map) {
		return memberMapper.findPwdByEmail(map);
	}
	
	@Override
	public MemberDTO findPwdByPhone(Map<String, String> map) {
		return memberMapper.findPwdByPhone(map);
	}
	
	@Override
	public MemberDTO findMemberByID(String member_id) {
		return memberMapper.findMemberByID(member_id);
	}
	
	@Override
	public void updatePwdAndRank(MemberDTO memberDTO) {
		memberMapper.updatePwdAndRank(memberDTO);
	}
	
	@Override
	public void tempPwdByEmail(HttpSession httpSession, String member_id) {
		MemberDTO memberDTO = findMemberByID(member_id);
		
		// 임시 비밀번호 생성
		String pw = "";
		for (int i = 0; i < 12; i++) {
			pw += (char) ((Math.random() * 26) + 97);
		}
		// 비밀번호 변경
		memberDTO.setMember_pwd(pw);
		//비밀번호 + 회원 등급 변경 
		updatePwdAndRank(memberDTO);
		// 비밀번호 변경 메일 발송
		try {
			//sendEmail(memberDTO, "findpw");
			sendEmail(memberDTO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		httpSession.setAttribute("memId", memberDTO.getMember_id());
		httpSession.setAttribute("memKeyword", memberDTO.getEmail());
	}
	
	//메일 보내기
	public void sendEmail(MemberDTO memberDTO) throws Exception {
		Properties p = System.getProperties();
		p.put("mail.smtp.starttls.enable", "true");
        p.put("mail.smtp.host", "smtp.naver.com");
        p.put("mail.smtp.auth", "true");
        p.put("mail.smtp.port", "587");
        p.put("mail.smtp.ssl.protocols", "TLSv1.2");
        //메일 보낼 계정 설정
        Authenticator auth = new MyAuthentication();
        Session session = Session.getInstance(p, auth);
        MimeMessage msg = new MimeMessage(session);
        
        try {
            msg.setSentDate(new Date());
            InternetAddress from = new InternetAddress();
            
            from = new InternetAddress("theCShop<smart4940@naver.com>");
            msg.setFrom(from);
 
            InternetAddress to = new InternetAddress(memberDTO.getEmail());
            msg.setRecipient(javax.mail.Message.RecipientType.TO, to);
 
            msg.setSubject("[the C shop]"+memberDTO.getMember_id()+"님 임시비밀번호가 전송되었습니다.", "UTF-8");
            msg.setText("안녕하세요 the C shop입니다<br>"+
            		memberDTO.getMember_name()+"님 저희 쇼핑몰을 이용해 주셔서 감사합니다<br>"+
            		" 회원님("+memberDTO.getMember_id()+")의 임시비밀번호는 : "+memberDTO.getMember_pwd()+"입니다", "UTF-8");
            msg.setHeader("content-Type", "text/html");
 
            javax.mail.Transport.send(msg);
        } catch (AddressException addr_e){
            addr_e.printStackTrace();
        } catch (MessagingException msg_e){
            msg_e.printStackTrace();
        }
	}
	
	
	@Override
	public void tempPwdByPhone(HttpSession httpSession, String member_id) {
		MemberDTO memberDTO = findMemberByID(member_id);
		String numStr = "";
        for (int i = 0; i < 12; i++) {
			numStr += (char) ((Math.random() * 26) + 97);
		}
        System.out.println("수신자 번호 : " + memberDTO.getTotalPhone());
        System.out.println("인증번호 : " + numStr);
        String api_key = "NCSONFLLAZ74EJQU";
    	String api_secret = "59MPAP18UQNTCN8KLHYVTSJKSZLXI8XI";
    	Message coolsms = new Message(api_key, api_secret);

    	// 4 params(to, from, type, text) are mandatory. must be filled
    	HashMap<String, String> params = new HashMap<String, String>();
    	System.out.println("findMemberByID memberDTO : " + memberDTO);
    	params.put("to", memberDTO.getTotalPhone()); // 수신전화번호
    	params.put("from", "01091073930"); // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
    	params.put("type", "SMS");
    	params.put("text", "the C shop : 임시 비밀번호는" + "[" + numStr + "]" + "입니다.");
    	params.put("app_version", "test app 1.2"); // application name and version

		memberDTO.setMember_pwd(numStr);
		updatePwdAndRank(memberDTO);
    	try {
    		JSONObject obj = (JSONObject) coolsms.send(params);
    		System.out.println(obj.toString());
    	} catch (CoolsmsException e) {
    		System.out.println(e.getMessage());
    		System.out.println(e.getCode());
    	}
	}
	
	@Override
	public List<MemberDTO> getMemberListByMemberIdAndMemberName(Map<String, String> map) {
		List<MemberDTO> list = memberMapper.getMemberListByMemberIdAndMemberName(map);
		System.out.println(list);
		return list;
	}
	
	
	@Override
	public void memberGradeUpdate(Map<String, String> map) {
		memberMapper.memberGradeUpdate(map);
	}
	
	@Override
	public MemberDTO socialLogin(String socialId) {
		return memberMapper.socialLogin(socialId);
	}
	
	
	@Override
	public MemberDTO getMemberByMemberIdAndMemberName(Map<String, String> map) {
		return memberMapper.getMemberByMemberIdAndMemberName(map);
	}
	
	@Override
	public void memberAuthUpdate(Map<String, String> map) {
		memberMapper.memberAuthUpdate(map);
	}
	
	@Override
	public void deleteMember(String member_id) {
		memberMapper.deleteMember(member_id);
	}
	
	@Override
	public MemberAddressDTO getEditAddress(String address_id) {
		return memberMapper.getEditAddress(address_id);
	}
	
	@Override
	public void defaultAddressModify(MemberAddressDTO memberAddressDTO) {
		memberMapper.defaultAddressModify(memberAddressDTO);
	}
	
	@Override
	public void addressModify(MemberAddressDTO memberAddressDTO) {
		memberMapper.addressModify(memberAddressDTO);
	}
	
	@Override
	public List<MemberAddressDTO> getAddressListByMemberID(String member_id) {
		return memberMapper.getAddressListByMemberID(member_id);
	}
	
	@Override
	public void modifyOrdersOfAddress(MemberAddressDTO memberAddressDTO) {
		memberMapper.modifyOrdersOfAddress(memberAddressDTO);
	}
	
	@Override
	public void deleteAddressDTO(String address_id) {
		memberMapper.deleteAddressDTO(address_id);
	}
}
