package com.example.demo.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.GumaeDto;
import com.example.demo.dto.ReviewDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class MemberController {
	@Autowired
	@Qualifier("ms")
	private MemberService service;
	
	@RequestMapping("/member/member")
	public String member() {
		return service.member();
	}
	@RequestMapping("/member/useridCheck")
	public @ResponseBody String useridCheck(HttpServletRequest request) {
		return service.useridCheck(request);
	}
	@RequestMapping("/member/memberOk")
	public String memberOk(MemberDto mdto) {
		return service.memberOk(mdto);
	}
	@GetMapping("/member/cartView")
	public String cartView(Model model,HttpServletRequest request,HttpSession session) {
		return service.cartView(model, request, session);
	}
	@GetMapping("/member/cartDel")
	public String cartDel(HttpServletRequest request, HttpSession session,HttpServletResponse response)
	{
		return service.cartDel(request,session,response);
	}
	
	@GetMapping("/member/chgSu")
	public @ResponseBody String chgSu(HttpServletRequest request,HttpSession session,HttpServletResponse response)
	{
		return service.chgSu(request,session,response);
	}
	@GetMapping("/member/jjimList")
	public String jjimList(HttpSession session,Model model) {
		return service.jjimList(session, model);
	}
	@GetMapping("/member/jjimDel")
	public String jjimDel(HttpServletRequest request,HttpSession session) {
		return service.jjimDel(request,session);
	}
	@GetMapping("/member/addCart")
	public @ResponseBody String addCart(HttpServletRequest request,HttpSession session) {
		return service.addCart(request, session);
	}
	@GetMapping("/member/jumunList")
	public String jumunList(HttpSession session,Model model,HttpServletRequest request) {
		return service.jumunList(session,model,request);
	}
	@GetMapping("/member/chgState")
	public String chgState(HttpSession session,GumaeDto gdto) {
		return service.chgState(session, gdto);
	}
	@GetMapping("/member/review")
	public String review(ReviewDto rdto,Model model) {
		return service.review(rdto,model);
	}
	@PostMapping("/member/reviewOk")
	public String reviewOk(HttpSession session,ReviewDto rdto) {
		return service.reviewOk(session, rdto);
	}
	@RequestMapping("/member/reviewDelete")
	public String reviewDelete(HttpServletRequest request,HttpSession session) {
		return service.reviewDelete(request, session);
	}
	@GetMapping("/member/reviewUpdate")
	public String reviewUpdate(HttpServletRequest request,HttpSession session,Model model) {
		return service.reviewUpdate(request, session,model);
	}
	@PostMapping("/member/reviewUpdateOk")
	public String reviewUpdateOk(ReviewDto rdto,HttpSession session,HttpServletRequest request) {
		return service.reviewUpdateOk(rdto, session,request);
	}
	@GetMapping("/member/memberInfo")
	public String memberInfo(HttpSession session,Model model) {
		return service.memberInfo(session, model);
	}
	@GetMapping("/member/chgEmail")
	public @ResponseBody String chgEmail(HttpServletRequest request,HttpSession session) {
		return service.chgEmail(request, session);
	}
	@PostMapping("/member/chgPhone")
	public String chgPhone(HttpServletRequest request,HttpSession session) {
		return service.chgPhone(request, session);
	}
	@PostMapping("/member/chgPwd")
	public String chgPwd(HttpServletRequest request,HttpSession session) {
		return service.chgPwd(request, session);
	}
	@GetMapping("/member/baesongList")
	public String baesongList(HttpSession session,Model model) {
		return service.baesongList(session, model);
	}
	@GetMapping("/member/baesongWrite")
	public String baesongWrite() {
		return "/member/baesongWrite";
	}
	@GetMapping("/member/reviewList")
	public String reviewList(HttpSession session,Model model) {
		return service.reviewList(session, model);
	}
	@GetMapping("/member/qnaList")
	public String qnaList(HttpSession session,Model model) {
		return service.qnaList(session, model);
	}
}
