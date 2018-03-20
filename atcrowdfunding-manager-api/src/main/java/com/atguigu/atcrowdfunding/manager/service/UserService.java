package com.atguigu.atcrowdfunding.manager.service;

import java.util.List;
import java.util.Map;

import com.atguigu.atcrowdfunding.bean.Page;
import com.atguigu.atcrowdfunding.bean.Permission;
import com.atguigu.atcrowdfunding.bean.User;

public interface UserService {
	
		public User doLogin(Map<String, String> params);
		
		
		public boolean register(User user);


		public Page<User> queryUserPage(Map<String, Object> paramMap);


		public int saveUser(User user);


		public int deleteUserById(Integer id);


		public int updateUser(User user);


		public User queryUserById(Integer id);


		public int deleteUserByIdArray(Integer[] id);


		public List<Permission> queryPermissionRoleByUserId(Integer id);
}
