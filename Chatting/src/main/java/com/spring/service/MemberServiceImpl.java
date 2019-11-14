package com.spring.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.spring.DAO.MemberDAO;
import com.spring.dto.MemberVO;


@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	private MemberDAO dao;
	

	@Override
	public void join(MemberVO vo) throws Exception {
		dao.join(vo);
	}
	
	@Override
	public MemberVO login(MemberVO vo) throws Exception {
		return dao.login(vo);
	}
}
