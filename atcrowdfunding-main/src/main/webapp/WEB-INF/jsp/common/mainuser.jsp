<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="tree">
	<ul style="padding-left: 0px;" class="list-group">
		<c:if test="${not empty selfPermissionRoleUser }">
				<li class="list-group-item tree-closed"><a href="main.html"><i class="glyphicon glyphicon-dashboard"></i> 控制面板</a></li>
				<c:forEach items="${selfPermissionRoleUser }" var="permission">
						<c:if test="${permission.children.size() ==0 }">
										<li class="list-group-item tree-closed"><span><i class="${permission.icon }"></i> ${permission.name } <span class="badge" style="float: right">${permission.children.size() }</span></span>
						</c:if>
						<c:if test="${permission.children.size() !=0 }">
								<li class="list-group-item tree-closed"><span><i class="${permission.icon }"></i> ${permission.name } <span class="badge" style="float: right">${permission.children.size() }</span></span>
								<ul style="margin-top: 10px; display: none;">
								<c:forEach items="${permission.children }" var="innerpermission">
									<li style="height: 30px;"><a href="${APP_PATH }/${innerpermission.url}"><i class="${innerpermission.icon }"></i>${innerpermission.name}</a></li>
								</c:forEach>
								</ul>
								</li>
						</c:if>
				</c:forEach>
				
		</c:if>
	</ul>

</div>

	

