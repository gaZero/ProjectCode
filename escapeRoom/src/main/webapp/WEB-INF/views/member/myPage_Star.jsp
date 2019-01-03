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
    <link href="../resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template -->
    <link href="../resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>
<style type="text/css">
	.myRes {
		position: relative;
		/* border: solid 1px black; */
		padding: 10px;
		margin: 10px;
		width: 600px;
		height: 200px;
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
		right:3%;
	}
	#center {
		position: relative;
		width: 80%;
		top: 100px;
		left: 10%;
	}
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
</style>
<!-- Bootstrap core JavaScript -->
<script src="../resources/vendor/jquery/jquery.js"></script>
<script src="../resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
$(function() {
	var id = $("#cid").val();	//text용임. 세션id적용 필요
	$("#div").empty();
	
	$.ajax("myPage_myRes.do", {
		data : {id:id},
		success : function(data){
			var list = eval("("+data+")");
			if(list.length != 0) {
				$.each(list, function(i,v){
					var myRes = $("<div></div>").addClass("myRes");
					var tb = $("<table></table>").attr({
						border: "1px",
						width: "600px",
						height: "200px"
					});
					var tr1 = $("<tr></tr>");
					var tr2 = $("<tr></tr>");
					var tr3 = $("<tr></tr>");
					var tr4 = $("<tr></tr>");
					$("<td></td>").attr("align","center").html("장소").appendTo(tr1);
					$("<td></td>").attr("colspan","3").html("&nbsp;"+v.loc1 + "&nbsp;" + v.ername).appendTo(tr1);
					
					var td_star = $("<td></td>").attr({"rowspan":"4", "align":"center"}).appendTo(tr1);
					if(v.star == 0) {
						var div_star = $("<div></div>").addClass("starRev").appendTo(td_star);
						$("<span>2</span>").addClass("starR on").appendTo(div_star);
						$("<span>3</span>").addClass("starR").appendTo(div_star);
						$("<span>4</span>").addClass("starR").appendTo(div_star);
						$("<span>5</span>").addClass("starR").appendTo(div_star);
						$("<span>6</span>").addClass("starR").appendTo(div_star);
						$("<br>").appendTo(td_star);
						var give_star = $("<button style='background-color:#3755AB;color:white;'></button>").html("별점 주기").appendTo(td_star);
						var num_star = 0;
						
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
						var div_star = $("<div></div>").addClass("starRev").appendTo(td_star);
						for(var i=0; i<v.star; i++) {
							$("<span>파란별</span>").addClass("starR on").appendTo(div_star);
						}
						for(var i=5; i>v.star; i--) {
							$("<span>회색별</span>").addClass("starR").appendTo(div_star);
						}
						$("<br>").appendTo(td_star);
						var give_star = $("<h5 style='color:#3755AB;'></h5>").html("평가 완료!").appendTo(td_star);
					}
					
					var time = v.bookTime;
					var hour = Math.floor(v.bookTime/60);
					var minute = Math.round((time/60 - hour) * 60);
					var viewtime = "";
					if(minute < 10) {
						viewtime = hour+":0"+minute;
					} else {
						viewtime = hour+":"+minute;
					}
					$("<td></td>").attr("align","center").html("일시").appendTo(tr2);
					$("<td></td>").attr("colspan","3").html("&nbsp;"+v.bookDate + "&nbsp;&nbsp;" + viewtime).appendTo(tr2);
					
					var tname = $("<h2></h2>").html("&nbsp;"+v.tname);
					$("<td style='font-weight: bold; font-family: 휴먼옛체;'></td>").attr("colspan","4").html(tname).appendTo(tr3);
					
					var payType;
					if(v.payType == 1) {
						payType = "현장결제";
					} else {
						payType = "카드결제";
					}
					$("<td></td>").attr("align","center").html("인원").appendTo(tr4);
					$("<td></td>").html("&nbsp;"+v.resPeople+"명").appendTo(tr4);
					$("<td></td>").attr("align","center").html("결제정보").appendTo(tr4);
					$("<td></td>").html("&nbsp;"+v.totalPrice+"원&nbsp;"+payType).appendTo(tr4);
					
					var byear = v.bookDate.substring(0,4);
					var bmonth = v.bookDate.substring(5,7);
					var bdate = v.bookDate.substring(8,10);
					
					var d = new Date();
					var year = d.getFullYear();
					var month = d.getMonth()+1;
					var date = d.getDate();
					
					if(byear >= year && bmonth >= month && bdate >= date) {
						
					} else {
						$(tb).append(tr1,tr2,tr3,tr4)
						$(myRes).append(tb);
						$("#div").append(myRes);
					}	// if ~ else 문 end
				});	// each 문 end
			} else {
				$("<h2></h2>").html("탈출정보가 없습니다.").appendTo("#div");
			}
		}	
	});	// ajax end
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
        <a class="navbar-brand" href="../main.do" id="navbarLogo"><img src="../resources/img/mylogo.png" width="150" id="imglogo"></a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
          <ul class="navbar-nav ml-auto">
            <li class="nav-item">
              <a class="nav-link" href="../main.do">예약하기</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="../listES2.do">지점소개</a>
            </li>
             <li class="nav-item active">
              <a class="nav-link" href="#">내정보</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="../logout.do">로그아웃</a>
            </li>
          </ul>
        </div>
      </div>
    </nav>
    <!-- end Navigation -->
   
    <input type="text" id="cid" value="<%=session.getAttribute("id")%>">
    <div id="center">
		<h1><font color="#FFE400">나의 탈출방</font></h1>
		<br>
		<div id="div"></div>
    </div>
    
    
   	<!-- 마이페이지 - 목록  -->
	<div id="layer_fixed">
   	 <div class="list_mypage">
	    <a href="UpdateMemberInfo.do?id=${id }" class="list-group-item"><img src="../resources/img/icons/my_infor.JPG" width="25" height="25">&nbsp; 내 정보 수정 </a>
		<a href="myPage_Res.do?id=${id }" class="list-group-item"><img src="../resources/img/icons/my_res.JPG" width="25" height="25">&nbsp; 내 예약 현황 </a>
		<a href="deleteRoom.do?id=${id }" class="list-group-item"><img src="../resources/img/icons/my_delete.JPG" width="25" height="25">&nbsp; 회원 탈퇴 </a>
		<a href="myPage_Star.do?id=${id }" class="list-group-item"><img src="../resources/img/icons/my_star.JPG" width="25" height="25">&nbsp; 별점 주기 </a>
	  </div>
    </div>
    
	<!-- Bootstrap core JavaScript -->
    <script src="../resources/vendor/jquery/jquery.min.js"></script>
    <script src="../resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Plugin JavaScript -->
    <script src="../resources/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Contact form JavaScript -->
    <script src="../resources/js/jqBootstrapValidation.js"></script>
    <script src="../resources/js/contact_me.js"></script>

</body>
</html>
