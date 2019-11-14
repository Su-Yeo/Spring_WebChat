package com.spring.mapper;

import java.util.List;

import com.spring.dto.NoticeVO;
import com.spring.dto.RoomDTO;

public interface NoticeMapper {
	public List<NoticeVO> SelectNotices();
	public void InsertNotice(String comment);
}
