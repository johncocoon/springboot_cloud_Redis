package com.atguigu.atcrowdfunding.manager.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.atguigu.atcrowdfunding.bean.Permission;
import com.atguigu.atcrowdfunding.bean.User;

public interface UserMapper {
    int deleteByPrimaryKey(Integer id);

    int saveUser(User record);

    User selectByPrimaryKey(Integer id);

    List<User> selectAll();

    int updateByPrimaryKey(User record);
    
    @Select("select * from t_user where loginacct = #{loginacct}")
    public User doLogin(@Param("loginacct")String loginacct);
    
	List<User> queryUserPage(Map<String, Object> paramMap);

	Integer countUser(Map<String, Object> paramMap);

	int deleteUserByIdArray(Integer[] id);

	List<Permission> queryPermissionRoleByUserId(Integer id);
	


    
    
}