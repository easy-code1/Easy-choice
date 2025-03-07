package com.example.demo.product;

import java.text.DecimalFormat;
import java.time.LocalDate;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.util.WebUtils;

import com.example.demo.MyUtil;
import com.example.demo.dto.BaesongDto;
import com.example.demo.dto.CartDto;
import com.example.demo.dto.GumaeDto;
import com.example.demo.dto.MemberDto;
import com.example.demo.dto.ProductDto;
import com.example.demo.dto.QnaDto;
import com.example.demo.dto.ReviewDto;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Service
@Qualifier("ps")
public class ProductServiceImpl implements ProductService{
	@Autowired
	private ProductMapper mapper;

	@Override
	public String productList(HttpServletRequest request, Model model) {
		String pcode=request.getParameter("pcode");
		String sword=request.getParameter("sword");
		int page=1;
		if(request.getParameter("page")!=null) {
			page=Integer.parseInt(request.getParameter("page"));
		}
		int index=(page-1)*20;
		int pstart=page/10;
		if(page%10==0) {
			pstart--;
		}
		pstart=pstart*10+1;
		int pend=pstart+9;
		int chong;
		if(pcode==null || pcode.length()==0) {
			chong=mapper.getChong(sword,0);
		}
		else {
			chong=mapper.getChong(pcode,1);
		}
		if(pend>chong) {
			pend=chong;
		}
		model.addAttribute("pstart",pstart);
		model.addAttribute("pend",pend);
		model.addAttribute("chong",chong);
		model.addAttribute("pcode",pcode);
		model.addAttribute("page",page);
		
		String orderStr="";
		int order=1;
		if(request.getParameter("order")!=null) {
			order=Integer.parseInt(request.getParameter("order"));
		}
		switch(order) {
		case 2:orderStr="price desc"; break;
		case 3:orderStr="price asc"; break;
		case 4:orderStr="writeday desc"; break;
		case 5:orderStr="star desc"; break;
		default:orderStr="pansu desc";
		}
		model.addAttribute("order",order);
		
		String menuList="";
		if(pcode==null || pcode.equals("")) {
			menuList="검색어 : "+sword;
		}
		else {
			if(pcode.length()==3) {
				String daeName=mapper.getDae(pcode.substring(1));
				menuList="Home - "+daeName;
			}
			else if(pcode.length()==5) {
				String dae=pcode.substring(1,3);
				String jung=pcode.substring(3,5);
				String daeName=mapper.getDae(dae);
				String jungName=mapper.getJung(jung, dae);
				menuList="Home - "+daeName+" - "+jungName;
			}
			else {
				String dae=pcode.substring(1,3);
				String jung=pcode.substring(3,5);
				String so=pcode.substring(5,7);
				String daeName=mapper.getDae(dae);
				String jungName=mapper.getJung(jung, dae);
				String soName=mapper.getSo(so, dae+jung);
				menuList="Home - "+daeName+" - "+jungName+" - "+soName;
			}
		}
		model.addAttribute("sword",sword);
		model.addAttribute("menuList",menuList);
		ArrayList<ProductDto> plist;
		 if(pcode==null || pcode.length()==0){
		    plist=mapper.productList(index,sword,orderStr,0);
		 }
		 else{
		    plist=mapper.productList(index,pcode,orderStr,1);
		 }
		
		for(int i=0;i<plist.size();i++) {
			ProductDto pdto=plist.get(i);
			MyUtil.getBaeday(pdto);
			MyUtil.getStar(pdto);
					
			int price=pdto.getPrice();
			int halin=pdto.getHalin();
			int juk=pdto.getJuk();
			double halinPrice=price-(price*halin/100.0);
			double jukPrice=price*juk/100.0;
			DecimalFormat df=new DecimalFormat("#,###");
			pdto.setPriceStr(df.format(price));
			pdto.setHalinPriceStr(df.format(halinPrice));
			pdto.setJukPriceStr(df.format(jukPrice));
			
			String[] pimgs=pdto.getPimg().split("/");
			pdto.setPimg(pimgs[0]);
		}
		
		
		model.addAttribute("plist",plist);
		return "/product/productList";
	}

	@Override
	public String productContent(HttpServletRequest request, Model model,HttpSession session) {
		String pcode=request.getParameter("pcode");
		
		int ok=0;
		if(session.getAttribute("userid")!=null) {
			String userid=session.getAttribute("userid").toString();
			ok=mapper.isJjim(pcode, userid);
		}
		model.addAttribute("ok",ok);
		
		ProductDto pdto=mapper.productContent(pcode);
		MyUtil.getStar(pdto);
		int price=pdto.getPrice();
		int halin=pdto.getHalin();
		int juk=pdto.getJuk();
		double halinPrice=price-(price*halin/100.0);
		double jukPrice=price*juk/100.0;
		DecimalFormat df=new DecimalFormat("#,###");
		pdto.setPriceStr(df.format(price));
		pdto.setHalinPriceStr(df.format(halinPrice));
		pdto.setJukPriceStr(df.format(jukPrice));
		MyUtil.getBaeday(pdto);
		
		String[] pimgs=pdto.getPimg().split("/");
		model.addAttribute("pimgs",pimgs);
		
		model.addAttribute("pdto",pdto);
		
		ArrayList<ReviewDto> rlist=mapper.getReview(pcode);
		for(int i=0;i<rlist.size();i++) {
			ReviewDto rdto=rlist.get(i);
			rdto.setContent(rdto.getContent().replace("\r\n", "<br>"));
		}
		model.addAttribute("rlist",rlist);
		
		ArrayList<QnaDto> qlist=mapper.getQna(pcode);
		for(int i=0;i<qlist.size();i++) {
			QnaDto qdto=qlist.get(i);
			qdto.setContent(qdto.getContent().replace("\r\n", "<br>"));
		}
		model.addAttribute("qlist",qlist);
		
		return "/product/productContent";
	}

	@Override
	public String jjimOk(HttpServletRequest request, HttpSession session) {
		if(session.getAttribute("userid")==null) {
			return "0";
		}
		else {
			String pcode=request.getParameter("pcode");
			String userid=session.getAttribute("userid").toString();
			mapper.jjimOk(pcode, userid);
			return "1";
		}
		
	}

	@Override
	public String jjimDel(HttpServletRequest request, HttpSession session) {
		if(session.getAttribute("userid")==null) {
			return "0";
		}
		else {
			String pcode=request.getParameter("pcode");
			String userid=session.getAttribute("userid").toString();
			mapper.jjimDel(pcode, userid);
			return "1";
		}
		
	}

	@Override
	public String addCart(CartDto cdto, HttpSession session,HttpServletRequest request,HttpServletResponse response) {
		if(session.getAttribute("userid")==null) {
			String newCode=cdto.getPcode()+"-"+cdto.getSu()+"/";
			Cookie cookie=WebUtils.getCookie(request, "cart");
			if(cookie==null || cookie.getValue().equals("")) {
				cookie=new Cookie("cart",newCode);
				cookie.setMaxAge(60*60*24);
				cookie.setPath("/");
				response.addCookie(cookie);
			}
			else {
				String cart=cookie.getValue();
				String[] carts=cart.split("/");
				int chk=0;
				for(int i=0;i<carts.length;i++) {
					if(carts[i].indexOf(cdto.getPcode())!=-1) {
						int hap=Integer.parseInt(carts[i].substring(13))+cdto.getSu();
						carts[i]=carts[i].substring(0,13)+hap;
						chk=1;
					}	
				}
				String cartNew="";
				for(int i=0;i<carts.length;i++) {
					cartNew+=carts[i]+"/";
				}
				if(chk==1) {
					cart=cartNew;
				}
				else {
					cart=cartNew+newCode;
				}
				
				cookie=new Cookie("cart",cart);
				cookie.setMaxAge(60*60*24);
				cookie.setPath("/");
				response.addCookie(cookie);
			}
			
		}
		else {
			String userid=session.getAttribute("userid").toString();
			cdto.setUserid(userid);
			if(mapper.isCart(cdto)) {
				mapper.upCart(cdto);
			}
			else {
				mapper.addCart(cdto);
			}
			
		}
		
		
		return "1";
	}

	@Override
	public String productGumae(HttpServletRequest request, HttpSession session, Model model) {
		String pcode=request.getParameter("pcode");
		String su=request.getParameter("su");
		if(session.getAttribute("userid")==null) {
			return "redirect:/login/login?pcode="+pcode+"&su="+su;
		}
		else {
			String userid=session.getAttribute("userid").toString();
			
			MemberDto mdto=mapper.getMember(userid);
			model.addAttribute("mdto",mdto);
			
			BaesongDto bdto=mapper.getBaesong(userid);
			if(bdto!=null) {
				String reqStr=null;
				switch(bdto.getReq()) {
				case 0: reqStr="문 앞";break;
				case 1: reqStr="직접 받고 부재시 문 앞";break;
				case 2: reqStr="경비실";break;
				case 3: reqStr="택배함";break;
				case 4: reqStr="기타";break;
				default: reqStr="";
				}
				bdto.setReqStr(reqStr);
				
			}
			
			model.addAttribute("bdto",bdto);
			
			String[] pcodes=pcode.split(",");
			String[] sus=su.split(",");
			ArrayList<ProductDto> plist=new ArrayList<ProductDto>();
			for(int i=0;i<pcodes.length;i++) {
				ProductDto pdto=mapper.productContent(pcodes[i]);
				MyUtil.getBaeday(pdto);
				pdto.setSu(Integer.parseInt(sus[i]));
				
				DecimalFormat df=new DecimalFormat("#,###");
				
				int price=pdto.getPrice();
				int halin=pdto.getHalin();
				price=price-(price*halin/100);
				pdto.setPriceStr(df.format(price));
				pdto.setPrice(price);
				plist.add(pdto);
			}
			
			model.addAttribute("plist",plist);
			
			return "/product/productGumae";
		}
		
	}

	@Override
	public String baesongWrite() {
		return "/product/baesongWrite";
	}

	@Override
	public String baesongWriteOk(BaesongDto bdto, HttpSession session) {
		bdto.setUserid(session.getAttribute("userid").toString());
		if(bdto.getGibon()==1) {
			mapper.setZero(session.getAttribute("userid").toString());
		}
		
		if(bdto.getGibon()==0 && mapper.isBaesong(session.getAttribute("userid").toString())==0) {
			bdto.setGibon(1);
		}
		
		mapper.baesongWriteOk(bdto);
		if(bdto.getCk()==0) {
			return "redirect:/product/baesongList";
		}
		else {
			return "/member/baesongWriteOk";
		}
	}

	@Override
	public String baesongList(HttpSession session, Model model) {
		String userid=session.getAttribute("userid").toString();
		ArrayList<BaesongDto> blist=mapper.baesongList(userid);
		for(int i=0;i<blist.size();i++) {
			BaesongDto bdto=blist.get(i);
			String reqStr=null;
			switch(bdto.getReq()) {
			case 0: reqStr="문 앞";break;
			case 1: reqStr="직접 받고 부재시 문 앞";break;
			case 2: reqStr="경비실";break;
			case 3: reqStr="택배함";break;
			case 4: reqStr="기타";break;
			default: reqStr="";
			}
			bdto.setReqStr(reqStr);
		}
		model.addAttribute("blist",blist);
		return "/product/baesongList";
	}

	@Override
	public String baesongUpdate(HttpServletRequest request,Model model,HttpSession session) {
		if(session.getAttribute("userid")==null) {
			return "redirect:/product/baesongOut";
		}
		else {
			BaesongDto bdto= mapper.getBaesong2(request.getParameter("id"));
			model.addAttribute("bdto",bdto);
			return "/product/baesongUpdate";
		}
		
	}

	@Override
	public String baesongUpdateOk(BaesongDto bdto,HttpSession session) {
		if(session.getAttribute("userid")==null) {
			return "redirect:/product/baesongOut";
		}
		else {
			if(bdto.getGibon()==1) {
				mapper.setZero(session.getAttribute("userid").toString());
			}
			mapper.baesongUpdateOk(bdto);
			if(bdto.getCk()==0) {
				return "redirect:/product/baesongList";
			}
			else {
				return "/member/baesongUpdateOk";
			}
		}
		
	}

	@Override
	public String baesongDelete(HttpServletRequest request,HttpSession session) {
		if(session.getAttribute("userid")==null) {
			return "redirect:/product/baesongOut";
		}
		else {
			mapper.baesongDelete(request.getParameter("id"));
			if(request.getParameter("ck")==null) {
				return "redirect:/product/baesongList";
			}
			else {
				return "redirect:/member/baesongList";
			}
			
		}
	}

	@Override
	public String gumaeOk(GumaeDto gdto, HttpSession session) {
		if(session.getAttribute("userid")==null) {
			return "redirect:/login/login";
		}
		else {
			String userid=session.getAttribute("userid").toString();
			gdto.setUserid(userid);
			String today=LocalDate.now().toString().replace("-","");
			String jumuncode="j"+today;
			int num=mapper.getNumber(jumuncode);
			jumuncode+=String.format("%03d", num);
			gdto.setJumuncode(jumuncode);
			String[] pcodes=gdto.getPcode().split("/"); 
			String[] sus=gdto.getSus().split("/");
			for(int i=0;i<pcodes.length;i++) {
				gdto.setPcode(pcodes[i]);
				gdto.setSu(Integer.parseInt(sus[i]));
				mapper.gumaeOk(gdto);
				mapper.cartDel(userid, pcodes[i]);
			}
			mapper.setJuk(gdto.getUseJuk(), userid);
			
			return "redirect:/product/gumaeList?jumuncode="+jumuncode;
		}
	}

	@Override
	public String baesongOut() {
		return "/product/baesongOut";
	}

	@Override
	public String gumaeList(HttpServletRequest request, HttpSession session,Model model) {
		if(session.getAttribute("userid")==null) {
			return "redirect:/login/login";
		}
		else {
			String jumuncode=request.getParameter("jumuncode");
			ArrayList<GumaeDto> glist=mapper.getGumae(jumuncode);
			ArrayList<ProductDto> plist=new ArrayList<ProductDto>();
			int halinPriceAll=0,baePriceAll=0;
			int useJuk=0;
			for(int i=0;i<glist.size();i++) {
				GumaeDto gdto=glist.get(i);
				ProductDto pdto=mapper.productContent(gdto.getPcode());
				MyUtil.getBaeday(pdto);
				pdto.setSu(gdto.getSu());
				int halinPrice=pdto.getPrice()-(pdto.getPrice()*pdto.getHalin()/100);
				halinPriceAll+=halinPrice;
				baePriceAll+=pdto.getBaeprice();
				useJuk=gdto.getUseJuk();
				plist.add(pdto);
				
			}
			BaesongDto bdto=mapper.getBaesong2(glist.get(0).getBaeId()+"");
			String reqStr;
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
			model.addAttribute("bdto",bdto);
			model.addAttribute("plist",plist);
			model.addAttribute("halinPriceAll",MyUtil.comma(halinPriceAll));
			model.addAttribute("baePriceAll",MyUtil.comma(baePriceAll));
			model.addAttribute("useJuk",MyUtil.comma(useJuk));
			model.addAttribute("chongPrice",MyUtil.comma(halinPriceAll+baePriceAll-useJuk));
			return "/product/gumaeList";
		}
	}

	@Override
	public String qnaWriteOk(QnaDto qdto, HttpServletRequest request,HttpSession session) {
		String userid=session.getAttribute("userid").toString();
		qdto.setUserid(userid);
		mapper.qnaWriteOk(qdto);
		return "redirect:/product/productContent?pcode="+qdto.getPcode();
	}

	@Override
	public String qnaDelete(HttpServletRequest request) {
		String id=request.getParameter("id");
		String pcode=request.getParameter("pcode");
		String ref=request.getParameter("ref");
		if(ref.equals("0")) {
			mapper.qnaDelete1(id);
		}
		else {
			mapper.qnaDelete2(ref);
		}
		if(request.getParameter("chk")==null) {
			return "redirect:/product/productContent?pcode="+pcode;
		}
		else {
			return "redirect:/member/qnaList";
		}
	}
	
}
