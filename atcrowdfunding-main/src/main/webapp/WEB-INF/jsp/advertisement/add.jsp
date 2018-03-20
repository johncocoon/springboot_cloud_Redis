<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

	<link rel="stylesheet" href="${APP_PATH }/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${APP_PATH }/css/font-awesome.min.css">
	<link rel="stylesheet" href="${APP_PATH }/css/main.css">
	<link href="${APP_PATH }/bootstrap/css/fileinput.css" media="all" rel="stylesheet" type="text/css" />
	
	    
	
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
				  <li><a href="#">数据列表</a></li>
				  <li class="active">新增</li>
				</ol>
			<div class="panel panel-default">
              <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
			  <div class="panel-body">
			  
			 
			  
			  
			  
				<form id="form" method="post" enctype="multipart/form-data" action="${APP_PATH }/advert/add.do">
				  <div class="form-group">
					<label for="name">广告名称</label>
					<input type="text" class="form-control" id="name" name="name"  placeholder="请输入广告名称">
				  </div>
				 
				  <div class="form-group">
					<label for="email">上传图片</label>
					 <input id="file-0" class="file" type="file" name="mfile" multiple data-min-file-count="1">
	                <br>
				  </div>
				  <button id="savebtn" type="button" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i> 新增</button>
				  <button id="resetbtn" type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
				</form>
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
    <script src="${APP_PATH }/bootstrap/js/fileinput.js" type="text/javascript"></script>
     <script src="${APP_PATH }/bootstrap/js/fileinput_locale_zh.js" type="text/javascript"></script>
     <script src="${APP_PATH }/jquery/jquery-form.min.js"></script>
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
            
            
            $("#file-0").fileinput({
                language: 'zh', //设置语言
               allowedFileExtensions: ['jpg', 'gif', 'png'],//接收的文件后缀
               //uploadExtraData:{"id": 1, "fileName":'123.mp3'},
                showUpload:true, //是否显示上传按钮
                showRemove :true, //显示移除按钮
                showPreview :true, //是否显示预览
                showCaption:false,//是否显示标题
                browseClass:"btn btn-primary", //按钮样式    
               dropZoneEnabled: false,//是否显示拖拽区域
                maxFileCount:10, //表示允许同时上传的最大文件个数
                enctype:'multipart/form-data',
               validateInitialCount:true,
                previewFileIcon: "<iclass='glyphicon glyphicon-king'></i>",
               msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",

           }).on("fileuploaded", function (event, data, previewId, index){});

            
            
            
           
            $("#savebtn").click(function(){
            	var options = {
            			url:"${APP_PATH}/advert/add.do",
           				beforeSubmit : function(){
           					loadingIndex = layer.msg('数据正在保存中', {icon: 6});
                   			return true ; //必须返回true,否则,请求终止.
           				},
           				success : function(result){
                			layer.close(loadingIndex);
                			if(result.flag){
                				layer.msg("广告数据保存成功", {time:1000, icon:6});
                				window.location.href="${APP_PATH}/advert/index.htm";
                			}else{
                				layer.msg("广告数据保存失败", {time:1000, icon:5, shift:6});
                			}	
                		}	
            		};
            		$("#form").ajaxSubmit(options); //异步提交
            		return ; 
            });
           
           
            
        </script>
  </body>
</html>
