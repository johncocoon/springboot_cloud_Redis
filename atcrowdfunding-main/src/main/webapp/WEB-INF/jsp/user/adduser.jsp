<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<head>
<meta charset="GB18030">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="css/font-awesome.min.css">
<link rel="stylesheet" href="css/main.css">
<link rel="stylesheet" href="css/doc.min.css">
<style>
.tree li {
	list-style-type: none;
	cursor: pointer;
}
</style>
</head>
<body>
	<div class="panel panel-default">
		<div class="panel-heading">
			表单数据
			<div style="float: right; cursor: pointer;" data-toggle="modal"
				data-target="#myModal">
				<i class="glyphicon glyphicon-question-sign"></i>
			</div>
		</div>
		<div class="panel-body">
			<form role="form">
				<div class="form-group">
					<label for="exampleInputPassword1">登陆账号</label> <input type="text"
						class="form-control" id="exampleInputPassword1"
						placeholder="请输入登陆账号">
				</div>
				<div class="form-group">
					<label for="exampleInputPassword1">用户名称</label> <input type="text"
						class="form-control" id="exampleInputPassword1"
						placeholder="请输入用户名称">
				</div>
				<div class="form-group">
					<label for="exampleInputEmail1">邮箱地址</label> <input type="email"
						class="form-control" id="exampleInputEmail1" placeholder="请输入邮箱地址">
					<p class="help-block label label-warning">请输入合法的邮箱地址, 格式为：
						xxxx@xxxx.com</p>
				</div>
				<button type="button" class="btn btn-success">
					<i class="glyphicon glyphicon-plus"></i> 新增
				</button>
				<button type="button" class="btn btn-danger">
					<i class="glyphicon glyphicon-refresh"></i> 重置
				</button>
			</form>
		</div>
	</div>

</body>
    <script src="${APP_PATH }/bootstrap/js/bootstrap.min.js"></script>
	<script src="${APP_PATH }/script/docs.min.js"></script>
	<script src="${APP_PATH }/jquery/layer/layer.js"></script>
    <script src="${APP_PATH }/jquery/jquery-2.1.1.min.js"></script>
<script type="text/javascript">

$().click(function (){
		layer.open({
			  type: 1,
			  skin: 'layui-layer-rim', //加上边框
			  area: ['420px', '240px'], //宽高
			  content: 'html内容'
			});
});
</script>

