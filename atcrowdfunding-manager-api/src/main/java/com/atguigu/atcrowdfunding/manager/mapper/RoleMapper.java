package com.atguigu.atcrowdfunding.manager.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.atguigu.atcrowdfunding.bean.Permission;
import com.atguigu.atcrowdfunding.bean.Role;

public interface RoleMapper {
 
    int deleteByPrimaryKey(Integer id);

  
    int insert(Role record);

   
    Role selectByPrimaryKey(Integer id);

  
    List<Role> selectAll(@Param("name")String name);

   
    int updateByPrimaryKey(Role record);

    @Select("select roleid from t_user_role where userid =#{userid}")
	List<Integer> selectAssignRoleById(Integer userid);

    
	void insertByUseridAndRoleId(@Param("userid")Integer userid, @Param("ids")List<Integer> ids);


	void deleteRoleById(@Param("userid")Integer userid, @Param("ids")List<Integer> ids);


	void insertPermissionRole(@Param("roleid")Integer roleid,@Param("ids") List<Integer> ids);


	void deletePermissionRole(Integer roleid);


	List<Integer> queryByRoleid(Integer roleid);
}