<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<html>
<head>
    <title>ȸ������ ȭ��</title>
 
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
    
        // ȸ������ ȭ���� �Է°����� �˻��Ѵ�.
        function checkValue()
        {
            var form = document.userInfo;
        
            if(!form.id.value){
                alert("���̵� �Է��ϼ���.");
                return false;
            }     
            
            
            if(!form.pwd.value){
                alert("��й�ȣ�� �Է��ϼ���.");
                return false;
            }
            
            // ��й�ȣ�� ��й�ȣ Ȯ�ο� �Էµ� ���� �������� Ȯ��
            if(form.pwd.value != form.pwdcheck.value ){
                alert("��й�ȣ�� �����ϰ� �Է��ϼ���.");
                return false;
            }    
            
            if(!form.name.value){
                alert("�̸��� �Է��ϼ���.");
                return false;
            }
          
            if(!form.email.value){
                alert("���� �ּҸ� �Է��ϼ���.");
                return false;
            }
            
            if(!form.tel.value){
                alert("��ȭ��ȣ�� �Է��ϼ���.");
                return false;
            }
            
            if(isNaN(form.tel.value)){
                alert("��ȭ��ȣ�� -�� ������ ���ڸ� �Է����ּ���.");
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
    			$("#authResult").html("�����Ǿ����ϴ�.");
    		}
    		else
    		{
    			$("#authResult").html("������ �����Ͽ����ϴ�.");
    		}
    	});
        
   </script>
    
</head>
<body>
        <br><br>
        <b><font size="6" color="gray">ȸ������</font></b>
        <br><br><br>         
        
        <form method="post">
            <table>
                <tr>
                    <td id="title">���̵�</td>
                    <td>
                        <input type="text" name="id" id="id" maxlength="50">
                    </td>
                </tr>
                        
                <tr>
                    <td id="title">��й�ȣ</td>
                    <td>
                        <input type="password" name="pwd" maxlength="50" id="pwd">
                    </td>
                </tr>
                
                <tr>
                    <td id="title">��й�ȣ Ȯ��</td>
                    <td>
                        <input type="password" name="pwdcheck" maxlength="50">
                    </td>
                </tr>
                    
                <tr>
                    <td id="title">�̸�</td>
                    <td>
                        <input type="text" name="name" maxlength="50" id="name">
                    </td>
                </tr>
                                           
                    
                <tr>
                    <td id="title">�̸���</td>
                    <td>                    	
                        <input type="email" name="email" maxlength="50" id="email">                        
                        <button id="btnEmail">����</button>
                    </td>
                </tr>
                    
                <tr>
                    <td id="title">�޴���ȭ</td>
                    <td>
                        <input type="text" name="tel" id="tel"/>
                    </td>
                </tr>
            </table>
            <br>
            <input type="submit" value="����"/>  
            <input type="reset" value="���">
        </form>
 
</body>
</html>
