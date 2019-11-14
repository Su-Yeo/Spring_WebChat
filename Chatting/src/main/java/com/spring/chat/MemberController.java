package com.spring.chat;


import java.io.PrintWriter;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.dto.MemberVO;
import com.spring.mapper.MemberMapper;
import com.spring.mapper.RoomMapper;
import com.spring.service.MemberService;


@Controller
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
    private SqlSession sqlSession;
	
	@Inject
	MemberService service;
	
	@RequestMapping(value="/join", method = RequestMethod.GET)
	public void getjoin() throws Exception{
		logger.info("get join");
	}
		
	@RequestMapping(value="/join", method = RequestMethod.POST)
	public String postjoin(@Valid MemberVO vo, BindingResult bindingResult, HttpServletResponse response) throws Exception{
		logger.info("post join");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		String idCheck = sqlSession.selectOne("IdCheck", vo.getId());
    	
		if(bindingResult.hasErrors()) {
			out.println("<script>alert('회원가입에 실패했습니다. 빈칸이 있는지 다시한번 확인해주세요.'); location.href='./?join=join';</script>");
			out.flush();
			return null;
		}else if(idCheck!=null) {
			out.println("<script>alert('사용하고 있는 아이디입니다.'); location.href='./?join=join';</script>");
			out.flush();
			return null;		
		}else {
			out.println("<script>alert('회원가입성공.'); location.href='./';</script>");
			out.flush();
			service.join(vo);
			return null;
		}
		
	}
	
	@RequestMapping(value="/login1", method= {RequestMethod.POST, RequestMethod.GET})
	public String login(MemberVO vo, HttpServletRequest req, RedirectAttributes rttr, HttpServletResponse response) throws Exception
	{
		logger.info("post login");
		
		HttpSession session = req.getSession();
		MemberVO login = service.login(vo); 
		if(login == null) {
			logger.info("로그인if");
			session.setAttribute("loginid", null);
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();	 
			out.println("<script>alert('로그인에 실패했습니다. 아이디나 비밀번호를 확인해주세요.'); location.href='';</script>");
			out.flush();

			rttr.addFlashAttribute("msg", false);	
			return null;
		}
			else {
				logger.info("로그인시도 else");
				session.setAttribute("loginid", login);		
				return "redirect:/";
			}
		
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) throws Exception {
	 logger.info("get logout");
	 
	 session.invalidate();
	   
	 return "redirect:/";
	}
	
}
