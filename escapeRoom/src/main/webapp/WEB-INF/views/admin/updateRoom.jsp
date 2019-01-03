<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>정보 수정</title>
<!-- Bootstrap core CSS -->
    <link href="../resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom fonts for this template -->
    <link href="../resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>
    <style type="text/css">
    #hello{
		position: fixed;
		top:350px;
		right:0%;
	} 
	#layer_fixed
	{
		width:200px;
		color: #555;
		font-size:13px;
		position:fixed;
		z-index:999;
		top:70px;
		right:0%;
		-webkit-box-shadow: 0 1px 2px 0 #777;
		box-shadow: 0 1px 2px 0 #777;
		background-color: #363636;	
	}
	.list-group-item {
		background-color: #white;
		color: black;
	}
	#navbarResponsive {
		position: fixed;
		right:1%;
	}
	#center {
		position: relative;
		width:50%;
		top: 110px;
		left: 20%;
	}
   </style>
<script src="../resources/vendor/jquery/jquery.js"></script>
<script src="../resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.6.1.min.js"></script> 	
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js?autoload=false"></script>
<script type="text/javascript">
$(function(){
	
	$("#put").click(function(){
	//load함수를 이용하여 core스크립트의 로딩이 완료된 후, 우편번호 서비스를 실행합니다.
	    daum.postcode.load(function(){
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
	                // 예제를 참고하여 다양한 활용법을 확인해 보세요.
	         			
	                var fullAddr = '';
	            	var extraAddr= '';
	            	
	            	 // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    fullAddr = data.roadAddress;

	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    fullAddr = data.jibunAddress;
	                }

	                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
	                if(data.userSelectedType === 'R'){
	                    //법정동명이 있을 경우 추가한다.
	                    if(data.bname !== ''){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있을 경우 추가한다.
	                    if(data.buildingName !== ''){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	                }

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('addr').value = fullAddr;

	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById('sample6_address2').focus();
	                
	                $("#addr").html(data);
	            }
	        }).open();
	    });
	})
 	
  
        // 회원가입 화면의 입력값들을 검사한다.
        function checkValue()
        {
            var form = document.userInfo;
        
            if(!form.id.value){
                alert("아이디를 입력하세요.");
                return false;
            }     
            
            
            if(!form.pwd.value){
                alert("비밀번호를 입력하세요.");
                return false;
            }
            
            // 비밀번호와 비밀번호 확인에 입력된 값이 동일한지 확인
            if(form.pwd.value != form.pwdcheck.value ){
                alert("비밀번호를 동일하게 입력하세요.");
                return false;
            }    
            
            if(!form.name.value){
                alert("이름을 입력하세요.");
                return false;
            }
          
            if(!form.email.value){
                alert("메일 주소를 입력하세요.");
                return false;
            }
            
            if(!form.tel.value){
                alert("전화번호를 입력하세요.");
                return false;
            }
            
            if(isNaN(form.tel.value)){
                alert("전화번호는 - 제외한 숫자만 입력해주세요.");
                return false;
            }
            
        }
	$("#btn_bye").click(function(){
		var pwd = $("#pwd_check").val();
		var id = $("#id_check").val();
		 $.ajax({url:"ermember/deleteRoom.do",data:{id:id,pwd:pwd},success:function(data){
			 if(data=='success'){
				swal({title: "탈퇴 성공", text: "Bye!", icon: 
				"success"}).then(function(){ 
				  	location.reload("../listES2.do");
				   }
				);
			}else{
				swal("탈퇴 실패", "Please check your Password!", "error");
			}
		}})//btnbyeajax 
		
	})//btnbye
	
})
   </script>
</head>
<body>
<!-- start Navigation -->
<div id="navCSS">
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">

        <a class="navbar-brand" href="../main.do" id="navbarLogo"><img src="../resources/img/mylogo.png" width="150" id="imglogo"></a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
          <ul class="navbar-nav ml-auto">
            <li class="nav-item">
              <a class="nav-link" href="../main.do">예약하기</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="../listES2.do">지점소개</a>
            </li>
             <li class="nav-item active">
              <a class="nav-link" href="#">내정보</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="../logout.do">로그아웃</a>
            </li>
          </ul>
        </div>

    </nav>
</div>
<!-- end Navigation -->
<div id="center">
	<h2 align="center">${ev.name } 님의 회원 정보 수정</h2>
	<br>
	<form action="updateRoom.do" method="post" enctype="multipart/form-data">
	       <table class="table">
                <tr>
                    <td width="140px">아이디</td>
                    <td>
                    	<input type="hidden" name="id" value="${ev.id }">
                    	${ev.id }
                    </td>
                </tr>
                        
                <tr>
                    <td>비밀번호</td>
                    <td>
                        <input type="password" name="pwd" maxlength="50" value="${ev.pwd }">
                    </td>
                </tr>
                
                <tr>
                    <td>비밀번호 확인</td>
                    <td>
                        <input type="password" maxlength="50" id="pwdcheck">
                    </td>
                </tr>
                    
                    
                <tr>
                    <td>지점명</td>
                    <td>
                        <input type="text" name="ername" maxlength="100" value="${ev.ername }">
                    </td>
                </tr>
                               
                               
                <tr>
                    <td>지점주소</td>
                    <td>
                 		시/도  : <input type="text" name="loc1" maxlength="100" value="${ev.loc1 }">
                 		구 : <input type="text" name="loc2" maxlength="100" value="${ev.loc2 }"">
                    </td>
                </tr>
                               
              
                <tr>
                    <td>이름</td>
                    <td>
                        <input type="text" name="name" maxlength="50" value="${ev.name }">
                    </td>
                </tr>
                                           
                    
                <tr>
                    <td>이메일</td>
                    <td>
                        <input type="email" name="email" maxlength="50" value="${ev.email }">
                    </td>
                </tr>
                    
                <tr>
                    <td>지점 전화번호</td>
                    <td>
                        <input type="text" name="tel" value="${ev.tel }">
                    </td>
                </tr>
                          
                <tr>
                    <td>지점 방 개수</td>
                    <td>
                        <input type="number" name="room" value="${ev.room }">
                    </td>
                </tr>
                
                 
                            
                <tr>
                    <td>지점 이미지</td>
                    <td>     
                  	 	<input type="hidden" name="fname" value="${ev.fname }">
                    	기존 사진 : 
                    	<br>
                    	<img src="../resources/img/${ev.fname }" width="100" height="100"/><br>
                        <input type="file" name="file">
                    </td>
                </tr>
                
                <tr>
                    <td>지점 상세주소</td>
                    <td>
                    	<h4>기존주소 : ${ev.addr }<br></h4>
						<input type="text" name="addr" size="30" id="addr">
						<button type="button" id="put">주소검색</button>
                    </td>
                </tr>
                <tr>
                	<td colspan="2" align="center"><input type="submit" value="수정">
						<input type="reset" value="취소"></td>
                </tr>
            </table>

	
	</form>
</div>
		<!-- 마이페이지 - 목록  -->
	<div id="layer_fixed">
   	 <div class="list_mypage">
	    <a href="updateRoom.do?id=${ev.id }" class="list-group-item"><img src="../resources/img/icons/my_infor.JPG" width="25" height="25">&nbsp; 정보 수정 </a>
		<a href="../bmain.do?ername=${ev.ername }" class="list-group-item"><img src="../resources/img/icons/my_board.JPG" width="25" height="25">&nbsp; 게시물 관리 </a>
		<a href="myPageAdmin.do?id=${ev.id }" class="list-group-item"><img src="../resources/img/icons/my_res.JPG" width="25" height="25">&nbsp; 예약 관리 </a>
		<a href="theme/listTheme.do?id=${ev.id }" class="list-group-item"><img src="../resources/img/icons/my_theme.JPG" width="25" height="25">&nbsp; 테마 관리 </a>
		<a href="deleteRoom.do?id=${ev.id }" class="list-group-item"><img src="../resources/img/icons/my_delete.JPG" width="25" height="25">&nbsp; 회원 탈퇴 </a>
	  </div>
    </div>
    <div id="hello" align="center">
		<img src="../resources/img/${ev.fname }" width="200" height="200">
		<p align="center">${ev.name } 님 반갑습니다.</p>
	</div>
</body>
</html>