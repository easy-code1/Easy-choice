package com.example.demo.dto;

import lombok.Data;

@Data
public class MemberDto {
	private int id,state,juk;
	private String userid,pwd,email,phone,writeday,name,oldPwd;
}
