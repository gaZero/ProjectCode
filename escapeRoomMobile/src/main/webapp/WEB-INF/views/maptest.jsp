<%@page import="org.springframework.web.servlet.ModelAndView"%>
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

#heae{
	height: 55px;
}
#ww{
	width: 40px;
	height: 40px;
}
.infow
{
	align-content: center;
}
a:link {text-decoration: none; color: #333333;}

a:visited {text-decoration: none; color: #333333;}

a:hover {text-decoration: none; color: #333333;}

a:active {text-decoration: none; color: purple;}
.overlay{
	background-color: white;
	


}

</style>
<meta charset="UTF-8">
<meta name="viewport"
   content="width=device-width,
   initial-scale=1.0,
   maximum-scale=1.0,
   minimum-scale=1.0,
   user-scalable=no">   <!-- 사용자가 조절할수 있는가? -->
<link rel="shortcut icon" href="resources/img/bit.png">      <!-- 안드로이드 사용자를 위한 바로가기 -->
<link rel="apple-touch-icon" href="resources/img/bit.png">   
<!-- 아이폰 " -->
<title>지점소개</title>    
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
<script src="http://code.jquery.com/jquery-2.2.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a152f668e711e1e46ffa7c5703b3ab41&libraries=services"></script>

			<script type="text/javascript">
		$(function () {
			
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
	        center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  

	// 지도를 생성합니다    
	var map = new daum.maps.Map(mapContainer, mapOption); 

	var mid = new daum.maps.LatLng(37.552334, 126.937708) // 지도의 중심좌표
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new daum.maps.services.Geocoder();
	var positions = [];
	var div_list = $("<div></div>")
	var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
	var imageSize = new daum.maps.Size(24, 35); 
	var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize); 
	var position =  new daum.maps.LatLng(37.552334, 126.937708);
	var marker = new daum.maps.Marker({
          map: map,
          position: position,
          image : markerImage
    });
	
	$.ajax({url:"listRoom.do",success:function(data){
		all = eval("("+data+")");
		create(all);}})//에이작 불러 오기 끝
	
		function create(c){
		
			$.each(c,function(a,b){
			
				// 주소로 좌표를 검색합니다
				geocoder.addressSearch(b.addr, function(result, status) {

				    // 정상적으로 검색이 완료됐으면 
				     if (status === daum.maps.services.Status.OK) {

				        var coords = new daum.maps.LatLng(result[0].y, result[0].x);
				        positions.push({title: b.ername, latlng: coords});
				        // 결과값으로 받은 위치를 마커로 표시합니다

						 for (var i = 0; i < positions.length; i ++) {
				        var marker = new daum.maps.Marker({
				            map: map,
				            position: coords,
				            title : b.ername,
				            clickable: true
				        });
						 }
				        // 인포윈도우로 장소에 대한 설명을 표시합니다
				       	var iwContent = "<div> "+b.ername+"</div>"
						    iwRemoveable = true;

							 var infowindow = new daum.maps.InfoWindow({content : iwContent, removable : iwRemoveable});

							daum.maps.event.addListener(marker, 'click', function() {
								
								$(div_list).empty();
							
								// 마커 위에 인포윈도우를 표시합니다
							
							     infowindow.open(map, marker);
							 
							      $(div_list).addClass("list");
									var table = $("<table width=100% align='center'></table>");
									var tr_blank1 = $("<tr height=10px></tr>");
									var tr_content = $("<tr></tr>");
									
									//이미지
									var img = $("<img></img>").attr({
										src:"resources/img/logo/"+b.fname,
										width:"80%",
										style:"margin-left: auto; margin-right: auto; margin-bottom:auto;display: block;"
										
									})
									var td_img = $("<td width=50%></td>").append(img);
									
									//내용
									var td_content=$("<td></td>");
									//타이틀
									var span_title=$("<span style='font-family:'MS Verdana';'></span>")
									var title = $("<strong></strong><br><br>").html("<font size=4; style='font-family:'MS Verdana';'>"+b.ername+"</font>");
									$(span_title).append(title);
									
									//주소
									
									var i_addr = $("<i class='fas fa-map-marker-alt'></i>").html("&nbsp;"+b.addr+"<br><br>");
									var span_addr=$("<span style='font-family:'MS Verdana';'></span>").append(i_addr);

									
									var i_phone = $("<i class='fas fa-phone'></i>").html("&nbsp;"+b.tel+"<br>");
									var span_tel=$("<span style='font-family:'MS Verdana';'></span>").append(i_phone);

									//버튼
									var tag_ername = $("<a data-ajax='false' data-role='button' class='ui-btn ui-corner-all ui-shadow ui-btn-inline' style='width:40px'>문의</a>").attr("href","mbBoard.do?ername="+b.ername);
									var btn_q = $("<div class='ui-block-a'></div>").append(tag_ername);
									var tag_a = $("<a data-ajax='false' data-role='button' class='ui-btn ui-corner-all ui-shadow ui-btn-inline' style='width:40px'>예약</a>").attr("href","themeMain.do?eid="+b.id);
									var btn_r = $("<div class='ui-block-b'></div>").append(tag_a);
									var div_btn=$("<div class='ui-grid-a'></div>").append(btn_q,btn_r);
								
									var tr_blank2 = $("<tr height=10px></tr>");
									var td_blk = $("<td width='5'></td>")
									$(tr_content).append(td_img,span_title,span_addr,span_tel,div_btn,td_blk);
									$(table).append(tr_blank1,tr_content,tr_blank2);
									
									$(div_list).append(table);
							      
							      	$("#content").append(div_list);
							});
   					
							
							
				        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
				        map.setCenter(mid);
				      
				    } 
						
	
							});//지오 코더
							
				
				})//반복문 끝
				

		}// create 끝

	}); // 스크립트 아예 끝
	
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
			<div>
				<h3 align=center> 내 주변 방탈출 카페 </h3>
			</div>
			<br>
				<hr>
				
				
				<div id="map" style="width:340px;height:300px;" align="center"></div>
				
			
		
			<hr>
			
			<div data-role="content" id="content">
			
				
			</div>
		
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
				
		<div data-role="footer"  align="center"  data-position="fixed">
			<div class="ui-grid-c center">
					<div class="ui-block-a">
						<a data-ajax="false" href="mbMain.do"><img src="resources/img/mainA/home_1.png" width="30" height="50"></a>
					</div>
		    				
		    		<div class="ui-block-b">
		    			<a data-ajax="false" href="listES2.do"><img src="resources/img/mainA/sear_1.png"  width="30" height="50"></a>
		    		</div>
		   			 	
		   			<div class="ui-block-c">
						<a data-ajax="false" href="maptest.do"><img src="resources/img/mainA/near2.png"  width="30" height="50"></a>
		   			</div>
		   				
		   			<div class="ui-block-d">
		   			<a data-ajax="false" href="myPage.do"><img src="resources/img/mainA/min_1.png"  width="30" height="50"></a>
		   			</div>
			</div>
		</div>
	</div>		
</body>

</html>