package com.example.demo.admin;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.example.demo.MyUtil;
import com.example.demo.dto.CompanyDto;
import com.example.demo.dto.DaeDto;
import com.example.demo.dto.GumaeDto;
import com.example.demo.dto.JungDto;
import com.example.demo.dto.ProductDto;
import com.example.demo.dto.QnaDto;
import com.example.demo.dto.SoDto;

import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController {
	@Autowired
	private AdminMapper mapper;
	
	@GetMapping("/admin/proWrite")
	public String proWrite(Model model) {
		ArrayList<DaeDto> dlist=mapper.getDae();
		ArrayList<CompanyDto> clist=mapper.getCompany();
		model.addAttribute("clist",clist);
		model.addAttribute("dlist",dlist);
		return "/admin/proWrite";
	}
	@GetMapping("/admin/getJung")
	public @ResponseBody ArrayList<JungDto> getJung(String dae) {
		return mapper.getJung(dae);	
	}
	@GetMapping("/admin/getSo")
	public @ResponseBody ArrayList<SoDto> getSo(String daejung){
		return mapper.getSo(daejung);
	}
	@GetMapping("/admin/getPcode")
	public @ResponseBody String getPcode(String pcode) {
		int num=mapper.getNumber(pcode);
		String imsi=String.format("%03d", num);
		pcode+=imsi;
		return pcode;
	}
	@PostMapping("/admin/proWriteOk")
	public String proWriteOk(ProductDto pdto,MultipartHttpServletRequest multi)throws Exception {
		String pimg="";
		String dimg="";
		Iterator<String> iter=multi.getFileNames();
		while(iter.hasNext()) {
			String imsi=iter.next();
			MultipartFile file=multi.getFile(imsi);
			if(!file.isEmpty()) {
				String oname=file.getOriginalFilename();
				if(!imsi.equals("exdimg")) {
					pimg+=oname+"/";
				}
				else {
					dimg=oname;
				}
				String str=ResourceUtils.getFile("classpath:static/product").toString();
				
				File sfile=new File(str+"/"+oname);
				while(sfile.exists()) {
					String[] fnames=oname.split("[.]");
					oname=fnames[0]+System.currentTimeMillis()+"."+fnames[1];
					sfile=new File(str+"/"+oname);
				}
				
				Path path=Paths.get(str+"/"+oname);
				Files.copy(file.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
			}	
		}
		pdto.setDimg(dimg);
		pdto.setPimg(pimg);
		mapper.proWriteOk(pdto);
		return "redirect:/admin/proList";
	}
	@RequestMapping("/admin/test")
	public String test() {
		return "/admin/test";
	}
	@GetMapping("/admin/panmaeList")
	public String panmaeList(Model model,HttpSession session) {
		ArrayList<HashMap> mapAll=mapper.panmaeList();
		for(int i=0;i<mapAll.size();i++) {
			HashMap map=mapAll.get(i);
			int state=Integer.parseInt(map.get("state").toString());
			map.put("stateStr",MyUtil.getState(state));
		}
		model.addAttribute("mapAll",mapAll);
		return"/admin/panmaeList";
	}
	@GetMapping("/admin/chgState")
	public String chgState(GumaeDto gdto) {
		mapper.chgState(gdto);
		return "redirect:/admin/panmaeList";
	}
	@GetMapping("/admin/qnaList")
	public String qnaList(Model model) {
		ArrayList<QnaDto> qlist=mapper.qnaList();
		model.addAttribute("qlist",qlist);
		return "/admin/qnaList";
	}
	@PostMapping("/admin/qnaAnswer")
	public String qnaAnswer(QnaDto qdto) {
		mapper.qnaAnswer(qdto);
		mapper.setRef(qdto.getRef());
		return "redirect:/admin/qnaList";
	}
}
