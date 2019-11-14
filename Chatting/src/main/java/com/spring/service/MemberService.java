package com.spring.service;

import com.spring.dto.MemberVO;

public interface MemberService {

	public void join(MemberVO vo) throws Exception;
	
	public MemberVO login(MemberVO vo) throws Exception;
}
