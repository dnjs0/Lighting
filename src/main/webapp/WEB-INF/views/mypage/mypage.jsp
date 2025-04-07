<%-- <%@page import="com.lighting.mypage.model.MemberDAO"%> --%>
<%@page import="java.util.ArrayList"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.lighting.mypage.model.MeetingDAO, com.lighting.mypage.model.MeetingDTO, com.lighting.mypage.model.MemberDTO" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/inc/asset.jsp" %>
<meta charset="UTF-8">

<title>오늘어때?</title>
<script>
    window.onload = function() {
        let status = sessionStorage.getItem('status');

        if (status) {
            $.ajax({
                url: '/lighting/mypage/setSessionStatus.do',
                type: 'POST',
                data: { status: status },
                success: function(response) {
                },
                error: function(error) {
                    console.error('Error updating session status:', error);
                }
            });
        }
    };
    
    function changeStatusAndMove(status, url) {
        sessionStorage.setItem('status', status);

        $.ajax({
            url: '/lighting/mypage/setSessionStatus.do',
            type: 'POST',
            data: { status: status },
            success: function(response) {
                location.href = url; // AJAX 요청 완료 후 페이지 이동
            },
            error: function(error) {
                console.error('Error updating session status:', error);
            }
        });
    }
</script>

        <!-- 전체 박스 -->
    <style> 

        body {
            margin: 0;
        }

        #mypageLogo {
            display: inline-block;
            margin: 20px 0 20px 60px;
            color: #0D0143;
        }

        #back_box {
          width: 1300px;
          margin: 0 auto;
          background-color: #f9f7ff;
        }
      
        #grid_box {
          display: grid;
          grid-template-columns: 300px auto 200px; /* 3열 */
          grid-template-rows: repeat(2, 1fr); /* 2행 */
          width: 100%;
          max-width: 1300px;
          margin: 0 auto;
        }
      
        #grid_box > div {
          margin: 0;
          box-sizing: border-box;
          /*border: 1px solid #ccc;*/
          text-align: center;
        }

        #box1 {
            grid-row: span 2;
            border-top: 1px solid #1E62C8;
            padding-top: 50px;

            display: flex;
            flex-direction: column;
        }

        #box2 {
            grid-row: span 2;
            overflow-y: auto;
            height: 920px;
            position: relative;
            padding-top: 100px;
            padding: 100px 20px 0 20px;
            border-top: 1px solid #1E62C8;
        }
        
        #box3 {
            overflow-y: auto;
            height: 495px;
            border-left: 1px solid #1E62C8;
            border-top: 1px solid #1E62C8;
        }

        #box4 {
            overflow-y: auto;
            height: 495px;
            border-left: 1px solid #1E62C8;
            border-top: 2px solid black;
        }
      
    </style>

    <!-- box1 -->
    <style>

        #profile {
            width: 150px;
            height: 150px;
            margin-bottom: 10px;
            border-radius: 50%;
            object-fit: cover;
        }


        #myEvaluation {
            margin-bottom: 50px;
        }

        .link a {
            font-size: 20px;
            text-decoration: none;
            font-weight: normal;
            color: #0D0143;
        }

        .link a:visited {
            color: #0D0143;
        }

        .link {
            margin: 10px auto;
            text-align: left;
            margin-left: 40px;
        }

        #unregister {
            text-align: left;
            margin-top: auto;
            margin-bottom: 30px;
        }

        #unregister > a {
            text-decoration: none;
            font-size: 16px;
            margin-left: 40px;
        }

        #unregister > a:visited {
            color: #0D0143;
        }

        #userInfo > span {
            color: #0D0143;
            font-size: 20px;
        }

        #evaluationIcon, .gradeIcon {
            width: 25px;
            height: 25px;
        }

        #myEvaluation span {
            color: #0D0143;
            font-size: 20px;
        }
        
    </style> 

    <!-- box2 공통-->
    <style>
        #btnPassion {
            width: 130px;
            background-color: #1e62c8;
            color: white;
            border-radius: 5px; 
            border: none;
            padding: 5px 0;
            cursor: pointer;

            position: absolute;
            top: 20px;
            right: 20px;
        }

        #btnPassion:hover {
            background-color: #1e4ca0;
        }

        #box2 > h3 {
            display: inline;
        }

        #box2 > h3 {
            position: absolute;
            top: 35px;
            left: 25px;
        }

        #box2 h3 {
            color: #0D0143;
        }

        .title {
            cursor: pointer;
        }
    </style>
    
    <!-- box2 joined -->
    <c:if test="${sessionScope.status == 'joined'}">
    <style>

        #list {
            width: 680px;
            margin-left: 40px;
            border-collapse: collapse;;
        }


        #list th {
            padding: 8px 0 8px 0;
            color: #0D0143;
            border-bottom: 2px solid #1E62C8;
        }

        #list td {
            font-size: 12px;
            padding: 10px 0;
            color: #0D0143;
            font-weight: bold;
            border-bottom: 1px solid #1E62C8;
        }

        .col1 {
            width: 105px;
        }

        .col2 {
            width: 80px;
        }

        .col3 {
            max-width: 315px;
            height: 28px;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }

        .col4 {
            width: 70px;
        }

        .col5 {
            width: 110px;
        }

        #sort {
            width: 100px;
            border: 2px solid #1E62C8;
            border-radius: 4px;
            font-weight: bold;
            text-align: center;
            padding: 2px 0;
        }

        #sort:focus {
            border: 2px solid #1E62C8;
            border-radius: 4px;
            outline: none; /* 기본 포커스 스타일 제거 */
        }

        .btnEvaluation {
            background-color: #1e62c8;
            color: white;
            border-radius: 5px; 
            border: none;
            font-size: 12px;
            font-weight: bold;

            height: 28px;
            width: 100px;
            padding: 5px 5px;
            cursor: pointer;
        }

        .btnEvaluation:hover {
            background-color: #1e4ca0;
        }

    </style>
    </c:if>

    <!-- box2 written -->
    <c:if test="${sessionScope.status == 'written'}">
    <style>
        #list {
            width: 680px;
            margin-left: 40px;
            border-collapse: collapse;
        }


        #list th {
            padding: 8px 0 8px 0;
            color: #0D0143;
            border-bottom: 2px solid #1E62C8;
        }

        #list td {
            font-size: 12px;
            padding: 10px 0;
            color: #0D0143;
            font-weight: bold;
            border-bottom: 1px solid #1E62C8;
        }

        .col1 {
            width: 105px;
        }

        .col2 {
            max-width: 350px;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }

        .col3 {
            width: 110px;
        }

        #sort {
            width: 100px;
            border: 2px solid #1E62C8;
            border-radius: 4px;
            font-weight: bold;
            text-align: center;
            padding: 2px 0;
        }

        #sort:focus {
            border: 2px solid #1E62C8;
            border-radius: 4px;
            outline: none; /* 기본 포커스 스타일 제거 */
        }

        .col3 > button {
            width: 50px;
            background-color: #1e62c8;
            color: white;
            border-radius: 5px; 
            border: none;
            padding: 5px 0;
            cursor: pointer;
            font-weight: bold;
        }

        .col3 > button:hover {
            background-color: #1e4ca0;
        }

    </style>
    </c:if>

    <!-- box2 wish -->
    <c:if test="${sessionScope.status == 'wish'}">
    <style>

        .btnParticipation {
            background-color: #1e62c8;
            color: white;
            border-radius: 5px; 
            border: none;
            font-size: 12px;
            font-weight: bold;

            width: 100px;
            height: 28px;
            padding: 5px 5px;
            cursor: pointer;
        }

        .btnParticipation:hover {
            background-color: #1e4ca0;
        }

        .btnParticipationClose {
            background-color: #C81E1E;
            color: white;
            border-radius: 5px; 
            border: none;
            font-size: 12px;
            font-weight: bold;

            width: 50px;
            height: 28px;
            padding: 5px 5px;
            cursor: pointer;
        }

        .btnParticipationClose:hover {
            cursor: not-allowed;

        }

        #list {
            width: 680px;
            margin-left: 40px;
            border-collapse: collapse;;
        }


        #list th {
            padding: 8px 0 8px 0;
            color: #0D0143;
            border-bottom: 2px solid #1E62C8;
        }

        #list td {
            font-size: 12px;
            padding: 10px 0;
            color: #0D0143;
            font-weight: bold;
            border-bottom: 1px solid #1E62C8;
        }

        .col1 {
            width: 105px;
        }

        .col2 {
            width: 80px;
        }

        .col3 {
            max-width: 315px;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }

        .col4 {
            width: 70px;
        }

        .col5 {
            width: 110px;
            height: 28px;
        }

        #sort {
            width: 100px;
            border: 2px solid #1E62C8;
            border-radius: 4px;
            font-weight: bold;
            text-align: center;
            padding: 2px 0;
        }

        #sort:focus {
            border: 2px solid #1E62C8;
            border-radius: 4px;
            outline: none; /* 기본 포커스 스타일 제거 */
        }

    </style>

    </c:if>

    <!-- requesting -->
    <c:if test="${sessionScope.status == 'requesting'}">
    <style>

        #list {
            width: 680px;
            margin-left: 40px;
            border-collapse: collapse;;
        }

        #list th {
            padding: 8px 0 8px 0;
            color: #0D0143;
            border-bottom: 2px solid #1E62C8;
        }

        #list td {
            font-size: 12px;
            padding: 10px 0;
            color: #0D0143;
            font-weight: bold;
            border-bottom: 1px solid #1E62C8;
        }

        .col1 {
            width: 105px;
        }

        .col2 {
            width: 80px;
        }

        .col3 {
            max-width: 315px;
            height: 28px;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }

        .col4 {
            width: 70px;
        }

        .col5 {
            width: 110px;
        }

        #sort {
            width: 100px;
            border: 2px solid #1E62C8;
            border-radius: 4px;
            font-weight: bold;
            text-align: center;
            padding: 2px 0;
        }

        #sort:focus {
            border: 2px solid #1E62C8;
            border-radius: 4px;
            outline: none; /* 기본 포커스 스타일 제거 */
        }

        .btnConfirmed, .btnCancle, .btnRejectionReason {
            color: white;
            border-radius: 5px; 
            border: none;
            font-size: 12px;
            font-weight: bold;
            cursor: pointer;
            height: 28px;
            width: 100px;
            padding: 5px 5px;
        }

        .btnConfirmed {
            background-color: #1e62c8;
        }

        .btnCancle {
            background-color: #1EC842;
            cursor: pointer;
        }

        .btnCancle:hover {
            background-color: #1E7542;
        }

        .btnRejectionReason {
            background-color: #C81E1E;
            cursor: pointer;
        }

        .btnRejectionReason:hover {
            background-color: #A31E1E;
        }


    </style>
    </c:if>

    <!-- requested -->
    <c:if test="${sessionScope.status == 'requested'}">
    <style>

        #list {
            width: 680px;
            margin-left: 40px;
            border-collapse: collapse;;
        }

        #list th {
            padding: 8px 0 8px 0;
            color: #0D0143;
            border-bottom: 2px solid #1E62C8;
        }

        #list td {
            font-size: 12px;
            padding: 10px 0;
            color: #0D0143;
            font-weight: bold;
            border-bottom: 1px solid #1E62C8;
        }

        .col1 {
            width: 105px;
        }

        .col2 {
            width: 80px;
        }

        .col3 {
            max-width: 315px;
            height: 28px;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }

        .col4 {
            width: 70px;
        }

        .col5 {
            width: 110px;
        }

        #sort {
            width: 100px;
            border: 2px solid #1E62C8;
            border-radius: 4px;
            font-weight: bold;
            text-align: center;
            padding: 2px 0;
        }

        #sort:focus {
            border: 2px solid #1E62C8;
            border-radius: 4px;
            outline: none; /* 기본 포커스 스타일 제거 */
        }

        .btnRequested, .btnEnded {
            color: white;
            border-radius: 5px; 
            border: none;
            font-size: 12px;
            font-weight: bold;

            height: 28px;
            width: 100px;
            padding: 5px 5px;
        }

        .btnRequested {
            background-color: #1e62c8;
            cursor: pointer;
        }

        .btnRequested:hover {
            background-color: #1e4ca0
        }

        .btnEnded {
            background-color: #C81E1E;
        }

    </style>
    </c:if>

    <!-- updateInfo -->
    <c:if test="${sessionScope.status == 'updateInfo'}">
    <style>
        #btnBox {
            margin-left: 30px;
        }

        #btnBox > button {
            display: block;
            margin-top: 10px;
            width: 200px;
            background-color: #1e62c8;
            color: white;
            border-radius: 5px; 
            border: none;
            padding: 10px 30px;
            cursor: pointer;
        }

        #btnBox > button:hover {
            background-color: #1e4ca0;
        }
        
    </style>
    </c:if>

    <!-- box3,4 -->
    <style>

        #friendList > :nth-child(1) {
            margin: 20px auto;
            color: #505050;
        }

        #blockList > :nth-child(1) {
            margin: 20px auto;
            color: #505050;
        }

        .friendItem > :nth-child(2), .blockItem > :nth-child(2) {
            color: #505050;
            display: inline-block;
            width: 140px;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }

        .friendItem > img, .blockItem > img {
            width: 20px;
            height: 20px;
        }
        
        .btnDelFreiend, .btnUnblock {
            cursor: pointer;
        }

    </style>

</head>
<body>

    <div id="back_box">
    <%@ include file="/WEB-INF/views/inc/header.jsp" %>
    
    
    <main>
        <h2 id="mypageLogo">마이 페이지</h2>
        

        <div id="grid_box">

            <div id="box1">
                <div>
                    <!-- icon.png >> 변수명 -->
                    <img src="/lighting/images/${member.photoFileName}" id="profile">
                </div>

                <div id="userInfo">
                    <!-- 마스터.png >> 변수명 -->
                    <img src="/lighting/images/${gradeIcon}" id="evaluationIcon" alt="등급 아이콘">
                    <!-- 닉네임 >> 변수명 -->
                    <span id="myNickname">${member.nickname}</span>
                    <!-- (아이디) >> 변수명 -->
                    <span id="myId">(${member.id})</span>
                </div>

                <div id="myEvaluation">
                    <span>⭐</span>
                    <span>
                        <!-- 5.0 >> 변수명 -->
                        <b><span>${avgScore}</span>점</b>
                    </span>
                </div>

                <div class="link">
                    <a href="#!" onclick="changeStatusAndMove('joined', '/lighting/mypage/mypage.do');">
                        <c:if test="${sessionScope.status == 'joined'}">
                        <b>
                        </c:if>
                        내가 참여한 모임 보기
                        <c:if test="${sessionScope.status == 'joined'}">
                        </b>
                        </c:if>
                    </a>
                </div>
                <div class="link">
                    <a href="#!" onclick="changeStatusAndMove('written', '/lighting/mypage/mypage.do');">
                        <c:if test="${sessionScope.status == 'written'}">
                        <b>
                        </c:if>
                        내가 작성한 글 보기
                        <c:if test="${sessionScope.status == 'written'}">
                        </b>
                        </c:if>
                    </a>
                </div>
                <div class="link">
                    <a href="#!" onclick="changeStatusAndMove('wish', '/lighting/mypage/mypage.do');">
                        <c:if test="${sessionScope.status == 'wish'}">
                        <b>
                        </c:if>
                        내가 찜한 모임 보기
                        <c:if test="${sessionScope.status == 'wish'}">
                        </b>
                        </c:if>
                    </a>
                </div>
                <div class="link">
                    <a href="#!" onclick="changeStatusAndMove('requesting', '/lighting/mypage/mypage.do')">
                        <c:if test="${sessionScope.status == 'requesting'}">
                        <b>
                        </c:if>
                        내가 신청한 모임 보기
                        <c:if test="${sessionScope.status == 'requesting'}">
                        </b>
                        </c:if>
                    </a>
                </div>
                <div class="link">
                    <a href="#!" onclick="changeStatusAndMove('requested', '/lighting/mypage/mypage.do')">
                        <c:if test="${sessionScope.status == 'requested'}">
                        <b>
                        </c:if>
                        내가 만든 모임 신청 보기
                        <c:if test="${sessionScope.status == 'requested'}">
                        </b>
                        </c:if>
                    </a>
                </div>
                <div class="link">
                    <a href="#!" onclick="changeStatusAndMove('updateInfo', '/lighting/mypage/mypage.do');">
                        <c:if test="${sessionScope.status == 'updateInfo'}">
                        <b>
                        </c:if>
                        회원 정보 수정
                        <c:if test="${sessionScope.status == 'updateInfo'}">
                        </b>
                        </c:if>
                    </a>
                </div>
                <div id="unregister">
                    <a href="#!">회원 탈퇴</a>
                    <!-- href="/lighting/mypage/unregister.do" -->
                </div>
            </div>

            
            
            <div id="box2">
                <button id="btnPassion">열정(등급) 보기</button>
                
                <!-- joined -->
                <c:if test="${sessionScope.status == 'joined'}">
                <h3>내가 참여한 모임 보기</h3>
                <table id="list">
                    <tr>
                        <th>모임 일자</th>
                        <th>장소</th>
                        <th>제목</th>
                        <th>모집인원</th>
                        <th>
                            <!-- change 이벤트 걸기 -->
                            <select name="sort" id="sort_joined" onchange="sortMeetings('joined')">
                                <option value="recentOrder" ${param.sort eq 'recentOrder' ? 'selected' : ''}>최신 순</option>
                                <option value="koreanOrder" ${param.sort eq 'koreanOrder' ? 'selected' : ''}>가나다 순</option>
                                <option value="moreCapOrder" ${param.sort eq 'moreCapOrder' ? 'selected' : ''}>많이 참여한 순</option>
                                <option value="lessCapOrder" ${param.sort eq 'lessCapOrder' ? 'selected' : ''}>적게 참여한 순</option>
                                <option value="oldestOrder" ${param.sort eq 'oldestOrder' ? 'selected' : ''}>오래된 순</option>
                            </select>
                        </th>
                    </tr>

                    <!-- for문 시작 -->
                    <c:forEach var="meeting" items="${meetingList}">
                    <tr>
                        <td class="col1">
                            <!-- 모임시작시간 가져와서 파싱해서 값 넣기 -->
                            ${meeting.startTime}
                        </td>
                        <td class="col2">
                            <!-- 글 작성자의 활동지역 가져오기 -->
                            ${meeting.location}
                        </td>
                        <td class="col3 title" data-tblmeetingpostseq="${meeting.tblMeetingPostSeq}">
                            <!-- 게시글의 제목 가져오기 -->
                            ${meeting.title}
                        </td>
                        <td class="col4">
                            <!-- 게시글의 정원 가져오기 -->
                            <span>${meeting.capacity}</span>명
                        </td>
                        <td>
                            <button class="btnEvaluation">
                                회원 평가하기
                            </button>
                        </td>
                    </tr>
                    </c:forEach>
                    <!-- for문 종료 -->
                </table>

                </c:if>
                
                <!-- written -->
                <c:if test="${sessionScope.status == 'written'}">
                <h3>내가 작성한 글 보기</h3>
                <table id="list">
                    <tr>
                        <th>작성 일자</th>
                        <th>제목</th>
                        <th>
                            <select name="sort" id="sort_written" onchange="sortMeetings('written')">
                                <option value="recentOrder" ${param.sort eq 'recentOrder' ? 'selected' : ''}>최신 순</option>
                                <option value="koreanOrder" ${param.sort eq 'koreanOrder' ? 'selected' : ''}>가나다 순</option>
                                <option value="moreCapOrder" ${param.sort eq 'moreCapOrder' ? 'selected' : ''}>많이 참여한 순</option>
                                <option value="lessCapOrder" ${param.sort eq 'lessCapOrder' ? 'selected' : ''}>적게 참여한 순</option>
                                <option value="oldestOrder" ${param.sort eq 'oldestOrder' ? 'selected' : ''}>오래된 순</option>
                            </select>
                        </th>
                    </tr>

                    <!-- for문 시작 -->
                    <c:forEach var="meeting" items="${meetingList}">
                    <tr>
                        <td class="col1">
                            <!-- 모임시작시간 가져와서 파싱해서 값 넣기 -->
                            ${meeting.startTime}
                        </td>
                        <td class="col2 title" data-tblmeetingpostseq="${meeting.tblMeetingPostSeq}">
                            <!-- 게시글의 제목 가져오기 -->
                            ${meeting.title}
                        </td>
                        <td class="col3">
                            <button class="btnUpdatePost">
                                수정
                            </button>
                            <button class="btnDeletePost">
                                삭제
                            </button>
                        </td>
                    </tr>
                    </c:forEach>
                    <!-- for문 종료 -->

                </table>

                </c:if>
                
                <!-- wish -->
                <c:if test="${sessionScope.status == 'wish'}">
                <h3>내가 찜한 모임 보기</h3>
                <table id="list">
                    <tr>
                        <th>글 번호</th>
                        <th>장소</th>
                        <th>제목</th>
                        <th>모집인원</th>
                        <th>
                            <select name="sort" id="sort_wish" onchange="sortMeetings('wish')">
                                <option value="recentOrder" ${param.sort eq 'recentOrder' ? 'selected' : ''}>최신 순</option>
                                <option value="koreanOrder" ${param.sort eq 'koreanOrder' ? 'selected' : ''}>가나다 순</option>
                                <option value="moreCapOrder" ${param.sort eq 'moreCapOrder' ? 'selected' : ''}>많이 참여한 순</option>
                                <option value="lessCapOrder" ${param.sort eq 'lessCapOrder' ? 'selected' : ''}>적게 참여한 순</option>
                                <option value="oldestOrder" ${param.sort eq 'oldestOrder' ? 'selected' : ''}>오래된 순</option>
                            </select>
                        </th>
                    </tr>


                    <!-- for문 시작 -->
                    <c:forEach var="meeting" items="${meetingList}">
                    <tr>
                    <!-- 마감된 모임의 경우 인라인 스타일을 적용하여 글자 색 수정 -->
                        <td class="col1">
                        <!-- 게시글의 seq 가져오기 -->
                            ${meeting.tblMeetingPostSeq}
                        </td>
                        <td class="col2">
                            <!-- 글 작성자의 활동지역 가져오기 -->
                            서울/강남구${meeting.location}
                        </td>
                        <td class="col3 title" data-tblmeetingpostseq="${meeting.tblMeetingPostSeq}">
                            <!-- 게시글의 제목 가져오기 -->
                            ${meeting.title}
                        </td>
                        <td class="col4">
                            <!-- 게시글의 정원 가져오기 -->
                            <span>${meeting.capacity}</span>명
                        </td>

                        <td class="col5">
                            <!-- if문or choose문을 통해 버튼 선택적으로 출력 -->
                            <button class="btnParticipation">
                                모임 참여하기
                            </button>
                        </td>

                    </tr>
                    </c:forEach>
                </table>


                </c:if>
                
                <!-- requesting -->
                <c:if test="${sessionScope.status == 'requesting'}">
                <h3>내가 신청한 모임 보기</h3>
                <table id="list">
                    <tr>
                        <th>모임 일자</th>
                        <th>장소</th>
                        <th>제목</th>
                        <th>모집인원</th>
                        <th>
                            <!-- change 이벤트 걸기 -->
                            <select name="sort" id="sort_requesting" onchange="sortMeetings('requesting')">
                                <option value="recentOrder" ${param.sort eq 'recentOrder' ? 'selected' : ''}>최신 순</option>
                                <option value="koreanOrder" ${param.sort eq 'koreanOrder' ? 'selected' : ''}>가나다 순</option>
                                <option value="moreCapOrder" ${param.sort eq 'moreCapOrder' ? 'selected' : ''}>많이 참여한 순</option>
                                <option value="lessCapOrder" ${param.sort eq 'lessCapOrder' ? 'selected' : ''}>적게 참여한 순</option>
                                <option value="oldestOrder" ${param.sort eq 'oldestOrder' ? 'selected' : ''}>오래된 순</option>
                            </select>
                        </th>
                    </tr>
                    
                    <c:forEach var="meeting" items="${meetingList}">
                    <tr>
                        <td class="col1">${meeting.startTime}</td>
                        <td class="col2">서울/강남구 ${meeting.location}</td>
                        <td class="col3 title" data-tblmeetingpostseq="${meeting.tblMeetingPostSeq}">${meeting.title}</td>
                        <td class="col4"><span>${meeting.capacity}</span>명</td>
                        <td class="col5">
                            <c:choose>
                                <c:when test="${meeting.approvalStatus == 'n'}">
                                    <c:choose>
                                        <c:when test="${meeting.requestSeq gt 0}">
                                            <button class="btnRejectionReason" data-requestseq="${meeting.requestSeq}">
                                                (거부)사유
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <button class="btnCancle" data-requestseq="${meeting.requestSeq}">
                                                취소
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:otherwise>
                                    <button class="btnConfirmed">승인완료</button>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    </c:forEach>

                </table>
                </c:if>
                
                <!-- requested -->
                <c:if test="${sessionScope.status == 'requested'}">
                <h3>내가 만든 모임 신청 보기</h3>
                <table id="list">
                    <tr>
                        <th>모임 일자</th>
                        <th>장소</th>
                        <th>제목</th>
                        <th>모집인원</th>
                        <th>
                            <!-- change 이벤트 걸기 -->
                            <select name="sort" id="sort_requested" onchange="sortMeetings('requested')">
                                <option value="recentOrder" ${param.sort eq 'recentOrder' ? 'selected' : ''}>최신 순</option>
                                <option value="koreanOrder" ${param.sort eq 'koreanOrder' ? 'selected' : ''}>가나다 순</option>
                                <option value="moreCapOrder" ${param.sort eq 'moreCapOrder' ? 'selected' : ''}>많이 참여한 순</option>
                                <option value="lessCapOrder" ${param.sort eq 'lessCapOrder' ? 'selected' : ''}>적게 참여한 순</option>
                                <option value="oldestOrder" ${param.sort eq 'oldestOrder' ? 'selected' : ''}>오래된 순</option>
                            </select>
                        </th>
                    </tr>

                    <!-- for문 시작 -->
                    <c:forEach var="meeting" items="${meetingList}">
                    <tr>
                        <td class="col1">
                            <!-- 모임시작시간 가져와서 파싱해서 값 넣기 -->
                            ${meeting.startTime}
                        </td>
                        <td class="col2">
                            <!-- 글 작성자의 활동지역 가져오기 -->
                            ${meeting.location}
                        </td>
                        <td class="col3 title" data-tblmeetingpostseq="${meeting.tblMeetingPostSeq}">
                            <!-- 게시글의 제목 가져오기 -->
                            ${meeting.title}
                        </td>
                        <td class="col4">
                            <!-- 게시글의 정원 가져오기 -->
                            <span>${meeting.capacity}</span>명
                        </td>
                        <td class="col5">
                            <button class="btnRequested" onclick="openServletInNewWindow('/lighting/mypage/applystatus.do?meetingPostSeq=${meeting.tblMeetingPostSeq}')">
                                신청 받은 현황
                            </button>
                        </td>
                    </tr>
                    </c:forEach>
                </table>

                </c:if>
                
                <!-- updateInfo -->
                <c:if test="${sessionScope.status == 'updateInfo'}">
                <h3>회원 정보 수정</h3>

                    <div id="btnBox">
                        <button id="btnUpdateProfile">
                            프로필 이미지 변경
                        </button>

                        <button id="btnUpdateInfo">
                            개인 정보 수정
                        </button>

                        <button id="btnOpenPublic">
                            공개 여부 설정
                        </button>

                        <button id="btnUpdatePassword">
                            비밀번호 변경
                        </button>
                    </div>

                </c:if>
                
                
            </div>
            


            

            <div id="box3">
                <div id="friendList">
                    <div>친구목록</div>
                        
                    <!-- for문 시작 -->
                    <!-- friendList는 FriendDTO 객체 리스트 -->
                    <c:forEach var="friend" items="${friendList}">
                    <div class="friendItem" data-friend-id="${friend.friendMemberSeq}">
                        <!-- 다이아.png >> 변수명 -->
                        <img src="/lighting/images/실버.png" class="evaluationIcon" alt="평가 아이콘">
                        <span>${friend.nickname}</span>
                        <img src="/lighting/images/닫기.png" class="btnDelFreiend" alt="삭제" style="cursor:pointer;"
     onclick="deleteFriend(${friend.friendMemberSeq}, this);"/>
                        <!-- 삭제 이벤트 이후 한번 더 리스트 출력할것 -->
                    </div>
                    </c:forEach>
                    <!-- for문 종료 -->

                </div>
            </div>

            <div id="box4">
                <div id="blockList">
                    <div>차단목록</div>

                    <!-- for문 시작 -->
                    <c:forEach var="block" items="${blockList}">
                    <div class="blockItem">
                        <img src="/lighting/images/실버.png" class="gradeIcon" data-friend-id="${block.blockedMemberSeq}" alt="프로필">

                        <span>${block.nickname}</span>
                        <img src="/lighting/images/닫기.png"
                        class="btnUnblock"
                        data-id="${block.blockedMemberSeq}"
                        onclick="unblockUser(${block.blockedMemberSeq}, this);"/>
                    </div>
                    </c:forEach>

                    <!-- for문 종료 -->

                </div>
            </div>

        </div>

    </main>

    <%@ include file="/WEB-INF/views/inc/footer.jsp" %>
    </div>
    
    <!-- 마이페이지 공통 자바스크립트 -->
    <script>

    $('#btnPassion').click(()=>{
        openServletInNewWindow("/lighting/mypage/grade.do");
    });
    
    $('#unregister').click(()=>{
        openServletInNewWindow("/lighting/mypage/unregister.do");
    });
    
    $('.btnEvaluation').click(()=>{
        openServletInNewWindow("/lighting/mypage/giveevaluation.do");
    });
    
    $('#btnUpdateInfo').click(()=>{
        openServletInNewWindow("/lighting/mypage/updateinfo.do");
    });
    
    $('#btnUpdatePassword').click(()=>{
        openServletInNewWindow("/lighting/mypage/updatepassword.do");
    });
    
    $('.btnDeletePost').click(()=>{
        openServletInNewWindow("/lighting/meeting/delete.do");
    });
    
    $('#btnUpdateProfile').click(()=>{
        openServletInNewWindow("/lighting/mypage/updateprofile.do");
    });
    
    $('#btnOpenPublic').click(()=>{
        openServletInNewWindow("/lighting/mypage/updateopenpublic.do");
    });
    
    $('.btnRejectionReason').click(()=>{
        openServletInNewWindow("/lighting/mypage/rejectionreason.do?requestSeq=3");
    });
    
    function openServletInNewWindow(servletUrl) {
        window.open(servletUrl, "_blank", "width=600,height=400,scrollbars=yes");
    }
    
    $('#list .title').click(()=>{
        const tdElement = document.querySelector('.col3.title'); // 첫 번째 요소만 가져옴
        const postSeq = tdElement.dataset.tblmeetingpostseq;

        console.log(postSeq);

         location.href = '/lighting/meeting/read.do?tblMeetingPostSeq=' + postSeq;
    });
    
    //셀렉트 박스 정렬
    function sortMeetings(section) {
        var sortValue = document.getElementById('sort_' + section).value;
        window.location.href = '/lighting/mypage/mypage.do?status=' + section + '&sort=' + sortValue;
    }
    
    function deleteFriend(friendId, btn) {
        // 전달받은 btn(삭제 아이콘)으로부터 가장 가까운 .friendItem 요소 찾기
        var friendItem = $(btn).closest('.friendItem');
        if (confirm("친구를 삭제하시겠습니까?")) {
            $.ajax({
                url: '<%=request.getContextPath()%>/mypage/deletefriend.do',
                type: 'POST',
                data: { friendId: friendId },
                success: function(response) {
                    // 응답이 JSON 문자열일 경우 JSON.parse()로 파싱
                    var res = typeof response === "string" ? JSON.parse(response) : response;
                    if (res.status === "success") {
                        friendItem.remove();
                    } else {
                        alert("친구 삭제에 실패했습니다.");
                    }
                },
                error: function(error) {
                    console.error("친구 삭제 실패:", error);
                    alert("친구 삭제에 실패했습니다.");
                }
            });
        }
    }
    
    function unblockUser(blockedId, btn) {
        console.log("📦 전달 blockedId:", blockedId);
        const blockItem = btn.closest('.blockItem');

        if (confirm("차단을 해제하시겠습니까?")) {
            fetch("/lighting/mypage/unblock.do", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: "blockedId=" + blockedId
            })
            .then(res => res.json())
            .then(data => {
                console.log("📨 서버 응답:", data);
                if (data.status === "success") {
                    blockItem.remove(); // ✅ DOM에서 제거
                } else {
                    alert("차단 해제에 실패했습니다.");
                }
            })
            .catch(err => {
                console.error("❌ fetch 실패:", err);
                alert("차단 해제에 실패했습니다.");
            });
        }
    }
    
    $(document).ready(function() {
        $(".gradeIcon").each(function() {
            let friendId = $(this).data("friend-id");
            let $img = $(this);

            $.ajax({
                url: "/lighting/mypage/evaluation.do",
                method: "POST",
                data: { friendId: friendId },
                dataType: 'json',
                success: function(res) {
                    console.log("🔥 받은 점수:", res.score);
                    let score = res.score;
                    let grade = "실버";
                    if (score >= 4) grade = "마스터";
                    else if (score >= 3) grade = "다이아";
                    else if (score >= 2) grade = "골드";
                    else grade = "실버";
                    console.log("🎖️ 등급:", grade);
                    
                    $img.attr("src", '/lighting/images/' + grade + '.png');
                },
                error: function(err) {
                    console.error("점수 불러오기 실패:", err);
                }
            });
        });
    });


    $(".evaluationIcon").each(function() {
        // 부모 .friendItem에 설정된 data-friend-id에서 친구 번호를 가져옴
        let friendId = $(this).closest(".friendItem").data("friend-id");
        let $img = $(this);
        $.ajax({
            url: "/lighting/mypage/evaluation.do",
            method: "POST",
            data: { friendId: friendId },
            dataType: 'json',
            success: function(res) {
                let score = res.score;
                let grade = "실버";
                if (score >= 4) grade = "마스터";
                else if (score >= 3) grade = "다이아";
                else if (score >= 2) grade = "골드";
                else grade = "실버";
                $img.attr("src", '/lighting/images/' + grade + '.png');
            },
            error: function(err) {
                console.error("친구 평가 점수 불러오기 실패:", err);
            }
        });
    });
    
    $('.btnCancle').click(function(){
        var btn = $(this);
        var requestSeq = btn.data('requestseq'); // 각 버튼에 설정된 신청 건 번호
        if(confirm("정말 취소하시겠습니까?")){
             $.ajax({
                  url: '/lighting/mypage/cancelRequest.do',
                  type: 'POST',
                  data: { requestSeq: requestSeq },
                  success: function(response){
                      // 서버 응답이 JSON 형태라고 가정합니다.
                      if(response.status === "success"){
                          btn.remove(); // 취소 처리 후 버튼 제거
                          alert("취소 처리되었습니다.");
                      } else {
                          alert("취소 처리에 실패했습니다.");
                      }
                  },
                  error: function(err){
                      console.error("취소 처리 실패:", err);
                      alert("취소 처리 중 오류 발생");
                  }
             });
        }
    });
    
    // (거부)사유 버튼 클릭: 모달 페이지를 새 창으로 열어 해당 신청 건의 requestSeq 전달
    $('.btnRejectionReason').click(function(){
        var reqSeq = $(this).data('requestseq');
        openServletInNewWindow("/lighting/mypage/rejectionreason.do?requestSeq=" + reqSeq);
    });

    // 취소 버튼 클릭: AJAX를 통해 tblParticipationRequest 삭제 후 버튼 제거
    $('.btnCancle').click(function(){
        var btn = $(this);
        var reqSeq = btn.data('requestseq');
        if(confirm("정말 취소하시겠습니까?")){
             $.ajax({
                  url: '/lighting/mypage/cancelRequest.do',
                  type: 'POST',
                  data: { requestSeq: reqSeq },
                  success: function(response){
                      if(response.status === "success"){
                          btn.remove();
                          alert("취소 처리되었습니다.");
                      } else {
                          alert("취소 처리에 실패했습니다.");
                      }
                  },
                  error: function(err){
                      console.error("취소 처리 실패:", err);
                      alert("취소 처리 중 오류 발생");
                  }
             });
        }
    });

    function openServletInNewWindow(servletUrl) {
        window.open(servletUrl, "_blank", "width=600,height=400,scrollbars=yes");
    }
    
    $('#list').on('click', '.title', function() {
        const postSeq = $(this).data('tblmeetingpostseq');
        console.log("게시글 번호:", postSeq);
        location.href = '/lighting/meeting/read.do?tblMeetingPostSeq=' + postSeq;
    });
    
    function openServletInNewWindow(url) {
        window.open(url, '_blank', 'width=700,height=600,scrollbars=yes');
    }
    </script>
    

</body>
</html>