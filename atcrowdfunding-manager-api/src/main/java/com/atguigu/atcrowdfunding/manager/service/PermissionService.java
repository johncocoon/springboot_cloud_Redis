package com.atguigu.atcrowdfunding.manager.service;

import java.util.List;

import com.atguigu.atcrowdfunding.bean.Permission;

public interface PermissionService {

	Permission getRootPermission();

	List<Permission> queryChildrenPermission(Integer id);

	int savePermission(Permission permission);

	int deleteById(Integer id);

	Permission queryPermissionById(Integer id);

	int updatePermissionById(Permission permission);

	List<Permission> queryAll();

	

}
