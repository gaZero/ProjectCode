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
<title>지점소개</title>    
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
    
<style type="text/css">
	.room{
		float: left;
		position:relative;
		margin: 10px;
		height:250px;
		width:290px;
		padding: 10px;
		text-align:center;
		border: solid 1px black;
	}
	#navbarResponsive {
		position: fixed;
		right:3%;
	}
</style>
<!-- Bootstrap core JavaScript -->
<script src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>


<script type="text/javascript">
$(function(){
	//노드 생성 
	function create(c){
		$.each(c,function(a,b){

			var panel = $("<div></div>").addClass("room")
			
			var img = $("<img></img>").attr({
				src:"resources/img/"+b.fname,
				width:"160",
				height:"120"
			})
				
			$(panel).append(img);
			
			var ername= $("<p></p>").html(b.ername);
			
			span1 = $("<span><span>");
			span2 = $("<span></span>");
			span3 = $("<span></span>");
			
			var img_cal = $("<img></img>").attr({
				src:"resources/img/calen.jpg",
				width:"20",
				height:"20"
			})
			
			var img_look = $("<img></img>").attr({
				src:"resources/img/look.png",
				width:"15",
				height:"15"
			})
			
			
			var img_qna = $("<img></img>").attr({
				src:"resources/img/qna.png",
				width:"15",
				height:"15"
			})
			
			var soge = $("<a href='detailInfo.do?ername="+b.ername+"'></a>").html("지점소개")
			var book = $("<a href='main.do?loc1="+b.loc1+"&loc2="+b.loc2+"&ername="+b.ername+"'></a>").html("예약하기");
			var qna = $("<a href='bmain.do?ername="+b.ername+"'></a>").html("질문하기");
			
			$(span1).append(img_look,soge)
			$(span2).append(img_cal,book)
			$(span3).append(img_qna,qna)
			
			$(panel).append(ername,span1,span2,span3);
			
			$("#room").append(panel);
		})
	}	
	//노등생성 끝
	
	
	//첫번째 창에 전체 상품목록 보여줌
		$.ajax({url:"listRoom.do",success:function(data){
			all = eval("("+data+")");
			create(all);
				
		}});
	//끝	
		
	//첫번째 select box 클릭했을 때 노드 생성 + 바뀜
		$("#select1").change(function(){			
			$("#select2").empty().append('<option value="">--선택--</option>') ;
			$("#select3").empty().append('<option value="">--선택--</option>') ;
			$("#room").empty();
			var loc1 = $("#select1 option:selected").val();
			
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
					$("#select2").append(option)
				})
				
					create(arr);		

			 //두번째 셀렉박스 클릭시 노드생성
				$("#select2").change(function(){
					var loc2 = $("#select2 option:selected").val();
				
					detailInfo(loc1, loc2);

					//세번째 셀렉박스 클릭시 노드 생성
					$("#select3").change(function(){
						var ername = $("#select3 option:selected").val();	
						
						detailRoom(loc1,loc2,ername);
		
						
					})///sel3
					
					
				})///sel2
				
			
		}}) //ajax
	})
	
	
 	function detailInfo(loc1,loc2){
		$("#room").empty();
		$("#select3").empty();
		

		$.ajax({url:"listRoom.do",data:{loc1:loc1,loc2:loc2},success:function(data){
			arr2 = eval("("+data+")");
			
			$("#select3").empty().append('<option value="">--선택--</option>') ;
			$("#room").empty();

		 	$.each(arr2,function(a,b){
				var option = $("<option></option>").html(b.ername);
				$("#select3").append(option);

				var panel = $("<div></div>").addClass("room")
			
				var img = $("<img></img>").attr({
					src:"resources/img/"+b.fname,
					width:"150",
					height:"150"
				})
					
				$(panel).append(img);
				
				var ername= $("<p></p>").html(b.ername);
				
				span1 = $("<span><span>");
				span2 = $("<span></span>");
				span3 = $("<span></span>");
				
				var img_cal = $("<img></img>").attr({
					src:"resources/img/calen.jpg",
					width:"20",
					height:"20"
				})
				
				var img_look = $("<img></img>").attr({
					src:"resources/img/look.png",
					width:"15",
					height:"15"
				})
				
				
				var img_qna = $("<img></img>").attr({
					src:"resources/img/qna.png",
					width:"15",
					height:"15"
				})
				
	
				var soge = $("<a href='detailInfo.do?ername="+b.ername+"'></a>").html("지점소개")
				var book = $("<a href='main.do?loc1="+b.loc1+"&loc2="+b.loc2+"&ername="+b.ername+"'></a>").html("예약하기");
				var qna = $("<a href='bmain.do?ername="+b.ername+"'></a>").html("질문하기");
				
				$(span1).append(img_look,soge)
				$(span2).append(img_cal,book)
				$(span3).append(img_qna,qna)
				
				$(panel).append(ername,span1,span2,span3);
				$("#room").append(panel);
		})
			 
			 
		}})//ajax
	}//detailInfo
	
	
	 	function detailRoom(loc1,loc2,ername){
			$("#room").empty();
			$.ajax({url:"listRoom.do",data:{loc1:loc1,loc2:loc2,ername:ername},success:function(data){
				arr2 = eval("("+data+")");
				$.each(arr2,function(a,b){

					var panel = $("<div></div>").addClass("room")
					
					var img = $("<img></img>").attr({
						src:"resources/img/"+b.fname,
						width:"150",
						height:"150"
					})
						
					$(panel).append(img);
					
					var ername= $("<p></p>").html(b.ername);
					
					span1 = $("<span><span>");
					span2 = $("<span></span>");
					span3 = $("<span></span>");
					
					var img_cal = $("<img></img>").attr({
						src:"resources/img/calen.jpg",
						width:"20",
						height:"20"
					})
					
					var img_look = $("<img></img>").attr({
						src:"resources/img/look.png",
						width:"15",
						height:"15"
					})
					
					
					var img_qna = $("<img></img>").attr({
						src:"resources/img/qna.png",
						width:"15",
						height:"15"
					})
					

					var soge = $("<a href='detailInfo.do?ername="+b.ername+"'></a>").html("지점소개")
					var book = $("<a href='main.do?loc1="+b.loc1+"&loc2="+b.loc2+"&ername="+b.ername+"'></a>").html("예약하기");
					var qna = $("<a href='bmain.do?ername="+b.ername+"'></a>").html("질문하기");
					
					
					$(span1).append(img_look,soge)
					$(span2).append(img_cal,book)
					$(span3).append(img_qna,qna)
					
					$(panel).append(ername,span1,span2,span3);
					$("#room").empty();
					$("#room").append(panel);
					
				})
			
			
			}})//ajaxRoom
		}//detailRoom

		
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
})//function
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
	                <a href="insertRoom.do" class="btn btn-default btn-block m-t-md"> 회원가입</a>
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
    
    
    
   	<!-- welcome -->
      <br><br><br><br>

	<!-- end welcome -->
	
	<hr>
	<h2 class="my-4" align="center"><img src="resources/img/allthat.png"></h2>
	<hr>
		<br><br><br>
			<select id="select1" name="select1">
				<option value='' selected>-- 선택 --</option>
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
				<option value='경북'>경북</option>
				<option value='전남'>전남</option>
				<option value='전주'>전주/전북</option>
			</select>
			
			<select id="select2">
				<option value='' selected>-- 선택 --</option>
			</select>
			
			<select id="select3">
				<option value='' selected>--선택--</option>
			</select>
			
			<div id="room">
			
			</div>
			
			<hr>
		<!---------------- 페이징 --------------->
		
    <!-- Bootstrap core JavaScript -->
    <script src="resources/vendor/jquery/jquery.min.js"></script>
    <script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Plugin JavaScript -->
    <script src="resources/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Contact form JavaScript -->
    <script src="resources/js/jqBootstrapValidation.js"></script>
    <script src="resources/js/contact_me.js"></script>

    <!-- Custom scripts for this template -->
    <script src="resources/js/agency.min.js"></script>
		
		
		
		

</body>
</html>