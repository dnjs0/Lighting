<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/inc/asset.jsp" %>
<meta charset="UTF-8">
<title>오늘어때?</title>
<!-- <link rel="stylesheet" href="css/lighting.css"> -->

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
body {
    width: 1300px;
    height: 1000px;
    background-color: #fff;
    margin: 0 auto;
}

.container {
    margin: 0;
    padding: 0;
    background-color: #f9f7ff;
    box-sizing: border-box;    
}

#logo {
    width: 220px;
    margin: 15px 0 0 20px;
    cursor: pointer;
}

#tx {
    /*  border: solid 1px black; */
    font-size: 30px;
    text-align: center;
    margin: 5px;
}

#pic > img {
    margin: 10px;
    align-items: center;
    margin-top : 25px;
    margin-bottom: 25px;
    position: relative;
    left: 240px;
}

#button {
    border: 0px;
    border-bottom: 5px solid #1e62c8;
    background-color: #f9f7ff;
    width: 100px;
    height: 50px;
    margin-bottom: 30px;
}

#role1 {
    padding: 10px;
    font-size: 25px;
    margin: 0 auto;
    /* border: solid 1px black; */
    background: #1e62c8;
    width: 800px;
    height: 50px;
    color: #FFF;
    border-radius: 15px 15px 0 0;
    font-weight: bold;
}

#role2 {
    margin: 0 auto;
    /* border: solid 1px black; */
    background: #FFF;
    width: 800px;
    height: 300px;
    padding: 20px;
    overflow-y: auto;
    text-align: center;
}

#label1 {
    text-align: right; /* 오른쪽 정렬 */
    margin-top: 10px;
    float: right;
}

.btn1 {
    display: flex;
    justify-content: center; /* 버튼을 가로로 중앙 정렬 */
    align-items: center; /* 버튼을 세로로 중앙 정렬 (선택 사항) */
    height: 100px; /* 원하는 높이를 설정 */
}

#btn1 {
    border: solid 0px black;
    background-color: #1e62c8;
    text-align: center;
    width: 300px; /* 버튼 가로 크기 증가 */
    height: 60px; /* 버튼 세로 크기 증가 */
    color: white; /* 글씨 색상 설정 */
    font-size: 18px; /* 글씨 크기 설정 */
    line-height: 60px; /* 글씨 세로 중앙 정렬 */
    border-radius: 5px; /* 버튼의 모서리 둥글게 */
    cursor: pointer; /* 마우스 커서가 버튼 위에 있을 때 손 모양으로 변경 */
}
</style>
</head>
<body class="body">

    <!-- registerrole.jsp -->
    <main class="container">
    <div id="div1">
        <img alt="로고" src="/lighting/images/logo_가로.png" id="logo" onclick="location.href='/lighting/main.do';">

    </div>
    <div id="tx">
        회원가입을 위해 <br>아래 서비스<b>이용약관에 동의</b>해주세요.
    </div>

    <div id="pic">

        <img src="/lighting/images/bar.png">


        <div id="role1">이용약관</div>
        <div id="role2">
            제 1 장 총칙 <br> <br> 제1조 목적 <br> 본 약관은 (주)타임즈코어(이하
            "회사"라고 함)이 제공하는 각각의 웹사이트(이하 "타임즈코어 FAMILY 사이트"이라고 함)의 <br> 이용에
            관한 제반사항 및 이용자와 회사의 권리, 의무를 규정함을 목적으로 합니다. <br> <br> 제2조 용어의
            정의 <br> (1) 타임즈코어 FAMILY 사이트: (주)타임즈코어에서 운영하는 모든 웹사이트 중 FAMILY
            회원을 적용하는 아래에 열거한 웹사이트들을 지칭함.<br> 가. The TEEN TIMES
            (www.teentimes.org)<br> 나. The JUNIOR TIMES
            (www.juniortimes.co.kr)<br> 다. The KIDS TIMES
            (www.kidstimes.net)<br> 라. The KINDER TIMES
            (www.kindertimes.co.kr)<br> 마. The WORLD TIMES
            (www.worldtimes.co.kr)<br> 바. TIMESCAMP (www.timescamp.co.kr)<br>
            (2) 타임즈코어 FAMILY 회원: 타임즈코어 FAMILY 사이트를 통해 회원등록 절차를 거쳐 본 이용자 약관에 동의한
            이용자<br> (3) 이용자: 타임즈코어 FAMILY 사이트에 접속하여 이 약관에 따라 회사가 제공하는 서비스를
            받는 정회원과 준회원<br> (4) 준회원: 회원 가입 후 서비스를 이용하고 있지 않은 회원<br> (5)
            서비스: 정보중개(링크) 및 그를 통해 제공되는 정보들을 제외한 온라인강의, 디지털콘텐츠, 서비스 등 타임즈코어 FAMILY
            사이트에 수록된 모든 정보의 총칭<br> (6) 무료회원: 현재 유료 서비스를 이용하고 있지 않은 모든 회원<br>
            (7) 회원 ID: 이용자 식별과 서비스 이용을 위하여 이용자가 선정하고 회사가 부여하는 영문자 또는 숫자의 조합<br>
            (8) 비밀번호: 회원의 본인 확인과 비밀 보호를 위해 회원 자신이 설정한 문자, 숫자 또는 양자의 조합<br>
            (9) 구독일: 결제일과 별도로 회원이 구독 시작일을 설정할 수 있는 기능<br> (10) 할인쿠폰: 정해진 온라인
            서비스에 대해 판매가의 일정금액 또는 일정비율로 할인구매할 수 있는 온-오프라인상의 인증번호<br>
        </div>

        <div class="btn1">
            <label id="label1"> <input type="checkbox" name="agree" /> 위
                약관에 동의합니다.
            </label>
        </div>

        <div class="btn1">
            <form method="GET" action="/lighting/user/register/register.do">
                <button type="submit" id="btn1">회원가입</button>

                <!-- <a id="btn1" href="/login/registerok.do">
        회원가입
    </a> -->

            </form>
        </div>
    </div>
    </main>

	<script>
		// 회원가입 버튼 클릭 시 실행되는 함수
		document.getElementById("btn1").onclick = function(event) {
			// 체크박스를 선택했는지 확인
			var checkbox = document.getElementsByName("agree")[0];

			// 체크되지 않은 경우
			if (!checkbox.checked) {
				alert("이용약관에 동의해주세요.");
				event.preventDefault(); // 폼 제출을 막음
			} else {
				// 체크되었으면 register_sw.do로 이동
				//window.location.href = "register_sw.jsp"; // 페이지 이동
			}
		}
	</script>

	
	<!-- <div class="btn1">
	<form method="POST" action="/login/register.jsp">
	<button value="회원가입">
	회원가입
	</button>
	<button type="submit" onclick="location.href='lighting/login/register.jsp';">회원가입2</button>
    <a id="btn1" href="/login/registerok.do">
        회원가입
    </a>
    </form>
	</div> -->
    
<%@ include file="/WEB-INF/views/inc/footer.jsp" %>
    <script>
        // 회원가입 버튼 클릭 시 실행되는 함수
        document.getElementById("btn1").onclick = function(event) {
            // 체크박스를 선택했는지 확인
            var checkbox = document.getElementsByName("agree")[0];

            // 체크되지 않은 경우
            if (!checkbox.checked) {
                alert("이용약관에 동의해주세요.");
                event.preventDefault(); // 폼 제출을 막음
            } else {
            	//alert("페이지 넘어가야함.");
                // 체크되었으면 register_sw.do로 이동
                //window.location.href = "register_sw.jsp"; // 페이지 이동
            }
        }
        
        $('#logo1').click(() => { 
            window.location.href =  '/lighting/main.do'; // 메인페이지로 이동
          });
        
    </script>
</body>
</html>