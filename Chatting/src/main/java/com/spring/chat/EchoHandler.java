package com.spring.chat;


import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.spring.dto.MemberVO;

public class EchoHandler extends TextWebSocketHandler {
	
    @Autowired
    private SqlSession sqlSession;
    
    //private Logger logger = LoggerFactory.getLogger(EchoHandler.class);
    private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
    private Map<WebSocketSession, String> MemberIdMap = new HashMap<WebSocketSession, String>();
    private Map<WebSocketSession, String> RoomIdMap = new HashMap<WebSocketSession, String>();
    // 웹소켓 서버측에 텍스트 메시지가 접수되면 호출되는 메소드
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
    	super.handleTextMessage(session, message);
    	String payloadMessage = (String) message.getPayload();
    	System.out.println("서버에 도착한 메시지:"+payloadMessage);
//    	String roomID = payloadMessage.replaceAll("\"roomID\":\"", "");
//    	roomID = roomID.substring(1, roomID.indexOf("\""));
//    	System.out.println(roomID);
    	Map<String,Object> map = session.getAttributes();
    	String roomID = (String)map.get("roomID");
    	for (WebSocketSession sess : sessionList) {
    		if(RoomIdMap.get(sess).equals(roomID)) {
    			sess.sendMessage(new TextMessage(payloadMessage));
    		}
    	}
    }
 // 웹소켓 서버에 클라이언트가 접속하면 호출되는 메소드
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        super.afterConnectionEstablished(session);
        Map<String,Object> map = session.getAttributes(); 
        
    	MemberVO login = new MemberVO();
    	login = (MemberVO)map.get("loginid");
    	String loginID = login.getId();
    	String roomID = (String)map.get("roomID");
    	
    	System.out.println(loginID);
    	sessionList.add(session);
    	MemberIdMap.put(session, loginID);
    	RoomIdMap.put(session, roomID);
    	
    	Date date = new Date();
    	long now = date.getTime();
    	TextMessage message = new TextMessage("{\"type\":\"notice\",\"text\":\"" + loginID + "님이 입장하셨습니다.\",\"id\":\"" + loginID + "\"," + "\"date\":"+ now +"}");
    	this.handleTextMessage(session, message);
    	
    	String text = "{\"type\":\"participants\",\"text\":\"";
    	for (WebSocketSession sess : sessionList) {
    		if(RoomIdMap.get(sess).equals(roomID)) {
    			text += MemberIdMap.get(sess) + "<br/>";
    		}
    	}
    	text += "\",\"id\":\"" + loginID + "\"," + "\"date\":"+ now +"}";
    	TextMessage message2 = new TextMessage(text);
    	this.handleTextMessage(session, message2);
    	
    	
        System.out.println("클라이언트 접속됨");
    }
 
    // 클라이언트가 접속을 종료하면 호출되는 메소드
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        super.afterConnectionClosed(session, status);
    	String loginID = MemberIdMap.get(session);
    	String roomID = RoomIdMap.get(session);
        Date date = new Date();
    	long now = date.getTime();
    	
    	TextMessage message = new TextMessage("{\"type\":\"notice\",\"text\":\"" + loginID + "님이 퇴장하셨습니다.\",\"id\":\"" + loginID + "\"," + "\"date\":"+ now +"}");
    	
       	String text = "{\"type\":\"participants\",\"text\":\"";
    	for (WebSocketSession sess : sessionList) {
    		if(RoomIdMap.get(sess).equals(roomID)) {
    			if(sess!= session) {
    				text += MemberIdMap.get(sess) + "<br/>";
    			}
    		}
    	}
    	text += "\",\"id\":\"" + loginID + "\"," + "\"date\":"+ now +"}";
    	
    	TextMessage message2 = new TextMessage(text);
    	
    	
    	for (WebSocketSession sess : sessionList) {
    		if(RoomIdMap.get(sess).equals(roomID)) {
    			if(sess!= session) {
    				sess.sendMessage(message);
    				sess.sendMessage(message2);
    			}
    		}
    	}
    
    	sessionList.remove(session);
        MemberIdMap.remove(session);
        RoomIdMap.remove(session);
        System.out.println("클라이언트 접속해제");
    }
 
    // 메시지 전송시나 접속해제시 오류가 발생할 때 호출되는 메소드
    @Override
    public void handleTransportError(WebSocketSession session,
            Throwable exception) throws Exception {
        super.handleTransportError(session, exception);
        System.out.println("전송오류 발생");
    }
}
