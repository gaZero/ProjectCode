<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC>
<html>
<head>
<style type="text/css">
#heae{
	height: 55px;
}
#ww{
	width: 40px;
	height: 40px;
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
	user-scalable=no">	<!-- 사용자가 조절할수 있는가? -->
<link rel="shortcut icon" href="resources/img/bit.png">		<!-- 안드로이드 사용자를 위한 바로가기 -->
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

	$(function () {

		 function urlencode(str) {

			    str = (str + '').toString();

			    return encodeURIComponent(str)

			        .replace(/!/g, '%21')

			        .replace(/'/g, '%27')

			        .replace(/\(/g, '%28')

			        .replace(/\)/g, '%29')

			        .replace(/\*/g, '%2A')

			        .replace(/%20/g, '+');

			}



			function urldecode(str) {

			    return decodeURIComponent((str + '')

			        .replace(/%(?![\da-f]{2})/gi, function() {

			            return '%25';

			        })

			        .replace(/\+/g, '%20'));

			}



			function rawurlencode(str) {

			    str = (str + '').toString();

			    return encodeURIComponent(str)

			        .replace(/!/g, '%21')

			        .replace(/'/g, '%27')

			        .replace(/\(/g, '%28')

			        .replace(/\)/g, '%29')

			        .replace(/\*/g, '%2A');

			}



			function rawurldecode(str) {

			    return decodeURIComponent((str + '')

			        .replace(/%(?![\da-f]{2})/gi, function() {

			            return '%25';

			        }));

			}
		
		
		
	 var urle = encodeURI("mbBoard.do?ername=셜록홈즈 대학로점");
	 
	 $("#arl").attr("href", urle);
	
		$("#btn_login").click(function(){
			var id = $("#id").val();
			var pwd = $("#pwd").val();
			$.ajax({url:"login.do",data:{id:id,pwd:pwd},success:function(data){
				if(data=='success'){
					swal({title: "로그인 성공", text: "Welcome!", icon: 
					"success"}).then(function(){ 
					  	location.reload("mbMain.dp");
					   }
					);
				}else{
					swal("로그인 실패", "Please check your ID or Password!", "error");
				}
			}})//btnloginajax
		})//btnlogin

/* 		$("div[data-role='page']").live( "pageshow", function( event )
		{   
		    resizeContent();
		}); */
				 
		function resizeContent() {
		    var headerHeight = parseInt( $("div[data-role='header']").css( "height" ) );
		    var footerHeight = parseInt( $("div[data-role='footer']").css( "height" ) );
		    alert("headerHeight:" + headerHeight);
		    var contentHeight = screen.availHeight - headerHeight - footerHeight - 78; // 78 : iPhone bottom bar height (retina)
		    $("div[data-role='content']").css( "height", contentHeight );
		}
		$("#logo").click(function() {
			$(location).attr("href","mbMain.do");
		});
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
	                	<label for="username-email">아이디</label>
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
	                <a href="insertMember.do" class="btn btn-default btn-block m-t-md"> 회원가입</a>
	            </div>
        	</form>
        	</div>
     		 </div>
    		</div>
    	</div>
	</div>
	<!-- end modal -->
	
	<div data-role="page">
		<!-- header -->
		<div data-role="header" style="background-color: black;" align="center">
			<img align="middle" src="resources/img/mylogo.png" width="120" height="50" id="logo">
			<div style="position:absolute;  top:0px; right:5px;"><a id="ww" href="#myPanel" class="ui-btn ui-shadow ui-corner-all ui-icon-bars ui-btn-icon-notext ui-btn-b ui-btn-inline"></a>
			</div>
	    </div>
		
		<div data-role="content">
			<h2 align="center"><img src="resources/img/etc/001.png" width="100%"></h2>
				<div id="Icon">
					<div class="ui-grid-b" align="center">
							<div class="ui-block-a">
							<a data-ajax="false" href="themeAll.do"><img src="resources/img/mainA/all1.png" width="100" height="100"></a>
							</div>
		    				
		    				<div class="ui-block-b">
		    				<a data-ajax="false" href="themeAll.do?genre=공포"><img src="resources/img/mainA/gong1.png" width="100" height="100"></a>
		    				</div>
		   				 	
		   				 	<div class="ui-block-c">
		   				 	<a data-ajax="false" href="themeAll.do?genre=판타지"><img src="resources/img/mainA/pan_1.png" width="100" height="100"></a>
		   				 	</div>
		   				
		   					<div class="ui-block-a">
		   					<a data-ajax="false" href="themeAll.do?genre=감성"><img src="resources/img/mainA/gam_1.png" width="100" height="100"></a>
		   					</div>
							<div class="ui-block-b">
							<a  data-ajax="false"href="themeAll.do?genre=스케일"><img src="resources/img/mainA/se_1.png" width="100" height="100"></a>
							</div>
							
							<div class="ui-block-c">
							<a data-ajax="false" href="themeAll.do?genre=19금"><img src="resources/img/mainA/19_1.png" width="100" height="100"></a>
							</div>		
				 		</div>
			</div>
			
			<hr>		
				<div data-role="panel" data-position="right" id="myPanel" data-display="overlay"   data-theme="b" > 
					<div id="panel_menu" align="center">		
					<hr width="100" color="grey">
  					  	<p><a data-ajax="false" href="#" style="color:white;">메    인    으    로 </a></p>		
  					 <hr width="100" color="grey">
          			  <c:if test="${empty id}">            		
  					  	<p><a href="login.do" data-toggle="modal" data-target="#myModal" style="color:white;">로     그     인</a></p>
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
				
				<br>
				<div width="100%" align="center">
					<font size="5" style="font-weight: bold; font-family: 휴먼옛체;">LNL 인기 테마</font><br>
				</div>
				<img src="resources/img/${fname }" width="100%">	
				
				<br>
				<br>
		</div>

		
		
		<div data-role="footer"  align="center"  data-position="fixed"  data-fullscreen="true">
			
				<div class="ui-grid-c center">
							<div class="ui-block-a">
							<a data-ajax="false" href="mbMain.do"><img src="resources/img/mainA/home_2.png" width="30" height="50"></a>
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

	</body>
</html>