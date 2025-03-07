package com.example.demo.product;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.dto.BaesongDto;
import com.example.demo.dto.CartDto;
import com.example.demo.dto.GumaeDto;
import com.example.demo.dto.MemberDto;
import com.example.demo.dto.ProductDto;
import com.example.demo.dto.QnaDto;
import com.example.demo.dto.ReviewDto;

@Mapper
public interface ProductMapper {
	public ArrayList<ProductDto> productList(int index,String pcode,String orderStr,int ck);
	public int getChong(String pcode,int ck);
	public String getDae(String code);
	public String getJung(String code,String daecode);
	public String getSo(String code,String daejung);
	public ProductDto productContent(String pcode);
	public void jjimOk(String pcode,String userid);
	public int isJjim(String pcode,String userid);
	public void jjimDel(String pcode,String userid);
	public void addCart(CartDto cdto);
	public boolean isCart(CartDto cdto);
	public void upCart(CartDto cdto);
	public MemberDto getMember(String userid);
	public BaesongDto getBaesong(String userid);
	public void baesongWriteOk(BaesongDto bdto);
	public ArrayList<BaesongDto> baesongList(String userid);
	public void setZero(String userid);
	public int isBaesong(String userid);
	public BaesongDto getBaesong2(String id);
	public void baesongUpdateOk(BaesongDto bdto);
	public void baesongDelete(String id);
	public int getNumber(String jumuncode);
	public void gumaeOk(GumaeDto gdto);
	public void setJuk(int useJuk,String userid);
	public void cartDel(String userid,String pcode);
	public ArrayList<GumaeDto> getGumae(String jumuncode);
	public ArrayList<ReviewDto> getReview(String pcode);
	public void qnaWriteOk(QnaDto qdto);
	public ArrayList<QnaDto> getQna(String pcode);
	public void qnaDelete1(String id);
	public void qnaDelete2(String ref);
}
