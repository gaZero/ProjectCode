<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="s" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.css" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 

<!-- include summernote css/js -->
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.js"></script>





<script type="text/javascript">
</script>
<title>Insert title here</title>
</head>
<body>
	<div class="header" align="center" class="container">
	<h2>${info} ${title }</h2>
		<hr>
	</div>
		<div class="container">
	<form action="insertBoard.do" method="post"
		enctype="multipart/form-data">
		
		<div class="form">
			
			<input type="hidden" id="ername" name="ername" value="<%=(String)session.getAttribute("ername")%>">
			
			<s:choose>
			<s:when test="${empty pTitle }">
			<input type="hidden" id="btype" name="btype" value="0">
			</s:when>
			
			<s:otherwise>
			<input type="hidden" id="btype" name="btype" value="1">
			</s:otherwise>
			</s:choose>

			<input type="hidden" id="no" name="no" value="${no}">
		
			<label for="id" >작성자:</label> 
			<input type="text" id="id" name="id" value="<%=session.getAttribute("id")%>" ><br>
			
		
			<label for="title">제목 :</label> 
			<input type="text" name="title" value="${pTitle }"><br>
		
		
			<textarea rows="10" cols="60" name="content" id="content"></textarea><br>
			
			<label for="file">파일:</label> 
			<input type="file" name="uploadFile">
			</div>
			<input type="submit" value="등록" class="btn btn-success center">
			<a class="btn btn-default centert" href="#">뒤로가기</a>
		</form>		
		</div>
	
</body>
</html>