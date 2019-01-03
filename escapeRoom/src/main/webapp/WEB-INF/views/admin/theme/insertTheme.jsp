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
	.select{
		width: 173px;
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
	#title {
		position: relative;
		top: 150px;
		left: 22%;
	}
	#center {
		position: relative;
		width: 70%;
		top: 200px;
		left: 12%;
	}
	.inText{
	
	width: 400px;
	
	}
	.inTime
	{
		width: 50px;
	}
</style>
<!-- Bootstrap core JavaScript -->
<script src="../../resources/vendor/jquery/jquery.js"></script>
<script src="../../resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
	$(function() {
		
		$("#timeBtn").on("click", function () {
			
			$("#trt").empty()
			var ptList = [];
			var startTime_h = $("#startTime_h").val()
			var startTime_m = $("#startTime_m").val()
			
			var endTime_h = $("#endTime_h").val()
			var endTime_m = $("#endTime_m").val()
			
			var playTime = $("#playtime").val()
			
			var startTime = startTime_h +":"+startTime_m;
			
			var endTime = endTime_h + endTime_m;
			
			var st =  parseInt(startTime_h);
			var et = parseInt(endTime_h)-1;
			var pt = parseInt(playTime) + 20;
			var p_m = parseInt(startTime_m);
			var min;
			
			ptList.push(parseInt((startTime_h*60) + p_m))
			
			var std	= $("<td></td>").html(startTime);
			$("#trt").append(std);
				for (var i = st; i < et; i++) 
				
				{						
					min = p_m + pt;	
					
					if(min>=60)
						{
							var smin = parseInt(min /60)
							st = st+ smin
							
							if(st>et)
							{
								break;
							}
							
							if(min%60==0)
								{
								min = 0;
								}else
								{
									min = min-(60*smin)
								}
						}
									
					p_m = min
					
					if(min.length==1)
						{
							min ="00";
						}
					
					if(min==0)
						{
							min = "00";
						}
					
					var	rtime = st.toString()+":" + min;
					var retime = parseInt(st*60) + parseInt(min);		
					var td = $("<td></td>").html(rtime);
					ptList.push(retime);
					
					$("#trt").append(td);
				}
				$("#reTime").val(ptList);
				
			
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
    
    <img src="../../resources/img/title/insert_theme.png" id="title">
	<div id="center">
		<form action="insertTheme.do" method="post" enctype="multipart/form-data">
			<input type="hidden" name="id" value="<%=session.getAttribute("id") %>">
			<input type="hidden" name="ername" id="ername">


			<table width="600px" class="table">
			<tr><td width="250px" align="center">테마이름</td><td width="350px"><input type="text" name="tname"></td></tr>
			<tr><td align="center">장르</td> 
			<td><select name="genre" class="select">
	            <option value='공포'>공포</option>
	            <option value='판타지'>판타지</option>
	            <option value='감성'>감성</option>
	            <option value='스케일'>스케일</option>
	            <option value='19금'>19</option>
			</select></td></tr>
			<tr><td align="center">내용</td>
			<td><textarea rows="10" cols="60" name="content"></textarea></td></tr>
			<tr><td align="center">난이도</td>
			<td><select name="tstar">
				<option value='1'>1</option>
	            <option value='2'>2</option>
	            <option value='3'>3</option>
	            <option value='4'>4</option>
	            <option value='5'>5</option>
			</select></td></tr>
			<tr><td align="center">파일명</td><td><input type="file" name="uploadFile"></td></tr>
			<td align="center">플레이 시간</td>	
			<td><select name="playtime" id="playtime" class="select">
				<option value='30'>30분</option>
	            <option value='45'>45분</option>
	            <option value='60'>60분</option>
	            <option value='75'>75분</option>
			</select></td>
			
			<tr><td align="center">예약 가능 시간</td>
				<td >
					<font color="red"><h7>24시 기준으로 입력해주세요. <br>ex) 오전 11 시반 =11:30  오후 11시 = 23:00</h7><br></font> 
				<input type="text" id="startTime_h" name="startTime_h" placeholder="오픈" class="inTime"> &nbsp; : &nbsp;
				<input type="text" id="startTime_m" name="startTime_m" placeholder="시간" class="inTime">
				 &nbsp;	
				~
				&nbsp;
				<input type="text" id="endTime_h" name="endTime_h" placeholder="마감" class="inTime"> &nbsp; : &nbsp;
				<input type="text" id="endTime_m" name="endTime_m" placeholder="시간" class="inTime">
				<button type="button" id="timeBtn">입력</button><br>
				<font color="blue">준비시간은 20분 으로 설정 되어 있습니다.</font>

					<table>
						<tr id="trt"></tr>
					</table>
					<input type="hidden" id="retime" name="retime">
				</td>
				
			</tr>
			<tr><td align="center">인원수</td>
			<td><select name="people" id="people">
				<option value='1'>1</option>
	            <option value='2'>2</option>
	            <option value='3'>3</option>
	            <option value='4'>4</option>
	            <option value='5'>5</option>
	            <option value='6'>6</option>
			</select></td></tr>
			<tr><td align="center">가격</td><td><input type="number" name="price"></td></tr>		
			<tr><td colspan="2" align="center"><input type="submit" value="수정">&nbsp;<input type="reset" value="취소"></td></tr>
			</table>
		</form>
	</div>
	<br>
	
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