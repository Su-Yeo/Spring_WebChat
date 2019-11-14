package com.spring.DAO;

import com.spring.dto.MemberVO;

public interface MemberDAO {

	public void join(MemberVO vo)throws Exception;
	
	public MemberVO login(MemberVO vo)throws Exception;
}
