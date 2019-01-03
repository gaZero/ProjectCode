<%@page import="java.net.URLEncoder"%>
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
<title>게시판</title> 
<link href="resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>
 <link href="resources/css/agency.min.css" rel="stylesheet">
 <style type="text/css">
	span{
		padding: 4px;
	}
	.noti{
		background-color: #E8D9FF;
	}
	#navbarResponsive {
		position: fixed;
		right:3%;
	}
</style>
 
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">

$(function () {	

	var ername =  "<%=(String)request.getAttribute("ername")%>"	
	var id ="<%=(String)session.getAttribute("id")%>"
	var userType  =""
	var currentPage;
	var link = document.location.href;
	var tab = link.split("#").pop();
	
	
	
	//안봐도됨 - 시작
	
	$("#next").css('cursor', 'pointer');	
	$("#prev").css('cursor', 'pointer');	
	//시작 pagenum
	var startpage =1;
	//마지막 pagenum
	var lastpage = 1;

	//에이작 담을 거
	var arr;
	
	//한화면에 보여줄 게시물 사이즈
	var pageSIZE = 10;
	
	//전체게시물
	var totalRecord = 1;
	
	//전체페이지수를 담기 위한 변수
	var totalPage = 1;
	

	
		
	
	//동적으로 생성된 span으로 만들어진 페이징 숫자를 클릭하면 현재 페이지 이동
	$(document).on("click","#sid", function() {

			currentPage = $(this).attr("idx");
			makeNode()

	})
	// 동적으로 생성된  tr 클릭시 해당하는 게시글로 이동
	


	//> 클릭시 다음 페이지로 이동
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
	
	//이전페이지를 보여주기 위한 이벤트 처리
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
	
	



//에이작 리스트 가져오기
var listGoods = function () 
{	
	
	$.ajax({
		 url: 'listBoard.do',
		  
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
		
	

		$("#tb").empty();
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
			
			
			var tr = $("<tr></tr>").attr("align","center");
			$(tr).attr("idx", g.no);
			$(tr).attr("id", "trs")
		
			$(tr).css('cursor', 'pointer');	
			var td_no = $("<th></th>").attr("scope", "row")
			$(td_no).html(g.no);
			var str="";
			var td_title = $("<td></td>").attr("align","left");
			
			$(tr).attr("cu", currentPage)
			if(g.btype==0)
			{
				str=str+" 공지] "
			
				$(tr).attr("class", "noti")	
			}
			
			
			if (g.b_level>0) {
				for (var i = 0; i < g.b_level; i++) {
					str = str+"\u00A0\u00A0"
				}
				str = str+">"
			}
			
			$(td_title).text(str+g.title);
			
			var td_id = $("<td></td>").html(g.id);
			var td_wdate =$("<td></td>").html(g.wdate);
			var td_hit =$("<td></td>").html(g.hit);
			
			$(tr).append(td_no,td_title,td_id,td_wdate,td_hit);
			$("#tb").append(tr);
	
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


	$("#btn_login").click(function(){
		var id = $("#id").val();
		var pwd = $("#pwd").val();
		$.ajax({url:"login.do",data:{id:id,pwd:pwd},success:function(data){
			if(data=='success'){
				swal({title: "로그인 성공", text: "Welcome!", icon: 
				"success"}).then(function(){ 
				  	location.reload("listES2.do");
				   }
				);
			}else{
				swal("로그인 실패", "Please check your ID or Password!", "error");
			}
		}})//btnloginajax

	})//btnlogin
	
	$(document).on("click","#trs", function() {

		var url = "";
		
		
		if("<%=session.getAttribute("id")%>" !=null ){	
			document.location.hash = "#" + currentPage;
			
			var ins = $(this).attr("idx");
			var cu = $(this).attr("cu");
			if(<%=session.getAttribute("userType")%>==0)
				{
				
					url = "admin/detailBoard.do?no="+ins+"&cu="+cu;
				}
				else if(<%=session.getAttribute("userType")%>==1)
				{
					url = "member/detailBoard.do?no="+ins+"&cu="+cu;
					
				}else
					{
					alert("로그인 후 열람가능합니다.");
					}
			$(location).attr('href',url);
			
			}else
			{
				alert("로그인 후 열람가능합니다.");
			}
	})
	
})
</script>

<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

	

	<!-- welcome -->
    <div class="container" align="center">
     <br><br><br>
     	<h5>       </h5>
      <c:if test="${not empty id}">
		${id }님 환영합니다.
	</c:if>
	</div>
	<!-- end welcome -->
		
	
		
			<div id="header" align="center">
				<a href="bmain.do?ername=${ername}" style=".title">
				
				<h2>${ername }&nbsp;&nbsp;Q&A</h2>
				
				</a>
				</div>
			<hr>
		
		
		<div class="container">
		<div align="right"> 

		
				<c:if test="${empty id} ">
						글작성 및 열람을 위해서 <a href="login.do" data-toggle="modal" data-target="#myModal">로그인</a>이 필요합니다.	
				</c:if>		
					
					<c:if test="${userType eq 0}">
						<a href="admin/insertBoard.do?id=<%=(String)session.getAttribute("id")%>" class="btn btn-default pull-right"> 글작성</a>
					</c:if>
					<c:if test="${userType eq 1}">
						<a href="member/insertBoard.do?id=<%=(String)session.getAttribute("id")%>" class="btn btn-default pull-right"> 글작성</a>
					</c:if>

				
				
		
		

		</div>
			<table  width="95%" class="table table-hover">
				<thead>
				<tr align="center">
					<th width="10%">글 번호</th>
					<th width="40%">제목</th>
					<th width="25%">작성자</th>
					<th width="*">등록일</th>
					<th width="10%">조회수</th>
				</tr>
				</thead>
				
				<tbody id="tb">
				
				
				</tbody>		
			</table>

		</div>
	<div class="container" align="center">
	<span id="prev"> &lt; </span>
	<span id="num">
		
	
	</span>
	<span id="next"> &gt; </span>
	</div>
	
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
        <a class="navbar-brand" href="main.do" id="navbarLogo"><img src="resources/img/mylogo.png" width="150" id="imglogo"></a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
          <ul class="navbar-nav ml-auto">
            <li class="nav-item">
              <a class="nav-link" href="main.do">예약하기</a>
            </li>
            <li class="nav-item active">
              <a class="nav-link" href="listES2.do">지점소개</a>
            </li>
            
            <c:if test="${empty id}">
            <li class="nav-item">
              <a class="nav-link" href="login.do" data-toggle="modal" data-target="#myModal">로그인</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="insertAll.do">회원가입</a>
            </li>
            </c:if>
            <c:if test="${not empty id}">
           		<c:if test="${userType eq 0}">
	             	<li class="nav-item">
	              		<a class="nav-link" href="admin/myPageAdmin.do?id=${id }">내정보</a>
	            	</li>
            	</c:if>
            	<c:if test="${userType eq 1}">
	             	<li class="nav-item">
	             		<a class="nav-link" href="member/myPage_Res.do">내정보</a>
	            	</li>
            	</c:if>
            <li class="nav-item">
              <a class="nav-link" href="logout.do">로그아웃</a>
            </li>
            </c:if>
          </ul>
        </div>
      </div>
    </nav>
    <!-- end Navigation -->

	<!---------------- 페이징 --------------->
		
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