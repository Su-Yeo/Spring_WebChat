<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>

<html>
<head>
	<title>home</title>
	<style>
	body{
	
	background-color: #FCFCFC; 
}
#size{
	width:300px;
	height:40px;
	font-size:15px;
}
div{
	width:300px;
	text-align : center;
  }
#btn{
	width:132px;
	background-color: #00AE8E;
	border: none;
	color:#fff;
	padding: 15px 0;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 15px;
	margin: 4px;
	cursor: pointer;
	border-radius:10px;
	}
	</style>
</head>
<body>
<div class="page">
   	<div style = "text-align : center; font-size:30px; display:table-cell; height:72px; vertical-align:middle;
	 color:#00AE8E; font-weight:bold;
	 min-width:300px;">Web Chatting</div>
<c:if test="${loginid == null}">
   <form method="post" action="login1">
	 
            <input id="size" placeholder="아이디" type="text" name="id" maxlength="20" style="width:280px; border: 1px solid #EAEAEA;">
               
            <p></p>
            <input id="size" placeholder="비밀번호" type="password" name="pw" maxlength="20" style="width:280px; border: 1px solid #EAEAEA;">
               
            <p></p>
            
            <button type="submit" id="btn">로그인</button>
            <input id="btn" type="button" onclick="location='/chat?join=join'" value="회원가입">
   </form>
<%--    <c:if test="${msg==false}">
   <span style="color:#f00;">로그인에 실패했습니다.<br/> 아이디나 비밀번호를 확인해주세요. </span>
   </c:if> --%>
   	
 </c:if>
   <c:if test="${loginid != null}">
   <form method="get" action="logout">
   <div style = "text-align : center; font-size:30px; display:table-cell; height:112px;
	 font-weight:bold;
	 min-width:300px;">${loginid.id}님<br>환영합니다</div>
   <button type="submit" id="btn" style="width:280px;">로그아웃</button>
   </form>
   </c:if>
  
   </div>
</body>
</html>