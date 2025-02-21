package com.example.demo.exception;

public class ThrowMain {
	public static void main(String[] args) {
		String str="abcdeaaooba";
		System.out.println(str);
		
		ThrowClass tc=new ThrowClass();
		str=tc.chgString(str);
		System.out.println(str);
		
		String str2;
		try {
			str2=null;
			str2=tc.chgString(str2);
		}
		catch(NullPointerException e){
			str2="null값이 온 것 같아요"; 
		}
		System.out.println(str2);
	}
}
