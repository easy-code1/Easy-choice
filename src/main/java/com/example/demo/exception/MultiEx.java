package com.example.demo.exception;

public class MultiEx {
	public static void main(String[] args) {
		try {
			int total=390;
			int num=0;
			int result=total/num;
			System.out.println(result);

			String str2=null;
			str2=str2.replace("java", "Action");
			System.out.println(str2);
			
			int[] num2=new int[6];
			num2[0]=100;
		    num2[6]=99;
		    
		    String bb="33a";
		    int n=Integer.parseInt(bb);
		    System.out.println(n);
		}
		catch(ArithmeticException e){
			System.out.println("0으로 나누는 일이 발생함");
		}
		catch(NullPointerException e){
			System.out.println("null이면 안돼요");
		}
		catch(ArrayIndexOutOfBoundsException e){
			System.out.println("배열의 범위초과");
		}
		catch(Exception e) {
			System.out.println("모든 예외를 처리한다");
		}
		System.out.println("다음 작업");
		
	}
}
