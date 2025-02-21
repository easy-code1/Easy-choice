package com.example.demo.login;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.util.WebUtils;

import com.example.demo.MailSend;
import com.example.demo.member.MemberDto;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Service
@Qualifier("ls")
public class LoginServiceImpl implements LoginService{

	@Autowired
	private LoginMapper mapper;
	
	@Override
	public String login(Model model,HttpServletRequest request) {
		model.addAttribute("err",request.getParameter("err"));
		model.addAttribute("pcode",request.getParameter("pcode"));
		model.addAttribute("su",request.getParameter("su"));
		model.addAttribute("cart",request.getParameter("cart"));
		return "/login/login";
	}

	@Override
	public String loginOk(MemberDto mdto,HttpSession session,HttpServletRequest request,HttpServletResponse response) {
		String name=mapper.loginOk(mdto);
		if(name==null) {
			return "redirect:/login/login?err=1";
		}
		else {
			session.setAttribute("name", name);
			session.setAttribute("userid", mdto.getUserid());
			
			Cookie cookie=WebUtils.getCookie(request, "cart");
			if(cookie!=null && !cookie.getValue().equals("")) {
				String cart=cookie.getValue();
				String[] carts=cart.split("/");
				for(int i=0;i<carts.length;i++) {
					String[] imsi=carts[i].split("-");
					if(mapper.isCart(mdto.getUserid(), imsi[0])) {
						mapper.upCart(mdto.getUserid(), imsi[0], imsi[1]);
					}
					else {
						mapper.addCart(mdto.getUserid(), imsi[0], imsi[1]);
					}
					
				}
				cookie=new Cookie("cart","");
				cookie.setMaxAge(0);
				cookie.setPath("/");
				response.addCookie(cookie);
				
			}
			
			String pcode=request.getParameter("pcode");
			String su=request.getParameter("su");
			if(pcode.equals("")) {
				if(request.getParameter("cart")==null) {
					return "redirect:/main/main";
				}
				else {
					return "redirect:/member/cartView";
				}
			}
			else {
				if(su==null) {
					return "redirect:/product/productContent?pcode="+pcode;
				}
				else {
					return "redirect:/product/productGumae?pcode="+pcode+"&su="+su;
				}
				
			}
			
		}
		
		
	}

	@Override
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/main/main";
	}

	@Override
	public String getUserid(MemberDto mdto) {
		String userid=mapper.getUserid(mdto);
		return userid;
	}

	@Override
	public String getPwd(MemberDto mdto) throws Exception{
		String pwd=mapper.getPwd(mdto);
		if(pwd!=null) {
			/*
			MailSend ms=MailSend.getInstance();
			String title=mdto.getUserid()+"님의 비밀번호를 보내드립니다";
			String content="당신의 비밀번호는 "+pwd+" 입니다";
			ms.setEmail(mdto.getEmail(), title, content, "네이버비밀번호");
			return "비밀번호를 "+mdto.getEmail()+"에 보냈습니다";
			*/
			String imsiPwd="";
			
			/*for(int i=0;i<6;i++) { //특수문자 제외
				int num=(int)(Math.random()*62);
				if(num<26) {
					num+=65;
				}
				else if(num<52) {
					num+=71;
				}
				else {
					num-=4;
				}
				imsiPwd+=(char)num;
			}*/
			
			for(int i=0;i<6;i++) { //특수문자 포함
				int num=(int)(Math.random()*90);
				num+=33;
				imsiPwd+=(char)num;
			}
			
			mapper.chgPwd(mdto.getUserid(), imsiPwd);
			return "임시 비밀번호: "+imsiPwd;
		}
		else {
			return "정보가 일치하지 않습니다";
		}
		
	}
	
}
