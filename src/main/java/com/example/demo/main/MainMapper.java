package com.example.demo.main;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.dto.ProductDto;

@Mapper
public interface MainMapper {
	public ArrayList<ProductDto> getEvent(int n);
}
