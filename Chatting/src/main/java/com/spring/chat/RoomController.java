package com.spring.chat;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.dto.MemberVO;
import com.spring.dto.RoomDTO;
import com.spring.mapper.RoomMapper;

@Controller
public class RoomController {
	
    @Autowired
    private SqlSession sqlSession;
    
    @RequestMapping(value="/delete", method=RequestMethod.POST)
    public String PostDelete(String roomId, HttpServletResponse response, HttpServletRequest req) throws Exception{
    	
    	RoomMapper mapper = sqlSession.getMapper(RoomMapper.class);
    	mapper.DeleteRoom(Integer.parseInt(roomId));
       
    	response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();	 
		out.println("<script>alert('방이 삭제되었습니다.'); opener.parent.location.reload(); window.close();</script>");
		out.flush();
		 
    	return null;
    }
    
    @RequestMapping(value = "/make", method=RequestMethod.GET)
    public void getmake() throws Exception {}
    
    @RequestMapping(value="/make", method=RequestMethod.POST)
    public String postmake(@Valid RoomDTO dto, HttpServletResponse response,RedirectAttributes rttr, HttpServletRequest req, BindingResult bindingResult) throws Exception{
    	HttpSession session = req.getSession();
    	
    	RoomMapper mapper = sqlSession.getMapper(RoomMapper.class);
    	List<RoomDTO> roomDtoList = new ArrayList<RoomDTO>();
    	roomDtoList = mapper.selectRooms();
        
    	int roomcount = 1;
    	for(RoomDTO roomDto : roomDtoList) {
    		if(Integer.parseInt(roomDto.getId()) != roomcount) {
    			break;
    		}
    		roomcount +=1;
    	}
    	String roomId = Integer.toString(roomcount);
	
		dto.setId(roomId);
    	dto.setMaster(((MemberVO)session.getAttribute("loginid")).getId());
    	mapper.InsertRoom(dto);
    	response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();	 
		out.println("<script>opener.parent.location.reload(); window.close();</script>");
		out.flush();
		return null;
    }
    
    @RequestMapping(value = "/chat", method=RequestMethod.GET)
    public String chat(Model model, @RequestParam(value="roomID")String roomID, HttpServletRequest req) {
    	HttpSession session = req.getSession();
    	
    	MemberVO login = new MemberVO();
    	login = (MemberVO)session.getAttribute("loginid");
    	String loginid = login.getId();
    	session.setAttribute("roomID", roomID);

    	model.addAttribute("id", loginid);
    	
    	RoomMapper room = sqlSession.getMapper(RoomMapper.class); 	
    	RoomDTO mapperRoom = room.selectRoomInfo(roomID);
    	model.addAttribute("subject", mapperRoom.getSubject());
    	model.addAttribute("master", mapperRoom.getMaster());
    	
    	System.out.println(loginid + "   1  " + mapperRoom.getMaster());
    	return "chat";
    }
}
