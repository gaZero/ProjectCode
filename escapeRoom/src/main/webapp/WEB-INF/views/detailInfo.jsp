<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="viewport" content="width=device-width">  
<meta name="description" content="">
<meta name="author" content="">
<title>지점 상세정보</title>    
  <!-- Bootstrap core CSS -->
    <link href="resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>
	
    
    <!-- Custom styles for this template -->
    <link href="resources/css/agency.min.css" rel="stylesheet">
    
<title>Insert title here</title>
<style type="text/css">
	#tbl{
		margin:auto;
		height:100px;
		width:80%
		
		
	}
	#navbarResponsive {
		position: fixed;
		right:3%;
	}
	@font-face { font-family: 'fontawesome-webfont'; src: url(resources/vendor/font-awesome/fonts/fontawesome-webfont.ttf) format('truetype'); }
	 body { font-family: fontawesome-webfont; }

</style>
<script src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<script type="text/javascript">
$(function(){
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
	                <a href="insertRoom.do" class="btn btn-default btn-block m-t-md"> 회원가입</a>
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
    
  	
	<br><br><br><br>
	<img src="resources/img/welcome_logo.png" width="700" height="60" style="margin-left: auto; margin-right: auto; display: block;"></img>
	<br><br><br><br>
	
	<table width="80%" id="tbl">
		<tr>
			<td colspan="3"><h3>&nbsp;[&nbsp;&nbsp; ${ev.ername } &nbsp;&nbsp;]&nbsp;</h3></td>
		</tr>
		<tr height="50">
		</tr>
		<tr>
			<td>	
				<i class="fa fa-map-marker" style="font-size:40px;color:gray;"></i>
				&nbsp;<i style="font-size:30px;color:gray;"> 찾아오시는 길 </i>
				<br><br><div id="map" style="width:100%;height:400px;"></div>
			</td>
			<td width="70"></td>
			<td width="500">
				<i class="fa fa-phone" style="font-size:30px;color:gray;">&nbsp;&nbsp;&nbsp;전화번호  :  ${ev.tel }</i><br><br><br><br>
				
				<i class="fa fa-map-o" style="font-size:30px;color:gray;">&nbsp;&nbsp;&nbsp;주소  :  ${ev.addr }</i><br><br>
			</td>
		</tr>
		<tr height="80"></tr>
		<tr>
			<td colspan="3">
				<hr>
				<br>
				<br>

				<i class="fa fa-black-tie">&nbsp;&nbsp;대표자 : ${ev.name }</i><br><br>
				<i class="fa fa-envelope-o">&nbsp;&nbsp;E-mail : ${ev.email }</i><br><br>
				<hr>
			</td>
		</tr>
	</table>

	
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a45032aaedc55b78d94c66e6686208ba&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new daum.maps.Map(mapContainer, mapOption); 

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new daum.maps.services.Geocoder();

// 주소로 좌표를 검색합니다
geocoder.addressSearch('${ev.addr}', function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === daum.maps.services.Status.OK) {

        var coords = new daum.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new daum.maps.Marker({
            map: map,
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new daum.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;">${ev.ername}</div>'
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    } 
});    
</script>

	
	
</body>
</html>