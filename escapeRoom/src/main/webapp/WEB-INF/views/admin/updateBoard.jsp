<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
</script>
<title>Insert title here</title>
</head>
<body>
	<div class="header" align="center" class="container">
	<h2><%=session.getAttribute("ername")%> ${title }</h2>
		<hr>
	</div>
	<div class="container">
	<form action="updateBoard.do" method="post"
		enctype="multipart/form-data">
			<input type="hidden" id="ername" name="ername" value="<%=session.getAttribute("ername")%>">
			<input type="hidden" id="btype" name="btype" value="${b.btype}">
			<input type="hidden" id="no" name="no" value="${b.no}">
		
			작성자 : <input type="text" id="id" name="id" value="${b.id }"><br>
			
		
			제목 : <input type="text" name="title" value="${b.title }"><br>
		
		
			<textarea rows="10" cols="100" name="content" id="content">${b.content }</textarea><br>
			
			첨부파일 : <input type="file" name="uploadFile" value="${b.fname }">
				
			<input type="submit" value="등록" class="btn btn-default center">
			<a class="btn btn-default centert" href="#">뒤로가기</a>
			
	</form>
	</div>
</body>
</html>