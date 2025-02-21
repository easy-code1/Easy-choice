package com.example.demo.exception;

public class FinallyEx {
	public static void main(String[] args) {
		try {
			int total=390;
			int num=0;
			int result=total/num;
			System.out.println(result);
		}
		catch(ArithmeticException e) {
			System.out.println("0은 안돼요");
		}
		finally { // 예외가 발생해도 안해도 무조건 실행
			      //해당구문은 try 구문과 연관된 구문
			System.out.println("finally 실행");
		}
		System.out.println("다음 작업");
	}
}
