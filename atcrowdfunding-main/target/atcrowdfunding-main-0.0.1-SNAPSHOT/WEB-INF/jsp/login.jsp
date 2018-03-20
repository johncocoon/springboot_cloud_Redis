<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="keys" content="">
    <meta name="author" content="">
	<link rel="stylesheet" href="${APP_PATH }/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${APP_PATH }/css/font-awesome.min.css">
	<link rel="stylesheet" href="${APP_PATH }/css/login.css">
	<style>

	</style>
  </head>
  <body>
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <div><a class="navbar-brand" href="index.html" style="font-size:32px;">尚筹网-创意产品众筹平台</a></div>
        </div>
      </div>
    </nav>

    <div class="container">
		
      <form class="form-signin" id="form" action="${APP_PATH}/user/dologin.do" method="post">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-log-in"></i> 用户登录</h2>
        <c:if test="${exception.message !=null}">
       				 <div class="form-group has-success has-feedback">
       						 ${exception.message}
					  </div>
		  </c:if>
		
		  <div class="form-group has-success has-feedback">
			<input type="text" class="form-control" id="inputSuccess4" name="loginacct" value="${param.loginacct }" placeholder="请输入登录账号" autofocus>
			<span class="glyphicon glyphicon-user form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<input type="text" class="form-control" id="inputSuccess4" name="userpswd" value="${param.userpswd }" placeholder="请输入登录密码" style="margin-top:10px;">
			<span class="glyphicon glyphicon-lock form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<select class="form-control" name="userType">
                <option value="member" >会员</option>
                <option value="user"  selected="selected">管理</option>
            </select>
		  </div>
        <div class="checkbox">
          <label>
            <input type="checkbox" value="remember-me"> 记住我
          </label>
          <br>
          <label>
            忘记密码
          </label>
          <label style="float:right">
            <a href="${APP_PATH }/toReg.htm">我要注册</a>
          </label>
        </div>
        <a class="btn btn-lg btn-success btn-block" onclick="dologin()" > 登录</a>
      </form>
    </div>
    <script src="${APP_PATH }/jquery/jquery-2.1.1.min.js"></script>
    <script src="${APP_PATH }/bootstrap/js/bootstrap.min.js"></script>
    <script src="${APP_PATH }/jquery/layer/layer.js"></script>
    <script>
    function dologin() {
     
       
        var loginacct = $("input[name='loginacct']").val();
        var userpswd = $("input[name='userpswd']").val();
        var userType = $("input[name='userType']").val();
      
        
        if($.trim(loginacct) == ""){
        	
        	layer.msg("用户名不能为空",{time:1000, icon:5, shift:6});
        	loginacct.focus();
        	return false;
        }
        if($.trim(userpswd)==""){
        	alert("密码不能为空");
        	userpswd.focus();
        	return false;
        }
        
        $.ajax({
        	type : "post",
        	url :"${APP_PATH}/user/dologin.do",
        	//contentType : "application/json",
        
        	data : {
        		loginacct:loginacct,
        		userpswd :userpswd,
        		userType : userType
        	},
        
        	success : function(result,i){
        	
        		if(result.flag){
        			window.location.href = "${APP_PATH}/tomian.htm";
        		}else{
        			alert(result.message);
        			window.location.href = "${APP_PATH}/toLogin.htm";
        		}
        	}
        	
        });

    }
    </script>
  </body>
</html>