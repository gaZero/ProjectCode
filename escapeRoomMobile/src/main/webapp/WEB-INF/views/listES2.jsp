<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
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
<style>
	.list{
		border: solid 4px #E6E6E6;
		width:100%;
		margin:auto;
		position:relative;
	}
	a:link {text-decoration: none; color: #333333;}
	a:visited {text-decoration: none; color: #333333;}
	a:hover {text-decoration: none; color: #333333;}
	a:active {text-decoration: none; color: purple;}
</style>

<script type="text/javascript">
	$(function(){
		var option;
		var temp1;
		var temp2;
		function create(c){
			$.each(c,function(a,b){
	
			var div_list = $("<div></div>").addClass("list");
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
			
			})
		}
		
		
		$.ajax({url:"listRoom.do",success:function(data){
			all = eval("("+data+")");
			create(all);
				
		}});
		
		
		$("select[name=CID1]").change(function(){		
			temp1 = $("select[name=CID2]");
			var loc1 = $(this).val();
			temp1.empty().append('<option value="">지역 선택</option>');
			$("#content").empty();
			
			
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
					temp1.append(option);
				})
				
					create(arr);		

 	
			}})

		})
			$("select[name=CID2]").change(function(){
					temp2 = $("select[name=CID3]");
					var loc1 = $("#CID1").val();
			        var loc2 = $(this).val();
			    
					temp2.empty().append('<option value="">지점 선택</option>') ;
					detailInfo(loc1, loc2);
					
				
					//세번째 셀렉박스 클릭시 노드 생성
				$("select[name=CID3]").change(function(){
					var loc1 = $("#CID1").val();
					var loc2 = $("#CID2").val();
					var ername = $(this).val();	
					
				detailRoom(loc1,loc2,ername);
				
				
				})///sel2	 
						
			})///sel3	
		
				
		
		

	 	function detailInfo(loc1,loc2){
			$("#content").empty();

			$.ajax({url:"listRoom.do",data:{loc1:loc1,loc2:loc2},success:function(data){
				arr2 = eval("("+data+")");

				$("#content").empty();

			 	$.each(arr2,function(a,b){
					var option = $("<option></option>").html(b.ername);
					temp2.append(option);

					
					var div_list = $("<div></div>").addClass("list");
					var table = $("<table width=100% align='center'></table>");
					var tr_blank1 = $("<tr height=15px></tr>");
					var tr_content = $("<tr></tr>");
					
					//이미지
					var img = $("<img></img>").attr({
						src:"resources/img/logo/"+b.fname,
						width:"80%", 
						style:"margin-left: auto; margin-right: auto; display: block;"
					})
					var td_img = $("<td width=50%></td>").append(img);
					
					//내용
					var td_content=$("<td></td>");
					//타이틀
					var span_title=$("<span style='font-family:'MS Verdana';'></span>")
					var title = $("<strong></strong><br><br>").html("<font size=5; style='font-family:'MS Verdana';'>"+b.ername+"</font>");
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
				
					var tr_blank2 = $("<tr height=15px></tr>");
			
					$(tr_content).append(td_img,span_title,span_addr,span_tel,div_btn,tr_blank2);
					$(table).append(tr_blank1,tr_content,tr_blank2);
					
					$(div_list).append(table);
					$("#content").append(div_list);
			})
				 
				 
			}})//ajax
		}//detailInfo
		
		
		 	function detailRoom(loc1,loc2,ername){
				$("#content").empty();
				$.ajax({url:"listRoom.do",data:{loc1:loc1,loc2:loc2,ername:ername},success:function(data){
					arr2 = eval("("+data+")");
					$.each(arr2,function(a,b){
						
						var div_list = $("<div></div>").addClass("list");
						var table = $("<table width=100% align='center'></table>");
						var tr_blank1 = $("<tr height=15px></tr>");
						var tr_content = $("<tr></tr>");
						
						//이미지
						var img = $("<img></img>").attr({
							src:"resources/img/logo/"+b.fname,
							width:"80%", 
							style:"margin-left: auto; margin-right: auto; display: block;"
						})
						var td_img = $("<td width=50%></td>").append(img);
						
						//내용
						var td_content=$("<td></td>");
						//타이틀
						var span_title=$("<span style='font-family:'MS Verdana';'></span>")
						var title = $("<strong></strong><br><br>").html("<font size=5; style='font-family:'MS Verdana';'>"+b.ername+"</font>");
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
					
						var tr_blank2 = $("<tr height=15px></tr>");
				
						$(tr_content).append(td_img,span_title,span_addr,span_tel,div_btn,tr_blank2);

						$(table).append(tr_blank1,tr_content,tr_blank2);
						
						$(div_list).append(table);
		
						$("#content").empty();
						$("#content").append(div_list);
						
					})
				
				
				}})//ajaxRoom
			}//detailRoom
		 
		$("#logo").click(function() {
			$(location).attr("href","mbMain.do");
		});
	})
	
</script>

<body>
	<div data-role="page">
	
		<!-- header -->
		<div data-role="header" style="background-color: black;" align="center">
			<img align="middle" src="resources/img/mylogo.png" width="120" height="50" id="logo">
			<div style="position:absolute;  top:0px; right:5px;"><a id="ww" href="#myPanel" class="ui-btn ui-shadow ui-corner-all ui-icon-bars ui-btn-icon-notext ui-btn-b ui-btn-inline"></a>
			</div>
	    </div>
		
		<!-- selectbox -->
		<hr align="center" style="border: dashed 5px #E6E6E6; width:90%;">
		<div class="ui-grid-a" style="width:90%;margin-left: auto; margin-right: auto; display: block;">
			<div class="ui-block-a"><select id="CID1" name="CID1">
				<option value=''>시·도 선택</option>
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
				<option value='전북'>경북</option>
				<option value='전남'>전남</option>
				<option value='전주'>전주/전북</option>
				</select></div>
				
			<div class="ui-block-b"><select id="CID2" name="CID2">
				<option value=''>지역 선택</option>
			</select></div>
				
			<div><select id="CID3" name="CID3" >
				<option value=''>지점 선택</option>
			</select></div>
		</div>
		<hr align="center" style="border: dashed 5px #E6E6E6; width:100%;">
		
		
		<!-- 지점자리 -->
		<div data-role="content" id="content">
		
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
		</div>

		
		<!-- footer -->
		<div data-role="footer"  align="center"  data-position="fixed"  data-fullscreen="true">
				<div class="ui-grid-c center">
					<div class="ui-block-a">
						<a data-ajax="false" href="mbMain.do"><img src="resources/img/mainA/home_1.png" width="30" height="50"></a>
					</div>
		    				
		    		<div class="ui-block-b">
		    			<a data-ajax="false" href="listES2.do"><img src="resources/img/mainA/sear_2.png"  width="30" height="50"></a>
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