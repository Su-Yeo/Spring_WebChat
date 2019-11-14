package com.spring.chat;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.mapper.NoticeMapper;

@Controller
public class NoticeController {
    @Autowired
    private SqlSession sqlSession;
    
    @RequestMapping(value = "/makenotice", method=RequestMethod.GET)
    public void GetMakeNotice() throws Exception {}
    
    @RequestMapping(value = "/makenotice", method=RequestMethod.POST)
    public String PostMakeNotice(String comment, HttpServletResponse response) throws Exception {
    	NoticeMapper noticeMapper = sqlSession.getMapper(NoticeMapper.class);
    	noticeMapper.InsertNotice(comment);
    	
    	response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();	 
		out.println("<script>opener.parent.location.reload(); window.close();</script>");
		out.flush();
		
    	return null;
    }
}
