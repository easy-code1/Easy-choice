package com.example.demo.member;

import lombok.Data;

@Data
public class MemberDto {
	private int id,state,juk;
	private String name,userid,pwd,email,phone,writeday;
}
