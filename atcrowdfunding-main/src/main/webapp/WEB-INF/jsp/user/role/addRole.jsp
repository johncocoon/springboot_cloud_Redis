<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${APP_PATH }/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${APP_PATH }/css/font-awesome.min.css">
	<link rel="stylesheet" href="${APP_PATH }/css/main.css">
    <script src="${APP_PATH }/jquery/jquery-2.1.1.min.js"></script>
    <script src="${APP_PATH }/bootstrap/js/bootstrap.min.js"></script>
	<script src="${APP_PATH }/script/docs.min.js"></script>
	<script src="${APP_PATH }/jquery/layer/layer.js"></script>
</head>
<body>
	        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main"  id="lastdiv">
				<ol class="breadcrumb">
				  <li><a href="#">首页</a></li>
				  <li><a href="#">数据列表</a></li>
				  <li class="active">新增</li>
				</ol>
			<div class="panel panel-default">
              <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
			  <div class="panel-body">
				<form id="form" method="post" action="${APP_PATH }/role/addRole.do" >
				  <div class="form-group">
					<label for="prefixing">角色缩写</label>
					<input id="tips1" type="text" class="form-control" id="prefixing" name="prefixing" value="${param.loginacct }" placeholder="请输入前缀">
				  </div>
				  <div class="form-group">
					<label for="suffering">角色 全称</label>
					<input type="text" class="form-control" id="suffering" name="suffering" value="${param.username }" placeholder="请输入后缀">
					<p class="help-block label label-warning">请输入中文角色：列如项目组长</p>
				  </div>
				
				  <button  id="savebtn1" type="button" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i> 新增</button>
				  <button id="resetbtn" type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
				</form>
			  </div>
			</div>
        </div>
        <script type="text/javascript">
        $(function(){
        	layer.tips("提示");
    		$("#prefixing").mousemove(function(){
    			console.log("sdfdsfdasfsadf");
    			layer.tips("提示","#prefixing");
    		});			
        });
        		
        
		        function mySubmit() {
					$('#form').submit();
				}
        </script>
</body>
</html>