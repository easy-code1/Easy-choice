package com.example.demo.exception;

public class ArithException {
	public static void main(String[] args) {
		try {
			int total=390;
			int num=0;
			int result=total/num;
			System.out.println(result);
		}
		catch(ArithmeticException e){
			System.out.println("0이 입력되어 계산 불가");
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		System.out.println("다음 작업");
	}
}
