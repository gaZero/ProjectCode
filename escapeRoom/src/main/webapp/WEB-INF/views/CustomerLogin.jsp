<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
 	<%
        // 인코딩 처리
        request.setCharacterEncoding("euc-kr"); 
    %>
    <title>로그인 화면</title>
       
    <script type="text/javascript">
    
        function checkValue()
        {
            inputForm = eval("document.loginInfo");
            if(!inputForm.id.value)
            {
                alert("아이디를 입력하세요");    
                inputForm.id.focus();
                return false;
            }
            if(!inputForm.pwd.value)
            {
                alert("비밀번호를 입력하세요");    
                inputForm.password.focus();
                return false;
            }
        }
    
        // 회원가입 버튼 클릭시 회원가입 화면으로 이동
        function goJoinForm() {
            location.href="MemberJoin.do";
        }    
    </script>
 
</head>
<body>
	 <div id="wrap">
        <form name="loginInfo" method="post" action="login.do">
            <table>
                <tr>
                    <td bgcolor="skyblue">아이디</td>
                    <td><input type="text" name="id" maxlength="50" id="id"></td>
                </tr>
                <tr>
                    <td bgcolor="skyblue">비밀번호</td>
                    <td><input type="password" name="pwd" maxlength="50" id="pwd"></td>
                </tr>
            </table>
            <br>
            <input type="submit" value="로그인"/>
            <input type="button" value="회원가입" onclick="goJoinForm()" />
        </form>
        
    </div>    
</body>
</html>