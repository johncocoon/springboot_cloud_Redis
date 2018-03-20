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

    <link rel="stylesheet"
          href="${APP_PATH}/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/main.css">
    <link rel="stylesheet" href="${APP_PATH}/css/pagination.css">
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
            <div class="tree">
                <%@include file="/WEB-INF/jsp/common/mainuser.jsp" %>
            </div>
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
                                <input class="form-control has-success" type="text" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                    <button type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                    <button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='form.html'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr >
                                <th width="30">#</th>
                                <th width="30"><input type="checkbox"></th>
                                <th>名称</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>

                            </tbody>
                            <tfoot>
                                <td colspan="6" align="center">
                                    <!-- <ul class="pagination">

                                    </ul> -->
                                    <div id="Pagination" class="pagination"><!-- 这里显示分页 --></div>
                                </td>
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
    <script src="${APP_PATH }/ztree/jquery.ztree.all-3.5.min.js"></script>
    <script src="${APP_PATH }/jquery/jquery.pagination.js"></script>
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
        <c:if test="${empty param.pageno}">
        startload(0);
        </c:if>
        
        <c:if test="${not empty param.pageno}">
        startload(${param.pageno}-1);
        </c:if>
    });
    
  //给解决一个初始化路径
    function startload(pageindex){
        var jsonObj = {
            pageno:(pageindex+1),
            pagesize:5

        };
        $.ajax({
            type:'post',
            url:'${APP_PATH}/cert/loadcert.do',
            data:jsonObj,
            beforeSend:function () {
                var loadingIndex = layer.msg('处理中', {time:2000,icon: 16});
                layer.close(loadingIndex );
                return true;
            },
            success:function (result) {
                if(result.flag){
                    var page = result.page;
                    var certlist = page.datas;
                    var content ="";
                    $.each(certlist,function(i,n){
                        content+='<tr>';
                        content+='<td>'+(i+1)+'</td>';
                        content+='<td><input type="checkbox"></td>';
                        content+='<td>'+n.name+'</td>';
                        content+='<td>';
                        content+='<button type="button" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
                        content+='<button type="button" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
                        content+='</td>';
                        content+='</tr>';
                    });
                    $("tbody").html(content);

                    // 创建分页
                    var num_entries = page.totalsize ;
                    $("#Pagination").pagination(num_entries, {
                        num_edge_entries: 2, //边缘页数
                        num_display_entries: 4, //主体页数
                        callback: startload, //查询当前页的数据.
                        items_per_page:page.pagesize, //每页显示1项
                        current_page:(page.pageno-1), //当前页,索引从0开始
                        prev_text:"上一页",
                        next_text:"下一页"
                        

                    });

                }else{
                    layer.msg("查询失败",{time:2000,icon:5,shift:6});

                }

            }
        });
    }
</script>
</body>
</html>