package com.example.demo;

import java.text.DecimalFormat;
import java.time.LocalDate;

import com.example.demo.dto.ProductDto;

public class MyUtil {
	public static void getStar(ProductDto pdto) {
		int ystar=0,hstar=0,gstar=0;
		ystar=(int)pdto.getStar();
		double imsi=pdto.getStar()-ystar;
		if(imsi>=0.8) {
			ystar++; 
		}
		else if(imsi>=0.2) {
			hstar++;
		}
		gstar=5-ystar-hstar;
		pdto.setYstar(ystar);
		pdto.setHstar(hstar);
		pdto.setGstar(gstar);
	}
	public static void getBaeday(ProductDto pdto) {
		LocalDate today=LocalDate.now();
		LocalDate xday=today.plusDays(pdto.getBaeday());
		int m=xday.getMonthValue();
		int d=xday.getDayOfMonth();
		int y=xday.getDayOfWeek().getValue();
		String yoil=null;
		switch(y) {
		case 1:yoil="월"; break;
		case 2:yoil="화"; break;
		case 3:yoil="수"; break;
		case 4:yoil="목"; break;
		case 5:yoil="금"; break;
		case 6:yoil="토"; break;
		case 7:yoil="일"; break;
		}
		if(pdto.getBaeday()==1) {
			pdto.setBaedayStr("내일("+yoil+") 도착예정");
		}
		else if(pdto.getBaeday()==2) {
			pdto.setBaedayStr("모레("+yoil+") 도착예정");
		}
		else {
			pdto.setBaedayStr(m+"/"+d+"("+yoil+") 도착예정");
		}
	}
	public static String comma(int num) {
		DecimalFormat df=new DecimalFormat("#,###");
		return df.format(num);
	}
	public static String getState(int num) {
		String str;
		switch(num) {
		case 0:str="결제완료";break;
		case 1:str="배송준비";break;
		case 2:str="취소신청";break;
		case 3:str="취소완료";break;
		case 4:str="배송중";break;
		case 5:str="배송완료";break;
		case 6:str="반품신청";break;
		case 7:str="반품완료";break;
		case 8:str="교환신청";break;
		case 9:str="교환완료";break;
		default: str="오류";
		}
		return str;
	}
}
