package com.example.demo;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.WebUtils;

import com.example.demo.dto.DaeDto;
import com.example.demo.dto.JungDto;
import com.example.demo.dto.SoDto;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@RestController
public class CookieController {
	
	@Autowired
	private CookieMapper mapper;
	
	@RequestMapping("/firstCookie")
	public String firstCookie(HttpServletResponse response) {
		try {
			Cookie cookie=new Cookie("fcook","1");
			cookie.setMaxAge(30);
			cookie.setPath("/");
			response.addCookie(cookie);
			return "1";
		}
		catch(Exception e) {
			return "0";
		}
		 
	}
	@RequestMapping("/fcookOk")
	public String fcookOk(HttpServletRequest request) {
		Cookie cookie=WebUtils.getCookie(request, "fcook");
		if(cookie==null) {
			return "0";
		}
		else {
			return "1";
		}
	}
	@RequestMapping("/getDae")
	public ArrayList<DaeDto> getDae() {
		return mapper.getDae();
	}
	@RequestMapping("/getJung")
	public ArrayList<JungDto> getJung(int daecode){
		String dae=String.format("%02d", daecode);
		return mapper.getJung(dae);
	}
	@RequestMapping("/getSo")
	public ArrayList<SoDto> getSo(int daejung){
		String daejung2=String.format("%04d", daejung);
		return mapper.getSo(daejung2);
	}
	@RequestMapping("/getCartNum")
	public String getCartNum(HttpSession session,HttpServletRequest request) {
		if(session.getAttribute("userid")==null) {
			Cookie cookie=WebUtils.getCookie(request, "cart");
			if(cookie==null || cookie.getValue().equals("")) {
				return "0";
			}
			else {
				return cookie.getValue().split("/").length+"";
			}
			
		}
		else {
			String userid=session.getAttribute("userid").toString();
			return mapper.getCartNum(userid);
		}
	}
}
