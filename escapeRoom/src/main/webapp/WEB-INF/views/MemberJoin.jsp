<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<html>
<head>
    <title>회원가입 화면</title>
 
    <style type="text/css">
        table{
            margin-left:auto; 
            margin-right:auto;
            border:3px solid skyblue;
        }
        
        td{
            border:1px solid skyblue
        }
        
        #title{
            background-color:skyblue
        }
   </style>
 
    <script type="text/javascript">
    
        // 회원가입 화면의 입력값들을 검사한다.
        function checkValue()
        {
            var form = document.userInfo;
        
            if(!form.id.value){
                alert("아이디를 입력하세요.");
                return false;
            }     
            
            
            if(!form.pwd.value){
                alert("비밀번호를 입력하세요.");
                return false;
            }
            
            // 비밀번호와 비밀번호 확인에 입력된 값이 동일한지 확인
            if(form.pwd.value != form.pwdcheck.value ){
                alert("비밀번호를 동일하게 입력하세요.");
                return false;
            }    
            
            if(!form.name.value){
                alert("이름을 입력하세요.");
                return false;
            }
          
            if(!form.email.value){
                alert("메일 주소를 입력하세요.");
                return false;
            }
            
            if(!form.tel.value){
                alert("전화번호를 입력하세요.");
                return false;
            }
            
            if(isNaN(form.tel.value)){
                alert("전화번호는 -을 제외한 숫자만 입력해주세요.");
                return false;
            }
            
        }
        
        $("#btnEmail").click(function(){
    		var data = $("#F").serializeArray();
    		$.ajax({url:"mail.do", data : data, success : function(data){
    			//alert(data);
    			senderNumber = data;
    			alert(
    						
    			)
    		}});
    	});	
    	
    	
    	
    	$("#btnOk").click(function(){
    		var userInput = $("#inputNumber").val();
    		alert(userInput)
    		alert(userInput)
    		if(senderNumber == userInput )
    		{
    			$("#inputForm").show();
    			$("#authResult").html("인증되었습니다.");
    		}
    		else
    		{
    			$("#authResult").html("인증에 실패하였습니다.");
    		}
    	});
        
   </script>
    
</head>
<body>
        <br><br>
        <b><font size="6" color="gray">회원가입</font></b>
        <br><br><br>         
        
        <form method="post">
            <table>
                <tr>
                    <td id="title">아이디</td>
                    <td>
                        <input type="text" name="id" id="id" maxlength="50">
                    </td>
                </tr>
                        
                <tr>
                    <td id="title">비밀번호</td>
                    <td>
                        <input type="password" name="pwd" maxlength="50" id="pwd">
                    </td>
                </tr>
                
                <tr>
                    <td id="title">비밀번호 확인</td>
                    <td>
                        <input type="password" name="pwdcheck" maxlength="50">
                    </td>
                </tr>
                    
                <tr>
                    <td id="title">이름</td>
                    <td>
                        <input type="text" name="name" maxlength="50" id="name">
                    </td>
                </tr>
                                           
                    
                <tr>
                    <td id="title">이메일</td>
                    <td>                    	
                        <input type="email" name="email" maxlength="50" id="email">                        
                        <button id="btnEmail">인증</button>
                    </td>
                </tr>
                    
                <tr>
                    <td id="title">휴대전화</td>
                    <td>
                        <input type="text" name="tel" id="tel"/>
                    </td>
                </tr>
            </table>
            <br>
            <input type="submit" value="가입"/>  
            <input type="reset" value="취소">
        </form>
 
</body>
</html>
