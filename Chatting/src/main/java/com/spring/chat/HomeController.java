package com.spring.chat;

import java.io.PrintWriter;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.dto.MemberVO;
import com.spring.dto.NoticeVO;
import com.spring.dto.RoomDTO;
import com.spring.mapper.NoticeMapper;
import com.spring.mapper.RoomMapper;
import com.spring.chat.HomeController;
/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
 
    @Autowired
    private SqlSession sqlSession;
    
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String home(Locale locale, Model model) {
    	NoticeMapper noticeMapper = sqlSession.getMapper(NoticeMapper.class);
    	List<NoticeVO> noticeVoList = noticeMapper.SelectNotices();
    	
    	model.addAttribute("notice", noticeVoList);
    
    	RoomMapper mapper = sqlSession.getMapper(RoomMapper.class);
    	int roomCount = mapper.countColumns();
    	
    	RoomDTO room[] = new RoomDTO[roomCount];
    	for (int i = 0; i < roomCount; i++) {
	        RoomDTO mapperRoom = mapper.selectRooms().get(i);
	        room[i] = new RoomDTO();
	        room[i].setId(mapperRoom.getId());
	        room[i].setSubject(mapperRoom.getSubject());
	        room[i].setMaster(mapperRoom.getMaster());
    	}
	        model.addAttribute("room", room);
    	
        return "home";
 }
}


