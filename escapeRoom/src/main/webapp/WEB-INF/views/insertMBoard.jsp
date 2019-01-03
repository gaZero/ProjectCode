<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="s" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,
	initial-scale=1.0,
	maximum-scale=1.0,
	minimum-scale=1.0,
	user-scalable=no">	<!-- 사용자가 조절할수 있는가? -->
<link rel="shortcut icon" href="resources/img/bit.png">		<!-- 안드로이드 사용자를 위한 바로가기 -->
<link rel="apple-touch-icon" href="resources/img/bit.png">	
<!-- 아이폰 " -->
<link rel="stylesheet" href="resources/css/swiper.min.css">
 <style type="text/css">
	.room{
		float: left;
		position:relative;
		margin: 10px;
		height:250px;
		width:290px;
		padding: 10px;
		border: solid 1px black;
	}
	span{
	 padding: 4px;
	}
	.noti{
		 background-color: #E8D9FF;
	}
	.conta{
		padding: 10px;
	
	}
	.log{
		margin: 0px;
	}
	#text1{
	
		font-weight : bold; 
		align-self: flex-end;
		 
	}

</style>
<title>Insert title here</title>
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<script src="resources/js/swiper.min.js"></script>
<script type="text/javascript">

$(function () {
	 $(window).on('hashchange', function () {
		 var cur = $(this).attr("page");
			var url = "mbBoard.do"
			$(location).attr('href',url);
			
       });
	 
})

</script>

</head>

<body>
	<div data-role="page">
		<div data-role="header" style="background-color: black;" align="center">
			<img src="resources/img/mylogo.png" align="top" width="150">
		</div>
	
		<div data-role="content">
			<div>내위치</div>
			<hr>
			<h1 align="center"> &lt;  &nbsp; <%=session.getAttribute("ername")%> &nbsp; &gt; </h1>
			<hr width="50%">
				
			
					<div class="log" align="center">
						<s:if test='${not empty id}'>
								<font size="3px"><%=session.getAttribute("id")%>님 환영합니다~ </font>
							</s:if>
					
					</div>
					<form action="insertMBoard.do" method="post" enctype="multipart/form-data">		

			
			<input type="hidden" id="ername" name="ername" value="<%=session.getAttribute("ername")%>">
			
	
			<input type="hidden" id="btype" name="btype" value="1">
	
			<input type="hidden" id="no" name="no" value="${no}">
		
			
			<input type="text" id="id" name="id" value="<%=session.getAttribute("id") %>" readonly="readonly"><br>
			
		
			
			<input type="text" name="title" value="${pTitle }" placeholder="글 제목"><br>
		
		
			<textarea rows="10" cols="60" name="content" id="content" placeholder="글 내용"></textarea><br>
			
			
			<input type="submit" value="등록" class="btn btn-success center">
	
			</form>
			
			</div>		
		
	
				
			
		
		<div data-role="footer"  align="center"  data-position="fixed">
			
				<div class="ui-grid-c center">
							<div class="ui-block-a">
							<img src="resources/img/mainA/home_2.png" width="30" height="50">
							</div>
		    				
		    				<div class="ui-block-b">
		    				<img src="resources/img/mainA/sear_1.png"  width="30" height="50">
		    				</div>
		   				 	
		   				 	<div class="ui-block-c">
							<img src="resources/img/mainA/near.png"  width="30" height="50">
		   				 	</div>
		   				
		   					<div class="ui-block-d">
		   					<img src="resources/img/mainA/min_1.png"  width="30" height="50">
		   					</div>

				 		</div>
		</div>
	
	
		</div>
</body>

</html>