package com.spring.DAO;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.spring.dto.RoomDTO;

@Service
public class RoomDAOImpl implements RoomDAO {
	@Inject
	private SqlSession sql;
	
	private static String namespace = "com.spring.mapper.RoomMapper";
	@Override
	public void make(RoomDTO dto) throws Exception {
		// TODO Auto-generated method stub
		sql.insert(namespace + ".make", dto);
	}

}
