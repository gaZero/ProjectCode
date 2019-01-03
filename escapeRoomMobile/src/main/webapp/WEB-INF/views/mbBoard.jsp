<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
 <style type="text/css">
	span{
	 padding: 4px;
	}
	.noti{
		 background-color: #E8D9FF;
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
<script type="text/javascript">

 
	$(document).on("pageshow",function () {
		
	
		var ername = decodeURI('<%=(String)request.getParameter("ername")%>');  	
		var id ="<%=(String)session.getAttribute("id")%>"
		
		
		var currentPage;
		var link = document.location.href;
		var tab = link.split("#").pop();
		
		$("#next").css('cursor', 'pointer');	
		$("#prev").css('cursor', 'pointer');	
		//시작 pagenum
		var startpage =1;
		//마지막 pagenum
		var lastpage = 1;

		//에이작 담을 거
		var arr;
		
		//한화면에 보여줄 게시물 사이즈
		var pageSIZE = 5;
		
		//전체게시물
		var totalRecord = 1;
		
		//전체페이지수를 담기 위한 변수
		var totalPage = 1;
		
		$(document).on("click","#sid", function() {

			currentPage = $(this).attr("idx");
			makeNode()

	})
	

	
	$(document).on("click","#next",function(){
		//현재페이지가 5의 배수일때
		if(currentPage%5==0)
			{
			//>를 눌렀으니 페이지 1개 증가하고
			currentPage = currentPage + 1;
			//증가된 페이지를 시작페이지로
			startpage = currentPage;
			//마지막페이지는 토탈페이지로
			lastpage = totalPage;
		}
		else{
			//5의배수 아니면 그냥 증가
			currentPage = currentPage + 1;	
			
		}
		//노드만들기
		makeNode();
		
	});
		
		
		
		
		$(document).on("click","#prev",function(){
			if(currentPage%5==1)
			{
				//현재페이지가 5의 배수일때	
			currentPage = currentPage - 1;
				//감소된 페이지는 마시막페이지로
			lastpage = currentPage;
			//시작페이지는 -4로
			startpage = lastpage-4;
			
		}
			else{
				//5의 배수 아니면 그냥 줄임
			currentPage = currentPage -1;	
			
		}
			makeNode();
		});
			
		var listGoods = function () 
		{	
			
			$.ajax({
				 url: 'listmbBoard.do',
				  
				  data: {ername : ername
				    // 보낼 데이터
				  },
					
					
					success : function (data) 
					{
						
						arr = eval("("+data+")"); 
				
						totalRecord = arr.length;
						totalPage = Math.ceil(totalRecord/pageSIZE);
						lastpage = totalPage;
						//없어도됨
						
						makeNode();
					
					}	 
			
			
			});
			
		}
		
		

		var makeNode = function () {
			//<> 버튼을 보여줌
			$("#prev").show();
			$("#next").show();
			
			//현재페이지가 1이랑 같거나 작으면
			if(currentPage<=1)
				{
					$("#prev").hide();
				}
			
			if(currentPage>=totalPage)
			{
				$("#next").hide();
			}
			
		

			$("#list").empty();
			$("#num").empty()
			var start = (currentPage-1) * pageSIZE;
			
			var arr2 = arr.slice(start,start+pageSIZE);
			
			var s
			if(s%5==0)
			{
				starta = s
				totala = totalpage
			}
			else
			{
				
				starta = startpage
				totala = lastpage+1;
			} 
		
			
			
			
			
			for (var i = starta; i < totala; i++) {
			
				
				var spx;
				if(i==currentPage)
					{
						var strong = $("<strong></strong>").html(i);
					
						spx =$("<span></span>").append(strong);
						currentPage=i;
					}else{
						spx = $("<span></span>").html(i);
					
					}
				$(spx).css('cursor', 'pointer');	
				$(spx).attr("id", "sid");
				$(spx).attr("idx",i);
			
				$("#num").append(spx);
				s++;
				}
			
			
			
			
			
			
			$.each(arr2, function(idx, g) {
				
				
				var li = $("<li></li>");
				var a = $("<a></a>");
				var span = $("<span></span>").attr("class", "ui-li-count")
				
				
				
			
				$(li).attr("idx", g.no);
				$(li).attr("id", "trs")
			$(a).attr("href", "#")
				$(li).css('cursor', 'pointer');	
			
				var str="";
				
			
				$(li).attr("cu", currentPage)
				if(g.btype==0)
				{
					str=str+" 공지] "
					$(li).attr("data-theme", "b")
			
				}
				
				
				if (g.b_level>0) {
					for (var i = 0; i < g.b_level; i++) {
						str = str+"\u00A0\u00A0"
					}
					str = str+">"
				}
				
				
				$(a).append(str+g.title);
				var bu = g.id +" | "+ g.wdate;
				
				$(span).append(bu);
				$(a).append(span);
				$(li).append(a)
				
				$("#list").append(li)
				
			$("#list").listview("refresh")
		
			});	
			
			
		}
		listGoods();
		
		if(tab.length==1)
		{
			
			currentPage = tab;
		
		}else
		{
			
			currentPage = 1;
		}

		$(document).on("click","#trs", function() {

			var url = "";
			
			
			if( id !=null ) 
				{	
				document.location.hash = "#" + currentPage;
				
				var ins = $(this).attr("idx");
				var cu = $(this).attr("cu");
					
						url = "mdetailBoard.do?no="+ins+"&cu="+cu;
					
				$(location).attr('href',url);
				
				}else
				{
					
					alert("로그인 후 열람가능합니다.");
				}
				
		})
	})






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
			<h1 align="center">
				&lt; &nbsp;
				<%=session.getAttribute("ername")%>
				&nbsp; &gt;
			</h1>
			<hr width="50%">


			<div>
				<s:if test='${not empty id}'>
					<h3 align="center"><%=session.getAttribute("id")%>님 환영합니다~
					</h3>
				</s:if>
				<div align="right">
					<a href="insertMBoard.do" data-role="button" data-icon="plus"
						data-ajax="false" data-iconpos="notext" draggable="false"></a>
				</div>
			</div>
			<ul data-role="listview" id="list" data-inset="true">
			</ul>

			<div class="container" align="center">
				<span id="prev"> &lt; </span> <span id="num"> </span> <span
					id="next"> &gt; </span>
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