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
// 전역 변수: WebSocket 연결, 채팅방 번호, 상대방 닉네임, 그리고 내 닉네임
var ws;
var currentRoom = "";
var partnerNickname = "";
var myNickname = ""; // 내 닉네임을 저장할 전역 변수

// 문서가 준비되면 내 닉네임을 서버에서 한 번만 조회
$(document).ready(function(){
    $.ajax({
        url: "${pageContext.request.contextPath}/chat/getMyNickname.do",
        type: "GET",
        dataType: "json",
        success: function(response){
            myNickname = response.nickname;
            console.log("내 닉네임:", myNickname);
        },
        error: function(err) {
            console.error("내 닉네임 로드 실패", err);
        }
    });
    
    // 엔터키: 전송, Shift+Enter: 줄바꿈 처리
    $('#content').keydown(function(e) {
        if (e.key === 'Enter' && !e.shiftKey) {
            e.preventDefault();  // 줄바꿈 방지
            $('#chatForm').submit();
        }
    });
    
    // 채팅방 버튼 클릭 이벤트
    $('.toggle-btn').click(function(){
        // 이미 활성화된 버튼이면 해제 후 채팅 내용 비우기
        if ($(this).hasClass('active')) {
            $(this).removeClass('active');
            $('#chatBox').empty();
            if (ws && ws.readyState === WebSocket.OPEN) {
                ws.close();
            }
            return;
        }
        
        // 모든 버튼 비활성화 후 현재 버튼 활성화
        $('.toggle-btn').removeClass('active');
        $(this).addClass('active');
        
        // 버튼의 data 속성에서 채팅방 번호와 상대 닉네임 추출
        currentRoom = $(this).data('chatroom');
        partnerNickname = $(this).data('nickname');
        
        // AJAX로 해당 채팅방의 채팅 내역 로드
        $.ajax({
            url: "${pageContext.request.contextPath}/chat/chat.do",
            type: "GET",
            data: { nickname: partnerNickname },
            dataType: "json",
            success: function(response) {
                $('#chatBox').empty();
                $.each(response, function(index, message){
                    // 내 닉네임과 비교해서 내 메시지이면 "나", 아니면 실제 sender를 사용
                    var isMyMessage = (message.sender === myNickname);
                    var senderDisplay = isMyMessage ? "나" : message.sender;
                    var cssClass = isMyMessage ? "mine" : "other";
                    
                    $('#chatBox').append(
                        '<p class="'+ cssClass +'"><strong>' + senderDisplay + ' : </strong>' 
                        + message.content + ' <em>(' + new Date(message.postDate).toLocaleTimeString() + ')</em></p>'
                    );
                });
                $('#chatBox').scrollTop($('#chatBox')[0].scrollHeight);
            },
            error: function(err) {
                console.error("채팅 내역 로드 실패", err);
            }
        });
        
        // 기존 WebSocket 연결 종료
        if (ws && ws.readyState === WebSocket.OPEN) {
            ws.close();
        }
        
        // 새로운 WebSocket 연결 생성 (URL은 서버 환경에 맞게)
        var wsUrl = "ws://" + window.location.host + "/lighting/chat/" + currentRoom;
        ws = new WebSocket(wsUrl);
        
        ws.onopen = function() {
            console.log("WebSocket 연결 성공: 채팅방 " + currentRoom);
        };
        
        ws.onmessage = function(event) {
            var data = JSON.parse(event.data);
            console.log("partnerNickname:", partnerNickname);
            console.log("data.sender:", data.sender);
            // data.sender가 내 닉네임과 같으면 내 메시지, 그렇지 않으면 상대 메시지로 구분
            var isMyMessage = (data.sender === myNickname);
            var senderDisplay = isMyMessage ? "나" : data.sender;
            var cssClass = isMyMessage ? "mine" : "other";
            
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
    
    // 메시지 전송 이벤트 처리: 내 닉네임을 sender로 사용
    $('#chatForm').submit(function(e){
        e.preventDefault();
        if (!ws || ws.readyState !== WebSocket.OPEN) {
            console.error("WebSocket 연결이 되어있지 않습니다.");
            return;
        }
        var sender = myNickname;
        var content = $('#content').val();
        var message = JSON.stringify({ sender: sender, content: content });
        ws.send(message);
        $('#content').val('');
    });
    
    // 채팅방 생성 버튼 클릭 이벤트 처리
    $('#createChatRoomBtn').click(function(){
        var inputNickname = $('#nickname').val().trim(); // 상대방 닉네임 입력값
        var tblMemberSeq = $('#tblMemberSeq').val(); // 내 회원 시퀀스 (hidden input 등)
        
        // 이미 해당 상대방과 채팅방이 있는지 확인
        var found = false;
        $('.toggle-btn').each(function(){
            if ($(this).data('nickname').toLowerCase() === inputNickname.toLowerCase()){
                found = true;
                $(this).click();
                return false;
            }
        });
        
        // 없으면 AJAX 요청으로 새 채팅방 생성
        if (!found) {
            var createUrl = "${pageContext.request.contextPath}/ChatRoomCreateServlet";
            $.ajax({
                url: createUrl,
                type: "POST",
                data: {
                    tblMemberSeq: tblMemberSeq,
                    nickname: inputNickname
                },
                dataType: "json",
                success: function(response){
                    if(response.tblChatRoomSeq) {
                        // 동적으로 새로운 버튼 추가 후 클릭 이벤트 실행
                        var newButton = $('<button type="button" class="toggle-btn" data-chatroom="' 
                            + response.tblChatRoomSeq + '" data-nickname="' + inputNickname + '">'
                            + inputNickname + '와 채팅하기</button>');
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
    
    // 로고 클릭 시 메인 페이지로 이동
    $('#logo').click(function(){ 
        window.location.href = '${pageContext.request.contextPath}/main.do';
    });
});
</script>


</body>
</html>
