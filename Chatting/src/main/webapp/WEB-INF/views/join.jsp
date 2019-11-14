<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
   <title>Home</title>
   <style type="text/css">
      body{
         background-color: #FCFCFC;   
      }
      .size{
         width:300px;
           height:40px;
           font-size:15px;
      }
      div{
         width:300px;

           text-align : center;
      }
      .btn{
    width:280px;
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
<body >
<div  class="page">
   <form method="post" action="join">
               
            <p></p>
            <input id="id" placeholder="아이디"  class="size" type="text" name="id" maxlength="10" style="width:280px; border: 1px solid #EAEAEA;">
            
            <p></p>
            <input id="name" placeholder="이름" class="size" type="text"  name="name" maxlength="10" style="width:280px; border: 1px solid #EAEAEA;">
               
            <p></p>
            <input id="pw" placeholder="비밀번호"  class="size" type="password" name="pw" maxlength="10" style="width:280px; border: 1px solid #EAEAEA;">
               
            <p></p>
            <button type="submit" class="btn"; id="btn">회원가입</button>
            <center>
   </form>
   
   </div>
</body>
</html>