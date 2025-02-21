package com.example.demo.exception;

public class ThrowClass {
	public String chgString(String str) throws NullPointerException{
		
		str=str.replace("aa", "bb");
		return str;
		
		/*
		try {
			str=str.replace("aa", "bb");
		}
		catch(NullPointerException e) {
			str="null값이 온 것 같아요";
		}
		return str;
		*/
	}
}
