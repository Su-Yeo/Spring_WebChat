<%@page import="org.springframework.ui.Model"%>
<p><%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Websocket Client</title>
<link rel="stylesheet"  href="resources/home.css" type="text/css"/>
<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
<script type="text/javascript">
	var popupX = (window.screen.width / 2) - (750 / 2);
	var popupY= (window.screen.height / 2) - (530 / 2);
	var popupX2 = (window.screen.width / 2) - (820 / 2);
	var popupY2= (window.screen.height / 2) - (490 / 2);
</script>
</head>
<body>
<center>
<div style = "min-width : 1040px; height : 700px; text-align : center;">
	<div style = "text-align : center; font-size:35px; display:table-cell; height:50px; vertical-align:middle;
	 color:#00AE8E; font-weight:bold; border:1px solid #eaeaea;
	 width:1020px; background-color: white;">Spring Web Chatting</div>

	<div style = "width:1040px; height:20px;"></div>
	<div style ="width:700px; height : 630px; float:left;">
		<div style = "width:100%; height:120px; border:1px solid #eaeaea; margin-bottom: 20px; background-color: white;">

				<c:if test="${loginid.id != null }">
				<button class="mkroomButton" style ="float:right; margin-top:10px; margin-right:15px; width:100px; height: 100px;" onclick="window.open('./make', 'windo', 'width=750,height=530,left=' + popupX + ',top='+ popupY)">방만들기</button>
					<c:if test="${loginid.id!='test'}">
						<table style="text-align:left; padding-left:10px; float:left; width: 570px;">
					</c:if>
				</c:if>
				
				<c:if test="${loginid.id=='test'}">
				<button class="mkroomButton" style ="float:right; margin-top:10px; margin-right:10px; width:100px; height: 100px;" onclick="window.open('./makenotice', 'windo', 'width=750,height=530,left=' + popupX + ',top='+ popupY)">등록하기</button>
				<table style="text-align:left; padding-left:10px; float:left; width: 465px;">
				</c:if>
				
				<c:if test="${loginid.id==null}">
					<table style="text-align:left; padding-left:10px; float:left; width: 690px;">
				</c:if>

				
					<tr>
						<th style="color:#00AE8E; font-size:30px;">Notice</th>
					</tr>
				<c:forEach var="notice" items="${notice}">
					<tr>
						<td style="border-bottom:1px solid #00AE8E;">
							${notice.comment}
						</td>
					</tr>
					</c:forEach>
				</table>
		</div>
		

		<div style = "width:100%; height:35px; border:1px solid #eaeaea; background-color: white; color:#00AE8E; margin-bottom: 10px;">
			<div style ="float:left; width:100px; font-weight:bold; margin-left:9px; text-align:center; font-size: 25px; font-family: Malgun Gothic;">
				방 번호
			</div>
			
			<div style ="float:left; width:340px; font-weight:bold; margin-left:10px; text-align:center; font-size: 25px; font-family: Malgun Gothic;">
				제목
			</div>
			
			<div style ="float:left; width:100px; font-weight:bold; margin-left:10px; text-align:center; font-size: 25px; font-family: Malgun Gothic;">
				방장
			</div>
		</div>
		
		<div style = "width:100%; height:393px; border:1px solid #eaeaea; overflow-y:scroll;">
			<table style ="width:100%; cellspacing:0; background-color: white; border-spacing:0px 0px;">
				<c:forEach var="room" items="${room}">
					<tr style ="width:100%; height:40px; background-color: white;">
						<td style ="border:1px solid #eaeaea; background-color: white;">
							<div style ="float:left; color:black; background-color:white;
										 font-size:20px;
										 height:23px; width:98px; text-align:center;
										 margin-left:5px; display: table-cell; vertical-align: middle;
										 border-bottom:1px solid #00AE8E;">
								${room.id}
							</div>
							<div style ="float:left; color:black; background-color:white;
										 font-size:20px;
										 height:23px; width:338px; text-align:left;
										 margin-left:10px; display: table-cell; vertical-align: middle;
										 border-bottom:1px solid #00AE8E;">
								${room.subject}
							</div>
							<div style ="float:left; color:black; background-color:white;
										 font-size:20px;
										 height:23px; width:98px; text-align:left;
										 margin-left:10px; display: table-cell; vertical-align:bottom;
										 border-bottom:1px solid #00AE8E;">
								${room.master}
							</div>
							<c:if test="${loginid.id != null }">
							<div style ="float: left; width:90px; height:25px; margin-top:-4px; margin-left: 5px;">
								<button class="inButton" style=" height:25px; width:90px;" onClick="window.open('./chat?roomID=${room.id}', 'windo', 'width=820,height=490,left=' + popupX2 + ',top='+ popupY2)">입장</button>
							</div>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	
	<div style="float:left; width:300px; height: 630px; text-align:center; margin-left:20px;">
		<div style="border:1px solid #eaeaea; background-color: white;">
			<%if(request.getParameter("join") != null){%>
				<jsp:include page="join.jsp" flush="false"/>
			<%}else{ %>
				<jsp:include page="login.jsp" flush="false"/>
			<%} %>
		</div>
		
		<div style="margin-top:20px; border:1px solid #eaeaea;">
			<img src="resources/img/symbol.png" style="width:100%; height:302px;"/>
		</div>
	</div>
</div>
</center>
</body>
</html></p>