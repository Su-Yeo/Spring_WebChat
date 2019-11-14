package com.spring.mapper;

import java.util.List;

import com.spring.dto.MemberVO;

public interface MemberMapper {
	 public List<MemberVO> selectUsers();
	 public void join(MemberVO data);
}
