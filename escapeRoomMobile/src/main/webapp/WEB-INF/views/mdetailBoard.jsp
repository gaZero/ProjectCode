<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="s" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC>
<html>
<head>
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
<link rel="stylesheet" href="resources/css/swiper.min.css">
 <style type="text/css">

	span{
	 padding: 4px;
	}
	.noti{
		 background-color: #E8D9FF;
	}
	.conta{
		padding: 10px;
	}
	.log{
		margin: 0px;
	}
	#text1{
		font-weight : bold; 
		align-self: flex-end;
	}
	a:link {text-decoration: none; color: #333333;}
	a:visited {text-decoration: none; color: #333333;}
	a:hover {text-decoration: none; color: #333333;}
	a:active {text-decoration: none; color: purple;}
</style>
<title>Insert title here</title>
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<script src="resources/js/swiper.min.js"></script>
<script type="text/javascript">



</script>

</head>

<body>
	<div data-role="page">
		<!-- header -->
		<div data-role="header" style="background-color: black;" align="center">
			<img align="middle" src="resources/img/mylogo.png" width="120" height="50" id="logo">
			<div style="position:absolute;  top:0px; right:5px;"><a id="ww" href="#myPanel" class="ui-btn ui-shadow ui-corner-all ui-icon-bars ui-btn-icon-notext ui-btn-b ui-btn-inline"></a>
			</div>
	    </div>
	
		<div data-role="content">
			<hr>
			<h1 align="center"> &lt;  &nbsp; <%=session.getAttribute("ername")%> &nbsp; &gt; </h1>
			<hr width="50%">
				
			
					<div class="log" align="center">
						<s:if test='${not empty id}'>
								<font size="3px"><%=session.getAttribute("id")%>님 환영합니다~ </font>
							</s:if>
					
					</div>
							
					<div class="conta">

					<font size="3px" style="font-weight: bold;"> &nbsp; ${b.title }</font> <br>
					<div align="right"> <font id="text1" style="text-align: right;"> ${b.id} &nbsp; | ${b.wdate}</font></div>
					<hr>
					<div>
				
						<s:if test="${not empty b.fname}">
							<img src="../resources/upload/${b.fname }"/>
						</s:if>
				
					</div>
					
					<div style="width: 400 px; height: 200px;">
					${b.content }
					</div>
					<hr>			
			</div>
				<div align="right">
				<s:if test="${b.id eq rid}">
				<a href="mbUpdateBoard.do?no=${b.no }" class="ui-btn ui-btn-inline ui-corner-all" data-ajax="false" >수정</a>
				<a href="#myPopupDialog" data-rel="popup" data-position-to="window"  data-transition="fade" class="ui-btn ui-corner-all ui-shadow ui-btn-inline">삭제</a>
				</s:if>
			
					<div data-role="popup" id="myPopupDialog">
      		
    				 

     					 <div data-role="main" class="ui-content">
       					 <h2>정말 삭제하시겠습니까?</h2>
       						<div align="center">
        					<a href="mbrealdeleteBoard.do?no=${b.no}" data-ajax="false" class="ui-btn ui-corner-all ui-shadow ui-btn-inline">예</a>
        					<a href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-inline" data-rel="back">아니오</a>
     									 </div>
							</div>
						    
    					</div>	
				</div>
				
				<div data-role="panel" data-position="right" id="myPanel" data-display="overlay"   data-theme="b" > 
					<div id="panel_menu" align="center">		
					<hr width="100" color="grey">
  					  	<p><a data-ajax="false" href="#" style="color:white;">메    인    으    로 </a></p>		
  					 <hr width="100" color="grey">
          			  <c:if test="${empty id}">            		
  					  	<p><a href="loginPage.do" data-toggle="modal" data-target="#myModal" style="color:white;">로     그     인</a></p>
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
		
		<div data-role="footer"  align="center"  data-position="fixed">
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