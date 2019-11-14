package com.spring.DAO;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.spring.dto.MemberVO;

@Service
public class MemberDAOImpl implements MemberDAO {
	@Inject
	private SqlSession sql;
	
	private static String namespace = "com.spring.mapper.MemberMapper";
	
	@Override
	public void join(MemberVO vo) throws Exception{
		sql.insert(namespace + ".join", vo);
	}
	
	@Override
	public MemberVO login(MemberVO vo) throws Exception{
		return sql.selectOne(namespace + ".login", vo);
	}
}
