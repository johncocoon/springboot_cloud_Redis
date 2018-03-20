package com.atguigu.atcrowdfunding.manager.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.atcrowdfunding.bean.Role;
import com.atguigu.atcrowdfunding.common.util.RoleModel;
import com.atguigu.atcrowdfunding.manager.mapper.RoleMapper;
import com.atguigu.atcrowdfunding.manager.service.RoleService;
@Service
public class RoleServiceImpl implements RoleService {
	
	@Autowired
	private RoleMapper roleMapper;
	
	@Override
	public int saveRole(Role role) {
		return roleMapper.insert(role);
	}

	@Override
	public List<Role> queryByName(String name) {
		return roleMapper.selectAll(name);
	}

	@Override
	public int deleterole(Integer id) {
		return roleMapper.deleteByPrimaryKey(id);
	}

	@Override
	public List<Role> queryAllRole() {
		return roleMapper.selectAll(null);
	}

	@Override
	public List<Integer> queryRoleByUserId(Integer userid) {
		// TODO Auto-generated method stub
		return roleMapper.selectAssignRoleById(userid);
	}

	

	@Override
	public void insertByUseridAndRoleId(Integer userid, RoleModel roleModel) {
		roleMapper.insertByUseridAndRoleId(userid, roleModel.getIds());
		
	}

	@Override
	public void deleteRoleById(Integer userid, RoleModel roleModel) {
		roleMapper.deleteRoleById(userid, roleModel.getIds());
		
	}

	@Override
	public void insertPermissionRole(Integer roleid, RoleModel roleModel) {
			roleMapper.deletePermissionRole(roleid);
			roleMapper.insertPermissionRole(roleid,roleModel.getIds());
	}

	@Override
	public List<Integer> queryAllByRoleId(Integer roleid) {
		
		return roleMapper.queryByRoleid(roleid);
	}
			
}
