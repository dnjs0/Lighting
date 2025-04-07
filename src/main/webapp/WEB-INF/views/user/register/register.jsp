<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <meta charset="UTF-8">
<head>
<%@ include file="/WEB-INF/views/inc/asset.jsp" %>
  <title>오늘어때?</title>
  <style>
   /* 공통 스타일 초기화 */
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
    /* 가운데 컨테이너 */
    .container {
      width: 1300px;
      min-height: 100vh;
      margin: 0 auto;
      background-color: #f9f7ff;
      padding: 40px 20px;
      position: relative;
    }
    
#logo {
    width: 220px;
    /* margin: -5px 0 0 5px; */
    cursor: pointer;
    position: relative;
    bottom: 25px;
}

    /* 안내 문구 */
    .signupTitle {
      font-size: 30px;
    text-align: center;
    margin: 5px;
    position: relative;
    bottom: 25px;
    }

    /* 진행 바 */
    #stepBox {
    margin: 10px;
    align-items: center;
    margin-top : 25px;
    margin-bottom: 25px;
    position: relative;
    left: 220px;
    bottom: 20px;
}

    /* 회원가입 폼 */
    .signupForm {
      max-width: 600px;
      margin: 0 auto;
      display: flex;
      flex-direction: column;
      gap: 20px;
      position: relative;
      bottom:20px;
    }
    
    /* 라벨 & 인풋 구역 */
    .formGroup {
      width: 100%;
      display: flex;
      flex-direction: column;
    }
    .inputGroup {
      display: flex;
      align-items: center;
      gap: 0;
    }
    input:focus,
    textarea:focus,
    select:focus {
      outline: none;
      box-shadow: none;
    }
    
    input[type="text"], 
    button {
      height: 40px;
      box-sizing: border-box;
      font-size: 16px;
      line-height: 1;
      padding: 8px;
      vertical-align: middle;
    }
    
    /* 아이디 중복체크 및 이메일 인증 버튼 스타일 */
    .inputGroup .btnIdCheck,
    .inputGroup .btnEmailCheck {
      border: 1px solid #1e62c8;
      border-left: none;
      border-radius: 0 4px 4px 0;
      background-color: #1e62c8;
      color: #fff;
      padding: 10px 16px;
      cursor: pointer;
    }
    .formGroup label {
      margin-bottom: 6px;
      font-weight: 500;
    }
    .formGroup input,
    .formGroup select {
      padding: 10px;
      border: 1px solid #1e62c8;
      border-radius: 4px;
      font-size: 14px;
    }
    .inputGroup input {
      border: 1px solid #1e62c8;
      border-right: none;
      border-radius: 4px 0 0 4px;
      flex: 1;
    }
    
    #gender {
      border: 1px solid #1e62c8;
      border-radius: 4px;
      font-size: 14px;
      padding: 10px;
      text-align: center;
      background-color: #fff;
    }
    
    #gender #female {
      margin-left: 15px;
    }
    
    /* 라디오 버튼 및 체크박스 기본 간격 조정 */
    .formGroup div {
      margin-top: 6px;
      text-align: center;
    }
    .formGroup div label {
      margin-right: 7px;
    }

    .interestTags {
      border: 1px solid #1e62c8;
      border-radius: 4px;
      font-size: 14px;
      padding: 10px;
      text-align: center;
      background-color: #fff;
    }

    /* 회원가입 완료 버튼 */
    #btnSubmit {
      width: 100%;
      margin: 50px auto;
      padding: 15px;
      background-color: #1e62c8;
      color: #fff;
      font-size: 16px;
      font-weight: bold;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }
  </style>
</head>
<body>
  <div class="container">
    <!-- 로고 영역 -->
      <img alt="로고" src="/lighting/images/logo_가로.png" id="logo">

    <!-- 안내 문구 -->
    <div class="signupTitle">
      회원가입을 위해<br>아래 <b>정보를 입력</b>해주세요.
    </div>
    
    <!-- 단계 표시 -->
    <div id="stepBox">
      <img alt="단계" src="/lighting/images/약관동의_02.png" id="step">  
    </div>
    
    <!-- 회원가입 폼 -->
    <form class="signupForm" action="/lighting/user/register/registerok.do" method="post">
      <!-- 아이디 -->
      <div class="formGroup">
        <label for="userid">&ensp;아이디</label>
        <div class="inputGroup">
          <input type="text" id="id" name="id" placeholder="영문, 숫자, ‘_’ 사용 가능 4~20자" required>  
          <button type="button" class="btnIdCheck" onclick="checkId();">중복체크</button>
        </div>
        <!-- 중복 여부 메시지 -->
    <span id="idMessage" style="font-size: 12px; display: none;"></span>
      </div>
      
      <!-- 비밀번호 -->
      <div class="formGroup">
        <label for="password">&ensp;비밀번호</label>
         <input type="password" id="pw" name="pw" placeholder="8~16자리, 영문+숫자+특수문자 조합" required>
       <!-- value="asdasd" -->
        <!-- 오류 메시지를 이 곳에 표시 -->
  	<span id="pwErrorMessage" style="color: red; font-size: 12px; display: none;">비밀번호는 8~16자리, 영문+숫자+특수문자 조합만 가능합니다.</span>     
      </div>
      
      <!-- 이름 -->
      <div class="formGroup">
        <label for="name">&ensp;이름</label>
        <input type="text" id="name" name="name" placeholder="실명 입력 (2~10자리, 한글만 입력 가능)" pattern="[가-힣]{2,10}" required><!-- value="홍길동" -->
 		 <!-- 오류 메시지를 이 곳에 표시 -->
  <span id="nameErrorMessage" style="color: red; font-size: 12px; display: none;">실명 입력 (2~10자리, 한글만 입력 가능)만 가능합니다.</span>    
      </div>
      
      <!-- 닉네임 -->
      <div class="formGroup">
        <label for="nickname">&ensp;닉네임</label>
        <input type="text" id="nickname" name="nickname" placeholder="2~10자리, 한글만 입력 가능"  pattern="[가-힣]{2,10}" required > <!-- value="홍길동" -->
		 <!-- 오류 메시지를 이 곳에 표시 -->
  	   <span id="nicknameErrorMessage" style="color: red; font-size: 12px; display: none;">2~10자리, 한글만 입력 가능합니다.</span>      
      </div>
      
      <!-- 생년월일 -->
      <div class="formGroup">
        <label for="birthdate">&ensp;생년월일</label>
        <input type="text" id="birthday" name="birthday" placeholder="YYYYMMDD 형식으로 입력" pattern="\d{8}" required > <!-- value="19990101" -->
		<!-- 오류 메시지를 이 곳에 표시 -->
  <span id="birthdayErrorMessage" style="color: red; font-size: 12px; display: none;">생년월일은 8자리 숫자(YYYYMMDD)로만 입력 가능합니다.</span>     
      </div>
      
      <!-- 연락처 -->
      <div class="formGroup">
        <label for="phone">&ensp;연락처</label>
        <input type="text" id="tel" name="tel" placeholder="‘-’ 대시를 포함하여 정확한 연락처를 입력해주세요" pattern="\d{3}-\d{3,4}-\d{4}" required > <!--  value="01012341234" -->
      	<!-- 오류 메시지를 이 곳에 표시 -->
  <span id="telErrorMessage" style="color: red; font-size: 12px; display: none;">연락처를 올바르게 입력해주세요. (예: 010-1234-1234)</span>
      </div>
      
      <!-- 이메일 -->
      <div class="formGroup">
        <label for="email">&ensp;이메일</label>
        <div class="inputGroup">
          <input type="email" id="email" name="email" placeholder="예) example@email.com" required > <!-- value="123@naver.com" -->
          <button type="button" class="btnEmailCheck" onclick="sendEmail();">인증받기</button>
        </div>
      </div>
      
<!-- 이메일 인증번호 입력란 추가 (초기에는 숨김 처리)-->
<div class="formGroup" id="verificationSection" style="display:none;">
  <label for="validNumber">인증번호</label>
  <div class="inputGroup">
    <input type="text" id="validNumber" name="validNumber" placeholder="이메일로 받은 인증번호 입력" required>
    <button type="button" class="btnEmailCheck" onclick="verifyCode()">확인</button>
  </div>
</div>
      
      <!-- 성별 선택 -->
      <div class="formGroup">
        <label>&ensp;성별</label>
        <div id="gender">
          <input type="radio" id="male" name="gender" value="m" required checked="checked">
          <label for="male">남성</label>
          <input type="radio" id="female" name="gender" value="f" required>
          <label for="female">여성</label>
        </div>
      </div>
      
      <!-- 주소 -->
      <div class="formGroup">
        <label>&ensp;주소</label>
        <div style="display: flex; gap: 10px;">
          <select id="sido" name="sido" style="flex: 1;">
  	<option value="" disabled selected>시/도 선택</option> <!-- 서울 선택 제거 -->
  	<option value="서울특별시">서울특별시</option>
  	<option value="부산">부산광역시</option>
  	<option value="대구">대구광역시</option>
  	<option value="인천">인천광역시</option>
  	<option value="경기도">경기도</option>
	</select>
          <select id="gugun" name="gugun" style="flex: 1;" disabled>
            <option value="">구/군 선택</option>
          </select>
        </div>
      </div>
      
      <!-- 관심 태그 선택 (최대 2개) -->
      <div class="formGroup">
        <label>&ensp;관심 태그 (최대 2개 선택 가능)</label>
        <div class="interestTags">
          <input type="checkbox" id="food" name="interest" value="맛집">
          <label for="food">맛집</label>
          <input type="checkbox" id="game" name="interest" value="게임">
          <label for="game">게임</label>
          <input type="checkbox" id="culture" name="interest" value="문화">
          <label for="culture">문화</label>
          <input type="checkbox" id="sports" name="interest" value="스포츠">
          <label for="sports">스포츠</label>
          <input type="checkbox" id="self" name="interest" value="자기계발">
          <label for="self">자기계발</label>
          <input type="checkbox" id="healing" name="interest" value="힐링">
          <label for="healing">힐링</label>
        </div>
      </div>
      
      <!-- 회원가입 버튼 -->
      <button type="submit" id="btnSubmit">회원가입 완료</button>
    </form>
  </div>
  
  <script>
	  
  document.addEventListener('DOMContentLoaded', function () {
	  // 페이지 로드 시 '서울'을 기본 선택하고 구/군 리스트를 불러오기
	  const sidoSelect = document.getElementById('sido');
	  const gugunSelect = document.getElementById('gugun');
	  const btnSubmit = document.getElementById('btnSubmit');
	  
	// '서울' 기본 선택
	  sidoSelect.value = '서울특별시';

	// 서울을 선택한 후 구/군 리스트를 불러오기
	  fetch('/lighting/user/getSeoulDistricts')
	    .then(res => res.json())
	    .then(data => {
	      gugunSelect.innerHTML = '<option value="" disabled selected>구/군 선택</option>';
	      data.forEach(dong => {
	        const option = document.createElement('option');
	        option.value = dong;
	        option.textContent = dong;
	        gugunSelect.appendChild(option);
	      });
	      gugunSelect.disabled = false;
	      
	      // 초기 상태에서 Submit 버튼 비활성화 (구/군 선택 안된 상태)
	      btnSubmit.disabled = true;
	      btnSubmit.style.backgroundColor = "#cccccc";
	      btnSubmit.style.cursor = "not-allowed";
	    });
	  
	  // 시/도 선택 시 구/군 동적으로 업데이트
	  sidoSelect.addEventListener('change', function () {
	    const sido = this.value;

	    if (sido === '서울특별시') {
	      fetch('/lighting/user/getSeoulDistricts')
	        .then(res => res.json())
	        .then(data => {
	          gugunSelect.innerHTML = '<option value="" disabled selected>구/군 선택</option>';
	          data.forEach(dong => {
	            const option = document.createElement('option');
	            option.value = dong;
	            option.textContent = dong;
	            gugunSelect.appendChild(option);
	          });
	          gugunSelect.disabled = false;
	          
	          // 구/군 아직 선택 안됨 - 버튼 비활성화
	          btnSubmit.disabled = true;
	          btnSubmit.style.backgroundColor = "#cccccc";
	          btnSubmit.style.cursor = "not-allowed";
	        });
	    } else {
	      gugunSelect.innerHTML = '<option value="">아직 해당 시/도는 준비 중입니다.</option>';
	      gugunSelect.disabled = true;
	      
	      // 서울 아닌 지역 선택 - 버튼 비활성화
	      btnSubmit.disabled = true;
	      btnSubmit.style.backgroundColor = "#cccccc";
	      btnSubmit.style.cursor = "not-allowed";
	    }
	  });
	  
	  // 구/군 선택 시 버튼 활성화
	  gugunSelect.addEventListener('change', function() {
	    if (this.value && !this.disabled) {
	      // 구/군 선택됨 - 버튼 활성화
	      btnSubmit.disabled = false;
	      btnSubmit.style.backgroundColor = "#1e62c8";
	      btnSubmit.style.cursor = "pointer";
	    } else {
	      // 구/군 선택 안됨 - 버튼 비활성화
	      btnSubmit.disabled = true;
	      btnSubmit.style.backgroundColor = "#cccccc";
	      btnSubmit.style.cursor = "not-allowed";
	    }
	  });
	  
	  // Submit 버튼 클릭 시 유효성 검사
	  btnSubmit.addEventListener('click', function (event) {
	    if (gugunSelect.disabled || !gugunSelect.value) {
	      event.preventDefault(); // 폼 제출을 막음
	      alert("서울특별시의 구/군을 선택해주세요.");
	    }
	  });
	});
    /* citySelect.addEventListener("change", function() {
      const selectedCity = this.value;
      if (selectedCity === "서울") {
        // 서울 선택 시 구/군 옵션 활성화
        districtSelect.innerHTML = seoulDistrictOptions;
        districtSelect.disabled = false;
      } else {
        // 서울이 아닐 경우 구/군 선택 불가능 및 안내 메시지 표시
        districtSelect.innerHTML = '<option value="">아직 서울만 지원합니다.</option>';
        districtSelect.disabled = true;
      }
    }); */

    // 관심 태그 체크박스 최대 2개 선택 제한
    const interestCheckboxes = document.querySelectorAll('.interestTags input[type="checkbox"]');
    interestCheckboxes.forEach(checkbox => {
      checkbox.addEventListener('change', function() {
        let checkedCount = document.querySelectorAll('.interestTags input[type="checkbox"]:checked').length;
        if (checkedCount > 2) {
          this.checked = false;
          alert("최대 2개까지 선택 가능합니다.");
        }
      });
    });
	
    // 비밀번호 검증 함수
    function validatePassword() {
      const password = document.getElementById('pw').value;
      const passwordPattern = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*()_+={}\[\]:;"\'<>,.?/\\|`~\-]).{8,16}$/;
      const pwErrorMessage = document.getElementById('pwErrorMessage'); // 오류 메시지 요소

      if (!passwordPattern.test(password)) {
        pwErrorMessage.style.display = 'inline'; // 오류 메시지 표시
      } else {
        pwErrorMessage.style.display = 'none'; // 비밀번호가 유효하면 오류 메시지 숨김
      }
    }

    // 비밀번호 입력 시 실시간으로 검증
    document.getElementById('pw').addEventListener('input', function() {
      validatePassword(); // 비밀번호가 변경될 때마다 검증 함수 호출
    });

    // 비밀번호 필드 포커스를 잃을 때도 검증
    document.getElementById('pw').addEventListener('blur', function() {
      validatePassword(); // 포커스를 잃을 때도 검증 호출
    });
    
 // 이름 검증 함수
    function validateName() {
        const name = document.getElementById('name').value; // 입력된 이름
        const namePattern = /^[가-힣]{2,10}$/; // 한글만 2~10자
        const nameErrorMessage = document.getElementById('nameErrorMessage'); // 오류 메시지 요소

        // 이름 규격에 맞지 않으면 오류 메시지 표시
        if (!namePattern.test(name)) {
            nameErrorMessage.style.display = 'inline'; // 오류 메시지 표시
        } else {
            nameErrorMessage.style.display = 'none'; // 이름이 유효하면 오류 메시지 숨김
        }
    }

    // 이름 입력 시 실시간으로 검증
    document.getElementById('name').addEventListener('input', function() {
        validateName(); // 이름이 변경될 때마다 검증 함수 호출
    });

    // 이름 필드 포커스를 잃을 때도 검증
    document.getElementById('name').addEventListener('blur', function() {
        validateName(); // 포커스를 잃을 때도 검증 호출
    });

 // 닉네임 검증 함수
    function validateNickname() {
        const nickname = document.getElementById('nickname').value; // 입력된 닉네임
        const nicknamePattern = /^[가-힣]{2,10}$/; // 한글만 2~10자
        const nicknameErrorMessage = document.getElementById('nicknameErrorMessage'); // 오류 메시지 요소

        // 닉네임 규격에 맞지 않으면 오류 메시지 표시
        if (!nicknamePattern.test(nickname)) {
            nicknameErrorMessage.style.display = 'inline'; // 오류 메시지 표시
        } else {
            nicknameErrorMessage.style.display = 'none'; // 닉네임이 유효하면 오류 메시지 숨김
        }
    }

    // 닉네임 입력 시 실시간으로 검증
    document.getElementById('nickname').addEventListener('input', function() {
        validateNickname(); // 닉네임이 변경될 때마다 검증 함수 호출
    });

    // 닉네임 필드 포커스를 잃을 때도 검증
    document.getElementById('nickname').addEventListener('blur', function() {
        validateNickname(); // 포커스를 잃을 때도 검증 호출
    });

 // 생년월일 검증 함수
    function validateBirthday() {
        const birthday = document.getElementById('birthday').value; // 입력된 생년월일
        const birthdayPattern = /^\d{8}$/; // 8자리 숫자(YYYYMMDD) 형식
        const birthdayErrorMessage = document.getElementById('birthdayErrorMessage'); // 오류 메시지 요소

        // 생년월일 규격에 맞지 않으면 오류 메시지 표시
        if (!birthdayPattern.test(birthday)) {
            birthdayErrorMessage.style.display = 'inline'; // 오류 메시지 표시
        } else {
            birthdayErrorMessage.style.display = 'none'; // 생년월일이 유효하면 오류 메시지 숨김
        }
    }

    // 생년월일 입력 시 실시간으로 검증
    document.getElementById('birthday').addEventListener('input', function() {
        validateBirthday(); // 생년월일이 변경될 때마다 검증 함수 호출
    });

    // 생년월일 필드 포커스를 잃을 때도 검증
    document.getElementById('birthday').addEventListener('blur', function() {
        validateBirthday(); // 포커스를 잃을 때도 검증 호출
    });

 	// 연락처 검증 함수
    function validateTel() {
      const tel = document.getElementById('tel').value; // 입력된 연락처
      const telPattern = /^\d{3}-\d{3,4}-\d{4}$/; // 11자리 숫자만 가능
      const telErrorMessage = document.getElementById('telErrorMessage'); // 오류 메시지 요소

      // 연락처가 규격에 맞지 않으면 오류 메시지 표시
      if (!telPattern.test(tel)) {
        telErrorMessage.style.display = 'inline'; // 오류 메시지 표시
      } else {
        telErrorMessage.style.display = 'none'; // 연락처가 유효하면 오류 메시지 숨김
      }
    }

    // 연락처 입력 시 실시간으로 검증
    document.getElementById('tel').addEventListener('input', function() {
      validateTel(); // 연락처가 변경될 때마다 검증 함수 호출
    });

    // 연락처 필드 포커스를 잃을 때도 검증
    document.getElementById('tel').addEventListener('blur', function() {
      validateTel(); // 포커스를 잃을 때도 검증 호출
    });
    
    
    // 아이디 중복 체크 함수
    function checkId() {
      const id = document.getElementById('id').value;

      if (id) {
        // Ajax로 중복 체크 요청
        const xhr = new XMLHttpRequest();
        xhr.open('GET', '/lighting/user/register/checkId.do?id=' + id, true);
        xhr.onreadystatechange = function () {
          if (xhr.readyState === 4 && xhr.status === 200) {
            const response = JSON.parse(xhr.responseText);
            const messageElement = document.getElementById('idMessage');
            
            if (response.isDuplicate) {
              // 아이디 중복 시
              messageElement.style.display = 'inline';  // 메시지 표시
              messageElement.style.color = 'red';  // 빨간색으로 표시
              messageElement.textContent = "중복되는 ID 입니다";
            } else {
              // 아이디 중복되지 않으면
              messageElement.style.display = 'inline';  // 메시지 표시
              messageElement.style.color = 'green';  // 초록색으로 표시
              messageElement.textContent = "사용 가능한 ID입니다"; 
              
              // 아이디 중복되지 않으면 다른 필드 활성화
  /*          document.getElementById('passwordGroup').style.display = 'block';
              document.getElementById('nameGroup').style.display = 'block';
              document.getElementById('nicknameGroup').style.display = 'block';
              document.getElementById('birthdayGroup').style.display = 'block';
              document.getElementById('telGroup').style.display = 'block';
              document.getElementById('emailGroup').style.display = 'block';
              document.getElementById('genderGroup').style.display = 'block'; */
            }
          }
        };
        xhr.send();
      } else {
        alert("아이디를 입력해 주세요.");
      }
    }
    
 // 이메일 인증 AJAX 요청
    function sendEmail() {
      const email = document.getElementById('email').value;

      fetch('/lighting/user/sendmail.do', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: 'email=' + encodeURIComponent(email)
      })
      .then(res => res.json())
      .then(data => {
        if (data.result === 1) {
          alert("인증번호가 이메일로 발송되었습니다.");
          
          // 인증번호 입력란과 확인 버튼을 보이도록 설정
          document.getElementById('verificationSection').style.display = 'block';
        }
      });
    }

 // 인증번호 확인 AJAX 요청
    function verifyCode() {
      const email = document.getElementById('email').value;
      const validNumber = document.getElementById('validNumber').value;

      // 서버로 보내는 데이터에서 `encodeURIComponent`를 클라이언트 측 JavaScript에서 처리
      const encodedEmail = encodeURIComponent(email);
      const encodedCode = encodeURIComponent(validNumber);

      fetch('/lighting/user/validmail.do', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: `email=\${encodedEmail}&validNumber=\${encodedCode}`
      })
      .then(res => res.json())
      .then(data => {
        if (data.result === 1) {
          alert("인증 성공!");
        } else {
          alert("인증 실패!");
        }
      });
    }



    
			
			

    $('#logo').click(() => { 
      window.location.href =  '/lighting/main.do'; // 메인페이지로 이동
    });
  </script>
  
  <%@ include file="/WEB-INF/views/inc/footer.jsp"%>
</body>
</html>
