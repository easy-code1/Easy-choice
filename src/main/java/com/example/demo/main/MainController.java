package com.example.demo.main;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	@Autowired
	@Qualifier("ms")
	private MainService service;
	
	@RequestMapping("/")
	public String home() {
		return "redirect:/main/main";
	}
	@RequestMapping("/main/main")
	public String main(Model model) {
		return service.main(model);
	}
	@RequestMapping("/main/slide")
	public String slide() {
		return "/main/slide";
	}
	
}
