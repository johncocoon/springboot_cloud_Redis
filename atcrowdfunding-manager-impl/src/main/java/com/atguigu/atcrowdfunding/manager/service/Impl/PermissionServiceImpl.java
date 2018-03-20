package com.atguigu.atcrowdfunding.manager.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.atcrowdfunding.bean.Permission;
import com.atguigu.atcrowdfunding.manager.mapper.PermissionMapper;
import com.atguigu.atcrowdfunding.manager.service.PermissionService;
@Service
public class PermissionServiceImpl implements PermissionService {
	@Autowired
	private PermissionMapper permissionMapper;
	
	@Override
	public Permission getRootPermission() {
		return permissionMapper.queryRootPermission();
	}

	@Override
	public List<Permission> queryChildrenPermission(Integer id) {
		return permissionMapper.selectByPid(id);
	}

	@Override
	public int savePermission(Permission permission) {
		return permissionMapper.insert(permission);
	}

	@Override
	public int deleteById(Integer id) {
		return permissionMapper.deleteByPrimaryKey(id);
	}

	@Override
	public Permission queryPermissionById(Integer id) {
		return permissionMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updatePermissionById(Permission permission) {
		return permissionMapper.updateByPrimaryKey(permission);
	}

	@Override
	public List<Permission> queryAll() {
		
		return permissionMapper.selectAll();
	}

}
