<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh_CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

	<link rel="stylesheet" href="${APP_PATH }/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${APP_PATH }/css/font-awesome.min.css">
	<link rel="stylesheet" href="${APP_PATH }/css/main.css">
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	table tbody tr:nth-child(odd){background:#F4F4F4;}
	table tbody td:nth-child(even){color:#C00;}
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
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
			  </div>
			  <div class="panel-body">
<form class="form-inline" role="form" style="float:left;">
  <div class="form-group has-feedback">
    <div class="input-group">
      <div class="input-group-addon">查询条件</div>
      <input id="queryCondition" class="form-control has-success" type="text" placeholder="请输入查询条件">
    </div>
  </div>
  <button id="buttonByLoginacct" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
</form>
<button id="deletebtn" type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
<button id="savebtn" type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='${APP_PATH}/user/tosaveUser.htm'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
<br>
 <hr style="clear:both;">
          <div class="table-responsive">
            <table class="table  table-bordered">
              <thead>
                <tr >
                  <th width="30">#</th>
				  <th width="30"><input id="allCheckbox" type="checkbox"/></th>
                  <th>账号</th>
                  <th>名称</th>
                  <th>邮箱地址</th>
                  <th width="100">操作</th>
                </tr>
              </thead>
              <tbody>
              </tbody>
			  <tfoot>
			     <tr >
				     <td colspan="6" align="center">
						<ul class="pagination">
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
			    
            $("tbody .btn-success").click(function(){
                window.location.href = "assignRole.html";
            });
            $("tbody .btn-primary").click(function(){
                window.location.href = "edit.html";
            });
            var value =  "";
            $("#queryCondition").change(function(){
            	value =  $("#queryCondition").val();
            });
           
            var json = {
       			 pageno:'1',
       			 condition : value
       		 };
            
			 function startload(json){
				
				 $.ajax({
					   type : 'post',
					   url : '${APP_PATH}/user/index2.do',
					   data : json,
					   success : function(result){
						   var index = layer.load(2, {time: 10*1000});
							layer.close(index);

						   queryPageP (result);
					   }
				   }); 
			 }   
			 startload(json);
			  
			  //点击按查询条件
	          
	          $("#buttonByLoginacct").click(function(){
	        	  json.condition =value;
	        	  startload(json);
	          });
			 
			  	  
			  
            });
            function queryPage(pageno){
            	$.ajax({
            		  	type : 'post',
   				   		url : '${APP_PATH}/user/index2.do',
   				   		data : {
   				   			pageno:pageno,
   				   		},
   				   		success : function(result){
   				   			queryPageP(result);
   				   		}
            		
            	});
            }
            function queryPageP (result){
            	var page = result.page ;
	    		   var datas = page.datas;
				   var content = '';
				   $.each(datas,function(i,n){
					    content+='<tr>';
	    				content+='  <td>'+(i+1)+'</td>';
	    				content+='  <td><input id="'+n.id+'" type="checkbox"></td>';
	    				content+='  <td>'+n.loginacct+'</td>';
	    				content+='  <td>'+n.username+'</td>';
	    				content+='  <td>'+n.email+'</td>';
	    				content+='  <td>';
	    				content+='      <button type="button" onclick="window.location.href=\'${APP_PATH}/role/toassignRole.do?userid='+n.id+'\'" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>';
	    				content+='      <button id="updatebtn" onclick="window.location.href=\'${APP_PATH}/user/toupdateUser.htm?id='+n.id+'&pageno='+page.pageno+'\'" type="button"  class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
	    				content+='      <button  type="button" onclick="deleteUsersimple('+n.id+',\''+n.loginacct+'\')" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
	    				content+='  </td>';
	    				content+='</tr>';			    				
	    			});
				   $("tbody").html(content);
				   var navigater = '';
	    			if(page.pageno==1){
	    				navigater += '<li class="disabled"><a href="#">上一页</a></li>';
	    			}else{
	    				navigater += '<li><a onclick="queryPage('+(page.pageno-1)+')">上一页</a></li>';
	    			}
	    			
	    			for(var num=1; num<=page.totalno; num++){
	    				navigater+='<li '; 
	    				if(page.pageno==num){
	    					navigater+='class="active"';
	    				}
	    				navigater+= ' ><a onclick="queryPage('+num+')">'+num+'</a></li>';
	    			}
	    			
					if(page.pageno==page.totalno){
	    				navigater += '<li class="disabled"><a href="#">下一页</a></li>';
	    			}else{
	    				navigater += '<li><a onclick="queryPage('+(page.pageno+1)+')">下一页</a></li>';
	    			}
					
	    			$(".pagination").html(navigater);
			   }
            
            
            
            
            //删除一个删除用户
           function deleteUsersimple(id,loginacct){
        	   layer.confirm("你确定要删除  "+loginacct+" 用户吗？",  {icon: 3, title:'提示'}, function(cindex){
   			       layer.close(cindex);
	   			    $.ajax({
	            		type:'POST',
	            		url : "${APP_PATH}/user/deleteUser.do",
	            		data :{
	            			id:id
	            		},
	            		success : function(result){
	            			alert(result.flag);
	            			if(result.flag){
	            				layer.msg("删除成功", {time:1000, icon:6});
	            				window.location.href="${APP_PATH}/user/index1.htm";
	            				
	            			}else{
	            				layer.msg(result.message, {time:1000, icon:5, shift:6});
	            			}
	            		}
	            	});
   				}, function(cindex){
   			       layer.close(cindex);
   				});
            }
            
            
            
            
            
        $("#allCheckbox").click(function(){
        	var flag = $("#allCheckbox").prop("checked");
        	var boxs =  $("tbody :checkbox");
        	boxs.each(function(i){
        		this.checked=flag;
        	});
        });
        
        
        //批量删除用户
        $("#deletebtn").click(function(){
        	
        	var checkeds = $("tbody :checked");
        	if(checkeds.length<=0){
        		layer.msg("删除时必须选中一条或多条",{time:1000, icon:5, shift:6});
        		return ;
        	}
        	var id = '';
        	$.each(checkeds,function(i,n){
        		var s=this.id;
        		if(i==0){
        			id += ('id='+s);
        		}else{
        			id +=('&id='+s);
        		}
        	});
        
        	$.ajax({
          		type:'POST',
          		url : "${APP_PATH}/user/deleteAllUser.do",
          		data :id,
          		beforeSend:function(){
          			var index = layer.load(2, {time: 10*1000});
        			layer.close(index);
          			return true;
          		},
          		success : function(result){
          			alert(id);
	          			if(result.flag){
	          				layer.msg(result.message,{time:3000, icon:6});
	          				window.location.href="${APP_PATH}/user/index1.htm";
	          			}else{
	          				layer.msg(result.message, {time:1000, icon:5, shift:6});
	          			}
          		}
          	});
       
        });
            
            
            
            
            
        </script>
  </body>
</html>
    