<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC>
<html>
<head>
<style type="text/css">
	.starR{
	  background: url('http://miuu227.godohosting.com/images/icon/ico_review.png') no-repeat right 0;
	  background-size: auto 100%;
	  width: 30px;
	  height: 30px;
	  display: inline-block;
	  text-indent: -9999px;
	  cursor: pointer;
	}
	.starR.on{background-position:0 0;}
	
	a:link {text-decoration: none; color: #333333;}
	a:visited {text-decoration: none; color: #333333;}
	a:hover {text-decoration: none; color: #333333;}
	a:active {text-decoration: none; color: purple;}
</style>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,
   initial-scale=1.0,
   maximum-scale=1.0,
   minimum-scale=1.0,
   user-scalable=no">
<!-- 사용자가 조절할수 있는가? -->
<link rel="shortcut icon" href="resources/img/bit.png">
<!-- 안드로이드 사용자를 위한 바로가기 -->
<link rel="apple-touch-icon" href="resources/img/bit.png">
<!-- 아이폰 " -->
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
    
<title>Insert title here</title>
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<script src="http://code.jquery.com/jquery-2.1.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>

<!-- Bootstrap core JavaScript -->
<script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">
$(function() {
	var id = $("#id").val();
		$.ajax("myPage_myRes.do", {
			data : {id:id},
			success : function(data){
				$("<br>").appendTo("#div_my");
				var list = eval("("+data+")");
				if($(list).length > 0) {
					$.each(list, function(i,v){
						var myRes = $('<div class="ui-grid-a" align="center"></div>');
						var div_file = $('<div class="ui-block-a">').appendTo(myRes);
						var div_infor = $('<div class="ui-block-b">').appendTo(myRes);
						
						$("<img></img>").attr({
							src:"resources/img/theme/"+v.fname,
							width:"140",
							height:"200"
						}).appendTo(div_file);
						
						$("<p></p>").attr({style:"font-size: 20px; font-weight: bold; font-family: 휴먼옛체;"}).html(v.tname).appendTo(div_infor);
						$("<p></p>").html(v.ername).appendTo(div_infor);
						
						var time = v.bookTime;
						var hour = Math.floor(v.bookTime/60);
						var minute = Math.round((time/60 - hour) * 60);
						var viewtime = "";
						if(minute < 10) {
							viewtime = hour+":0"+minute;
						} else {
							viewtime = hour+":"+minute;
						}				
						$("<span></span>").html(v.bookDate + "&nbsp;" + viewtime).appendTo(div_infor);
						$("<br>").appendTo(div_infor);
						var payType;
						if(v.payType == 1) {
							payType = "현장결제";
						} else {
							payType = "카드결제";
						}
						$("<span></span>").html(v.totalPrice+"원 &nbsp;"+payType).appendTo(div_infor);
						$("<br><br>").appendTo(div_infor);
						
						if(v.star == 0) {
							var div_star = $("<div></div>").addClass("starRev").appendTo(div_infor);
							$("<span>2</span>").addClass("starR on").appendTo(div_star);
							$("<span>3</span>").addClass("starR").appendTo(div_star);
							$("<span>4</span>").addClass("starR").appendTo(div_star);
							$("<span>5</span>").addClass("starR").appendTo(div_star);
							$("<span>6</span>").addClass("starR").appendTo(div_star);
							var give_star = $("<button style='background-color:#3755AB;color:white;'></button>").html("별점 주기").appendTo(div_infor);
							var num_star = 1;
							
							$(div_star).children('span').click(function(){
								$(this).parent().children('span').removeClass('on');
								$(this).addClass('on').prevAll('span').addClass('on');
								if($(this).addClass('on').prevAll('span').html() != null) {
									num_star = $(this).addClass('on').prevAll('span').html();
								} else {
									num_star = 1;
								}
								return false;
							});
							$(give_star).click(function(){
								$(location).attr("href","myPage_giveStar.do?resCode="+v.resCode+"&star="+num_star);
							});
						} else {
							var div_star = $("<div></div>").addClass("starRev").appendTo(div_infor);
							for(var i=0; i<v.star; i++) {
								$("<span>파란별</span>").addClass("starR on").appendTo(div_star);
							}
							for(var i=5; i>v.star; i--) {
								$("<span>회색별</span>").addClass("starR").appendTo(div_star);
							}
							var give_star = $("<h5 style='color:#3755AB;'></h5>").html("평가 완료!").appendTo(div_infor);
						}
						
						var byear = v.bookDate.substring(0,4);
						var bmonth = v.bookDate.substring(5,7);
						var bdate = v.bookDate.substring(8,10);
						
						var d = new Date();
						var year = d.getFullYear();
						var month = d.getMonth()+1;
						var date = d.getDate();
						
						if(byear >= year && bmonth >= month && bdate >= date) {
							
						} else {
							$("#div_my").append(myRes);
						}	// if ~ else 문 end
					});	// each 문 end
				} else {
					$("#div_my").attr("align","center");
					$("<img></img>").attr({
						src:"resources/img/etc/noRes.png",
						width:"230px",
						height:"330px"
					}).appendTo("#div_my");
				}	// if ~ else 문 end
			}	
		});	// ajax end		
	$("#logo").click(function() {
		$(location).attr("href","mbMain.do");
	});
});
</script>

</head>

<body>
	<div data-role="page">
		<div data-role="header" id="heae" style="background-color: black; position: relative;" align="center">
			
			<img align="middle" src="resources/img/mylogo.png" width="120" height="50" id="logo">
			<div style="position:absolute;  top:0px; right:5px;"><a id="ww" href="#myPanel" class="ui-btn ui-shadow ui-corner-all ui-icon-bars ui-btn-icon-notext ui-btn-b ui-btn-inline"></a>
			</div>
		</div>

		<div data-role="content">
			<hr>

			<input type="hidden" id="id" value="${id }">
			<h3 align="center"><b>별점 주기</b></h3>
			<hr>
			
			<div id="div_my">
			</div>
			
			<div data-role="panel" data-position="right" id="myPanel" data-display="overlay"   data-theme="b" > 
				<div id="panel_menu" align="center">		
					<hr width="100" color="grey">
  					  	<p><a data-ajax="false" href="mbMain.do" style="color:white;">메    인    으    로 </a></p>		
  					<hr width="100" color="grey">
          			<c:if test="${empty id}">            		
  					  	<p><a href="loginPage.do" style="color:white;">로     그     인</a></p>
  					  	<hr width="100" color="grey">
  					  	<p><a href="insertMember.do" style="color:white;">회     원     가     입</a></p>
  					</c:if>
  			
  					<c:if test="${not empty id}">
	              		<p><a data-ajax="false" href="myPage.do?id=${id }" style="color:white;">내    정    보</a></p>
	              		 <hr width="100" color="grey">
	              		<p><a data-ajax="false" href="logout.do" style="color:white;">로    그    아    웃</a></p>
            		</c:if>
            		<hr width="100" color="grey">
    				<p><a data-ajax="false" href="mbStar.do" style="color:white;">별    점    주    기 </a></p>		
  					<hr width="100" color="grey">
				</div>
			</div>
		</div>
		
		<div data-role="footer"  align="center"  data-position="fixed"  data-fullscreen="true">
			<div class="ui-grid-c center">
				<div class="ui-block-a">
					<a data-ajax="false" href="mbMain.do"><img src="resources/img/mainA/home_1.png" width="30" height="50"></a>
				</div>	
		    	<div class="ui-block-b">
		    		<a data-ajax="false" href="listES2.do"><img src="resources/img/mainA/sear_1.png"  width="30" height="50"></a>
		    	</div>	 	
		   		<div class="ui-block-c">
					<a data-ajax="false" href="maptest.do"><img src="resources/img/mainA/near.png"  width="30" height="50"></a>
		   		</div>	
		   		<div class="ui-block-d">
		   			<a data-ajax="false" href="myPage.do"><img src="resources/img/mainA/min_1.png"  width="30" height="50"></a>
		   		</div>
			</div>
		</div>
	</div>
	<!-- Bootstrap core JavaScript -->
    <script src="resources/vendor/jquery/jquery.min.js"></script>
    <script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Plugin JavaScript -->
    <script src="resources/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Contact form JavaScript -->
    <script src="resources/js/jqBootstrapValidation.js"></script>
    <script src="resources/js/contact_me.js"></script>

    <!-- Custom scripts for this template -->
</body>

</html>