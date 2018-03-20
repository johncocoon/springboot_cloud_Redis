package com.atguigu.atcrowdfunding.manager.service.Impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.atguigu.atcrowdfunding.bean.Page;
import com.atguigu.atcrowdfunding.bean.Permission;
import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.common.Exception.UserException;
import com.atguigu.atcrowdfunding.common.Exception.UserRegistException;
import com.atguigu.atcrowdfunding.manager.mapper.UserMapper;
import com.atguigu.atcrowdfunding.manager.service.UserService;
@Service
public class UserServiceImpl implements UserService{
	
	@Autowired
	private UserMapper userMapper;
	

	/**
	 * 
	 */
	@Override
	@Transactional
	public User doLogin(Map<String, String> params) {
		String  loginacct = (String) params.get("loginacct");
		
		User user = userMapper.doLogin(loginacct);
		
		if(user==null) {
			throw new UserException("用户不存在");
		}
		
		if(!user.getUserpswd().equals(params.get("userpswd"))) {
			System.out.println("=========用户名或密码错误==========");
			throw new UserException("用户名或密码错误");
		}
		return user;
		
	}
	public boolean register(User user) {
		int result = userMapper.saveUser(user);
		if(result<=0) {
			throw new UserRegistException("用户注册失败");
		}
		return true;
	}

	@Override
	public Page<User> queryUserPage(Map<String, Object> paramMap) {
		
		Integer pageno = (Integer) paramMap.get("pageno");
		Integer pagesize = (Integer) paramMap.get("pagesize");
		Page<User> page = new Page<>(pageno, pagesize);
		
		Integer startindex = page.getStartindex();
		paramMap.put("startindex", startindex);
		List<User> userlist=userMapper.queryUserPage(paramMap);
		//3.查询记录数
		Integer totalsize = userMapper.countUser(paramMap);
				
		page.setDatas(userlist);
			
		page.setTotalsize(totalsize);
		Integer totalno = totalsize%pagesize>0 ? (totalsize/pagesize+1) : (totalsize/pagesize);
		page.setTotalno(totalno);
		
		System.out.println(page.toString());
		
		return page;
	}


	@Override
	public int saveUser(User user) {
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String createtime = dateFormat.format(new Date());
		user.setCreatetime(createtime);
		user.setUserpswd("123");
		int insert = userMapper.saveUser(user);
		
		return insert;
	}


	@Override
	public int deleteUserById(Integer id) {
		int count = userMapper.deleteByPrimaryKey(id);
		
		return count;
	}


	@Override
	public int updateUser(User user) {
		
		return userMapper.updateByPrimaryKey(user);
	}


	@Override
	public User queryUserById(Integer id) {
		
		return userMapper.selectByPrimaryKey(id);
	}


	@Override
	public int deleteUserByIdArray(Integer[] id) {
		
		return userMapper.deleteUserByIdArray(id);
	}
	@Override
	public List<Permission> queryPermissionRoleByUserId(Integer id) {
		return userMapper.queryPermissionRoleByUserId(id);
	}
}
