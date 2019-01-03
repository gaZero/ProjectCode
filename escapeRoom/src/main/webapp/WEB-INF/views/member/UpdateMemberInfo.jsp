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
	.myRes {
		position: relative;
		/* border: solid 1px black; */
		padding: 10px;
		margin: 10px;
		width: 600px;
		height: 200px;
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
		right:3%;
	}
	#center {
		position: relative;
		width: 60%;
		top: 100px;
		left: 10%;
	}
</style>
<script src="../resources/vendor/jquery/jquery.js"></script>
<script src="../resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.6.1.min.js"></script> 	
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js?autoload=false"></script>
<script type="text/javascript">
$(function() {
	function checkValue()
    {
        var form = document.userInfo;
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
});
</script>
</head>
<body>
<!-- start modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
		        <h4 class="modal-title" id="myModalLabel">로그인</h4>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		      	</div>
		    <div class="modal-body">
          		<div class="login-box well">
        		<form accept-charset="UTF-8" role="form" method="post" action="login.do">
            		<legend align="center"></legend>
	            	<div class="form-group">
	                	<label for="username-email">이메일 or 아이디</label>
	                	<input name="id" value='' id="id" placeholder="E-mail or Username" type="text" class="form-control" />
	            	</div>
	            	<div class="form-group">
	                	<label for="password">비밀번호</label>
	                <input name="pwd" id="pwd" placeholder="Password" type="password" class="form-control" />
	            </div>
	            <div class="form-group">
	                <input type="button" id="btn_login" class="btn btn-default btn-login-submit btn-block m-t-md" value="로그인">
	            </div>
	            <hr/>
	            <div class="form-group">
	                <a href="" class="btn btn-default btn-block m-t-md"> 회원가입</a>
	            </div>
        	</form>
        	</div>
     		 </div>
    		</div>
    	</div>
	</div>
<!-- end modal -->

  <!-- start Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
      <div class="container">
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
      </div>
    </nav>
    <!-- end Navigation -->

    <div id="center">
    	<br>
		<h1><font color="#FFE400">내 정보 수정</font></h1>
		<br>
		<br>
	    <form method="post" action="UpdateMemberInfo.do">
		<table class="table">
			<input type="hidden" name="id" id="id" value="<%=session.getAttribute("id")%>">
			<tr>
				<td id="title" width="140px">아이디</td>
				<td>${rc.id }
				</td>
			</tr>
			<tr>
				<td id="title">비밀번호</td>
				<td><input type="password" name="pwd" maxlength="50" id="pwd">
				</td>
			</tr>

			<tr>
				<td id="title">비밀번호 확인</td>
				<td><input type="password" name="pwdcheck" maxlength="50">
				</td>
			</tr>

			<tr>
				<td id="title">이름</td>
				<td><input type="text" name="name" maxlength="50" id="name"
					value="${rc.name }"></td>
			</tr>

			<tr>
				<td id="title">이메일</td>
				<td><input type="email" name="email" maxlength="50" id="email"
					value="${rc.email }"></td>
			</tr>

			<tr>
				<td id="title">휴대전화</td>
				<td><input type="text" name="tel" id="tel" value="${rc.tel }" />
				</td>
			</tr>
		</table>
		<br> <input type="submit" value="수정" /> <input type="reset"
			value="취소">
	</form>
</div>
   	<!-- 마이페이지 - 목록  -->
	<div id="layer_fixed">
   	 <div class="list_mypage">
	    <a href="UpdateMemberInfo.do?id=${id }" class="list-group-item"><img src="../resources/img/icons/my_infor.JPG" width="25" height="25">&nbsp; 내 정보 수정 </a>
		<a href="myPage_Res.do?id=${id }" class="list-group-item"><img src="../resources/img/icons/my_res.JPG" width="25" height="25">&nbsp; 내 예약 현황 </a>
		<a href="deleteRoom.do?id=${id }" class="list-group-item"><img src="../resources/img/icons/my_delete.JPG" width="25" height="25">&nbsp; 회원 탈퇴 </a>
		<a href="myPage_Star.do?id=${id }" class="list-group-item"><img src="../resources/img/icons/my_star.JPG" width="25" height="25">&nbsp; 별점 주기 </a>
	  </div>
    </div>
    
	<!-- Bootstrap core JavaScript -->
    <script src="../resources/vendor/jquery/jquery.min.js"></script>
    <script src="../resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Plugin JavaScript -->
    <script src="../resources/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Contact form JavaScript -->
    <script src="../resources/js/jqBootstrapValidation.js"></script>
    <script src="../resources/js/contact_me.js"></script>
</body>
</html>
