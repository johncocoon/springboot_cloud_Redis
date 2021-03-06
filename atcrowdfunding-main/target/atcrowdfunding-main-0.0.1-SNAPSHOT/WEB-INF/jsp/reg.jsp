<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
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

	
      <form class="form-signin" id="form" action="${APP_PATH }/user/doReg.do" method="post">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-log-in"></i> 用户注册</h2>
        <span >${user.userpswd }</span>
        <input type="hidden" name="formid" value="${sessionScope.formid }"/>
		  <div class="form-group has-success has-feedback">
			<input type="text" class="form-control" id="inputSuccess4" name="loginacct" value="${param.loginacct}" placeholder="请输入登录账号" autofocus>
			<span class="glyphicon glyphicon-user form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<input type="text" class="form-control" id="inputSuccess4" name="userpswd"  placeholder="请输入登录密码" style="margin-top:10px;">
			<span class="glyphicon glyphicon-lock form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<input type="text" class="form-control" id="inputSuccess4" name="username" value="${param.username}" placeholder="请输入用户姓名" style="margin-top:10px;">
			<span class="glyphicon glyphicon-plus form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<input type="text" class="form-control" id="inputSuccess4" name="email" value="${param.email}" placeholder="请输入邮箱地址" style="margin-top:10px;">
			<span class="glyphicon glyphicon glyphicon-envelope form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<select class="form-control"  name="">
                <option>企业</option>
                <option selected="selected">个人</option>
            </select>
		  </div>
        <div class="checkbox">
          <label>忘记密码</label>
          <label style="float:right">
            <a href="login.html">我有账号</a>
          </label>
        </div>
        <a class="btn btn-lg btn-success btn-block" onclick="toregster()" > 注册</a>
      </form>
    </div>
    <script src="${APP_PATH }/jquery/jquery-2.1.1.min.js"></script>
    <script src="${APP_PATH }/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript">
    
    		function toregster(){
    			
    			$("#form").submit();
    	
    		}
    </script>
  </body>
</html>