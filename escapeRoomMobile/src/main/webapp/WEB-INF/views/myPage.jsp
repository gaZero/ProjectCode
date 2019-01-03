<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC>
<html>
<head>
<style type="text/css">
#btn_cancle {
	width: 100px;
	height: 35px;
	background: #4C4C4C;
	color: white;
}
.btn_infor {
	width: 150px;
	height: 40px;
	background: #CFCFCF;
	font-weight: 800;
}
.td_right {
	width: 220px;
}
td {
	font-style: bolder;
}
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
	
	$("#btn_myRes").click(function() {
		$("#div_my").empty();
		$.ajax("myPage_myRes.do", {
			data : {id:id},
			success : function(data){
				var list = eval("("+data+")");
				if($(list).length > 0) {
					$.each(list, function(i,v){
						var myRes = $('<div class="ui-grid-a" align="center"></div>');
						var div_file = $('<div class="ui-block-a">').appendTo(myRes);
						var div_infor = $('<div class="ui-block-b">').appendTo(myRes);
						
						$("<img></img>").attr({
							src:"resources/img/theme/"+v.fname,
							width:"150",
							height:"210"
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
						$("<br>").appendTo(div_infor);
						$("<span></span>").html("인원 : " + v.resPeople+"명").appendTo(div_infor);
						$("<br><br>").appendTo(div_infor);
						
						var cancle = $('<button id="btn_cancle" align="center"></button>').html("예약 취소").appendTo(div_infor);
						
						var byear = v.bookDate.substring(0,4);
						var bmonth = v.bookDate.substring(5,7);
						var bdate = v.bookDate.substring(8,10);
						
						var d = new Date();
						var year = d.getFullYear();
						var month = d.getMonth()+1;
						var date = d.getDate();
						
						if(byear >= year && bmonth >= month && bdate >= date) {
							$("#div_my").append(myRes);
						}
						
						$("<br>").appendTo("#div_my");
						
						$(cancle).click(function(){
							if(confirm("예약을 취소하시겠습니까?") == true){
								$(location).attr("href","resCancle.do?resCode="+v.resCode);
							}
						});	//cancle click end
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
	});	// btn_myRes click이벤트 end
	
	$("#btn_myInfor").click(function() {
		$("#div_my").empty();
		$.ajax("myPage_myInfor.do", {
			data : {id:id},
			dataType : "json",
			success : function(data){
				var tb = $("<table></table>").attr({width:"100%", height:"100px"}).appendTo("#div_my");
				var tr1 = $("<tr></tr>").appendTo(tb);
				var tr1_2 = $("<tr></tr>").appendTo(tb);
				var tr2 = $("<tr></tr>").appendTo(tb);
				var tr3 = $("<tr></tr>").appendTo(tb);
				var tr4 = $("<tr></tr>").appendTo(tb);
				var tr5 = $("<tr></tr>").appendTo(tb);
				$("<td></td>").html("이 름 ").attr({align:"center", width:"30%"}).appendTo(tr1);
				$("<td></td>").html("암 호 ").attr({align:"center", width:"30%"}).appendTo(tr1_2);
				$("<td></td>").html("전화번호 ").attr("align","center").appendTo(tr2);
				$("<td></td>").html("이메일 ").attr("align","center").appendTo(tr3);
				$("<td></td>").html("기존 암호<br> 확인").attr("align","center").appendTo(tr5);
				var td1 = $("<td></td>").appendTo(tr1);
				var td1_2 = $("<td></td>").appendTo(tr1_2);					
				var td2 = $("<td></td>").appendTo(tr2);
				var td3 = $("<td></td>").appendTo(tr3);
				var td4 = $("<td></td>").attr("height","10px").appendTo(tr4);
				var td5 = $("<td></td>").appendTo(tr5);
				
				var name = $("<input type='text' value="+data.name+">").addClass("td_right").appendTo(td1);
				var new_pwd = $("<input type='password'>").addClass("td_right").appendTo(td1_2);
				var tel = $("<input type='text' value="+data.tel+">").addClass("td_right").appendTo(td2);
				var email = $("<input type='text' value="+data.email+">").addClass("td_right").appendTo(td3);
				var old_pwd = $("<input type='password'>").addClass("td_right").appendTo(td5);
				
				$("<br>").appendTo("#div_my");
				
				var myInfor = $('<div class="ui-grid-a" align="center"></div>').appendTo("#div_my");
				var div_left = $('<div class="ui-block-a">').appendTo(myInfor);
				var div_right = $('<div class="ui-block-b">').appendTo(myInfor);
				var btn_update = $("<button></button>").html("회원 정보 수정").attr("style","font-weight: 600px;").addClass("btn_infor").appendTo(div_left);
				var btn_delete = $("<button></button>").html("회원 탈퇴").addClass("btn_infor").appendTo(div_right);
				
				$(btn_update).click(function() {
					if(old_pwd.val() == data.pwd) {
						if(new_pwd.val() != null && new_pwd.val() != "") {
							$(location).attr("href","updateMemberInfo.do?id="+data.id+"&name="+name.val()+"&tel="+tel.val()+"&email="+email.val()+"&pwd="+new_pwd.val());
						} else {
							$(location).attr("href","updateMemberInfo.do?id="+data.id+"&name="+name.val()+"&tel="+tel.val()+"&email="+email.val()+"&pwd="+old_pwd.val());
						}
					} else {
						alert("기존 암호가 일치하지 않습니다.");
					}
				});
				$(btn_delete).click(function() {
					if(old_pwd.val() == data.pwd) {
						$(location).attr("href","deleteMemberInfo.do?id="+data.id);
					} else {
						alert("기존 암호가 일치하지 않습니다.");
					}
				});
			}
		});	// ajax end
	});	// btn_myInfor click이벤트 end
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
			<h3 align="center"><b>My Page</b></h3>
			<h4 align="center">${id }님 환영합니다 ~</h4>
			<hr>
			
			<div>
				<div class="ui-grid-a" align="center">
					<div class="ui-block-a">
						<a href="#" data-role="button" id="btn_myInfor">내 정보</a>
					</div>
					<div class="ui-block-b">
						<a href="#" data-role="button" id="btn_myRes">예약 정보</a>
					</div>
				</div>
			</div>
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