<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="s" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
	$(function () {
		 $(window).on('hashchange', function () {
			 var cur = $(this).attr("page");
				var url = "main.do"
				$(location).attr('href',url);
				
	        });
		
	})



</script>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<div id="header" align="center">
		<h2>${b.ername }&nbsp;&nbsp;Q&A</h2>	
	</div>
		
		<div class="container">
			
				<hr>
			<div>
					
					<p>글번호 : ${b.no} &nbsp;&nbsp;&nbsp; 작성자 : ${b.id} &nbsp;&nbsp;&nbsp; 조회수 : ${b.hit}</p>
					<p>제목 : ${b.title }</p> <p> 게시일 : ${b.wdate}</p>
					<hr>
					<div>
				
						<s:if test="${not empty b.fname}">
							<img src="../resources/upload/${b.fname }"/>
						</s:if>
				
					</div>
					<div>
					
					${b.content }
					</div>
					<hr>
					ip주소 : ${b.ip }<br>
			</div>
				<a href="updateBoard.do?no=${b.no }" class="btn btn-default pull-right">수정</a>
				<a href ="deleteBoard.do?no=${b.no }" class="btn btn-default pull-right">삭제</a>
				<a href="insertBoard.do?no=${b.no}" class="btn btn-default pull-right">답글</a>
			
		</div>
</body>
</html>