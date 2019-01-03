<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>

<style type="text/css">
	.resEmpty {
		width:150px;
		height:80px;
		background-color: #D5D5D5;
		margin-top: 5px;
		margin-bottom: 5px;
		margin-right: 5px;
		margin-left: 5px;
	}
	.resOk {
		width:150px;
		height:80px;
		background-color: #B2CCFF;
		margin-top: 5px;
		margin-bottom: 5px;
		margin-right: 5px;
		margin-left: 5px;
	}
	#btn_modal {
		display: none;
	}
	#layer_fixed
	{
		width:200px;
		color: #555;
		font-size:13px;
		position:fixed;
		z-index:999;
		top:70px;
		right:0%;
		-webkit-box-shadow: 0 1px 2px 0 #777;
		box-shadow: 0 1px 2px 0 #777;
		background-color: #363636;	
	}
	.list-group-item {
		background-color: #white;
		color: black;
	}
	#navbarResponsive {
		position: fixed;
		right:1%;
	}
	#title {
		position: relative;
		top: 150px;
		left: 22%;
	}
	#center {
		position: relative;
		width:70%;
		top: 200px;
		left: 19%;
	}
	#navCSS{
		position:fixed;
		z-index:999;
		left:0%;
		background-color: #363636;
		width: 1500px;
	}
</style>
<link href="../resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
            	
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<script>
$(function() {
	var id = $("#id").val();
	
	var d = new Date();
	var year = d.getFullYear();
	var month = d.getMonth()+1;
	if(month < 10) {
		month = "0"+month;
	}
	var date = d.getDate();
	if(date < 10) {
		date = "0"+date;
	}
	var today = year + "-" + month + "-" + date;
	$("#resDate").val(today);
	
	erRes(id, today);
	
	$("#resDate").datepicker({
    	dateFormat: "yy-mm-dd",
    	//minDate: 0,
    	onSelect: function(resDate) {
			var date = $("#resDate").val();
			erRes(id, date);
    	}
    });
	
});
  
function erRes(id, date) {
	if(id && date) {
		$.ajax("reservationInfo_er.do",{
			data : {id:id, date:date},
			dataType : "json",
			success : function(data){
				$("#div").empty()
				$.each(data.str1, function(i,v){
					$("#ername").html(v.ername);
					var h2 = $("<h2></h2>").html(v.tname);
					var span = $("<span></span>");
					var tcode = v.tcode;
					if(v.people > 2) {
						span.html("난이도 : "+v.tstar+"&nbsp&nbsp 인원 : 2명~"+v.people+"명")
					} else {
						span.html("난이도 : "+v.tstar+"&nbsp&nbsp 인원 : "+v.people+"명")
					}
					$("#div").append(h2,span);
					var divTime = "divTime"+v.tcode
					$("<div></div>").attr({
						id:divTime,
						padding:"10px"
					}).appendTo("#div");
					var br = 0;
					$.each(data.str2, function(i2,v2){
						if(tcode == v2.tcode && date == v2.bookDate) {
							br = br + 1;
							if(br > 5) {
								$("<br>").appendTo("#divTime"+v2.tcode);
								br = 0;
							}
							var btn_booktime = $("<button></button>").appendTo("#divTime"+v2.tcode);
							
							var time = v2.bookTime;
							var hour = Math.floor(v2.bookTime/60);
							var minute = Math.round((time/60 - hour) * 60);
							var viewtime = "";
							if(minute < 10) {
								viewtime = hour+":0"+minute;
							} else {
								viewtime = hour+":"+minute;
							}
							$(btn_booktime).html(viewtime);
							
							if(v2.resCode == "0") {
								$(btn_booktime).addClass("resEmpty").html(viewtime+"<br>미예약");
							} else {
								$(btn_booktime).addClass("resOk").html(viewtime+"<br>예약확인");
								$(btn_booktime).click(function(){
									resDetail(v2.theme_resCode, date, viewtime, v.tname);									
									$("#btn_modal").trigger("click");
								});
							}
						}
					});	// str2(theme_res) each문 end
				}); // str1(theme) each문 end
			}
		}); // ajax end
	}
} // function myRes end

function resDetail(theme_resCode, date, viewtime, tname) {
	if(theme_resCode && date && viewtime && tname) {
		$.ajax("selErRes.do",{
			data: {theme_resCode:theme_resCode},
			dataType : "json",
			success: function(data){
				$("#modal-time").html(date+"&nbsp"+viewtime);
				$("#modal-tname").html(tname);
				$("#modal-name").html(data.name);
				$("#modal-resPeople").html(data.resPeople+"명");
				var tel = data.tel;
				$("#modal-tel").html(tel.substring(0,3)+" - "+tel.substring(3,7)+" - "+tel.substring(7,11));
				$("#modal-totalPrice").html(data.totalPrice+"원");
				if(data.payType == 1) {
					$("#modal-payType").html("현장결제");
				} else if(data.payType == 2) {
					$("#modal-payType").html("카드결제");
				}
				
			}
		}); // ajax end
	}
} // function resDetail end

  </script>
</head>
<body>
<!-- start Navigation -->
<div id="navCSS">
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">

        <a class="navbar-brand" href="../main.do" id="navbarLogo"><img src="../resources/img/mylogo.png" width="150" id="imglogo"></a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
          <ul class="navbar-nav ml-auto">
            <li class="nav-item">
              <a class="nav-link" href="../main.do">예약하기</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="../listES2.do">지점소개</a>
            </li>
             <li class="nav-item active">
              <a class="nav-link" href="#">내정보</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="../logout.do">로그아웃</a>
            </li>
          </ul>
        </div>

    </nav>
</div>
<!-- end Navigation -->
    
	<img src="../resources/img/title/er_res.png" id="title">
	<input type="hidden" id="id" value="${id }">
	<div id="center">
		<span><font size="4" id="ername"></font></span> &nbsp;
		<input type="text" id="resDate" name="resDate" class="ipt black" autocomplete="off" readonly="">
		<br>
		<br>
		<div id="div">
		</div>
	</div>
	
	<!-- Modal -->
	<div id="resModal" class="modal fade" role="dialog">
	  <div class="modal-dialog">
	    <!-- Modal content-->
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 id="modal-time"></h4>
	        <h3 id="modal-tname"></h4>
	      </div>
	      <div class="modal-body">
	        <table id="tb">
	        	<tr>
	        		<td width="200px">고객명</td>
	        		<td width="200px" id="modal-name"></td>	        	
	        	</tr>
	        	<tr>
	        		<td width="200px">총 인원</td>
	        		<td width="200px" id="modal-resPeople"></td>	        	
	        	</tr>
	        	<tr>
	        		<td width="200px">전화번호</td>
	        		<td width="200px" id="modal-tel"></td>	        	
	        	</tr>
	        	<tr>
	        		<td width="200px">금액</td>
	        		<td width="200px" id="modal-totalPrice"></td>	        	
	        	</tr>
	        	<tr>
	        		<td width="200px">결제방법</td>
	        		<td width="200px" id="modal-payType"></td>	        	
	        	</tr>
	        </table>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
	<button id="btn_modal" type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#resModal">Open Modal</button>
	
	<!-- 마이페이지 - 목록  -->
	<div id="layer_fixed">
   	 <div class="list_mypage">
	    <a href="updateRoom.do?id=${id }" class="list-group-item"><img src="../resources/img/icons/my_infor.JPG" width="25" height="25">&nbsp; 정보 수정 </a>
		<a href="../bmain.do?ername=${ername }" class="list-group-item"><img src="../resources/img/icons/my_board.JPG" width="25" height="25">&nbsp; 게시물 관리 </a>
		<a href="reservationInfo.do?id=${id }" class="list-group-item"><img src="../resources/img/icons/my_res.JPG" width="25" height="25">&nbsp; 예약 관리 </a>
		<a href="theme/listTheme.do?id=${id }" class="list-group-item"><img src="../resources/img/icons/my_theme.JPG" width="25" height="25">&nbsp; 테마 관리 </a>
		<a href="deleteRoom.do?id=${id }" class="list-group-item"><img src="../resources/img/icons/my_delete.JPG" width="25" height="25">&nbsp; 회원 탈퇴 </a>
	  </div>
    </div>
</body>
</html>