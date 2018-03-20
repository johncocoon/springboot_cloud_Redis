package com.atguigu.atcrowdfunding.manager.service;

import java.util.List;

import com.atguigu.atcrowdfunding.bean.Role;
import com.atguigu.atcrowdfunding.common.util.RoleModel;

public interface RoleService {

	int saveRole(Role role);

	List<Role> queryByName(String name);

	int deleterole(Integer id);

	List<Role> queryAllRole();

	List<Integer> queryRoleByUserId(Integer userid);

	void insertByUseridAndRoleId(Integer userid, RoleModel roleModel);

	void deleteRoleById(Integer userid, RoleModel roleModel);

	void insertPermissionRole(Integer roleid, RoleModel roleModel);

	List<Integer> queryAllByRoleId(Integer roleid);

}
