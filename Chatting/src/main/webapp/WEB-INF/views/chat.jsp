<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Websocket Client</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript">

    var url = window.location.host;//웹브라우저의 주소창의 포트까지 가져옴
    var pathname = window.location.pathname; /* '/'부터 오른쪽에 있는 모든 경로*/
    var appCtx = pathname.substring(0, pathname.indexOf("/",2));
    var root = url+appCtx;
    var path ="/chat"; //프로젝트 패스
     
    //var ws = new WebSocket("ws://192.168.0.100:8081/SpringWeb/echo-ws");
    var ws = new WebSocket("ws://"+root+"/echo-ws");
   
    ws.onopen = function () {
    	$('input[name=chatInput]').focus();
        $('#chatStatus').text('Info: connection opened.');
        $('input[name=chatInput]').on('keydown', function(evt){
            if(evt.keyCode==13&&$('input[name=chatInput]').val()!=""){
                var msg = {
                	    type: "message",
                	    text: $('input[name=chatInput]').val(),
                	    id:   "${id}",
                	    date: Date.now()
                	    };
                ws.send(JSON.stringify(msg));
                $('input[name=chatInput]').val('');
            }
        });
        $('input[id=chatButton]').on('click', function(evt){
        	if($('input[name=chatInput]').val()!=""){
                var msg = {
                	    type: "message",
                	    text: $('input[name=chatInput]').val(),
                	    id:   "${id}",
                	    date: Date.now()
                	    };
                ws.send(JSON.stringify(msg));
                $('input[name=chatInput]').val('');
        	}
            $('input[name=chatInput]').focus();
        });
        
        $('input[id=deleteButton]').on('click', function(evt){
                var msg = {
                	    type: "delete",
                	    text: "방장이 퇴장하였으므로 퇴장 시 재입장이 불가능합니다.",
                	    id:   "${id}",
                	    date: Date.now()
                	    };
                ws.send(JSON.stringify(msg));
        });
    };
    ws.onmessage = function (event) {
    	$('div#participants').empty();
    	var text = "";
    	var msg = JSON.parse(event.data);
    	var time = new Date(msg.date);
    	var ampm = (time.getHours()>12 ?  "PM" : "AM");
    	var h = (time.getHours()>12 ? time.getHours()-12 : time.getHours());
    	var m = time.getMinutes();
    	if (m>=0&&m<=9){
    		m="0"+m;
    	}
    	var timeStr = ampm+" "+h+":"+m;
    	
	    switch(msg.type) {
	      case "id":
	        clientID = msg.id;
	        setUsername();
	        break;
	      case "message":
	        if (msg.id == "${id}"){
		        html ='';
		        html += '<div style="float:right;">';
		        html += ' <div style= "background:#D4F4FA; max-width:250px; word-wrap: break-word; border-radius: 7px; padding:5px;">' + msg.text + '</div>';
		        html += ' <span style="font-size:10px;">' + timeStr + '</span>';
		        html += '</div><div style="clear:both"></div><br>';
	        }else{
		        html ='';
	        	html += '<div style="float:left; margin-left:3px;">';
		        html += ' <span>' + msg.id + '</span><br>';
		        html += ' <div style="background:#E4F7BA; max-width:250px; word-wrap: break-word; border-radius: 7px; padding:5px;">' + msg.text + '</div>';
		        html += ' <span style="font-size:10px; text-align:left;">' + timeStr + '</span>';
		        html += '</div><div style="clear:both"></div><br>';
	        }
	    	 $('div#placeholder').hide();
	        break;
	      case "file":
	    	  if (msg.id == "${id}"){
	    		  	html ='';
			        html += '<div style="float:right;">';
			        html += ' <div style= "background:#D4F4FA; max-width:250px; word-wrap: break-word; border-radius: 7px; padding:5px;">' + msg.text + '</div>';
			        html += ' <span style="font-size:10px;">' + timeStr + '</span>';
			        html += '</div><div style="clear:both"></div><br>';
		        }else{
		        	html ='';
		        	html += '<div style="float:left; margin-left:3px;">';
			        html += ' <span>' + msg.id + '</span><br>';
			        html += ' <div style="background:#E4F7BA; max-width:250px; word-wrap: break-word; border-radius: 7px; padding:5px;">' + msg.text + '</div>';
			        html += ' <span style="font-size:10px;">' + timeStr + '</span>';
			        html += '</div><div style="clear:both"></div><br>';
		        }
	     	 $('div#placeholder').hide();
	          break;
	      case "participants":
	    	  html ='';
	    	  html = ' <span>' + msg.text + '</span>';
	    	  break;
	      case "delete":
	      case "notice":
	    	  	html ='<center>';
		        html += ' <div style="background:#eaeaea; max-width:400px; word-wrap: break-word; border-radius: 7px; padding:5px;">' + msg.text + '</div>';
		        html += '</center><br>';
		       break;
	    }
	   	if(msg.type == "participants"){
	   		$('div#participants').empty();
	   		$('div#participants').append(html);
	   	}else{
    	$('div#view').append(html);
    	//$("div#view").scrollTop($("div#view").prop('scrollHeight'));
	   	}   	
    	//$("div#view").scrollTop($("div#view")[0].scrollHeight);
	   	$("div#view").scrollTop($("div#view").prop('scrollHeight'));
    };
    
    ws.onclose = function (event) {
        $('#chatStatus').text('Info: connection closed.');
    };
    
    //파일 업로드---------------------------------------------------
    //원본파일이름을 목록에 출력하기 위해
	function getOriginalName(fileName) {
	    // 이미지 파일이면
	    if(checkImageType(fileName)) {
	        return; // 함수종료
	    }
	    // uuid를 제외한 원래 파일 이름을 리턴
	    var idx = fileName.indexOf("_")+1;
	    return fileName.substr(idx);
	}
	
	//이미지파일 링크 - 클릭하면 원본 이미지를 출력해주기 위해
	function getImageLink(fileName) {
	    // 이미지파일이 아니면
	    if(!checkImageType(fileName)) { 
	        return; // 함수 종료 
	    }
	    // 이미지 파일이면(썸네일이 아닌 원본이미지를 가져오기 위해)
	    // 썸네일 이미지 파일명 - 파일경로+파일명 /2017/03/09/s_43fc37cc-021b-4eec-8322-bc5c8162863d_spring001.png
	    var front = fileName.substr(0, 12); // 년원일 경로 추출
	    var end = fileName.substr(14); // 년원일 경로와 s_를 제거한 원본 파일명을 추출
	    console.log(front); // /2017/03/09/
	    console.log(end); // 43fc37cc-021b-4eec-8322-bc5c8162863d_spring001.png
	    // 원본 파일명 - /2017/03/09/43fc37cc-021b-4eec-8322-bc5c8162863d_spring001.png
	    console.log("a"+front+end);
	    return front+end; // 디렉토리를 포함한 원본파일명을 리턴
	}
	
	//이미지파일 형식을 체크하기 위해
	function checkImageType(fileName) {
	    // i : ignore case(대소문자 무관)
	    var pattern = /jpg|gif|png|jpeg/i; // 정규표현식
	    return fileName.match(pattern); // 규칙이 맞으면 true
	}

    $(document).ready(function(){
        $("#view").on("dragenter dragover", function(event){
            event.preventDefault(); // 기본효과를 막음
        });
        // event : jQuery의 이벤트
        // originalEvent : javascript의 이벤트
        $("#view").on("drop", function(event){
            event.preventDefault(); // 기본효과를 막음
            
            // 드래그된 파일의 정보
            var files = event.originalEvent.dataTransfer.files;
            // 첫번째 파일
            var file = files[0];
            // 콘솔에서 파일정보 확인
            console.log(file);

            // ajax로 전달할 폼 객체
            var formData = new FormData();
            // 폼 객체에 파일추가, append("변수명", 값)
            formData.append("file", file);


            $.ajax({
                type: "post",
                url: path+"/upload/uploadAjax",
                data: formData,
                dataType: "text",
                processData: false,
                contentType: false,
                success: function(data){
                    var str = "";
                    var imgurl ="";
                    // 이미지 파일이면 썸네일 이미지 출력
                    if(checkImageType(data)){ 
                    	imgurl = path+"/upload/displayFile?fileName="+encodeURI(getImageLink(data));
                        str = "<a href='#' onclick='openLayer(\""+imgurl+"\")'>";
                        str += "<img src='"+path+"/upload/displayFile?fileName="+encodeURI(data)+"' style='height:100px;'></a>";
                    // 일반파일이면 다운로드링크
                    } else { 
                        str = "<a href='"+path+"/upload/displayFile?fileName="+data+"'>"+getOriginalName(data)+"</a>";
                    }

               	 	var msg = {
                    	    type: "file",
                    	    text: str,
                    	    id: "${id}",
                    	    date: Date.now()
                    	    };
                    ws.send(JSON.stringify(msg));
                }
            });
        });
    });
   	
   	var cnt = 0;
   	function openLayer(imgurl){
   		if(cnt==0){
   			cnt++;
   			var pop = document.getElementById("layerPop");
   		    var img = document.getElementById("layerImg");
   		    img.src=imgurl;
   			pop.style.display = "block";
   			pop.style.top = 50 + "px";
   			pop.style.left = 50 + "px";
   		}
   	}
   	
   	function closeLayer(){
   		var pop = document.getElementById("layerPop");
   		pop.style.display = "none";
   		cnt=0;
   	}
</script>
</head>
<body>
<div id="layerPop" style="position:absolute; width:500px; height:400px; display:none; line-height: 300px; text-align: center">
      <a href="#" onclick="closeLayer('layerPop')" class="close">
      	<img id="layerImg" src="" style="border:none; max-width: 500px; max-height: 400px; vertical-align: middle"/>
      </a>
</div>
<!-- <div id='chatStatus'></div> -->
<div style = "width : 803px; height : 30px;">
	<div style="text-size:20px; padding:5px; border:1px solid #00AE8E; border-bottom: 0px; text-align: center;'"><b>${subject}</b></div>
	<div id="view" style="overflow:auto; border:1px solid #00AE8E; border-right:none; height :400px; width:600px; float:left">
	<div id="placeholder" style=" position: absolute; top:0; bottom:0; left:10px; right:0; margin:auto 0; height:15px; 
  width:600px;color:#888888;font-size:15px;text-align:center;">파일은 마우스로 끌어오세요.</div>	
	</div>
	<div style="float:left; width:202px; height:400px;">
		<div style="text-align : center; width :202px; height :30px; line-height:30px; background:#00AE8E; color:white;">참여인원</div>
		<div id="participants" style="width :200px; height : 370px; border:1px solid #00AE8E;"></div>
	</div>
	<br>
	<div style="clear:Both; width:803px; padding-top:10px;">
		<input type="text" name="chatInput" style="float:left; width:430px; font-size:20px; height:30px; ">
		<input type="button" id="chatButton" value="보내기" style="margin-left:10px; width:150px; font-size:17px; float:left; height:30px; text-align: 
		center;background: #00AE8E ;border: none; border-radius: 5px; color:white;">
		

		<c:if  test="${id == master}">
			<form method="post" action="./delete">
			<input type="hidden" id="roomId" name="roomId" value="<%=request.getParameter("roomID").toString()%>">
			<input type="submit" id="deleteButton" value="방 삭제" style="width:150px; font-size:17px; float:right; height:30px; text-align: 
			center;background: #00AE8E ;border: none; border-radius: 5px; color:white;">
			</form>
		</c:if>
	</div>
</div>
</body>
</html>