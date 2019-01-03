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
<title>자바조 project</title>
  <!-- Bootstrap core CSS -->
    <link href="resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template -->
    <link href="resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>
<style type="text/css">
	.jumbotron{
		background-image: url('images/a.jpg');
		background-size: cover;
		text-shadow: black 0.2em 0.2em 0.2em;
		color:black;
	}
	/*내부 스타일 시트-특정 페이지만 적용(점보트론)*/
	.btn_res {
		width:150px;
		height:80px;
		margin-top: 5px;
		margin-bottom: 5px;
		margin-right: 5px;
		margin-left: 5px;
	}
	#btn_modal {
		display: none;
	}
	.div_center1 {
		position: relative;
		left: 32%;
	}
	.div_center2 {
		position: relative;
		left: 25%;
	}
	#loc1,#loc2,#ername {
		width: 140px;
	}
	#navbarResponsive {
		position: fixed;
		right:3%;
	}
	.footer {
	  padding: 25px 0;
	  text-align: center;
	  span.copyright {
	    font-size: 90%;
	    line-height: 40px;
	    text-transform: none;
	    @include heading-font;
	}
</style>
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

  
<script type="text/javascript">
	var user = navigator.userAgent;
	if(user.toLowerCase().indexOf("mobile") != -1) {
		location.href = "http://203.236.209.113:8099/escapeMb/mbMain.do";
	}

$(function() {
	
	$("#div").hide();
	var d = new Date();
	var year = d.getFullYear();
	var month = d.getMonth()+1;
	if(month < 10) {
		month = "0"+month;
	}
	var date = d.getDate();
	if(date < 10) {
		date = "0"+date;
	}
	var today = year + "-" + month + "-" + date;
	$("#resDate").val(today);
	
	var loc1 = $("#loc1").val();
	var loc2 = $("#loc2").val();
	var ername = $("#ername").val();
	var date = $("#resDate").val();

	resShow(loc1, loc2, ername, date);
	
	$("#resDate").datepicker({
    	dateFormat: "yy-mm-dd",
    	minDate: 0,
    	onSelect: function(resDate) {
    		var loc1 = $("#loc1").val();
    		var loc2 = $("#loc2").val();
			var ername = $("#ername").val();
			var date = $("#resDate").val();

			resShow(loc1, loc2, ername, date);
    	}
    });

	// 지점소개에서 "예약하기"로 넘어온 경우
	if($("#list_loc1").val() && $("#list_loc2").val() && $("#list_ername").val())
	{
		var loc1 = $("#list_loc1").val();
		var loc2 = $("#list_loc2").val();
		$("#loc1").val($("#list_loc1").val()).attr("selected","selected");
		$.ajax({url:"listRoom.do",data:{loc1:loc1},success:function(data){
			arr = eval("("+data+")"); 
			var temp = [];
			$.each(arr, function(i,v){
				temp[i] = v.loc2;
			})
			function tt(temp){
				var result = [];
				$.each(temp,function(i,e){
					if($.inArray(e,result)==-1){
						result.push(e);
					}
				})
				return result;
			}
			$.each(tt(temp),function(p,u){
				var option = $("<option></option>").html(u);
				$("#loc2").empty
				$("#loc2").append(option);
			});
			$("#loc2").val($("#list_loc2").val()).attr("selected","selected");
		}}); //ajax
		
		$.ajax({url:"listRoom.do",data:{loc1:loc1,loc2:loc2},success:function(data){
			arr2 = eval("("+data+")");
			
			$("#ername").empty().append('<option value="">지점 선택</option>') ;

		 	$.each(arr2,function(a,b){
				var option = $("<option></option>").html(b.ername);
				$("#ername").append(option);
			});
			$("#ername").val($("#list_ername").val()).attr("selected","selected");
		}}); //ajax
		resShow(loc1, loc2, $("#list_ername").val(), date)
	}	// 지점소개에서 "예약하기"로 넘어온 경우 end
	
    $("#loc1").change(function() {
    	var loc1 = $("#loc1").val();
    	var loc2 = $("#loc2").val();
		var ername = $("#ername").val();
		var date = $("#resDate").val();
		
		$("#loc2").empty().append('<option value="">지역 선택</option>');
		$("#ername").empty().append('<option value="">지점 선택</option>');

		$.ajax({url:"listRoom.do",data:{loc1:loc1},success:function(data){
			arr = eval("("+data+")"); 
			var temp = [];
			$.each(arr, function(i,v){
				temp[i] = v.loc2;
			})
			function tt(temp){
				var result = [];
				$.each(temp,function(i,e){
					if($.inArray(e,result)==-1){
						result.push(e);
					}
				})
				return result;
			}
			$.each(tt(temp),function(p,u){
				var option = $("<option></option>").html(u);
				$("#loc2").empty
				$("#loc2").append(option);
			});
		}}); //ajax
    }); //loc1 change
    
    $("#loc2").change(function() {
    	var loc1 = $("#loc1").val();
    	var loc2 = $("#loc2").val();
		var ername = $("#ername").val();
		var date = $("#resDate").val();
		
		$("#ername").empty().append('<option value="">지점 선택</option>');
		
		$.ajax({url:"listRoom.do",data:{loc1:loc1,loc2:loc2},success:function(data){
			arr2 = eval("("+data+")");
			
			$("#ername").empty().append('<option value="">지점 선택</option>') ;

		 	$.each(arr2,function(a,b){
				var option = $("<option></option>").html(b.ername);
				$("#ername").append(option);
			});
		}}); 
    }); //loc2 change
    
    $("#ername").change(function() {
    	var loc1 = $("#loc1").val();
    	var loc2 = $("#loc2").val();
		var ername = $("#ername").val();
		var date = $("#resDate").val();

		resShow(loc1, loc2, ername, date);
	}); //ername change
});

function resShow(loc1, loc2, ername, date) {
	if(loc1 && loc2 && ername && date) {
		$("#div").show();
		$("#img_select").hide();
		  
		var erInfor = {loc1:loc1, loc2:loc2, ername:ername, date:date}
		$.ajax("resShow.do",{
			data : erInfor,
			dataType : "json",
			traditional: true,
			success : function(data){
				$("#div").empty()
				$.each(data.str1, function(i,v){	
					var title = $("<h2></h2>");
					var span = $("<span></span>");
					var tname = $("<span></span").html(v.tname+"&nbsp;&nbsp;");
					var theme_detail = $("<span></span>").html("[테마 정보]");
					title.append(tname, theme_detail);
					var tcode = v.tcode;

					var span1 = $("<span></span>").html("난이도 : ");
					var span2 = $("<span></span>");
					var span3 = $("<span></span>");
					for(var i=0; i<v.tstar; i++) {
						$("<img></img>").attr({
							width: "16px",
							height: "16px",
							src: "resources/img/icons/star.png"
						}).appendTo(span2);
					}
					if(v.people > 2) {						
						span3.html("&nbsp&nbsp 인원 : 2명~"+v.people+"명")
					} else {
						span3.html("&nbsp&nbsp 인원 : "+v.people+"명")
					}
					$(span).append(span1,span2,span3);
					
					$("#div").append(title,span);
					var divTime = "divTime"+v.tcode
					$("<div></div>").attr({
						id:divTime,
						padding:"10px"
					}).appendTo("#div");
					
					$(theme_detail).click(function() {
						themeDetail(tcode);
						$("#btn_modal").trigger("click");
					});
					
					var br = 0;
					$.each(data.str2, function(i2,v2){
						if(tcode == v2.tcode && date == v2.bookDate) {
							br = br + 1;
							if(br > 5) {
								$("<br>").appendTo("#divTime"+v2.tcode);
								br = 0;
							}
							var btn_booktime = $("<button></button>").appendTo("#divTime"+v2.tcode);
							
							var time = v2.bookTime;
							var hour = Math.floor(v2.bookTime/60);
							var minute = Math.round((time/60 - hour) * 60);
							var viewtime = "";
							if(minute < 10) {
								viewtime = hour+":0"+minute;
							} else {
								viewtime = hour+":"+minute;
							}
							
							$(btn_booktime).addClass("btn_res");
							if(v2.resCode == "0") {
								$(btn_booktime).click(function(){
									$(location).attr("href","resDetail.do?date="+date+"&tcode="+v2.tcode+"&time="+time+"&theme_resCode="+v2.theme_resCode+"&viewtime="+viewtime);
								});
								$(btn_booktime).attr("style","background:#B2CCFF").html(viewtime+"<br>예약가능");
							} else {
								$(btn_booktime).attr("style","background:#989898").html(viewtime+"<br>예약불가");
							}
						}
					});
				});
			}
		});
	} else {
		  $("#div").hide();
	}
} //resShow

function themeDetail(tcode) {
	$.ajax("resTheme.do",{
		data: {tcode:tcode},
		dataType : "json",
		success: function(data){
			$("#modal-tname").html(data.tname);
			$("#modal-img").attr({ src:"resources/theme/"+data.fname });
			
			$("#modal-genre").html(data.genre);
			$("#modal-tstar").empty();
			for(var i=0; i<data.tstar; i++) {
				$("<img></img>").attr({
					width: "16px",
					height: "16px",
					src: "resources/img/icons/star.png"
				}).appendTo("#modal-tstar");
			}		
			$("#modal-content").html(data.content);
		}
	});
} //themeDetail
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
            <li class="nav-item active">
              <a class="nav-link" href="main.do">예약하기</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="listES2.do">지점소개</a>
            </li>
            
            <c:if test="${empty id}">
            <li class="nav-item">
              <a class="nav-link" href="loginPage.do">로그인</a>
            </li>
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

<div class="container"> 
  <div id="myCarousel" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <ol class="carousel-indicators">
      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
      <li data-target="#myCarousel" data-slide-to="1"></li>
      <li data-target="#myCarousel" data-slide-to="2"></li>
    </ol>

     <!-- Wrapper for slides -->
     <div class="carousel-inner">
       <div class="item active">        
         <img src="resources/images/001.png" class="img-fluid" alt="Los Angeles" style="max-width: 100%; height: auto;">
       </div>
 
       <div class="item">
         <img src="resources/images/002.png" alt="Chicago" style="width:100%;">
       </div>
     
   	   <div class="item">
         <img src="resources/images/003.png" alt="Chicago" style="width:100%;">
       </div>
    <!--   <div class="item">
        <img src="ny.jpg" alt="New york" style="width:100%;">
      </div>
    </div> -->

     <!-- Left and right controls -->
     <a class="left carousel-control" href="#myCarousel" data-slide="prev">
       <span class="glyphicon glyphicon-chevron-left"></span>
       <span class="sr-only">Previous</span>
     </a>
     <a class="right carousel-control" href="#myCarousel" data-slide="next">
       <span class="glyphicon glyphicon-chevron-right"></span>
       <span class="sr-only">Next</span>
     </a>
   </div>
 </div>
</div>	
	<br>
	<hr>
	<input type="hidden" value="${id }" id="sessionid">
	<input type="hidden" value="${loc1 }" id="list_loc1">
	<input type="hidden" value="${loc2 }" id="list_loc2">
	<input type="hidden" value="${ername }" id="list_ername">
	<!-- reservation -->
	<div class="div_center1">
		<select id="loc1">
			<option value="" selected>시·도 선택</option>
			<option value='서울'>서울</option>
			<option value='경기'>경기</option>
			<option value='인천'>인천</option>
			<option value='강원'>강원</option>
			<option value='제주'>제주</option>
			<option value='충남'>충남/세종</option>
			<option value='부산'>부산</option>
			<option value='울산'>울산</option>
			<option value='경남'>경남</option>
			<option value='대구'>대구</option>
			<option value='경북'>경북</option>
			<option value='전남'>전남</option>
			<option value='전주'>전주/전북</option>
		</select>
		<select id="loc2" >
			<option value="" selected>지역 선택</option>
		</select>
		<select id="ername">
			<option value="" selected>지점 선택</option>
		</select>
		<input type="text" id="resDate" name="resDate" class="ipt black" autocomplete="off" readonly="">
	<br>
	<br>
	</div>
	<h2 align="center"><img src="resources/img/selectER.jpg" width="500" height="150" id="img_select"></h2>
	<div id="div" class="div_center2"></div>
	
	<!-- Modal -->
	<div id="modal_theme" class="modal fade" role="dialog">
	  <div class="modal-dialog">
	    <!-- Modal content-->
	    <div class="modal-content">
	      <div class="modal-header">
	        <h2 id="modal-tname"></h2>
	      </div>
	      <div class="modal-body">
	        <table id="tb">
	        	<tr>
	        		<td width="200px">
	        			<img src="" width="300px" height="400px" id="modal-img"/>
	        		</td>
	        		<td width="20px"></td>
	        		<td width="500px" id="modal-detail" style="font-size: 13px">
	        			<div height="300px">
	        			장르 : <span id="modal-genre"></span><br> 
	        			난이도 : <span id="modal-tstar"></span><br>
	        			<span id="modal-content">
	        			</div>
	        		</td>	        	
	        	</tr>
	        </table>
	      </div>
	    </div>
	  </div>
	</div>
	<button id="btn_modal" type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#modal_theme">Open Modal</button>
	
	

	<footer class="container-fluid text-center" style="background-color: #000000; color:#ffffff">
	<section class="footer-top">
		<div class="inner container">
			<ul class="nav nav-pills">
				<li><a href="#">개인정보취급방침</a></li>
				<li><a href="#">제휴문의</a></li>
				<li><a href="#">고객센터</a></li>
			</ul></div></section>


	<section class="footer-bottom">		
		<div class="inner container">			
			<div class="site-info"></div>
				<a href="/" class="col-sm-1" align="left"><img src="resources/images/javajo_logo3.png"></a>
				
				<!-- 
				<ul class="nav nav-pills nav-stacked" align="text-center">
					<li><span>BitCamp<br>Team JAVAJO<br>이현진,김태욱,박은지,박가영,최혜정,박주희<br>
					copyright ⓒ bitcamp_자바조 All rights reserved.<br><br></span></li></ul>
				-->
				 
				<ul class="site_info_1">
		                <li><span>Team JAVAJO</span> </li>
		                <li><span>이현진,김태욱,박은지,박가영,최혜정,박주희</span></li>
		                <li><span>copyright ⓒ bitcamp_자바조  All All rights reserved.</span></li></ul>
				
				<!--
				<ul class="nav nav-pills">
					<li><a href="#"><img src="images/facebook_size.png" alt="facobook"></a></li>
					<li><a href="#"><img src="images/twiiter_size.png" alt="twitter"></a></li>
					<li><a href="#"><img src="images/instagram_size.jpg" alt="instagram"></a></li>
					<li><a href="#"><img src="images/kakao_size.png" alt="kakaotalk"></a></li>
				</ul>
				-->
		</div></section></footer>
	
	
	
	
	
	    <!-- Bootstrap core JavaScript -->
<!--     <script src="resources/vendor/jquery/jquery.min.js"></script>
    <script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script> -->

    <!-- Plugin JavaScript -->
    <script src="resources/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Contact form JavaScript -->
    <script src="resources/js/jqBootstrapValidation.js"></script>
    <script src="resources/js/contact_me.js"></script>

    <!-- Custom scripts for this template -->
    <script src="resources/js/agency.min.js"></script>
</body>
</html>