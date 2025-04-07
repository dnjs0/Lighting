<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<style>  
    .body {
        width:1300px;
        height:auto;
        align-content:center;
        display: flex;  
        flex-direction: column;
        margin: 0 auto;
        background-color: #f9f7ff;
    }

    #logo {  
        width: 220px;  
        height: auto;  
        margin-bottom: 20px; /* 로고와 다음 요소 사이의 간격 */  
        position: relative;
        top: 15px; /* 상단 20px 떨어지게 */  
        left: 20px; /* 왼쪽 20px 떨어지게 */  
    }  

    .header {  
        font-size: 15px;  
        color: #888;  
        cursor: pointer;  
        display: flex; /* 수평으로 나열하기 위해 flex 사용 */  
        justify-content: flex-end; /* 오른쪽 정렬 */  
        width: calc(100% - 40px);
        text-decoration: none;
    }  

    #userinfo {  
        display: flex; /* 유저 정보 항목 수평 정렬 */  
        gap: 30px; /* 링크 간의 간격 */ 
        position: relative;
        bottom: 50px;
        text-decoration: none;
        padding-right:20px;
    }  

    .search-container {  
        display: flex;  
        justify-content: center;  
        align-items: center;
        padding-top: 5px;  
        gap: 10px;
    }  


    .location-info{
        width:850px;
        margin : 0 auto;  
        padding-top: 10px;
        font-size: 16px;
        color: #888;
        display : block;
        text-align: right;
        /* padding-left : 750px; */
    }

    .weather-info {
        width:850px;
        margin : 0 auto; 
        margin-bottom : 10px; 
        padding-top: 5px;
        font-size: 16px;
        color: #555;
        display : block;
        text-align: right;
        /* padding-left : 600px; */
    }
    
    .weather-info span{
        color: #1e62c8;
    }
    
    
    .search-container select {
        margin-bottom: 10px;
        padding: 10px;
        border: 1px solid #1e62c8;
        border-radius: 4px;
    }
    
    .search-box {  
        width: 700px;  
        height: 50px;  
        padding: 7px 35px 7px 15px;   
        border: none;   
        border-radius: 30px;   
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);  
        margin-bottom: 20px;
    }  
 
    .search-button {  
        background: none;  
        border: none;  
        cursor: pointer;  
        margin-left: -60px; /* 검색창과 버튼의 간격 조정 */  
        margin-bottom: 20px;
    }  

    .search-button img {  
        width: 30px;  
        height: 30px;  
        color: rgb(13, 1, 67);  
    }  
    
    #categorySelect {
        height: 40px;
        border-radius: 5px;
        padding: 5px;
        font-size: 16px;
        margin-right: 15px;
        margin-bottom: 20px;
    }
</style>  

<header class="body">  
    <a href="/lighting/main.do">
      <img alt="로고" src="/lighting/images/logo_가로.png" id="logo">
    </a>
    
    <div class="header">  
        <div id="userinfo">
            <c:if test="${empty sessionScope.auth}">  
                <a id="login" href="/lighting/user/login.do">LOGIN</a>  
                <a id="join" href="/lighting/user/register/registerrole.do">JOIN</a>  
            </c:if>
            <c:if test="${not empty sessionScope.auth}">
                <a id="logout" href="/lighting/user/logoutok.do">LOGOUT</a>
                <a id="mypage" href="/lighting/mypage/mypage.do">MY PAGE</a>  
            </c:if>
        </div>  
    </div>  
    
    

        
    <!-- 날씨 정보 영역 -->
    <div class="location-info">
        <span id="location">로딩중...</span>
    </div>
    <div class="weather-info">
        온도 : <span id="tempValue">로딩중...</span>&nbsp;&nbsp;
        날씨 : <span id="ptyValue">로딩중...</span>
    </div>
        
    <div class="search-container">  
        
        <select id="categorySelect" onchange="setCategory(this.value)">
            <option disabled selected>카테고리 선택</option>
            <option value="1">유산소</option>
            <option value="2">웨이트(무산소)</option>
            <option value="3">격투</option>
            <option value="4">코어&amp;밸런스</option>
            <option value="5">기능성</option>
            <option value="6">다이어트</option>
            <option value="7">스포츠 기타</option>
            <option value="8">액션</option>
            <option value="9">어드밴처</option>
            <option value="10">롤플레잉(RPG)</option>
            <option value="11">시뮬레이션</option>
            <option value="12">전략</option>
            <option value="13">스포츠</option>
            <option value="14">퍼즐</option>
            <option value="15">아케이드</option>
            <option value="16">슈팅</option>
            <option value="17">게임 기타</option>
            <option value="18">식사</option>
            <option value="19">카페</option>
            <option value="20">디저트</option>
            <option value="21">술</option>
            <option value="22">비건</option>
            <option value="23">맛집 기타</option>
            <option value="24">영화</option>
            <option value="25">공연</option>
            <option value="26">전시회&amp;미술</option>
            <option value="27">노래&amp;춤</option>
            <option value="28">언어교환</option>
            <option value="29">애니메이션</option>
            <option value="30">쇼핑</option>
            <option value="31">악기연주</option>
            <option value="32">문화 기타</option>
            <option value="33">스터디</option>
            <option value="34">취업준비</option>
            <option value="35">모의면접</option>
            <option value="36">멘토&amp;멘티</option>
            <option value="37">독서</option>
            <option value="38">재테크</option>
            <option value="39">비즈니스</option>
            <option value="40">코딩</option>
            <option value="41">자기계발 기타</option>
            <option value="42">여행</option>
            <option value="43">드라이브</option>
            <option value="44">캠핑</option>
            <option value="45">등산</option>
            <option value="46">명상</option>
            <option value="47">반려동물</option>
            <option value="48">꽃꽃이</option>
            <option value="49">독서</option>
            <option value="50">힐링 기타</option>
        </select>
    
        <input type="text" class="search-box" placeholder="&ensp;&ensp;모임을 검색해 보세요." />  
        <button class="search-button" onclick="performSearch()">  
            <img src="/lighting/images/search.png" alt="Search">
        </button>  
    </div>  
</header>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    var selectedCategory = null;

    function setCategory(catSeq) {
        selectedCategory = catSeq;
    }

    function performSearch() {
        var keyword = document.querySelector('.search-box').value.trim();
        if (!keyword) {
            alert("검색어를 입력하세요.");
            return;
        }
        if (selectedCategory == null) {
            alert("카테고리를 선택하세요.");
            return;
        }
        
        console.log(keyword);
        console.log(selectedCategory);
        
        $.ajax({
            type: 'POST',
            url: '/lighting/searchdata.do',
            data: {
                searchKeyword: keyword,
                tblCategorySubSeq: selectedCategory
            },
            dataType: 'json',
            success: function(result) {
                $('#meetingBox').html('');
                if(result && result.length > 0) {
                    $('#noResultMessage').html(''); 
                    $.each(result, function(index, meeting) {
                        var item = `
                        <div class="item">
                            <div>
                                <img src="/lighting/images/${meeting.meetingPhoto}" class="thumnail" data-tblMeetingPostSeq="${meeting.tblMeetingPostSeq}">
                            </div> 
                            <span class="title" data-tblMeetingPostSeq="${meeting.tblMeetingPostSeq}">
                                ${meeting.title}
                            </span>
                            <div>
                                <img class="icon" src="/lighting/images/${meeting.memberPhoto}" alt="Icon">
                                <span class="nameAndCap">
                                    &ensp;
                                    <span class="name">${meeting.nickname}</span>
                                    <br>
                                    <span class="capBox">
                                        <span class="capacity">${meeting.capacity}</span> 명 모집중
                                    </span>
                                </span>
                            </div>
                        </div>`;
                        $('#meetingBox').append(item);
                    });
                } else {
                    $('#noResultMessage').html('<p>검색 결과가 없습니다.<br>이런 모임은 어떠세요?</p>');
                    
                    $.ajax({
                        type: 'GET',
                        url: '/lighting/maindata.do',
                        data: { showAll: "true" },
                        dataType: 'json',
                        success: function(defaultResult) {
                            let count = 0;
                            $.each(defaultResult, function(index, meeting) {
                                if(count < 4) {
                                    var item = `
                                    <div class="item">
                                        <div>
                                            <img src="/lighting/images/${meeting.meetingPhoto}" class="thumnail" data-tblMeetingPostSeq="${meeting.tblMeetingPostSeq}">
                                        </div>
                                        <span class="title" data-tblMeetingPostSeq="${meeting.tblMeetingPostSeq}">
                                            ${meeting.title}
                                        </span>
                                        <div>
                                            <img class="icon" src="/lighting/images/${meeting.memberPhoto}" alt="Icon">
                                            <span class="nameAndCap">
                                                &ensp;
                                                <span class="name">${meeting.nickname}</span>
                                                <br>
                                                <span class="capBox">
                                                    <span class="capacity">${meeting.capacity}</span> 명 모집중
                                                </span>
                                            </span>
                                        </div>
                                    </div>`;
                                    $('#meetingBox').append(item);
                                    count++;
                                }
                            });
                        },
                        error: function(a, b, c) {
                            console.log(a, b, c);
                        }
                    });
                }
                console.log(result);
            },
            error: function(a, b, c){
                console.log(a, b, c);
            }
        });
    }
    
    $(document).ready(function() {
        $('.search-box').keypress(function(e) {
            if (e.which == 13) { 
                performSearch();
            }
        });
    });
    
    
    $(document).ready(function(){
        $.ajax({
            url: '/lighting/weather.do',
            type: 'GET',
            dataType: 'json',
            success: function(data) {
                // 위치 업데이트
                $('#location').text(data.location);
                // 온도 업데이트 (℃ 단위 추가)
                $('#tempValue').text(data.temperature + "℃");
                
                // 강수형태를 숫자 코드에서 텍스트로 변환 (예시)
                var ptyText = "";
                switch(data.precipitationType) {
                    case "0": ptyText = "맑음"; break;
                    case "1": ptyText = "비"; break;
                    case "2": ptyText = "비/눈"; break;
                    case "3": ptyText = "눈"; break;
                    case "5": ptyText = "빗방울"; break;
                    case "6": ptyText = "빗방울눈날림"; break;
                    case "7": ptyText = "눈날림"; break;
                    default: ptyText = data.precipitationType;
                }
                // 강수형태 업데이트
                $('#ptyValue').text(ptyText);
            },
            error: function(err) {
                console.error('날씨 정보를 불러오는 데 실패했습니다.', err);
            }
        });
    });
</script>
