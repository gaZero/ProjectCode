<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC>
<html>
<head>
<style type="text/css">
.ui-block-a {
	margin: 50px;
	padding: 50px;
}
#btn_res {
	width: 120px;
	height: 50px;
}
#btn_modal {
	display: none;		
}
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
		var eid = $("#eid").val();
		var chk_block = 1;
		$.ajax("theme_list.do", {
			data : {id:eid},
			dataType : "json",
			success : function(data) {
				$.each(data, function(i,v){
					$("#title").html("<" + v.ername + ">");
					var div_block = $("<div></div>").append("<br>");
					var theme_img = $("<img></img>").attr({
						src:"resources/img/theme/"+v.fname,
						width:"160",
						height:"230"
					}).appendTo(div_block);
					if(chk_block == 1) {
						div_block.addClass("ui-block-a");
						chk_block = 2;
					} else if(chk_block == 2) {
						div_block.addClass("ui-block-b");
						chk_block = 1;
					}
					$("#theme_list").append(div_block);
					
					$(theme_img).click(function() {
						themeDetail(v.tcode);
						$("#btn_modal").trigger("click");
						$("#btn_res").click(function() {
							$(location).attr("href","resMain.do?tcode="+v.tcode);
						});
					});
				});	//each
			}
		});	//ajax
		
		function themeDetail(tcode) {
			$.ajax("resTheme.do",{
				data: {tcode:tcode},
				dataType : "json",
				success: function(data){
					$("#modal-tname").html(data.tname);
					$("#modal-ername").html(data.ername);
					$("#modal-img").attr({ src:"resources/img/theme/"+data.fname });
					
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

			<input type="hidden" id="eid" value="${eid }">
			<h3 align="center">예약 테마 목록</h3>
			<h3 id="title" align="center"></h3>
			<hr>
			
			<div>
				<div class="ui-grid-a" align="center" id="theme_list">
				</div>
			</div>
			
			<!-- Modal -->
			<div id="modal_theme" class="modal fade" role="dialog">
			  <div class="modal-dialog">
			    <!-- Modal content-->
			    <div class="modal-content">
			      <div class="modal-header">
			        <h2 id="modal-ername" align="center"></h2>
					<a href="#" data-role="button" class="close" data-icon="delete" data-iconpos="notext" data-dismiss="modal" aria-label="Close" id="x"></a>
			      </div>
			      <div class="modal-body">
			        <table id="tb">
			        	<tr>
			        		<td width="180px">
			        			<img src="" width="170px" height="250px" id="modal-img"/>
			        		</td>
			        		<td width="200px" id="modal-detail" style="font-size: 15px">
			        			<h3 id="modal-tname" align="center" style="font-weight: bold; font-family: 휴먼옛체;"></h3><br>
			        			&nbsp;장르 : <span id="modal-genre"></span><br> 
			        			&nbsp;난이도 : <span id="modal-tstar"></span><br>
			        			<br><br>
			        			<p align="center"><button id="btn_res">예약하기</button></p>
			        		</td>
			        	</tr>
			        	<tr><td colspan="2"><br></td></tr>
			        	<tr>
			        		<td colspan="2">
			        			<span id="modal-content">
			        		</td>
			        	</tr>
			        </table>
			      </div>
			    </div>
			  </div>
			</div>
			<button id="btn_modal" type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#modal_theme">Open Modal</button>
			<!-- Modal END -->
		
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