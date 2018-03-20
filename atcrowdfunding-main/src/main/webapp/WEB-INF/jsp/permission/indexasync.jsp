<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset=utf-8>
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
    			var setting = {
    					 check : {
			                  enable : true 
			        	 },
    					async:{
    						enable:true,
    						url:"${APP_PATH}/permission/loadindexasync.do",
    						type:"post",
    						autoParam:[]
    					},
    					view: {
    						
    						selectedMulti: false,
    						addDiyDom: function(treeId, treeNode){
    							var icoObj = $("#" + treeNode.tId + "_ico"); // tId = permissionTree_1, $("#permissionTree_1_ico")
    							if ( treeNode.icon ) {
    								icoObj.removeClass("button ico_docu ico_open").addClass(treeNode.icon).css("background","");
    							}
    						},
    						addHoverDom: function(treeId, treeNode){  
    							var aObj = $("#" + treeNode.tId + "_a"); // tId = permissionTree_1, ==> $("#permissionTree_1_a")
    							aObj.attr("href", "javascript:;");
    							if (treeNode.editNameFlag || $("#btnGroup"+treeNode.tId).length>0) return;
    							var s = '<span id="btnGroup'+treeNode.tId+'">';
    							if ( treeNode.level == 0 ) {
    								s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="${APP_PATH}/permission/toadd.do?id='+treeNode.id+'" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
    							} else if ( treeNode.level == 1 ) {
    								s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="${APP_PATH}/permission/toupdate.do?id='+treeNode.id+'"  title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
    								if (treeNode.children.length == 0) {
    									s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="#" onclick="deleteById('+treeNode.id+',\''+treeNode.name+'\')" >&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
    								}
    								s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="${APP_PATH}/permission/toadd.do?id='+treeNode.id+'" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
    							} else if ( treeNode.level == 2 ) {
    								s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  href="${APP_PATH}/permission/toupdate.do?id='+treeNode.id+'" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
    								s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="#" onclick="deleteById('+treeNode.id+',\''+treeNode.name+'\')"  >&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
    							}
    			
    							s += '</span>';
    							aObj.after(s);
    						},
    						removeHoverDom: function(treeId, treeNode){
    							$("#btnGroup"+treeNode.tId).remove();
    						}
    					},
    					
    					callback: {
    						onClick : function(event, treeId, json) {

    						}
    					}
    				};
    			$.fn.zTree.init($("#treeDemo"), setting);
				
            });
            $("tbody .btn-success").click(function(){
                window.location.href = "assignRole.html";
            });
            $("tbody .btn-primary").click(function(){
                window.location.href = "edit.html";
            });
		   

            
            function deleteById(id,name){
            	layer.confirm("是否要继续删除权限是《"+name+"》",  {icon: 3, title:'提示'}, function(cindex){
    			    layer.close(cindex);
    			    $.ajax({
                		type:'post',
                		url:'${APP_PATH}/permission/delete.do',
                		data:{
                			id:id
                		},
                		success:function(result){
                			if(result.flag){
                				startLoad();
                			}else{
                				layer.msg(result.message,{time:2000,icon:5,shift:6});
                			}
                			
                		}
                	});
    			}, function(cindex){
    			    layer.close(cindex);
    			});
            	
            }
     		
            
        </script>
  </body>
</html>
