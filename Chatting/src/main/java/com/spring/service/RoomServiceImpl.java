package com.spring.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.spring.DAO.RoomDAO;
import com.spring.dto.RoomDTO;

@Service
public class RoomServiceImpl implements RoomService {

	@Inject
	private RoomDAO dao;

	@Override
	public void make(RoomDTO dto) throws Exception {
		// TODO Auto-generated method stub
		dao.make(dto);
	}
}
