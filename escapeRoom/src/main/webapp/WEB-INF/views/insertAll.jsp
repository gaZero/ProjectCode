<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>            
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
    <title>회원가입 화면</title>
 <!-- Bootstrap core CSS -->
    <link href="resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="resources/image/icon/HalfLife.ico" rel="shortcuticon">
	
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
	#in_room, #in_customer {
		position: relative;
		width: 60%;
		top: 150px;
		left: 25%;
	}
	#title {
		position: relative;
		top: 100px;
		width: 100%;
	}
	.in_btn.on {
		background-color:#FFDD73;
		color:white;
		width: 180px;
		height: 80px;
	}
	.in_btn{
		background-color:#8C8C8C;
		color:white;
		width: 180px;
		height: 80px;
	}
	#in_room {
		display: none;
	}
   </style>
 	
<!-- Bootstrap core JavaScript -->
<script src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script type="text/javascript">
$(function() {

	$("#btn_room").click(function() {
		$("#btn_room").addClass("on");
		$("#btn_customer").removeClass("on");
		$("#in_customer").hide();
		$("#in_room").show();
	});

	$("#btn_customer").click(function() {
		$("#btn_room").removeClass("on");
		$("#btn_customer").addClass("on");
		$("#in_customer").show();
		$("#in_room").hide();
	});

	$("#put").click(function() {
		//load함수를 이용하여 core스크립트의 로딩이 완료된 후, 우편번호 서비스를 실행합니다.
		daum.postcode.load(function() {
			new daum.Postcode({
				oncomplete : function(data) {
					// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
					// 예제를 참고하여 다양한 활용법을 확인해 보세요.

					var fullAddr = '';
					var extraAddr = '';

					// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
					if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
						fullAddr = data.roadAddress;

					} else { // 사용자가 지번 주소를 선택했을 경우(J)
						fullAddr = data.jibunAddress;
					}

					//사용자가 선택한 주소가 도로명 타입일때 조합한다.
					if (data.userSelectedType === 'R') {
						//법정동명이 있을 경우 추가한다.
					if (data.bname !== '') {
						extraAddr += data.bname;
					}
					// 건물명이 있을 경우 추가한다.
					if (data.buildingName !== '') {
						extraAddr += (extraAddr !== '' ? ', '+ data.buildingName: data.buildingName);
					}
					// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
					fullAddr += (extraAddr !== '' ? ' ('+ extraAddr + ')': '');}

					// 우편번호와 주소 정보를 해당 필드에 넣는다.
					document.getElementById('addr').value = fullAddr;
					// 커서를 상세주소 필드로 이동한다.
					document.getElementById('sample6_address2').focus();

					$("#addr").html(data);
				}
			}).open();
		});
	});

	$("#btn_login").click(
		function() {
			var id = $("#idc").val();
			var pwd = $("#pwdc").val();
			$.ajax({
				url : "login.do",
				data : {
					id : id,
					pwd : pwd
				},
				success : function(data) {
					if (data == 'success') {
						swal({
							title : "로그인 성공",
							text : "Welcome!",
							icon : "success"
						}).then(function() {
							location.reload("listES2.do");
						});
					} else {
						swal("로그인 실패", "Please check your ID or Password!", "error");
					}
				}
			})//btnloginajax
		})//btnlogin
		
		$('.onlyAlphabetAndNumber').keyup(function(event) {
			if (!(event.keyCode >= 37 && event.keyCode <= 40)) {
				var inputVal = $(this).val();
				$(this).val($(this).val().replace(/[^_a-z0-9]/gi, '')); //_(underscore), 영어, 숫자만 가능
			}
		});

		$(".onlyHangul").keyup(function(event) {
			if (!(event.keyCode >= 37 && event.keyCode <= 40)) {
				var inputVal = $(this).val();
				$(this).val(inputVal.replace(/[a-z0-9]/gi, ''));
			}
		});

		$(".onlyNumber").keyup(function(event) {
			if (!(event.keyCode >= 37 && event.keyCode <= 40)) {
				var inputVal = $(this).val();
				$(this).val(inputVal.replace(/[^0-9]/gi, ''));
			}
		});
		//login_need_start

		var modalContents = $(".modal-contents");
		var modal = $("#defaultModal");

		$('#id').keyup(function(event) {

			var divId = $('#divId');

			if ($('#id').val() == "") {
				divId.removeClass("has-success");
				divId.addClass("has-error");
			} else {
				divId.removeClass("has-error");
				divId.addClass("has-success");
			}
		});

		$('#pwd').keyup(function(event) {

			var divPassword = $('#divPassword');

			if ($('#pwd').val() == "") {
				divPassword.removeClass("has-success");
				divPassword.addClass("has-error");
			} else {
				divPassword.removeClass("has-error");
				divPassword.addClass("has-success");
			}
		});

		$('#passwordCheck').keyup(function(event) {

			var passwordCheck = $('#passwordCheck').val();
			var password = $('#pwd').val();
			var divPasswordCheck = $('#divPasswordCheck');

			if ((passwordCheck == "") || (password != passwordCheck)) {
				divPasswordCheck.removeClass("has-success");
				divPasswordCheck.addClass("has-error");
			} else {
				divPasswordCheck.removeClass("has-error");
				divPasswordCheck.addClass("has-success");
			}
		});

		$('#name').keyup(function(event) {

			var divName = $('#divName');

			if ($.trim($('#name').val()) == "") {
				divName.removeClass("has-success");
				divName.addClass("has-error");
			} else {
				divName.removeClass("has-error");
				divName.addClass("has-success");
			}
		});

		$('#email').keyup(function(event) {

			var divEmail = $('#divEmail');

			if ($.trim($('#email').val()) == "") {
				divEmail.removeClass("has-success");
				divEmail.addClass("has-error");
			} else {
				divEmail.removeClass("has-error");
				divEmail.addClass("has-success");
			}
		});

		$('#phoneNumber').keyup(function(event) {

			var divPhoneNumber = $('#divPhoneNumber');

			if ($.trim($('#phoneNumber').val()) == "") {
				divPhoneNumber.removeClass("has-success");
				divPhoneNumber.addClass("has-error");
			} else {
				divPhoneNumber.removeClass("has-error");
				divPhoneNumber.addClass("has-success");
			}
		});

		//------- validation 검사
		$("form").submit(
			function(event) {

				var divId = $('#divId');
				var divPassword = $('#divPassword');
				var divPasswordCheck = $('#divPasswordCheck');
				var divName = $('#divName');
				var divERname = $('#divERname');
				var divEmail = $('#divEmail');
				var divPhoneNumber = $('#divPhoneNumber');

				//아이디 검사
				if ($('#id').val() == "") {
					modalContents.text("아이디를 입력하여 주시기 바랍니다.");
					modal.modal('show');

					divId.removeClass("has-success");
					divId.addClass("has-error");
					$('#id').focus();
					return false;
				} else {
					divId.removeClass("has-error");
					divId.addClass("has-success");
				}

				//패스워드 검사
				if ($('#pwd').val() == "") {
					modalContents.text("패스워드를 입력하여 주시기 바랍니다.");
					modal.modal('show');

					divPassword.removeClass("has-success");
					divPassword.addClass("has-error");
					$('#pwd').focus();
					return false;
				} else {
					divPassword.removeClass("has-error");
					divPassword.addClass("has-success");
				}

				//패스워드 확인
				if ($('#passwordCheck').val() == "") {
					modalContents.text("패스워드 확인을 입력하여 주시기 바랍니다.");
					modal.modal('show');

					divPasswordCheck.removeClass("has-success");
					divPasswordCheck.addClass("has-error");
					$('#passwordCheck').focus();
					return false;
				} else {
					divPasswordCheck.removeClass("has-error");
					divPasswordCheck.addClass("has-success");
				}

	//패스워드 비교
				if ($('#pwd').val() != $('#passwordCheck').val() || $('#passwordCheck').val() == "") {
					modalContents.text("패스워드가 일치하지 않습니다.");
					modal.modal('show');

					divPasswordCheck.removeClass("has-success");
					divPasswordCheck.addClass("has-error");
					$('#passwordCheck').focus();
					return false;
				} else {
					divPasswordCheck.removeClass("has-error");
					divPasswordCheck.addClass("has-success");
				}

				//이름
				if ($('#name').val() == "") {
					modalContents.text("이름을 입력하여 주시기 바랍니다.");
					modal.modal('show');

					divName.removeClass("has-success");
					divName.addClass("has-error");
					$('#name').focus();
					return false;
				} else {
					divName.removeClass("has-error");
					divName.addClass("has-success");
				}

				//지점명
				if ($('#ername').val() == "") {
					modalContents.text("별명을 입력하여 주시기 바랍니다.");
					modal.modal('show');

					divNickname.removeClass("has-success");
					divNickname.addClass("has-error");
					$('#ername').focus();
					return false;
				} else {
					divNickname.removeClass("has-error");
					divNickname.addClass("has-success");
				}

					//이메일
				if ($('#email').val() == "") {
					modalContents.text("이메일을 입력하여 주시기 바랍니다.");
					modal.modal('show');

					divEmail.removeClass("has-success");
					divEmail.addClass("has-error");
					$('#email').focus();
					return false;
				} else {
					divEmail.removeClass("has-error");
					divEmail.addClass("has-success");
				}

				//휴대폰 번호
				if ($('#tel').val() == "") {
					modalContents.text("휴대폰 번호를 입력하여 주시기 바랍니다.");
					modal.modal('show');

					divPhoneNumber.removeClass("has-success");
					divPhoneNumber.addClass("has-error");
					$('#tel').focus();
					return false;
				} else {
					divPhoneNumber.removeClass("has-error");
					divPhoneNumber.addClass("has-success");
				}
			});
		//login_need_end
	});
</script>
</head>
<body>

	<!-- 모달창 -->
	<div class="modal fade" id="defaultModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">알림</h4>
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
				</div>
				<div class="modal-body">
					<p class="modal-contents"></p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
	<!--// 모달창 -->

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
	                	<input name="id" value='' id="idc" placeholder="E-mail or Username" type="text" class="form-control" />
	            	</div>
	            	<div class="form-group">
	                	<label for="password">비밀번호</label>
	                <input name="pwd" id="pwdc" placeholder="Password" type="password" class="form-control" />
	            </div>
	            <div class="form-group">
	                <input type="button" id="btn_login" class="btn btn-default btn-login-submit btn-block m-t-md" value="로그인">
	            </div>
	            <hr/>
	            <div class="form-group">
	                <a href="insertAll.do" class="btn btn-default btn-block m-t-md"> 회원가입</a>
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
    
    <!-- start form -->
    <div id="title" align="center">
    	<h2><font color="#FFE400">회원 가입</font></h2>
    	<br>
    	<table>
    		<tr>
    			<td>
    				<button id="btn_customer" class="in_btn on" align="center"><h4>일반회원</h4></button>
    			</td>
    			<td width="70">	
    			</td>
    			<td>
    				<button id="btn_room" class="in_btn" align="center"><h4>점주회원</h4></button>
    			</td>
    		</tr>
    	</table>
    </div>
    
     <div id="in_customer">
        <form class="form-horizontal" role="form" method="post" action="MemberJoin.do">
        
            <div class="form-group" id="divId">
                <label for="inputId" class="col-lg-2 control-label">아이디</label>
                <div class="col-lg-10">
                    <input type="text" class="form-control onlyAlphabetAndNumber" name="id" id="cid" data-rule-required="true" placeholder="30자이내의 알파벳, 언더스코어(_), 숫자만 입력 가능합니다." maxlength="30">
                </div>
            </div>
            <div class="form-group" id="divPassword">
                <label for="inputPassword" class="col-lg-2 control-label">패스워드</label>
                <div class="col-lg-10">
                    <input type="password" class="form-control" name="pwd" id="cpwd" name="excludeHangul" data-rule-required="true" placeholder="패스워드" maxlength="30">
                </div>
            </div>
            <div class="form-group" id="divPasswordCheck">
                <label for="inputPasswordCheck" class="col-lg-2 control-label">패스워드 확인</label>
                <div class="col-lg-10">
                    <input type="password" class="form-control" id="cpasswordCheck" data-rule-required="true" placeholder="패스워드 확인" maxlength="30">
                </div>
            </div>
            <div class="form-group" id="divName">
                <label for="inputName" class="col-lg-2 control-label">이름</label>
                <div class="col-lg-10">
                    <input type="text" class="form-control onlyHangul" name="name" id="cname" data-rule-required="true" placeholder="한글만 입력 가능합니다." maxlength="15">
                </div>
            </div>
             
            <div class="form-group" id="divEmail">
                <label for="inputEmail" class="col-lg-2 control-label">이메일</label>
                <div class="col-lg-10">
                    <input type="email" class="form-control" name="email" id="cemail" data-rule-required="true" placeholder="이메일" maxlength="40">
                </div>
            </div>
            <div class="form-group" id="divPhoneNumber">
                <label for="inputPhoneNumber" class="col-lg-2 control-label">전화번호</label>
                <div class="col-lg-10">
                    <input type="text" class="form-control onlyNumber" name="tel" id="ctel" data-rule-required="true" placeholder="-를 제외하고 숫자만 입력하세요." maxlength="11">
                </div>
            </div>
            <div class="form-group">
                <div class="col-lg-offset-2 col-lg-10">
                    <button type="submit" class="btn btn-default">가입신청</button>
                </div>
            </div>
		</form>
    </div>
    
 	<div id="in_room">
        <form class="form-horizontal" role="form" method="post" action="insertRoom.do"  enctype="multipart/form-data">
        
            <div class="form-group" id="divId">
                <label for="inputId" class="col-lg-2 control-label">아이디</label>
                <div class="col-lg-10">
                    <input type="text" class="form-control onlyAlphabetAndNumber" name="id" id="id" data-rule-required="true" placeholder="30자이내의 알파벳, 언더스코어(_), 숫자만 입력 가능합니다." maxlength="30">
                </div>
            </div>
            <div class="form-group" id="divPassword">
                <label for="inputPassword" class="col-lg-2 control-label">패스워드</label>
                <div class="col-lg-10">
                    <input type="password" class="form-control" name="pwd" id="pwd" name="excludeHangul" data-rule-required="true" placeholder="패스워드" maxlength="30">
                </div>
            </div>
            <div class="form-group" id="divPasswordCheck">
                <label for="inputPasswordCheck" class="col-lg-2 control-label">패스워드 확인</label>
                <div class="col-lg-10">
                    <input type="password" class="form-control" id="passwordCheck" data-rule-required="true" placeholder="패스워드 확인" maxlength="30">
                </div>
            </div>
            <div class="form-group" id="divName">
                <label for="inputName" class="col-lg-2 control-label">이름</label>
                <div class="col-lg-10">
                    <input type="text" class="form-control onlyHangul" name="name" id="name" data-rule-required="true" placeholder="한글만 입력 가능합니다." maxlength="15">
                </div>
            </div>
             
            <div class="form-group" id="divERname">
                <label for="inputERname" class="col-lg-2 control-label">지점명</label>
                <div class="col-lg-10">
                    <input type="text" class="form-control" name="ername" id="ername" placeholder="지점명" maxlength="50">
                </div>
            </div>
            
               <div class="form-group" id="divLoc1">
                <label for="inputLoc1" class="col-lg-2 control-label">시/도</label>
                <div class="col-lg-10">
                   <input type="text" class="form-control"  id="loc1" name="loc1" data-rule-required="true" placeholder="서울,경기,충청 등의 형식으로 입력하세요." maxlength="11">
                </div>
              	</div> 
              	
              <div class="form-group" id="divLoc2">          
                <label for="inputLoc2" class="col-lg-2 control-label">구</label>
                <div class="col-lg-10">
                   <input type="text" class="form-control"  id="loc2" name="loc2" data-rule-required="true" placeholder="강남,홍대,수원 등의 형식으로 입력하세요." maxlength="11">
                </div>
            </div>
             
            <div class="form-group" id="divEmail">
                <label for="inputEmail" class="col-lg-2 control-label">이메일</label>
                <div class="col-lg-10">
                    <input type="email" class="form-control" name="email" id="email" data-rule-required="true" placeholder="이메일" maxlength="40">
                </div>
            </div>
            <div class="form-group" id="divPhoneNumber">
                <label for="inputPhoneNumber" class="col-lg-2 control-label">지점 전화번호</label>
                <div class="col-lg-10">
                    <input type="text" class="form-control onlyNumber" name="tel" id="tel" data-rule-required="true" placeholder="-를 제외하고 숫자만 입력하세요." maxlength="11">
                </div>
            </div>
            <div class="form-group" id="divRoomNumber">
                <label for="inputRoomNumber" class="col-lg-2 control-label">지점 방 개수</label>
                <div class="col-lg-10">
                    <input type="number" class="form-control onlyNumber" name="room" id="room" maxlength="4">
                </div>
            </div>
            <div class="form-group" id="divFname">
                <label for="inputFname" class="col-lg-2 control-label">지점 이미지</label>
                <div class="col-lg-10">
                    <input type="file" class="form-control onlyNumber" id="fname" name="uploadFile">
                </div>
            </div>
            <div class="form-group" id="divAddr">
                <label for="inputAddr" class="col-lg-2 control-label">지점 상세주소</label>
                <div class="col-lg-10">
                    <input type="text" class="form-control onlyNumber" name="addr" id="addr"><br><button type="button" id="put">주소검색</button>
                </div>
            </div>
          
            <div class="form-group">
                <div class="col-lg-offset-2 col-lg-10">
                    <button type="submit" class="btn btn-default">가입신청</button>
                </div>
            </div>
        </form>
    </div>
    <!-- end form -->
    
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
