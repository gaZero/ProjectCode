<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>Insert title here</title>
<!-- Bootstrap core CSS -->
    <link href="../../resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template -->
    <link href="../../resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>
<style type="text/css">
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
	#title {
		position: relative;
		top: 150px;
		left: 22%;
	}
	#center {
		position: relative;
		width: 80%;
		top: 200px;
		left: 4%;
	}
</style>
<!-- Bootstrap core JavaScript -->
<script src="../../resources/vendor/jquery/jquery.js"></script>
<script src="../../resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
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
        <a class="navbar-brand" href="../../main.do" id="navbarLogo"><img src="../../resources/img/mylogo.png" width="150" id="imglogo"></a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
          <ul class="navbar-nav ml-auto">
            <li class="nav-item">
              <a class="nav-link" href="../../main.do">예약하기</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="../../listES2.do">지점소개</a>
            </li>
            
            <c:if test="${empty id}">
            <li class="nav-item">
              <a class="nav-link" href="login.do" data-toggle="modal" data-target="#myModal">로그인</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="../insertRoom.do">회원가입</a>
            </li>
            </c:if>
            <c:if test="${not empty id}">
             <li class="nav-item active">
              <a class="nav-link" href="#">내정보</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="../../logout.do">로그아웃</a>
            </li>
            </c:if>   
          </ul>
        </div>
      </div>
    </nav>
    <!-- end Navigation -->
   
   <input type="hidden" name="id" value="${id }">
   	<img src="../../resources/img/title/list_theme.png" id="title">
	<div id="center">
	   <br>
	   <a href="insertTheme.do?id=${id}">테마등록</a> 
	   <br>
	   <table class="table">
	      <tr align="center">
	         <td>테마이름</td>
	         <td>장르</td>
	         <td width="30%">내용</td>
	         <td>난이도</td>
	         <td>파일이름</td>
	         <td>이용시간</td>
	         <td>인원</td>
	         <td>금액</td>
	         <td>관리</td>
	      </tr>
	      
	      <c:forEach var="t" items="${list }">
	         <tr align="center">
	            <td align="center">${t.tname}</td>
	            <td>${t.genre}</td>
	            <td>${t.content}</td>
	            <td>${t.tstar}</td>
	            <td>${t.fname}</td>
	            <td>${t.playtime}</td>
	            <td>${t.people}</td>
	            <td>${t.price}</td>  
	            <td align="center"><a href="updateTheme.do?tcode=${t.tcode }&id=${id}">수정</a>&nbsp;
	            <a href="deleteTheme.do?tcode=${t.tcode }&id=${id}">삭제</a></td>  
	         </tr>
	      </c:forEach>
	   </table>
	</div>
   
   	<!-- 마이페이지 - 목록  -->
	<div id="layer_fixed">
   	 <div class="list_mypage">
	    <a href="../updateRoom.do?id=${id }" class="list-group-item"><img src="../../resources/img/icons/my_infor.JPG" width="25" height="25">&nbsp; 정보 수정 </a>
		<a href="../../bmain.do?ername=${ername }" class="list-group-item"><img src="../../resources/img/icons/my_board.JPG" width="25" height="25">&nbsp; 게시물 관리 </a>
		<a href="../myPageAdmin.do?id=${id }" class="list-group-item"><img src="../../resources/img/icons/my_res.JPG" width="25" height="25">&nbsp; 예약 관리 </a>
		<a href="listTheme.do?id=${id }" class="list-group-item"><img src="../../resources/img/icons/my_theme.JPG" width="25" height="25">&nbsp; 테마 관리 </a>
		<a href="../deleteRoom.do?id=${id }" class="list-group-item"><img src="../../resources/img/icons/my_delete.JPG" width="25" height="25">&nbsp; 회원 탈퇴 </a>
	  </div>
    </div>
	<!-- Bootstrap core JavaScript -->
    <script src="../../resources/vendor/jquery/jquery.min.js"></script>
    <script src="../../resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Plugin JavaScript -->
    <script src="../../resources/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Contact form JavaScript -->
    <script src="../../resources/js/jqBootstrapValidation.js"></script>
    <script src="../../resources/js/contact_me.js"></script>

    <!-- Custom scripts for this template -->
    <script src="../../resources/js/agency.min.js"></script>
</body>
</html>
