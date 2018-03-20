<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="tree">
	<ul style="padding-left: 0px;" class="list-group">
		<#if selfPermissionRoleUser ?if_exists >
		<li class="list-group-item tree-closed"><a href="main.html"><i class="glyphicon glyphicon-dashboard"></i> 控制面板</a></li>
				
				<#list selfPermissionRoleUser as permission >
						<#if permission.children.size() ==0>
							<li class="list-group-item tree-closed"><span><i class="${permission.icon }"></i> ${permission.name } <span class="badge" style="float: right">${permission.children.size() }</span></span>
						</#if>
						<#if permission.children.size() !=0>
							<li class="list-group-item tree-closed"><span><i class="${permission.icon }"></i> ${permission.name } <span class="badge" style="float: right">${permission.children.size() }</span></span>
								<ul style="margin-top: 10px; display: none;">
								<#list permission.children as innerpermission> 
								<li style="height: 30px;"><a href="${APP_PATH }/${innerpermission.url}"><i class="${innerpermission.icon }"></i>${innerpermission.name}</a></li>
								</#list>
								
								</ul>
								</li>
						</#if>
				</#list>
		</#if>
		
	</ul>

</div>

	

