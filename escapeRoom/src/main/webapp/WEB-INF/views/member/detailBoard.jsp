<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="s" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>게시판</title> 
<link href="../resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="../resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>
 <link href="../resources/css/agency.min.css" rel="stylesheet">
<style type="text/css">
	#navbarResponsive {
		position: fixed;
		right:3%;
	}
</style>
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">

	$(function () {
		 $(window).on('hashchange', function () {
			 var cur = $(this).attr("page");
				var url = "main.do"
				$(location).attr('href',url);
				
	        });
		 

			$("#btn_login").click(function(){
				var id = $("#id").val();
				var pwd = $("#pwd").val();
				$.ajax({url:"login.do",data:{id:id,pwd:pwd},success:function(data){
					if(data=='success'){
						swal({title: "로그인 성공", text: "Welcome!", icon: 
						"success"}).then(function(){ 
						  	location.reload("listES2.do");
						   }
						);
					}else{
						swal("로그인 실패", "Please check your ID or Password!", "error");
					}
				}})//btnloginajax

			})//btnlogin
		
	})
</script>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	
		<!-- header -->
	<br><br><br><br><br><br>	
	<div class="header" align="center" >
		<h4>${b.ername }&nbsp;&nbsp;Q&A</h4>	
	</div>
	<br><br>
	<!-- end header -->
	
		<div class="container">

			<div>
					
					<p>글번호 : ${b.no} &nbsp;&nbsp;&nbsp; 작성자 : ${b.id} &nbsp;&nbsp;&nbsp; 조회수 : ${b.hit}</p>
					<p>제목 : ${b.title }</p> <p> 게시일 : ${b.wdate}</p>
					<hr>
					<div>
				
						<s:if test="${not empty b.fname}">
							<img src="../resources/upload/${b.fname }"/>
						</s:if>
				
					</div>
					<div style="width: 800 px; height: 300px;">
					
					${b.content }
					</div>
					<hr>
					ip주소 : ${b.ip }<br>
				
			</div>
				<s:if test="${b.id eq rid}">
				<a href="updateBoard.do?no=${b.no }" class="btn btn-default pull-right">수정</a>
				<a href ="deleteBoard.do?no=${b.no }&cu=<%=request.getAttribute("cu") %>" class="btn btn-default pull-right">삭제</a>
				</s:if>
			
		</div>
		
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
            <li class="nav-item active">
              <a class="nav-link" href="../listES2.do">지점소개</a>
            </li>
            
            <c:if test="${empty id}">
            <li class="nav-item">
              <a class="nav-link" href="../login.do" data-toggle="modal" data-target="#myModal">로그인</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="../insertAll.do">회원가입</a>
            </li>
            </c:if>
            <c:if test="${not empty id}">
           		<c:if test="${userType eq 0}">
	             	<li class="nav-item">
	              		<a class="nav-link" href="../admin/myPageAdmin.do?id=${id }">내정보</a>
	            	</li>
            	</c:if>
            	<c:if test="${userType eq 1}">
	             	<li class="nav-item">
	             		<a class="nav-link" href="myPage_Res.do">내정보</a>
	            	</li>
            	</c:if>
            <li class="nav-item">
              <a class="nav-link" href="../logout.do">로그아웃</a>
            </li>
            </c:if>
          </ul>
        </div>
      </div>
    </nav>
<!-- end Navigation -->

		<!---------------- 페이징 --------------->
		
    <!-- Bootstrap core JavaScript -->
    <script src="../resources/vendor/jquery/jquery.min.js"></script>
    <script src="../resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Plugin JavaScript -->
    <script src="../resources/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Contact form JavaScript -->
    <script src="../resources/js/jqBootstrapValidation.js"></script>
    <script src="../resources/js/contact_me.js"></script>

    <!-- Custom scripts for this template -->
    <script src="../resources/js/agency.min.js"></script>
		
</body>
</html>