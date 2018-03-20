<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<link rel="stylesheet"
	href="${APP_PATH }/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${APP_PATH }/css/font-awesome.min.css">
<link rel="stylesheet" href="${APP_PATH }/css/main.css">
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
									<input id="queryName" class="form-control has-success" type="text"
										placeholder="请输入查询条件">
								</div>
							</div>
							<button id="query1" type="button" class="btn btn-warning">
								<i class="glyphicon glyphicon-search"></i> 查询
							</button>
						</form>
						<button type="button" class="btn btn-danger"
							style="float: right; margin-left: 10px;">
							<i class=" glyphicon glyphicon-remove"></i> 删除
						</button>
						<button id="savebtn" type="button" class="btn btn-primary"
							style="float: right;">
							<i class="glyphicon glyphicon-plus"></i> 新增
						</button>
						<br>
						<hr style="clear: both;">
						<div class="table-responsive">
							<table class="table  table-bordered">
								<thead>
									<tr>
										<th width="30">#</th>
										<th width="30"><input type="checkbox"></th>
										<th>名称</th>
										<th width="100">操作</th>
									</tr>
								</thead>
								<tbody>


								</tbody>
								<tfoot>
									<tr>
										<td colspan="6" align="center">
											<ul class="pagination">
												<li class="disabled"><a href="#">上一页</a></li>
												<li class="active"><a href="#">1 <span
														class="sr-only">(current)</span></a></li>
												<li><a href="#">2</a></li>
												<li><a href="#">3</a></li>
												<li><a href="#">4</a></li>
												<li><a href="#">5</a></li>
												<li><a href="#">下一页</a></li>
											</ul>
										</td>
									</tr>

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
			
			startload(name);
			$("#query1").click(function(){
				var name = $("#queryName").val();
				startload(name);
			});
			$("#savebtn").click(function() {

				layer.open({
					type : 2,
					skin : 'layui-layer-rim', //加上边框
					area : [ '40%', '50%' ], //宽高

					btn : [ '确认', '取消' ],
					content : "${APP_PATH}/role/tosaveRole.htm",
					success : function(layero, index) {
						console.log(layero, index);
					},
					yes : function(index, layero) {
						alert(1111);
						alert(layero);
						alert($(layero).find("form").attr("method"));
						 var ins = $(layero).find("input");
						 $.each(ins,function(i,n){
							 alert(n.value);
						 });
						 
						layer.close(index);
					},
				});

			});

		});

		$("tbody .btn-success").click(function() {
			window.location.href = "assignPermission.html";
		});
		function mySubmit() {
			$('#form').submit();
		}

		function deleterole(id, name) {
			layer.confirm("是否要继续删除" + name + "的角色", {
				icon : 3,
				title : '提示'
			}, function(index) {
				layer.close(index);
				$.ajax({
					type : 'post',
					url : '${APP_PATH}/role/deleterole.do',
					data : {
						id : id
					},
					success : function(result) {
						if (result.flag) {
							layer.msg(result.message, {
								time : 2000,
								icon : 6
							});
							window.location.reload();
						} else {
							layer.msg(result.message, {
								time : 2000,
								icon : 5,
								shift : 6
							});
						}
					}
				});
			}, function(index) {
				return;
			});

		}
	
		//预加载  异步加载
		function startload(name){
			$.ajax({
				type : 'post',
				url : '${APP_PATH}/role/queryRole.do',
				data:{name:name},
				success : function(result) {
					var index = layer.load(2, {
						time : 10 * 1000
					});
					layer.close(index);
					if (result.flag) {
						roles = result.list;
						var content = '';
						$.each(
										roles,
										function(i, n) {
											content += '<tr>';
											content += '<td>' + (i + 1)
													+ '</td>';
											content += '<td><input type="checkbox"></td>';
											content += '<td>' + n.name
													+ '</td>';
											content += '<td>';
											content += '<button onclick="addPermissionBtn('+n.id+')" type="button" class="btn btn-success btn-xs">';
											content += '<i class=" glyphicon glyphicon-check"></i>';
											content += '</button>';
											content += '<button type="button" class="btn btn-primary btn-xs">';
											content += '<i class=" glyphicon glyphicon-pencil"></i>';
											content += '</button>';
											content += '<button  onclick="deleterole('
													+ n.id
													+ ',\''
													+ n.name
													+ '\')" type="button" class="btn btn-danger btn-xs">';
											content += '<i class=" glyphicon glyphicon-remove"></i>';
											content += '</button>';
											content += '</td>';
											content += '</tr>';
										});
						$("tbody").html(content);
					}
				}

			});
		}
		function addPermissionBtn(id){
			
			window.location.href="${APP_PATH}/role/toRolePermission.htm?roleid="+id;
		}
		
	</script>
</body>
</html>
