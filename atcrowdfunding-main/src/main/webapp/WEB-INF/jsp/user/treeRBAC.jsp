<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="GB18030">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
	
	<link rel="stylesheet" href="${APP_PATH }/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${APP_PATH }/css/font-awesome.min.css">
	<link rel="stylesheet" href="${APP_PATH }/css/main.css">
	<link rel="stylesheet" href="${APP_PATH }/css/doc.min.css">
	<link rel="stylesheet" href="${APP_PATH }/ztree/zTreeStyle.css">
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
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
				<ol class="breadcrumb">
				  <li><a href="#">首页</a></li>
				  <li><a href="#">许可树</a></li>
				  <li class="active">分配权限</li>
				</ol>
			<div class="panel panel-default">
			  <div class="panel-body">
					
								<ul id="treeDemo" class="ztree"></ul>
					
			  </div>
			</div>
        </div>
      </div>
    </div>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
		<div class="modal-content">
		  <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
			<h4 class="modal-title" id="myModalLabel">帮助</h4>
		  </div>
		  <div class="modal-body">
			<div class="bs-callout bs-callout-info">
				<h4>测试标题1</h4>
				<p>测试内容1，测试内容1，测试内容1，测试内容1，测试内容1，测试内容1</p>
			  </div>
			<div class="bs-callout bs-callout-info">
				<h4>测试标题2</h4>
				<p>测试内容2，测试内容2，测试内容2，测试内容2，测试内容2，测试内容2</p>
			  </div>
		  </div>
		  <!--
		  <div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			<button type="button" class="btn btn-primary">Save changes</button>
		  </div>
		  -->
		</div>
	  </div>
	</div>
    <script src="${APP_PATH }/jquery/jquery-2.1.1.min.js"></script>
    <script src="${APP_PATH }/bootstrap/js/bootstrap.min.js"></script>
	<script src="${APP_PATH }/script/docs.min.js"></script>
	<script src="${APP_PATH }/jquery/layer/layer.js"></script>
	<script src="${APP_PATH }/ztree/jquery.ztree.all-3.5.min.js"></script>
        <script type="text/javascript">
            $(function () {
			    $(".list-group-item").click(function(){
				    if ( $(this).find("ul") ) {
						$(this).toggleClass("tree-closed");
						if ( $(this).hasClass("tree-closed") ) {
							$("ul", this).hide("fast");
						} else {
							$("ul", this).show("fast");
						}
					}
				});
            });
            $("tbody .btn-success").click(function(){
                window.location.href = "assignRole.html";
            });
            $("tbody .btn-primary").click(function(){
                window.location.href = "edit.html";
            });
            
            var setting = {	};

    		var zNodes =[
    			{ name:"父节点1 - 展开", open:true,
    				children: [
    					{ name:"父节点11 - 折叠",
    						children: [
    							{ name:"叶子节点111"},
    							{ name:"叶子节点112"},
    							{ name:"叶子节点113"},
    							{ name:"叶子节点114"}
    						]},
    					{ name:"父节点12 - 折叠",
    						children: [
    							{ name:"叶子节点121"},
    							{ name:"叶子节点122"},
    							{ name:"叶子节点123"},
    							{ name:"叶子节点124"}
    						]},
    					{ name:"父节点13 - 没有子节点", isParent:true}
    				]},
    			{ name:"父节点2 - 折叠",
    				children: [
    					{ name:"父节点21 - 展开", open:true,
    						children: [
    							{ name:"叶子节点211"},
    							{ name:"叶子节点212"},
    							{ name:"叶子节点213"},
    							{ name:"叶子节点214"}
    						]},
    					{ name:"父节点22 - 折叠",
    						children: [
    							{ name:"叶子节点221"},
    							{ name:"叶子节点222"},
    							{ name:"叶子节点223"},
    							{ name:"叶子节点224"}
    						]},
    					{ name:"父节点23 - 折叠",
    						children: [
    							{ name:"叶子节点231"},
    							{ name:"叶子节点232"},
    							{ name:"叶子节点233"},
    							{ name:"叶子节点234"}
    						]}
    				]},
    			{ name:"父节点3 - 没有子节点", isParent:true}

    		];

    		$(document).ready(function(){
    			$.fn.zTree.init($("#treeDemo"), setting, zNodes);
    		});
            
        </script>
       
		
		
	
	
  </body>
</html>
