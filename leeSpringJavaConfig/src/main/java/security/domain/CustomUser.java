package security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Getter;
import member.bean.MemberDTO;

@Getter
public class CustomUser implements UserDetails{
	
	private MemberDTO memberDTO;

	public CustomUser(MemberDTO member) {
		this.memberDTO = member;
		System.out.println("커스텀 생성");
		System.out.println(this.memberDTO);
	}
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return memberDTO.getMemberAuthList().stream().map(
				auth -> new SimpleGrantedAuthority(auth.getAuthority())).collect(Collectors.toList());
						
	}


	@Override
	public String getPassword() {
		return memberDTO.getMember_pwd();
	}


	@Override
	public String getUsername() {
		return memberDTO.getMember_id();
	}


	@Override
	public boolean isAccountNonExpired() {
		return true;
	}


	@Override
	public boolean isAccountNonLocked() {
		return true;
	}


	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}


	@Override
	public boolean isEnabled() {
		return true;
	}

	@Override
	public String toString() {
		return "CustomUser [memberDTO=" + memberDTO + "]";
	}
	
		
}
