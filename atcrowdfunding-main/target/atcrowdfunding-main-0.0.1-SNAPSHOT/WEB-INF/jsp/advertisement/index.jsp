<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<link rel="stylesheet" href="${APP_PATH }/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${APP_PATH }/css/font-awesome.min.css">
<link rel="stylesheet" href="${APP_PATH }/css/main.css">
<link rel="stylesheet" href="${APP_PATH }/css/pagination.css">
<style>
.tree li {
	list-style-type: none;
	cursor: pointer;
}

table tbody tr:nth-child(odd) {
	background: #F4F4F4;
}

table tbody td:nth-child(even) {
	color: #C00;
}
</style>
</head>

<body>

	<jsp:include page="/WEB-INF/jsp/common/mainheader.jsp"></jsp:include>

	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-3 col-md-2 sidebar">
				<jsp:include page="/WEB-INF/jsp/common/mainuser.jsp"></jsp:include>
			</div>
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="glyphicon glyphicon-th"></i> 数据列表
						</h3>
					</div>
					<div class="panel-body">
						<form class="form-inline" role="form" style="float: left;">
							<div class="form-group has-feedback">
								<div class="input-group">
									<div class="input-group-addon">查询条件</div>
									<input class="form-control has-success" type="text"
										placeholder="请输入查询条件">
								</div>
							</div>
							<button type="button" class="btn btn-warning">
								<i class="glyphicon glyphicon-search"></i> 查询
							</button>
						</form>
						<button type="button" class="btn btn-danger"
							style="float: right; margin-left: 10px;">
							<i class=" glyphicon glyphicon-remove"></i> 删除
						</button>
						<button onclick="window.location.href='${APP_PATH }/advert/add.htm'" type="button" class="btn btn-primary"
							style="float: right;" onclick="window.location.href='form.html'">
							<i class="glyphicon glyphicon-plus"></i> 新增
						</button>
						<br>
						<hr style="clear: both;">
						<div class="table-responsive">
							<table class="table  table-bordered">
								<thead>
									<tr>
										<th width="30">#</th>
										<th>广告描述</th>
										<th>状态</th>
										<th width="100">操作</th>
									</tr>
								</thead>
								<tbody>
									
								</tbody>
								<tfoot>
										
								
								</tfoot>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

     <script src="${APP_PATH }/jquery/jquery-2.1.1.min.js"></script>
    <script src="${APP_PATH }/bootstrap/js/bootstrap.min.js"></script>
	<script src="${APP_PATH }/script/docs.min.js"></script>
	<script src="${APP_PATH }/jquery/layer/layer.js"></script>
	<script src="${APP_PATH }/jquery/jquery-form.min.js"></script>
		<script src="${APP_PATH }/jquery/jquery.pagination.js"></script>
	<script type="text/javascript">
		$(function() {
			$(".list-group-item").click(function() {
				if ($(this).find("ul")) {
					$(this).toggleClass("tree-closed");
					if ($(this).hasClass("tree-closed")) {
						$("ul", this).hide("fast");
					} else {
						$("ul", this).show("fast");
					}
				}
			});
			startload();

			
			
			
		});
		
		function startload(){
			
			 $.ajax({
	          		type:'POST',
	          		url : "${APP_PATH}/advert/toindex.do",
	          	
	          		success : function(result){
	          			alert(result);
	          			if(result.flag){
	          				var index = layer.msg("加载成功",{time:2000,icon:6});
	          				layer.close(index);
	          				
	          				var content ="";
	          				$.each(result.page.datas,function(i,n){
	          					content+='<tr>';
	          					content+='<td>'+i+'</td>';
	          					content+='<td>'+n.name+'</td>';
	          					content+='<td>'+n.status+'</td>';
	          					content+='<td>';
	          					content+='<button type="button" class="btn btn-success btn-xs">';
	          					content+='<i class="glyphicon glyphicon-check"></i>';
	          					content+='</button>';
	          					content+='<button type="button" class="btn btn-primary btn-xs">';
	          					content+='<i class="glyphicon glyphicon-pencil"></i>';
	          					content+='</button>';
	          					content+='<button type="button" class="btn btn-danger btn-xs">';
	          					content+='<i class="glyphicon glyphicon-remove"></i>';
	          					content+='</button>';
	          					content+='</td>';
	          					content+='</tr>';
	          				});
	          				$("tbody").html(content);
	          				
	          			}
	          		}
	          	});
			
		}
	</script>
</body>
</html>
