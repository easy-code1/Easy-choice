package com.example.demo.dto;

import lombok.Data;

@Data
public class ProductDto {
	
	private int id,price,halin,su,baeprice,juk,pansu,review,sales,baeday;
	private String pcode,pimg,dimg,title,writeday,salesDay;
	private double star;
	private String baedayStr;
	private int gstar,hstar,ystar;
	private String priceStr,halinPriceStr,jukPriceStr;
	private int wchk;
}
