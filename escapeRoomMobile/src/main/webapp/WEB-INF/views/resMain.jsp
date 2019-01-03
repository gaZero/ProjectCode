<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC>
<html>
<head>
<style type="text/css">
.swiper-container {
	width: 95%;
	height: 100px;
	margin: 20px auto;
}
#btn_res {
	width: 270px;
	height: 40px;
	background: #4C4C4C;
	color: white;
	font-weight: 600; 
}
.box{margin:0 auto;padding:5px;width:40px;}
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
<!-- 아이폰 -->
<!-- <link rel="stylesheet" href="resources/css/swiper.min.css"> -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>Insert title here</title>
<link rel="stylesheet"
	href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script	src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.11.3.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script> 
<script type="text/javascript">
$(function() {
	var timechk = 0; var agreechk = 0;
	var tcode = $("#tcode").val();
	var people = $("#people").val();
	for(var i=3; i<=people; i++) {
		$("<option></option>").html(i).appendTo("#resPeople").attr("value",i);
	}
	$("#totalView").html(2*$("#price").val() + "원");
	$("#totalPrice").val(2*$("#price").val());
	$("#resPeople").change(function() {
		$("#totalView").html(($("#resPeople").val()*$("#price").val()) + "원");
		$("#totalPrice").val(($("#resPeople").val()*$("#price").val()));
	});
	
	var d = new Date();
	var year = d.getFullYear();
	var month = d.getMonth()+1;
	var hour = d.getHours();
	if(month < 10) {
		month = "0"+month;
	}
	var date = d.getDate();
	if(date < 10) {
		date = "0"+date;
	}
	var today = year + "-" + month + "-" + date;
	$("#resDate").val(today);
	resShow(tcode, today, today, hour);
	
	$("#resDate").datepicker({
	    dateFormat: "yy-mm-dd",
	    minDate: 0,
	    dayNamesShort: ["일","월","화","수","목","금","토"],
	    dayNamesMin: ["일","월","화","수","목","금","토"],
    	onSelect: function() {
    		var date = $("#resDate").val();
    		
    		resShow(tcode, date, today, hour);
    	}
    });

	$("#agree").change(function() {
	   if(agreechk == 1) {
		   $("#div_res").empty();
		   agreechk = 0;
	   } else if (agreechk == 0) {
		  	agreechk = 1;
		  	var cid = $("#cid").val();
		  	if(cid != "" && cid != null) {
		  		$("#div_res").empty();
			   	var btn_res = $('<button data-role="button" id="btn_res">예 약 하 기</button>').appendTo("#div_res");
		  	} else {
		  		alert("로그인이 필요한 서비스입니다.");
		  	}

			$(btn_res).click(function(){
				if (timechk == 0){
					alert("예약하실 시간을 선택해주세요.");
				}
			});
	   }
	});
	
	function resShow(tcode, date, today, hours) {
		$.ajax("resShow.do", {
			data : {tcode:tcode, date:date},
			dataType : "json",
			success : function(data) {
				$("#divTime").empty();
				 $.each(data, function(i,v) {
					var btn_booktime = $("<a></a>").appendTo("#divTime");
					
					var time = v.bookTime;
					var hour = Math.floor(v.bookTime/60);
					var minute = Math.round((time/60 - hour) * 60);
					var viewtime = "";
					if(minute < 10) {
						viewtime = hour+":0"+minute;
					} else {
						viewtime = hour+":"+minute;
					}
					$(btn_booktime).addClass("btn btn-default btn-lg");
					if(hours > hour && today == v.bookDate) {
						$(btn_booktime).attr({
							style : "background:#989898; color:black; margin:5px;"
						}).html(viewtime);
					}
					else if(v.resCode == "0") {
						$(btn_booktime).click(function(){
							$("#resDate").val(date + " " + viewtime);
							timechk = 1;
							$("#theme_resCode").val(v.theme_resCode);
						});
						$(btn_booktime).attr({
							style : "background:#B677FF; color:white; margin:5px;"
						}).html(viewtime);
					} else {
						$(btn_booktime).attr({
							style : "background:#989898; color:black; margin:5px;"
						}).html(viewtime);
					}
				 });
			}
		});	//ajax
	}
	$("#logo").click(function() {
		$(location).attr("href","mbMain.do");
	});
});
</script>

</head>

<body>
	<div data-role="page">
		<div data-role="header" style="background-color: black;" align="center">
			<img align="middle" src="resources/img/mylogo.png" width="120" height="50" id="logo">
		</div>

		<div data-role="content" align="center">
			<hr>
			<form action="resOk.do" method="post">
				<input type="hidden" id="cid" name="cid" value="${id }"> 
				<input type="hidden" id="tcode" value="${vo.tcode }" name="tcode"> 
				<input type="hidden" id="theme_resCode" name="theme_resCode">
				<input type="hidden" id="people" value="${vo.people }"> 
				<input type="hidden" id="price" value="${vo.price }">
				<h3 id="title" align="center">예약하기</h3>
				<hr>

				<div>
					<div class="ui-grid-a" align="center">
						<div class="ui-block-a">
							<img src="resources/img/theme/${vo.fname }" width="160"
								height="230">
						</div>
						<div class="ui-block-b">
							<h4>${vo.ername }</h4>
							<font size="5" style="font-weight: bold; font-family: 휴먼옛체;">${vo.tname }</font><br>
							<table width="100%">
								<tr>
									<td width="35%"><h4>인원 :</h4></td>
									<td><select id="resPeople" name="resPeople">
											<option value="2" selected>2</option>
									</select></td>
								</tr>
								<tr>
									<td width="35%"><h4>금액 :</h4></td>
									<td>
										<h4 id="totalView" id="totalView"></h4>
										<input type="hidden" id="totalPrice" name="totalPrice"> 
									</td>
								</tr>
								<tr>
									<td colspan="2"><input onfocus="blur()" type="text"
										id="resDate" name="resDate" class="ipt blue"
										autocomplete="off" placeholder="날짜/시간 선택"></td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				<div id="divTime"></div>
				<div data-role="fieldcontain">
					<fieldset data-role="controlgroup">
						<input type="radio" name="payType" value="1" checked="checked" id="radio1">
						<label for="radio1" style="z-index: 0;">현 장 결 제</label>
						<!-- <input type="radio" name="payType" value="2" id="radio2">
						<label for="radio2" style="z-index: 0;">카 드 결 제</label> -->
					</fieldset>
				</div>
				<div>
					<table>
						<tr>
							<td>
								<div class="box">
									<input type="checkbox" id="agree" />
								</div>
							</td>
							<td><span>&nbsp;</span></td>
							<td><h5>위 예약 내용을 모두 확인 하였으며, 당일 취소 시 No Show 금액 지불에 동의 합니다.</h5></td>
						</tr>
					</table>
					<br>
					<div id="div_res" align="center"></div>
				</div>
			</form>
		</div>
		<!-- footer -->
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
</body>

</html>