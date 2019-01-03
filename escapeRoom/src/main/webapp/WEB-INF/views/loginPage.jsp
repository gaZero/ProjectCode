<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
 <!-- Bootstrap core CSS -->
    <link href="resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template -->
    <link href="resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>

<style type="text/css">
	#navbarResponsive {
		position: fixed;
		right:1%;
	}
	#center {
		position: relative;
		width: 50%;
		top: 100px;
		left: 26%;
	}
</style>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<script>
$(function(){
	$("#btn_login").click(function(){
		var id = $("#id").val();
		var pwd = $("#pwd").val();
		$.ajax({url:"login.do",data:{id:id,pwd:pwd},success:function(data){
			if(data=='success'){
				swal({title: "로그인 성공", text: "Welcome!", icon: 
				"success"}).then(function(){ 
					$(location).attr("href","main.do");
				   }
				);
			}else{
				swal("로그인 실패", "Please check your ID or Password!", "error");
			}
		}})//btnloginajax
	})//btnlogin
	$("#logo").click(function() {
		$(location).attr("href","main.do");
	});
})
   </script>
</head>
<body>

<!-- start Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
      <div class="container">
       <a class="navbar-brand" href="main.do" id="navbarLogo"><img src="resources/img/mylogo.png" width="150" id="imglogo"></a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
          <ul class="navbar-nav ml-auto">
            <li class="nav-item">
              <a class="nav-link" href="main.do">예약하기</a>
            </li>
            <li class="nav-item active">
              <a class="nav-link" href="listES2.do">지점소개</a>
            </li>
            
             <c:if test="${empty id}">
            <li class="nav-item">
              <a class="nav-link" href="insertAll.do">회원가입</a>
            </li>
            </c:if>
            <c:if test="${not empty id}">
           		<c:if test="${userType eq 0}">
	             	<li class="nav-item">
	              		<a class="nav-link" href="admin/myPageAdmin.do?id=${id }">내정보</a>
	            	</li>
            	</c:if>
            	<c:if test="${userType eq 1}">
	             	<li class="nav-item">
	             		<a class="nav-link" href="member/myPage_Res.do">내정보</a>
	            	</li>
            	</c:if>
            <li class="nav-item">
              <a class="nav-link" href="logout.do">로그아웃</a>
            </li>
            </c:if>  
          </ul>
        </div>
      </div>
    </nav> 
<!-- end Navigation -->
	<div id="center" align="center">
		<img src="resources/img/LNL.png" width="280" height="200""/>
		<br><br>
		<h3 class="my-4" align="center">Lock N LoL 통합계정 로그인</h3>

		<form method="post" action="login.do">
			<div class="form-group">
				<label for="username-email">아이디</label> <input name="id" value=''
					id="id" placeholder="Username" type="text" class="form-control" />
			</div>
			<div class="form-group">
				<label for="password">비밀번호</label> <input name="pwd" id="pwd"
					placeholder="Password" type="password" class="form-control" />
			</div>
			<div class="form-group">
				<input type="button" id="btn_login" value="로그인" class="btn btn-default btn-login-submit btn-block m-t-md">
			</div>
		</form>
	</div>
	<!-- end form -->
	</body>
</html>
