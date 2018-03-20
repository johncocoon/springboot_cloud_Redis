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
			  	<button id="addPermissionRole" type="button" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i>分配权限</button>
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
			    
			    startLoad();
				
            });
            $("tbody .btn-success").click(function(){
                window.location.href = "assignRole.html";
            });
            $("tbody .btn-primary").click(function(){
                window.location.href = "edit.html";
            });
		    function startLoad(){
			    $.ajax({
			    	type:"post",
			    	url:"${APP_PATH}/role/showTree.do",
			    	data:{
			    		roleid:'${param.roleid}'
			    	},
			    	success:function(result){
			    		if(result.flag){
			    			var setting = {
			    					 check : {
			    	                        enable : true  //在树节点前显示复选框
			    	                    },
			    						view: {
			    							selectedMulti: false,
			    							addDiyDom: function(treeId, treeNode){
			    								var icoObj = $("#" + treeNode.tId + "_ico"); // tId = permissionTree_1, $("#permissionTree_1_ico")
			    								if ( treeNode.icon ) {
			    									icoObj.removeClass("button ico_docu ico_open").addClass(treeNode.icon).css("background","");
			    								}
			    							},
			    						},
			    					
			    				};
			    				//$.fn.zTree.init($("#treeDemo"), setting); //异步访问数据
			    				
			    				$.fn.zTree.init($("#treeDemo"), setting, result.obj);
			    				
			    		}
			    	}
			    
			    });
     		}

            
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
            
            $("#addPermissionRole").click(function(){
            			
            	var jsonobj = {
            			roleid:'${param.roleid}'
            	};
            	var tree =$.fn.zTree.getZTreeObj("treeDemo");
            	
            	var selectNodes =  tree.getCheckedNodes(true);
            	
            	
            	$.each(selectNodes,function(i,n){
            		jsonobj["ids["+i+"]"] =n.id;
            	});
            	
            	$.ajax({
            		url:'${APP_PATH}/role/addPermissionRole.do',
            		type:'post',
            		data:jsonobj,
            		beforeSend:function(){
            			var index = layer.load(2, {time: 10*1000});
            			layer.close(index);
            		},
            		success:function(result){
            			if(result.flag){
            				layer.msg("分配成功",{time:1000,icon:6});
            			}else{
            				layer.msg("分配失败",{time:1000,icon:5,shift:6});
            			}
            		}
            	});
            	
            	
            });
            
     		
            
        </script>
  </body>
</html>
