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
    
    <!-- Custom styles for this template -->
    <link href="resources/css/agency.min.css" rel="stylesheet">
<style type="text/css">
	#btnRes {
		width:100px;
		height:40px;
		background-color: #D5D5D5;
	}
	#btnCancle {
		width:100px;
		height:40px;
		background-color: #D5D5D5;
	}
	#navbarResponsive {
		position: fixed;
		right:1%;
	}
	#title {
		position: relative;
		top: 150px;
		left: 30%;
	}
	#center {
		position: relative;
		width: 80%;
		top: 200px;
		left: 33%;
	}
</style>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<script>

$(function() {
	var id = $("#cid").val();
	var tcode = $("#tcode").val(); 

	$.ajax("resTheme.do", {
		data : {tcode:tcode},
		success : function(data){
			var themeVo = eval("("+data+")");
			$("#loc").html(themeVo.loc1 + "&nbsp;" + themeVo.loc2	);
			$("#ername").html(themeVo.ername);
			$("#tname").html(themeVo.tname);
			$("#price").val(themeVo.price);
			$("#erid").val(themeVo.id);
			$("#totalPrice").val($("#price").val() * 2);
			$("#totalView").html(($("#price").val() * 2)+"원");
			
			var people = themeVo.people;
			for(var i=2; i<=people; i++) {
				$("<option></option>").html(i).appendTo("#resPeople").attr("value",i);
			}
		}
	});
	
	$.ajax("resCustomer.do", {
		data : {id:id},
		success : function(data){
			var list = eval("("+data+")");
			$("#custName").html(list.name);
			$("#tel").html(list.tel);
		}
	});
	
	$("#resPeople").change(function() {
		var totalView = $("#price").val() * $("#resPeople").val();
		$("#totalView").html(totalView + "원");
		$("#totalPrice").val(totalView);
	});
	
	$("#btnRes").click(function(){
		alert("예약이 완료되었습니다.");
	});
	$("#btnCancle").click(function(){
		$(location).attr("href","main.do");
	});
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
              <a class="nav-link" href="login.do" data-toggle="modal" data-target="#myModal">로그인</a>
            </li>
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
    
   	<img src="resources/img/title/res_detail.png" id="title">
	<div id="center">
		<form action="resOk.do" method="post">
			<input type="hidden" id="cid" name="cid" value="<%=session.getAttribute("id")%>">
			<input type="hidden" id="price">
			<input type="hidden" id="totalPrice" name="totalPrice" value="">
			<table border="1" width="600px" height="700px">
				<tr>
					<td width="30%" align="center">장소</td>
					<td id="loc"></td>
				</tr>
				<tr>
					<td align="center">지점명</td>
					<td id="ername"></td>
				</tr>
				<tr>
					<td align="center">예약일</td>
					<td>
						${date }
					</td>
					<input type="hidden" name="theme_resCode" value="${theme_resCode }">
					<input type="hidden" name="tcode" id="tcode" value="${tcode }">
				</tr>
				<tr>
					<td align="center">시간</td>
					<td>
						${viewtime }
					</td>
					<input type="hidden" value="${time }">
				</tr>
				<tr>
					<td align="center">테마명</td>
					<td id="tname"></td>
				</tr>
				<tr>
					<td align="center">인원</td>
					<td>
						<select id="resPeople" name="resPeople"></select>
					</td>
				</tr>
				<tr>
					<td align="center">예약자명</td>
					<td id="custName"></td>
				</tr>
				<tr>
					<td align="center">연락처</td>
					<td>
						<span id="tel"></span>
					</td>
				</tr>
				<tr>
					<td align="center">가격</td>
					<td id="totalView" name="totalView"></td>
				</tr>
				<tr>
					<td align="center">결제방식</td>
					<td>
						<input type="radio" name="payType" value="1" checked="checked">현장결제
						<input type="radio" name="payType" value="2">카드결제
					</td>
				</tr>
			</table>
			<input type="submit" value="예약하기" id="btnRes">&nbsp;
			<button id="btnCancle">취소</button>
		</form>
	</div>
</body>
</html>