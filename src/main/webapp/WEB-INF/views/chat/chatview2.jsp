<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/inc/asset.jsp" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>오늘어때?</title>
<style>
  body {
    background-color: #fff;
    font-family: 'Pretendard-Regular';
  }

  .container {
    width: 1300px;
    margin: 0 auto;
    padding: 40px 20px;
    background-color: #f9f7ff;
    min-height: 100vh;
    position: relative;
  }

  #logo {
    position: absolute;
    top: 15px;
    left: 15px;
    width: 250px;
    cursor: pointer;
  }

  .chatTitle {
    font-size: 18px;
    text-align: center;
    margin-top: 60px;
    margin-bottom: 30px;
  }

  .chat-wrapper {
    display: flex;
    justify-content: center;
    gap: 20px;
  }

  .button-group {
    display: flex;
    flex-direction: column;
    width: 200px;
  }

  .toggle-btn {
    width: 100%;
  margin-top: 12px;
  padding: 10px 14px;
  background-color: #eaeaea;
  border: none;
  cursor: pointer;
  border-radius: 6px;
  text-align: left;
  }

  .toggle-btn.active {
    background-color: #007BFF;
    color: #fff;
  }

  #nickname {
    width: 100%;
    height : 40px;
    box-sizing: border-box;
    border-radius: 6px 6px 0 0;
    margin-bottom: 0;
    border: 1px solid #1e62c8;
  }
  
  #createChatRoomBtn {
	width: 100%;
	box-sizing: border-box;
	margin-top: 0;
    padding: 10px 14px;
    border-radius: 0 0 6px 6px;
    background-color: #1e62c8;
    color: #fff;
    border: none;
    cursor: pointer;
  }


  #chatBox {
    width: 700px;
    height: 400px;
    border: 1px solid #000;
    overflow-y: scroll;
    background: #fff;
    padding: 10px;
    border-radius: 6px;
  }

  #chatBox p {
    margin: 6px 0;
  }

  #chatBox .mine {
    color: #000;
  }

  #chatBox .other {
    color: #1e62c8;
  }

  .chat-input {
    margin-top: 10px;
    display: flex;
    gap: 8px;
  }

  #content {
    flex: 1;
    padding: 10px;
    border-radius: 6px;
    border: 1px solid #ccc;
    resize: none;
  }

  #chatForm button[type="submit"] {
    padding: 10px 20px;
    background-color: #1e62c8;
    color: #fff;
    border: none;
    border-radius: 6px;
    cursor: pointer;
  }
</style>
</head>
<body>
    <div class="container">
    <img src="/lighting/images/logo_가로.png" id="logo" alt="로고" />

    <div class="chatTitle"><br><br></div> 

    <div class="chat-wrapper">
      <div class="button-group">
        <input type="text" id="nickname" name="nickname" placeholder="닉네임" />
        <button type="button" id="createChatRoomBtn">채팅방 생성</button>
        <c:forEach var="room" items="${chatRooms}">
          <button type="button" class="toggle-btn" 
                  data-chatroom="${room.tblChatRoomSeq}" 
                  data-nickname="${room.nickname}">
            ${room.nickname}와 채팅하기
          </button>
        </c:forEach>
      </div>

      <div>
        <div id="chatBox"></div>
        <form id="chatForm" class="chat-input">
          <textarea id="content" name="content" rows="2" placeholder="메시지를 입력하세요..."></textarea>
          <button type="submit">전송</button>
        </form>
      </div>
    </div>
  </div>
    
    <script>
    
    
    var ws;
    var currentRoom = "";
    
    //엔ㅌ터 : 전송 , 쉬프트 엔터 : 줄바꿈
    $('#content').keydown(function(e){
        if (e.key === 'Enter' && !e.shiftKey) {
            e.preventDefault();  // 줄바꿈 방지
            $('#chatForm').submit();  // 폼 전송 
        }
    });
    
    // 버튼 클릭 시 채팅방 선택 및 WebSocket 연결 설정
    $('.toggle-btn').click(function(){
        // 버튼 활성화 처리
       //$('.toggle-btn').removeClass('active');
        //$(this).addClass('active');
        var isActive = $(this).hasClass('active');
        
        
     // 이미 눌린 상태면 해제 처리
        if (isActive) {
            $(this).removeClass('active');
            $('#chatBox').empty();

            if (ws && ws.readyState === WebSocket.OPEN) {
                ws.close();
            }

            return; 
        }

        // 나머지는 새로운 채팅방 클릭 시 동작
        $('.toggle-btn').removeClass('active');
        $(this).addClass('active');
        
        // 채팅방 번호와 닉네임 설정
        var currentRoom = $(this).data('chatroom');
	    var nickname = $(this).data('nickname');
	    var currentMemberSeq = $('#tblMemberSeq').val();
        
	    $.ajax({
	        url: "${pageContext.request.contextPath}/chat/chat.do",
	        type: "GET",
	        data: { nickname: nickname },
	        dataType: "json",
	        success: function(response) {
	            $('#chatBox').empty();
	            // 서버에서 받은 JSON 배열(response)을 순회하며 메시지 출력
	            $.each(response, function(index, message){
	                // 서버에서 'sender'에 "나" 또는 상대방 닉네임을 설정하므로 그대로 사용합니다.
	                var senderDisplay = message.sender;
	                $('#chatBox').append(
	                    '<p><strong>' + senderDisplay + ' : </strong>' + message.content + 
	                    ' <em>(' + new Date(message.postDate).toLocaleTimeString() + ')</em></p>'
	                );
	            });
	            $('#chatBox').scrollTop($('#chatBox')[0].scrollHeight);
	        },
	        error: function(err) {
	            console.error("채팅 내역 로드 실패", err);
	        }
	    });
	    
        // 기존 WebSocket 연결이 있다면 종료
        if(ws && ws.readyState === WebSocket.OPEN) {
            ws.close();
        }
        
        // WebSocket 연결 생성 (URL은 서버 환경에 맞게 수정)
        var wsUrl = "ws://" + window.location.host + "/lighting/chat/" + currentRoom;
        ws = new WebSocket(wsUrl);
        
        ws.onopen = function() {
        	console.log("WebSocket 연결 성공: 채팅방 " + currentRoom);
        };
        
        ws.onmessage = function(event) {
            var data = JSON.parse(event.data);
            var currentNickname = $('#nickname').val();
            var isMine = (data.sender === currentNickname);
            var senderDisplay = isMine ? "나" : data.sender;
            var cssClass = isMine ? "mine" : "other";

            $('#chatBox').append(
            	    `<p class="\${cssClass}"><strong>\${senderDisplay} :</strong> \${data.content} 
            	    <em>(\${new Date(data.timestamp).toLocaleTimeString()})</em></p>`
            	  );

            $('#chatBox').scrollTop($('#chatBox')[0].scrollHeight);
        };
        
        ws.onclose = function() {
            console.log("WebSocket 연결 종료");
        };
        
        ws.onerror = function(error) {
            console.error("WebSocket 오류", error);
        };
    });
    
    // 메시지 전송 이벤트 처리
    $('#chatForm').submit(function(e){
        e.preventDefault();
        if(!ws || ws.readyState !== WebSocket.OPEN) {
            console.error("WebSocket 연결이 되어있지 않습니다.");
            return;
        }
        var sender = $('#nickname').val();
        var content = $('#content').val();
        var message = JSON.stringify({ sender: sender, content: content });
        ws.send(message);
        $('#content').val('');
    });
    
 // 채팅방 생성 버튼 클릭 이벤트 처리
    $('#createChatRoomBtn').click(function(){
        var nickname = $('#nickname').val().trim();
        var tblMemberSeq = $('#tblMemberSeq').val();

        // 입력된 닉네임과 기존 버튼의 data-nickname(대소문자 무시) 비교
        var found = false;
        $('.toggle-btn').each(function(){
            if ($(this).data('nickname').toLowerCase() === nickname.toLowerCase()){
                found = true;
                $(this).click();
                return false;
            }
        });
        
        // 존재하지 않을 경우 AJAX 요청으로 새 채팅방 생성
        if(!found){
        	var createUrl = "${pageContext.request.contextPath}/ChatRoomCreateServlet";
            $.ajax({
                url: createUrl,
                type: "POST",
                data: {
                    tblMemberSeq: tblMemberSeq,
                    nickname: nickname
                },
                dataType: "json",
                success: function(response){
                    if(response.tblChatRoomSeq) {
                        // 동적으로 새로운 버튼 추가 후 클릭 이벤트 실행
                        var newButton = $('<button type="button" class="toggle-btn" data-chatroom="' 
                            + response.tblChatRoomSeq + '" data-nickname="' + nickname + '">'
                            + nickname + '와 채팅하기</button>');
                        $('.button-group').append(newButton);
                        newButton.click();
                    } else {
                        console.error("채팅방 생성 실패");
                    }
                },
                error: function(err) {
                    console.error("채팅방 생성 요청 오류", err);
                }
            });
        }
    });
 
    $('#logo').click(() => { 
        window.location.href =  '/lighting/main.do'; // 메인페이지로 이동
      });
 
    </script>
</body>
</html>
