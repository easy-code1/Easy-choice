package com.example.demo.product;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.WebUtils;

import com.example.demo.dto.BaesongDto;
import com.example.demo.dto.CartDto;
import com.example.demo.dto.GumaeDto;
import com.example.demo.dto.QnaDto;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class ProductController {
	@Autowired
	@Qualifier("ps")
	private ProductService service;
	
	@GetMapping("/product/productList")
	public String productList(HttpServletRequest request,Model model) {
		return service.productList(request,model);
	}
	@GetMapping("/product/productContent")
	public String productContent(HttpServletRequest request,Model model,HttpSession session) {
		return service.productContent(request, model,session);
	}
	@GetMapping("/product/jjimOk")
	public @ResponseBody String jjimOk(HttpServletRequest request,HttpSession session) {
		return service.jjimOk(request, session);
	}
	@GetMapping("/product/jjimDel")
	public @ResponseBody String jjimDel(HttpServletRequest request,HttpSession session) {
		return service.jjimDel(request, session);
	}
	@GetMapping("/product/addCart")
	public @ResponseBody String addCart(CartDto cdto,HttpSession session,
			HttpServletRequest request,HttpServletResponse response) {
		return service.addCart(cdto, session,request,response);
	}
	@GetMapping("/product/cookieDel")
	public @ResponseBody void cookieDel(HttpServletResponse response) {
		Cookie cookie=new Cookie("cart","");
		cookie.setMaxAge(0);
		cookie.setPath("/");
		response.addCookie(cookie);
	}
	@GetMapping("/product/cookieView")
	public @ResponseBody String cookieView(HttpServletRequest request) {
		Cookie cookie=WebUtils.getCookie(request, "cart");
		if(cookie!=null) {
			return cookie.getValue();
		}
		else {
			return "";
		}
	}
	@RequestMapping("/product/productGumae")
	public String productGumae(HttpServletRequest request,HttpSession session,Model model) {
		return service.productGumae(request, session, model);
	}
	@GetMapping("/product/baesongWrite")
	public String baesongWrite() {
		return service.baesongWrite();
	}
	@PostMapping("/product/baesongWriteOk")
	public String baesongWriteOk(BaesongDto bdto,HttpSession session) {
		return service.baesongWriteOk(bdto, session);
	}
	@GetMapping("/product/baesongList")
	public String baesongList(HttpSession session,Model model) {
		return service.baesongList(session, model);
	}
	@RequestMapping("/product/baesongUpdate")
	public String baesongUpdate(HttpServletRequest request,Model model,HttpSession session) {
		return service.baesongUpdate(request,model,session);
	}
	@PostMapping("/product/baesongUpdateOk")
	public String baesongUpdateOk(BaesongDto bdto,HttpSession session) {
		return service.baesongUpdateOk(bdto,session);
	}
	@RequestMapping("/product/baesongDelete")
	public String baesongDelete(HttpServletRequest request,HttpSession session) {
		return service.baesongDelete(request,session);
	}
	@PostMapping("/product/gumaeOk")
	public String gumaeOk(GumaeDto gdto,HttpSession session) {
		return service.gumaeOk(gdto, session);
	}
	@GetMapping("/product/baesongOut")
	public String baesongOut() {
		return service.baesongOut();
	}
	@GetMapping("/product/gumaeList")
	public String gumaeList(HttpServletRequest request,HttpSession session,Model model) {
		return service.gumaeList(request,session,model);
	}
	@PostMapping("/product/qnaWriteOk")
	public String qnaWriteOk(QnaDto qdto,HttpServletRequest request,HttpSession session) {
		return service.qnaWriteOk(qdto, request,session);
	}
	@GetMapping("/product/qnaDelete")
	public String qnaDelete(HttpServletRequest request) {
		return service.qnaDelete(request);
	}
}
