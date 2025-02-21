package com.example.demo.member;

import java.text.DecimalFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.util.WebUtils;

import com.example.demo.MyUtil;
import com.example.demo.dto.BaesongDto;
import com.example.demo.dto.GumaeDto;
import com.example.demo.dto.ProductDto;
import com.example.demo.dto.ReviewDto;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Service
@Qualifier("ms")
public class MemberServiceImpl implements MemberService{
	@Autowired
	private MemberMapper mapper;

	@Override
	public String member() {
		return "/member/member";
	}

	@Override
	public String useridCheck(HttpServletRequest request) {
		String userid=request.getParameter("userid");
		return mapper.useridCheck(userid);
	}

	@Override
	public String memberOk(MemberDto mdto) {
		if(mapper.useridCheck(mdto.getUserid()).equals("0")) {
			mapper.memberOk(mdto);
			return "redirect:/login/login";
		}
		else {
			return "redirect:/member/member?err=1";
		}
		
	}

	@Override
	public String cartView(Model model, HttpServletRequest request, HttpSession session) {
		
		ArrayList<ProductDto> plist=null;
		if(session.getAttribute("userid")==null) {
			Cookie cookie=WebUtils.getCookie(request, "cart");
			if(cookie!=null && !cookie.getValue().equals("")) {
				String[] pcodes=cookie.getValue().split("/");
				DecimalFormat df=new DecimalFormat("#,###");
				plist=new ArrayList<ProductDto>();
				for(int i=0;i<pcodes.length;i++) {
					String pcode=pcodes[i].substring(0,12);
					ProductDto pdto=mapper.getProduct(pcode);
					MyUtil.getBaeday(pdto);
					int price=pdto.getPrice();
					int halin=pdto.getHalin();
					int juk=pdto.getJuk();
					double halinPrice=price-(price*halin/100.0);		
					double jukPrice= price*juk/100.0;
					pdto.setHalinPriceStr(df.format(halinPrice));
					pdto.setJukPriceStr(df.format(jukPrice));
					pdto.setPrice((int)halinPrice);
					int su=Integer.parseInt(pcodes[i].substring(13));
					pdto.setSu(su);
					pdto.setWchk(1);
					plist.add(pdto);
				}
				model.addAttribute("plist",plist);
			}
		}
		else {
			String userid=session.getAttribute("userid").toString();
			plist=mapper.cartView(userid);
			DecimalFormat df=new DecimalFormat("#,###");
			for(int i=0;i<plist.size();i++) {
				ProductDto pdto=plist.get(i);
				MyUtil.getBaeday(pdto);
				int price=pdto.getPrice();
				int halin=pdto.getHalin();
				int juk=pdto.getJuk();
				double halinPrice=price-(price*halin/100.0);		
				double jukPrice= price*juk/100.0;
				pdto.setHalinPriceStr(df.format(halinPrice));
				pdto.setJukPriceStr(df.format(jukPrice));
				pdto.setPrice((int)halinPrice);
				
				/*
				String[] wday=pdto.getWriteday().split("-");
				int y=Integer.parseInt(wday[0]);
				int m=Integer.parseInt(wday[1]);
				int d=Integer.parseInt(wday[2]);
				LocalDate cartDay=LocalDate.of(y, m, d);
				LocalDate today=LocalDate.now();
				if(today.isEqual(cartDay)) {
					pdto.setWchk(1);
				}
				else {
					pdto.setWchk(0);
				}
				*/
			}
			model.addAttribute("plist",plist);
			model.addAttribute("today",LocalDate.now().toString());
		}
		int height=660;
		int size=0;
		if(plist!=null) {
			size=plist.size();
		}
		if(size>4) {
			int n=size-4;
			n=n*110;
			height+=n;
			
		}
		model.addAttribute("height",height);
		
		return "/member/cartView";
		
	}
	@Override
	public String cartDel(HttpServletRequest request, HttpSession session, HttpServletResponse response) 
	{
		if(session.getAttribute("userid")==null)
		{
			String pcodes=request.getParameter("ids");
			
			Cookie cookie=WebUtils.getCookie(request, "cart");
			
			if(cookie!=null && !cookie.getValue().equals("")) {
				String cart=cookie.getValue();
				String[] carts=cart.split("/");
				String[] pcodeDel=pcodes.split(",");
				for(int i=0;i<pcodeDel.length;i++) {
					for(int j=0;j<carts.length;j++) {
						if(carts[j].indexOf(pcodeDel[i])!=-1) {
							carts[j]="";
						}
					}
				}
				String newCart="";
				for(int i=0;i<carts.length;i++) {
					if(carts[i]!="") {
						newCart+=carts[i]+"/";
					}
				}
				cookie=new Cookie("cart",newCart);
				cookie.setMaxAge(60*60*24);
				cookie.setPath("/");
				response.addCookie(cookie);
			}
		}
		else
		{
			// 요청된 상품을 cart테이블에서 삭제
			// 선택삭제 =>  "11,22,33,"
			// 삭제    =>  "11"
	
			String ids=request.getParameter("ids");
			
			String[] imsi=ids.split(",");  
		     
			for(int i=0;i<imsi.length;i++)
			{
				mapper.cartDel(imsi[i]);
			}
		}
		
		return "redirect:/member/cartView";
	}

	@Override
	public String chgSu(HttpServletRequest request,HttpSession session,HttpServletResponse response) {
		 String id=request.getParameter("id");
		 String num=request.getParameter("num");
		 String pcode=request.getParameter("pcode");
		 
		 if(session.getAttribute("userid")==null) {
			 Cookie cookie=WebUtils.getCookie(request, "cart");
			 if(cookie!=null && !cookie.getValue().equals("")) {
				 String cart=cookie.getValue();
				 String[] carts=cart.split("/");
				 for(int i=0;i<carts.length;i++) {
					 if(carts[i].indexOf(pcode)!=-1) {
						 carts[i]=pcode+"-"+num;
					 }
				 }
				 String newCart="";
				 for(int i=0;i<carts.length;i++) {
					 newCart+=carts[i]+"/";
				 }
				 cookie=new Cookie("cart",newCart);
				 cookie.setMaxAge(60*60*24);
				 cookie.setPath("/");
				 response.addCookie(cookie);
			 }
			 return "0";
		 }
		 else {
			 mapper.chgSu(id,num);
			 return "0";
		 }
		
		 
	}

	@Override
	public String jjimList(HttpSession session, Model model) {
		if(session.getAttribute("userid")==null) {
			return "redirect:/login/login";
		}
		else {
			String userid=session.getAttribute("userid").toString();
			ArrayList<ProductDto> plist=mapper.jjimList(userid);
			model.addAttribute("plist",plist);
			return "/member/jjimList";
		}
	}

	@Override
	public String jjimDel(HttpServletRequest request,HttpSession session) {
		if(session.getAttribute("userid")==null) {
			return "redirect:/login/login";
		}
		else {
			String ids=request.getParameter("ids");
			String[] imsi=ids.split(",");
			for(int i=0;i<imsi.length;i++) {
				mapper.jjimDel(imsi[i]);
			}
			return "redirect:/member/jjimList";
		}
		
	}

	@Override
	public String addCart(HttpServletRequest request, HttpSession session) {
		if(session.getAttribute("userid")==null) {
			return "-1";
		}
		else {
			String userid=session.getAttribute("userid").toString();
			String pcode=request.getParameter("pcode");
			if(mapper.isCart(userid, pcode)) {
				mapper.upCart(userid, pcode);
			}
			else {
				mapper.addCart(userid, pcode);
			}
			return mapper.getCartSu(userid);
		}
	}

	@Override
	public String jumunList(HttpSession session, Model model,HttpServletRequest request) {
		if(session.getAttribute("userid")==null) {
			return "redirect:/login/login";
		}
		else {
			String userid=session.getAttribute("userid").toString();
			String start,end;
			int month;
			if(request.getParameter("start")==null) {
				month=0;
				if(request.getParameter("month")!=null) {
					month=Integer.parseInt(request.getParameter("month"));
				}
				LocalDate today=LocalDate.now();
				LocalDate xday=today.minusMonths(month);
				start=xday.toString();
				end=today.toString();
			}
			else {
				start=request.getParameter("start");
				end=request.getParameter("end");
				month=1;
				model.addAttribute("start",start);
				model.addAttribute("end",end);
			}
			ArrayList<HashMap> mapAll=mapper.jumunList(userid,start,end,month);
			for(int i=0;i<mapAll.size();i++) {
				HashMap map=mapAll.get(i);
				int state=Integer.parseInt(map.get("state").toString());
				map.put("stateStr", MyUtil.getState(state));
			}
			model.addAttribute("mapAll",mapAll);
			return "/member/jumunList";
		}
	}

	@Override
	public String chgState(HttpSession session, GumaeDto gdto) {
		if(session.getAttribute("userid")==null) {
			return "redirect:/login/login";
		}
		else {
			mapper.chgState(gdto);
			return "redirect:/member/jumunList";
		}
	}

	@Override
	public String review(ReviewDto rdto,Model model) {
		model.addAttribute("gid",rdto.getId());
		model.addAttribute("pcode",rdto.getPcode());
		return "/member/review";
	}

	@Override
	public String reviewOk(HttpSession session, ReviewDto rdto) {
		String usesrid=session.getAttribute("userid").toString();
		rdto.setUserid(usesrid);
		rdto.setGid(rdto.getId());
		mapper.reviewOk(rdto);
		mapper.chgReview(rdto.getId());
		double avg=mapper.avgStar(rdto.getPcode());
		mapper.chgStar(rdto.getPcode(), avg);
		mapper.upReview(rdto.getPcode());
		return "redirect:/member/jumunList";
	}

	@Override
	public String reviewDelete(HttpServletRequest request, HttpSession session) {
		if(session.getAttribute("userid")==null) {
			return "redirect:/login/login";
		}
		else {
			String id=request.getParameter("id");
			String pcode=request.getParameter("pcode");
			String gid=request.getParameter("gid");
			mapper.reviewDelete(id);
			double avg=mapper.avgStar(pcode);
			mapper.chgStar2(avg,pcode);
			mapper.setReview(gid);
			return "redirect:/product/productContent?pcode="+pcode;
		}
	}

	@Override
	public String reviewUpdate(HttpServletRequest request, HttpSession session,Model model) {
		if(session.getAttribute("userid")==null) {
			return "redirect:/login/login";
		}
		else {
			String id=request.getParameter("id");
			String pcode=request.getParameter("pcode");
			ReviewDto rdto=mapper.getReview(id);
			model.addAttribute("rdto",rdto);
			return "/member/reviewUpdate";
		}
	}

	@Override
	public String reviewUpdateOk(ReviewDto rdto, HttpSession session) {
		if(session.getAttribute("userid")==null) {
			return "redirect:/login/login";
		}
		else {
			mapper.reviewUpdateOk(rdto);
			double avg=mapper.avgStar(rdto.getPcode());
			mapper.chgStar(rdto.getPcode(), avg);
			return "redirect:/product/productContent?pcode="+rdto.getPcode();
		}
	}

	@Override
	public String memberInfo(HttpSession session, Model model) {
		if(session.getAttribute("userid")==null) {
			return "redirect:/login/login";
		}
		else {
			String userid=session.getAttribute("userid").toString();
			MemberDto mdto=mapper.memberInfo(userid);
			model.addAttribute("mdto",mdto);
			return "/member/memberInfo";
		}
	}

	@Override
	public String chgEmail(HttpServletRequest request, HttpSession session) {
		if(session.getAttribute("userid")==null) {
			return "0";
		}
		else {
			String email=request.getParameter("email");
			String userid=session.getAttribute("userid").toString();
			mapper.chgEmail(userid, email);
			return "1";
		}
	}

	@Override
	public String chgPhone(HttpServletRequest request, HttpSession session) {
		if(session.getAttribute("userid")==null) {
			return "redirect:/login/login";
		}
		else {
			String phone=request.getParameter("phone");
			String userid=session.getAttribute("userid").toString();
			mapper.chgPhone(userid, phone);
			return "redirect:/member/memberInfo";
		}
	}

	@Override
	public String chgPwd(HttpServletRequest request, HttpSession session) {
		if(session.getAttribute("userid")==null) {
			return "redirect:/login/login";
		}
		else {
			String newPwd=request.getParameter("newPwd");
			String userid=session.getAttribute("userid").toString();
			String oldPwd=request.getParameter("oldPwd");
			String err=null;
			if(mapper.isPwd(userid, oldPwd)) {
				mapper.chgPwd(userid, newPwd);
				err="1";
			}
			else {
				err="0";
			}
			return "redirect:/member/memberInfo?err="+err;
		}
	}

	@Override
	public String baesongList(HttpSession session, Model model) {
		String userid=session.getAttribute("userid").toString();
		ArrayList<BaesongDto> blist=mapper.baesongList(userid);
		for(int i=0;i<blist.size();i++)
		{
			BaesongDto bdto=blist.get(i);
			String reqStr=null;
			switch(bdto.getReq())
			{
			    case 0: reqStr="문 앞"; break;
			    case 1: reqStr="직접 받고 부재시 문 앞"; break;
			    case 2: reqStr="경비실"; break;
			    case 3: reqStr="택배함"; break;
			    case 4: reqStr="기타"; break;
			    default: reqStr="";
			}
			bdto.setReqStr(reqStr);
		}
		
		model.addAttribute("blist",blist);
		return "/member/baesongList";
	}
	

}
