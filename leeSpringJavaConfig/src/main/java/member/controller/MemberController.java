package member.controller;

import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.log4j.Log4j2;
import member.bean.MemberAddressDTO;
import member.bean.MemberAuthDTO;
import member.bean.MemberDTO;
import member.service.MemberService;
import security.domain.CustomUser;

@Controller
@Log4j2
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private MemberService memberService; 
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	//로그인
	@GetMapping("/login")
	public String loginForm(String error, String logout, Model model) {
		log.info("error : " + error);
		log.info("logout : " + logout);
		
		if (error != null) {
			model.addAttribute("error", "로그인 에러. 아이디와 비밀번호를 확인해주세요.");
		}
		
		if (logout != null) {
			model.addAttribute("logout", "logout!!");
		}
		
		model.addAttribute("display", "/WEB-INF/views/member/login.jsp");
		return "index";
	}
	
	
	@PostMapping("/socialLoginOk")
	@ResponseBody
	public String socialLogin(HttpSession httpSession, @RequestParam("member_id") String socialId) throws Exception{
		System.out.println(socialId);
		MemberDTO memberDTO = memberService.socialLogin(socialId);
		if (memberDTO != null) {
			httpSession.setAttribute("memberDTO", memberDTO);
			return "ok";
		} else {
			return "fail";
		}
	}
	
	
	@PostMapping("/loginOK")
	public void loginOK(@RequestParam Map<String, String> map) {
		System.out.println("login map : " + map);
	}
	
	//로그아웃
	@PostMapping("/logout")
	public void logout(HttpSession httpSession) {
		log.info("custom logout");
	}
	
	
	
	
	//회원가입
	@GetMapping("/joinForm")
	public String joinMemberForm(Model model) {
		model.addAttribute("display", "/WEB-INF/views/member/join.jsp");
		return "index";
	}
	
	
	@PostMapping("/join")
	public void join(@ModelAttribute MemberDTO memberDTO, @RequestParam String _csrf, Model model) {
		memberDTO.setMember_pwd(passwordEncoder.encode(memberDTO.getMember_pwd()));
		System.out.println("after joinMemberDTO : "  + memberDTO);
		memberService.join(memberDTO);
		model.addAttribute("display", "/WEB-INF/views/member/join.jsp");
	}
	
	
	//회원가입
	@GetMapping("/admin")
	public String admin(Model model) {
		model.addAttribute("display", "/WEB-INF/views/member/admin.jsp");
		return "index";
	}
	
	
	//소셜 로그인후 정보로 회원가입
	@PostMapping("/socialJoin")
	@ResponseBody
	public void socialJoin(@ModelAttribute MemberDTO memberDTO, Model model) {
		memberService.socialJoin(memberDTO);
		System.out.println(memberDTO);
		log.info(memberDTO);
	}
	
	
	
	
	
	//회원가입시 아이디 중복체크
	@PostMapping("/checkId")
	@ResponseBody
	public String checkId(@RequestParam Map<String, String> map) {
		System.out.println("map : " + map);
		String member_id = map.get("member_id");
		System.out.println("check member_id : " + member_id);
		MemberDTO memberDTO = memberService.getMemberDtoByMemberId(member_id);
		
		if (memberDTO != null) {
			return "exist";
		} else {
			return "non_exist";
		}
	}
	
	
	
	//회원정보 페이지
	@GetMapping("/account")
	public String account(Model model) {
		model.addAttribute("display", "/WEB-INF/views/member/account.jsp");
		return "index";
	}
	
	
	//회원정보수정
	@GetMapping("/modifyForm")
	public String modifyMemberForm(Model model) {
		model.addAttribute("display", "/WEB-INF/views/member/modify.jsp");
		return "index";
	}
	
	@PostMapping("/modifyOk")
	@ResponseBody
	public void modifyOK(@ModelAttribute MemberDTO memberDTO) {
		System.out.println("modify memberDTO : " + memberDTO);
		memberService.modifyOK(memberDTO);
	}
	
	//회원탈퇴
	public void deleteMember() {
		
	}
	
	
	
	//아이디 찾기
	@GetMapping("/findIdForm")
	public String findId(Model model) {
		model.addAttribute("display", "/WEB-INF/views/member/findId.jsp");
		return "index";
	}
	//이메일로 아이디 찾기
	@PostMapping("/findIdEmail")
	@ResponseBody
	public String findIdEmail(HttpSession httpSession, @RequestParam Map<String, String> map) {
		System.out.println("findIdEmail : " + map);
		MemberDTO memberDTO = memberService.findIdEmail(map);
		
		if (memberDTO != null) {
			httpSession.setAttribute("memId", memberDTO.getMember_id());
			httpSession.setAttribute("memName", memberDTO.getMember_name());
			httpSession.setAttribute("memOption", "Email");
			httpSession.setAttribute("memKeyword", memberDTO.getEmail());
			
			httpSession.setAttribute("memSys", memberDTO.getJoinDate());
			
			//httpSession.setAttribute("memRank", memberDTO.getRank_num());
			return "emailok";
		} else {
			return "emailfail";
		}
	}
	
	//핸드폰 번호로 아이디 찾기
	@PostMapping("/findIdPhone")
	@ResponseBody
	public String findIdPhone(HttpSession httpSession, @RequestParam Map<String, String> map) {
		System.out.println("findIdPhone : " + map);
		MemberDTO memberDTO = memberService.findIdPhone(map);
		
		if (memberDTO != null) {
			httpSession.setAttribute("memId", memberDTO.getMember_id());
			httpSession.setAttribute("memName", memberDTO.getMember_name());
			httpSession.setAttribute("memOption", "휴대폰번호");
			httpSession.setAttribute("memKeyword", memberDTO.getTotalPhone());
			httpSession.setAttribute("memSys", memberDTO.getJoinDate());
			//httpSession.setAttribute("memRank", memberDTO.getRank_num());
			
			return "phoneok";
		} else {
			return "phonefail";
		}
	}
	
	
	//아이디 찾기 결과
	@GetMapping("/findIdResult")
	public String findIdResult(Model model) {
		model.addAttribute("display", "/WEB-INF/views/member/findIdResult.jsp");
		return "index";
	}
	
	
	//비밀번호 찾기
	@GetMapping("/findPwdForm")
	public String findPwd(Model model) {
		model.addAttribute("display", "/WEB-INF/views/member/findPwd.jsp");
		return "index";
	}
	
	//ID, 이름, email로 비밀번호 찾기
	@PostMapping("/findPwdByEmail")
	@ResponseBody
	public String findPwdByEmail(HttpSession httpSession, @RequestParam Map<String, String> map) {
		System.out.println("findPwdByEmail : " + map);
		MemberDTO memberDTO = memberService.findPwdByEmail(map);
		System.out.println("findPwdByEmail memberDTO : " + memberDTO);
		
		if (memberDTO != null) {
			httpSession.setAttribute("memId", memberDTO.getMember_id());
			httpSession.setAttribute("memName", memberDTO.getMember_name());
			httpSession.setAttribute("memOption", "Email");
			httpSession.setAttribute("memKeyword", memberDTO.getEmail());
			return "emailok";
		} else {
			return "emailfail";
		}
	}
	
	//e메일로 임시비밀번호 전송
	@PostMapping("/tempPwdByEmail")
	@ResponseBody
	public void tempPwdByEmail(HttpSession httpSession, @RequestParam String member_id) {
		System.out.println("tempPwdByEmail : " + member_id);
		
		memberService.tempPwdByEmail(httpSession, member_id);
		
	}
	//임시비밀번호 전송후 페이지이동
	@GetMapping("/tempAlert")
	public String tempalert(Model model) {
		model.addAttribute("display", "/WEB-INF/views/member/tempAlert.jsp");
		return "index";
	}
	
	
	//ID, 이름, phone으로 비밀번호 찾기
	@PostMapping("/findPwdByPhone")
	@ResponseBody
	public String findPwdByPhone(HttpSession httpSession, @RequestParam Map<String, String> map) {
		System.out.println("findPwdByPhone : " + map);
		MemberDTO memberDTO = memberService.findPwdByPhone(map);
		
		if (memberDTO != null) {
			httpSession.setAttribute("memId", memberDTO.getMember_id());
			httpSession.setAttribute("memName", memberDTO.getMember_name());
			httpSession.setAttribute("memOption", "Phone");
			httpSession.setAttribute("memKeyword", memberDTO.getTotalPhone());
			return "phoneok";
		} else {
			return "phonefail";
		}
	}
	//휴대폰번호로 임시비밀번호 전송
	@PostMapping("/tempPwdByPhone")
	@ResponseBody
	public void tempPwdByPhone(HttpSession httpSession, @RequestParam String member_id) {
		System.out.println("tempPwdByPhone : " + member_id);
		memberService.tempPwdByPhone(httpSession, member_id);
		
	}
	
	
	//비밀번호 찾기 결과
	@GetMapping("/findPwdResult")
	public String findPwdResult(Model model) {
		model.addAttribute("display", "/WEB-INF/views/member/findPwdResult.jsp");
		return "index";
	}
	
	
	
	//member 관리 페이지 이동
	@GetMapping("/management")
	public String management() {
		return "/member/management";
	}
	
	
	//관리자 모드에서 사용. id와 이름으로 회원list 찾기. like 검색
	@PostMapping("/getMemberListByMemberIdAndMemberName")
	@ResponseBody
	public List<MemberDTO> getMemberListByMemberIdAndMemberName(@RequestParam Map<String, String> map) {
		System.out.println(map);
		return memberService.getMemberListByMemberIdAndMemberName(map);
	}
	
	
	//관리자 모드에서 사용. id와 이름으로 memberDTO찾기. 
	@PostMapping("/getMemberByMemberIdAndMemberName")
	@ResponseBody
	public MemberDTO getMemberByMemberIdAndMemberName(@RequestParam Map<String, String> map) {
		System.out.println(map);
		return memberService.getMemberByMemberIdAndMemberName(map);
	}
	
	
	//맴버 등급 정보 가져오기
	/*
	@PostMapping("/getRankNum")
	@ResponseBody
	public List<MemberAuthDTO> getRankNum() {
		return memberService.getRankNum();
	}
	*/
	//관리자모드에서 사용. 멤버 등급 조정
	
	@PostMapping("/memberGradeUpdate")
	public void memberGradeUpdate(@RequestParam Map<String, String> map) {
		System.out.println(map);
		memberService.memberGradeUpdate(map);
	}
	
	
	@GetMapping("/shipping")
	public String shipping(Model model) {
		model.addAttribute("display", "/WEB-INF/views/member/shipping.jsp");
		return "index";
	}
	
	@GetMapping("/privacy")
	public String privacy(Model model) {
		model.addAttribute("display", "/WEB-INF/views/member/privacy.jsp");
		return "index";
	}
	
	@GetMapping("/term")
	public String term(Model model) {
		model.addAttribute("display", "/WEB-INF/views/member/term.jsp");
		return "index";
	}
	
	@GetMapping("/about")
	public String about(Model model) {
		model.addAttribute("display", "/WEB-INF/views/member/about.jsp");
		return "index";
	}
	
	@GetMapping("/store")
	public String store(Model model) {
		model.addAttribute("display", "/WEB-INF/views/member/store.jsp");
		return "index";
	}
	
	
	
	@PostMapping("/memberAuthUpdate")
	@ResponseBody
	public void memberAuthUpdate(@RequestParam Map<String, String> map) {
		
		memberService.memberAuthUpdate(map);
	}
	
	@PostMapping("/deleteMember")
	@ResponseBody
	public void deleteMember(@RequestParam String member_id) {
		
		memberService.deleteMember(member_id);
	}
	
	@GetMapping("/addresses")
	public String addresses(Authentication auth, Model model) {
		CustomUser customUser= (CustomUser)auth.getPrincipal();
		model.addAttribute("memberDTO", memberService.getMemberDtoByMemberId(customUser.getMemberDTO().getMember_id()));
		model.addAttribute("display", "/WEB-INF/views/member/address.jsp");
		return "index";
	}
	
	
	
	@GetMapping("/addressEdit")
	public String addressEdit(@RequestParam String address_id, Model model) {
		System.out.println(address_id);
		model.addAttribute("address_id", address_id);
		model.addAttribute("display", "/WEB-INF/views/member/addressEdit.jsp");
		return "index";
	}
	
	
	@PostMapping("/addressModify")
	@ResponseBody
	public void addressModify(@ModelAttribute MemberAddressDTO memberAddressDTO, @RequestParam(value = "defaultAddr", required = false) String defaultAddr) {
		System.out.println(memberAddressDTO);
		System.out.println(defaultAddr);
		if (defaultAddr != null) {
			memberService.defaultAddressModify(memberAddressDTO);
		} else {
			memberService.addressModify(memberAddressDTO);
		}
	}
	
	@PostMapping("/getEditAddress")
	@ResponseBody
	public MemberAddressDTO getEditAddress(@RequestParam String address_id) {
		return memberService.getEditAddress(address_id);
	}

	
	@GetMapping("/addNewAddress")
	public String addressNew(Model model) {
		model.addAttribute("display", "/WEB-INF/views/member/addNewAddress.jsp");
		return "index";
	}
	
	@PostMapping("/addNewAddress")
	@ResponseBody
	public void addNewAddress(@ModelAttribute MemberAddressDTO memberAddressDTO, @RequestParam(value = "defaultAddr", required = false) String defaultAddr) {
		System.out.println(memberAddressDTO);
		System.out.println(defaultAddr);
		
		if (defaultAddr != null) {
			memberService.insertDefaultAddress(memberAddressDTO);
		} else {
			memberService.insertAddress(memberAddressDTO);
		}
	}
	
	
	@PostMapping("/deleteAddress")
	@ResponseBody
	public void deleteAddress(Authentication auth ,@RequestParam String[] deleteAddress) {
		for (String address_id : deleteAddress) {
			System.out.println(address_id);
			memberService.deleteAddressDTO(address_id);
		}
		
		CustomUser customUser= (CustomUser)auth.getPrincipal();
		
		List<MemberAddressDTO> list = memberService.getAddressListByMemberID(customUser.getMemberDTO().getMember_id());
	
		
		for (int i = 1; i <= list.size(); i++) {
			MemberAddressDTO memberAddressDTO = list.get(i - 1);
			memberAddressDTO.setOrders(i+"");
			memberService.modifyOrdersOfAddress(memberAddressDTO);
		}
	}
	
}
