<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<%
  request.setCharacterEncoding("UTF-8");
%>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>Login</title>
  <%@include file="/WEB-INF/views/inc/asset.jsp"%>
  <style>
    @font-face {  
      font-family: 'Pretendard-Regular';  
      src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');  
      font-weight: 400;  
      font-style: normal;
    }
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Pretendard-Regular';
    }
    ul {
      list-style: none;
    }
    /* 전체 배경 흰색 */
    body {
      background-color: #fff;
    }
    /* 전체 컨테이너 : 1300px 고정, 내부 요소들을 중앙 정렬 */
    .container {
      width: 1300px;
      min-height: 100vh;
      margin: 0 auto;
      background-color: #f9f7ff;
      padding: 40px 20px;
      position: relative;
      display: flex;
      flex-direction: column;
      align-items: center;
    }
    /* 로고 중앙 정렬 */
    #logo {
      width: 250px;
      margin: 140px auto 20px auto;
      display: block;
      cursor: pointer;
    }
    /* 로그인 폼과 제목을 감싸는 래퍼 */
    .formWrapper {
      width: 500px;  
      margin: 0 auto;
      display: flex;
      flex-direction: column;
      align-items: center;
    }
    /* 안내 문구 : 래퍼의 너비에 맞춰 중앙 정렬 */
    .signupTitle {
      font-size: 18px;
      line-height: 1.4;
      margin-bottom: 20px;
      width: 100%;
    }
    /* 로그인 폼 */
    .signupForm {
      width: 100%;
      display: flex;
      flex-direction: column;
      gap: 20px;
    }
    /* 폼 그룹 */
    .formGroup {
      width: 100%;
      display: flex;
      flex-direction: column;
    }
    .formGroup label {
      margin-bottom: 6px;
      font-weight: 500;
    }
    .formGroup input {
      padding: 10px;
      border: 1px solid #1e62c8;
      border-radius: 4px;
      font-size: 14px;
      height: 40px;
    }
    .formGroup input:focus {
      outline: none;
    }
    
    /* 로그인 버튼 */
    button {
      width: 100%;
      padding: 15px;
      background-color: #1e62c8;
      color: #fff;
      font-size: 16px;
      font-weight: bold;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }
    /* 링크 영역 */
    .link {
      text-align: center;
      font-size: 13px;
      margin-bottom: 20px;
    }
    
    .link a {
      text-decoration: none;
      color: #444;
    }
    /* a 태그 클릭 시 색상 변경 */
    .link a:active {
      color: #1e62c8;
    }
  </style>
</head>
<body>
  <div class="container">
    <img alt="로고" id="logo" src="/lighting/images/logo_세로.png">
    <div class="formWrapper">
      <!-- 안내 문구는 폼 위, 래퍼 내부에서 중앙 정렬 -->
       <div class="signupTitle"></div> 
      <!-- 로그인 폼 -->
      <form class="signupForm" action="/lighting/user/loginok.do" method="post">
        <!-- 아이디 입력 -->
        <div class="formGroup">
          <label for="id">아이디</label>
          <input type="text" id="id" name="id" placeholder="아이디"  required>
        </div>
        <!-- 비밀번호 입력 -->
        <div class="formGroup">
          <label for="pw">비밀번호</label>
          <input type="password" id="pw" name="pw" placeholder="비밀번호(영문, 숫자, 특수문자 포함 8 ~ 20자)" required>
        </div>
        <!-- 추가 링크 영역 -->
        <div class="link">
          <a href="/lighting/user/register/registerrole.do">회원가입</a> | 
          <a id="findId" href="/lighting/user/findid.do">아이디 찾기</a> | 
          <a href="/lighting/user/findpassword.do">비밀번호 찾기</a>
        </div>
        <!-- 로그인 버튼 -->
        <button type="submit">로그인</button>
      </form>
    </div>
      
      <br>
      <br>
      <!-- 개발용 -->
        <div>
        <form action="/lighting/user/loginok.do" method="POST">
            <input type="hidden" name="id" value="4p2lv7zo">
            <input type="hidden" name="pw" value="m3^37#66">
            <button type="submit" class="in">1로그인</button>
        </form>
        </div>
        <div>
        <form action="/lighting/user/loginok.do" method="POST">
            <input type="hidden" name="id" value="m8pv3xbevv">
            <input type="hidden" name="pw" value="x2$8xu6937eg">
            <button type="submit" class="in">2로그인</button>
        </form>
        </div>
        
        
        
  </div>
  
  <script>
      document.getElementById("logo").addEventListener("click", function(){
	    window.location.href = "/lighting/main.do";
	  });
  </script>
  
  <%@ include file="/WEB-INF/views/inc/footer.jsp" %>
</body>
</html>
