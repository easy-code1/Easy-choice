package com.example.demo.main;

import java.text.DecimalFormat;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.example.demo.MyUtil;
import com.example.demo.dto.ProductDto;

@Service
@Qualifier("ms")
public class MainServiceImpl implements MainService{
	@Autowired
	private MainMapper mapper;

	@Override
	public String main(Model model) {
		ArrayList<ProductDto> plist1=mapper.getEvent(0);
		for(int i=0;i<plist1.size();i++) // ArrayList의 처음부터 끝까지 요소를 읽어서 작업을 하기
		{
			ProductDto pdto=plist1.get(i);			
 
			MyUtil.getStar(pdto);
			
			
			// 상품금액, 할인금액, 적립금을 계산 후 => 소수점X , 3자리마다 ,처리
			int price=pdto.getPrice();
			int halin=pdto.getHalin();
			int juk=pdto.getJuk();
			
			double halinPrice=price-(price*halin/100.0);		
			
			double jukPrice= price*juk/100.0;
			
			DecimalFormat df=new DecimalFormat("#,###");
			String priceStr=df.format(price);
			
			pdto.setPriceStr(priceStr);			
			pdto.setHalinPriceStr(df.format(halinPrice));
			pdto.setJukPriceStr(df.format(jukPrice));
			
			//그림이 여러개 일 경우 하나의 그림만 dto에 저장한다.
			String[] pimgs=pdto.getPimg().split("/");
			pdto.setPimg(pimgs[0]);
		}
		
		model.addAttribute("plist1",plist1);
		
		ArrayList<ProductDto> plist2=mapper.getEvent(1);
		for(int i=0;i<plist2.size();i++) // ArrayList의 처음부터 끝까지 요소를 읽어서 작업을 하기
		{
			ProductDto pdto=plist2.get(i);			
 
			MyUtil.getStar(pdto);
			
			
			// 상품금액, 할인금액, 적립금을 계산 후 => 소수점X , 3자리마다 ,처리
			int price=pdto.getPrice();
			int halin=pdto.getHalin();
			int juk=pdto.getJuk();
			
			double halinPrice=price-(price*halin/100.0);		
			
			double jukPrice= price*juk/100.0;
			
			DecimalFormat df=new DecimalFormat("#,###");
			String priceStr=df.format(price);
			
			pdto.setPriceStr(priceStr);			
			pdto.setHalinPriceStr(df.format(halinPrice));
			pdto.setJukPriceStr(df.format(jukPrice));
			
			//그림이 여러개 일 경우 하나의 그림만 dto에 저장한다.
			String[] pimgs=pdto.getPimg().split("/");
			pdto.setPimg(pimgs[0]);
		}
		
		model.addAttribute("plist2",plist2);
		
		ArrayList<ProductDto> plist3=mapper.getEvent(2);
		for(int i=0;i<plist3.size();i++) // ArrayList의 처음부터 끝까지 요소를 읽어서 작업을 하기
		{
			ProductDto pdto=plist3.get(i);			
 
			MyUtil.getStar(pdto);
			
			
			// 상품금액, 할인금액, 적립금을 계산 후 => 소수점X , 3자리마다 ,처리
			int price=pdto.getPrice();
			int halin=pdto.getHalin();
			int juk=pdto.getJuk();
			
			double halinPrice=price-(price*halin/100.0);		
			
			double jukPrice= price*juk/100.0;
			
			DecimalFormat df=new DecimalFormat("#,###");
			String priceStr=df.format(price);
			
			pdto.setPriceStr(priceStr);			
			pdto.setHalinPriceStr(df.format(halinPrice));
			pdto.setJukPriceStr(df.format(jukPrice));
			
			//그림이 여러개 일 경우 하나의 그림만 dto에 저장한다.
			String[] pimgs=pdto.getPimg().split("/");
			pdto.setPimg(pimgs[0]);
		}
		
		model.addAttribute("plist3",plist3);
		return "/main/main";
	}

}
