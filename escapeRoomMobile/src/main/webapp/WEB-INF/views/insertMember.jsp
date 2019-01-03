<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>            
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
    
    <title>회원가입 화면</title>
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<script src="http://code.jquery.com/jquery-2.1.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>

<!-- Bootstrap core JavaScript -->
<script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<style type="text/css">
    table{
        margin-left:auto; 
        margin-right:auto;
        border:3px solid black;
        width:100%;
        height:100%;
    }
        
    td{
        border:1px solid black
    } 	
	a:link {text-decoration: none; color: #333333;}
	a:visited {text-decoration: none; color: #333333;}
	a:hover {text-decoration: none; color: #333333;}
	a:active {text-decoration: none; color: purple;}
</style>
<!-- Bootstrap core JavaScript -->
<script src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script type="text/javascript">
$(function(){
	$("#put").click(function(){
	//load함수를 이용하여 core스크립트의 로딩이 완료된 후, 우편번호 서비스를 실행합니다.
	    daum.postcode.load(function(){
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
	                // 예제를 참고하여 다양한 활용법을 확인해 보세요.
	         			
	                var fullAddr = '';
	            	var extraAddr= '';
	            	
	            	 // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    fullAddr = data.roadAddress;

	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    fullAddr = data.jibunAddress;
	                }

	                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
	                if(data.userSelectedType === 'R'){
	                    //법정동명이 있을 경우 추가한다.
	                    if(data.bname !== ''){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있을 경우 추가한다.
	                    if(data.buildingName !== ''){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	                }

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('addr').value = fullAddr;

	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById('sample6_address2').focus();
	                
	                $("#addr").html(data);
	            }
	        }).open();
	    });
	})
 	
	
	  $('.onlyAlphabetAndNumber').keyup(function(event){
          if (!(event.keyCode >=37 && event.keyCode<=40)) {
              var inputVal = $(this).val();
              $(this).val($(this).val().replace(/[^_a-z0-9]/gi,'')); //_(underscore), 영어, 숫자만 가능
          }
      });
       
      $(".onlyHangul").keyup(function(event){
          if (!(event.keyCode >=37 && event.keyCode<=40)) {
              var inputVal = $(this).val();
              $(this).val(inputVal.replace(/[a-z0-9]/gi,''));
          }
      });
   
      $(".onlyNumber").keyup(function(event){
          if (!(event.keyCode >=37 && event.keyCode<=40)) {
              var inputVal = $(this).val();
              $(this).val(inputVal.replace(/[^0-9]/gi,''));
          }
      });    
	
	//login_need_start
	
	var modalContents = $(".modal-contents");
	var modal = $("#defaultModal");
	
	  $('#id').keyup(function(event){
                     
                    var divId = $('#divId');
                     
                    if($('#id').val()==""){
                        divId.removeClass("has-success");
                        divId.addClass("has-error");
                    }else{
                    	$.getJSON('',{id:uid},function(data){
            				alert(data);
            				if(data.id==uid){//아이디 중복
            					count=0;
            					$('#id_signed').html('이미 등록된 아이디').css('color', 'red');
            					$('#id').val('').focus();
            				}else{
            					count=1; //중복 확인 작업을 수행하면 count를 1로 변경
            					$("#id_signed").html('사용 가능한 아이디').css('color', 'black');
            				}
            			});
                        divId.removeClass("has-error");
                        divId.addClass("has-success");
                    }
                });
                 
                $('#pwd').keyup(function(event){
                     
                    var divPassword = $('#divPassword');
                     
                    if($('#pwd').val()==""){
                        divPassword.removeClass("has-success");
                        divPassword.addClass("has-error");
                    }else{
                        divPassword.removeClass("has-error");
                        divPassword.addClass("has-success");
                    }
                });
                 
                $('#passwordCheck').keyup(function(event){
                     
                    var passwordCheck = $('#passwordCheck').val();
                    var password = $('#pwd').val();
                    var divPasswordCheck = $('#divPasswordCheck');
                     
                    if((passwordCheck=="") || (password!=passwordCheck)){
                        divPasswordCheck.removeClass("has-success");
                        divPasswordCheck.addClass("has-error");
                    }else{
                        divPasswordCheck.removeClass("has-error");
                        divPasswordCheck.addClass("has-success");
                    }
                });
                 
                $('#name').keyup(function(event){
                     
                    var divName = $('#divName');
                     
                    if($.trim($('#name').val())==""){
                        divName.removeClass("has-success");
                        divName.addClass("has-error");
                    }else{
                        divName.removeClass("has-error");
                        divName.addClass("has-success");
                    }
                });
                 
                 
                $('#email').keyup(function(event){
                     
                    var divEmail = $('#divEmail');
                     
                    if($.trim($('#email').val())==""){
                        divEmail.removeClass("has-success");
                        divEmail.addClass("has-error");
                    }else{
                        divEmail.removeClass("has-error");
                        divEmail.addClass("has-success");
                    }
                });
                 
                $('#phoneNumber').keyup(function(event){
                     
                    var divPhoneNumber = $('#divPhoneNumber');
                     
                    if($.trim($('#phoneNumber').val())==""){
                        divPhoneNumber.removeClass("has-success");
                        divPhoneNumber.addClass("has-error");
                    }else{
                        divPhoneNumber.removeClass("has-error");
                        divPhoneNumber.addClass("has-success");
                    }
                });
                 
                 
                //------- validation 검사
                $( "form" ).submit(function( event ) {
                     
                    var divId = $('#divId');
                    var divPassword = $('#divPassword');
                    var divPasswordCheck = $('#divPasswordCheck');
                    var divName = $('#divName');
                    var divERname = $('#divERname');
                    var divEmail = $('#divEmail');
                    var divPhoneNumber = $('#divPhoneNumber');
                     
                    //아이디 검사
                    if($('#id').val()==""){
                        modalContents.text("아이디를 입력하여 주시기 바랍니다.");
                        modal.modal('show');
                         
                        divId.removeClass("has-success");
                        divId.addClass("has-error");
                        $('#id').focus();
                        return false;
                    }else{
                    	
                        divId.removeClass("has-error");
                        divId.addClass("has-success");
                    }
                    
                           	
                                   
                    //패스워드 검사
                    if($('#pwd').val()==""){
                        modalContents.text("패스워드를 입력하여 주시기 바랍니다.");
                        modal.modal('show');
                         
                        divPassword.removeClass("has-success");
                        divPassword.addClass("has-error");
                        $('#pwd').focus();
                        return false;
                    }else{
                        divPassword.removeClass("has-error");
                        divPassword.addClass("has-success");
                    }
                     
                    //패스워드 확인
                    if($('#passwordCheck').val()==""){
                        modalContents.text("패스워드 확인을 입력하여 주시기 바랍니다.");
                        modal.modal('show');
                         
                        divPasswordCheck.removeClass("has-success");
                        divPasswordCheck.addClass("has-error");
                        $('#passwordCheck').focus();
                        return false;
                    }else{
                        divPasswordCheck.removeClass("has-error");
                        divPasswordCheck.addClass("has-success");
                    }
                     
                    //패스워드 비교
                    if($('#pwd').val()!=$('#passwordCheck').val() || $('#passwordCheck').val()==""){
                        modalContents.text("패스워드가 일치하지 않습니다.");
                        modal.modal('show');
                         
                        divPasswordCheck.removeClass("has-success");
                        divPasswordCheck.addClass("has-error");
                        $('#passwordCheck').focus();
                        return false;
                    }else{
                        divPasswordCheck.removeClass("has-error");
                        divPasswordCheck.addClass("has-success");
                    }
                     
                    //이름
                    if($('#name').val()==""){
                        modalContents.text("이름을 입력하여 주시기 바랍니다.");
                        modal.modal('show');
                         
                        divName.removeClass("has-success");
                        divName.addClass("has-error");
                        $('#name').focus();
                        return false;
                    }else{
                        divName.removeClass("has-error");
                        divName.addClass("has-success");
                    }
                     
                    //지점명
                    if($('#ername').val()==""){
                        modalContents.text("별명을 입력하여 주시기 바랍니다.");
                        modal.modal('show');
                         
                        divNickname.removeClass("has-success");
                        divNickname.addClass("has-error");
                        $('#ername').focus();
                        return false;
                    }else{
                        divNickname.removeClass("has-error");
                        divNickname.addClass("has-success");
                    }
                     
                    //이메일
                    if($('#email').val()==""){
                        modalContents.text("이메일을 입력하여 주시기 바랍니다.");
                        modal.modal('show');
                         
                        divEmail.removeClass("has-success");
                        divEmail.addClass("has-error");
                        $('#email').focus();
                        return false;
                    }else{
                        divEmail.removeClass("has-error");
                        divEmail.addClass("has-success");
                    }
                     
                    //휴대폰 번호
                    if($('#tel').val()==""){
                        modalContents.text("휴대폰 번호를 입력하여 주시기 바랍니다.");
                        modal.modal('show');
                         
                        divPhoneNumber.removeClass("has-success");
                        divPhoneNumber.addClass("has-error");
                        $('#tel').focus();
                        return false;
                    }else{
                        divPhoneNumber.removeClass("has-error");
                        divPhoneNumber.addClass("has-success");
                    }
                });
	//login_need_end
	$("#logo").click(function() {
		$(location).attr("href","mbMain.do");
	});
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
			<h4 class="my-4" align="center">Bit Java 통합계정 가입</h4> 
			<h6 class="my-2" align="center">welcome!</h6>
			<hr>
			<br>
			<!-- start form -->
	        <form class="form-horizontal" role="form" method="post" action="insertMember.do"  enctype="multipart/form-data">
	            <div class="form-group" id="divId"> 
	                <label for="inputId" class="col-lg-2 control-label">아이디</label>
	                <div class="col-lg-10">
	                    <input type="text" class="form-control onlyAlphabetAndNumber" name="id" id="id" data-rule-required="true" placeholder="30자이내의 알파벳, 언더스코어(_), 숫자만 입력" maxlength="30">
	                	<span id="id_signed"></span>
	                </div>          
	            </div>    
	            
	            <div class="form-group" id="divPassword">
	                <label for="inputPassword" class="col-lg-2 control-label">패스워드</label>
	                <div class="col-lg-10">
	                    <input type="password" class="form-control" name="pwd" id="pwd" name="excludeHangul" data-rule-required="true" placeholder="영문,숫자,특수문자 중 2개 이상을 조합하여 입력" maxlength="30">
	                </div>
	            </div>
	            
	            <div class="form-group" id="divPasswordCheck">
	                <label for="inputPasswordCheck" class="col-lg-2 control-label">패스워드 확인</label>
	                <div class="col-lg-10">
	                    <input type="password" class="form-control" id="passwordCheck" data-rule-required="true" placeholder="패스워드와 동일하게 입력" maxlength="30">
	                </div>
	            </div>
	            
	            <div class="form-group" id="divName">
	                <label for="inputName" class="col-lg-2 control-label">이름</label>
	                <div class="col-lg-10">
	                    <input type="text" class="form-control onlyHangul" name="name" id="name" data-rule-required="true" placeholder="ex)홍길동" maxlength="15">
	                </div>
	            </div>
	       
	            <div class="form-group" id="divEmail">
	                <label for="inputEmail" class="col-lg-2 control-label">이메일</label>
	                <div class="col-lg-10">
	                    <input type="email" class="form-control" name="email" id="email" data-rule-required="true" placeholder="ex)aaa@bit.com" maxlength="40">
	                </div>
	            </div>
	
	            <div class="form-group" id="divTel">
	                <label for="inputTel" class="col-lg-2 control-label">전화번호</label>
	                <div class="col-lg-10">
	                    <input type="tel" class="form-control" name="tel" id="tel" data-rule-required="true" placeholder="ex)01012341234" maxlength="40">
	                </div>
	            </div>
	            
	  			<br>
	            <div class="form-group">
	                <div class="col-lg-offset-2 col-lg-10">
	                    <button type="submit" class="btn btn-default">Sign in</button>
	                </div>
	            </div>
	        </form>
	    <!-- end form -->
	    <br>
	    <br>
		</div>

		<div data-role="panel" data-position="right" id="myPanel" data-display="overlay" data-theme="b" > 
			<div id="panel_menu" align="center">		
				<hr width="100" color="grey">
	  			<p><a data-ajax="false" href="mbMain.do" style="color:white;">메    인    으    로 </a></p>		
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
		<!---------------- 페이징 --------------->
		
    <!-- Bootstrap core JavaScript -->
    <script src="resources/vendor/jquery/jquery.min.js"></script>
    <script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="resources/vendor/bootstrap/js/respond.js"></script>
	
    <!-- Plugin JavaScript -->
    <script src="resources/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Contact form JavaScript -->
    <script src="resources/js/jqBootstrapValidation.js"></script>
    <script src="resources/js/contact_me.js"></script>

</body>
</html>
