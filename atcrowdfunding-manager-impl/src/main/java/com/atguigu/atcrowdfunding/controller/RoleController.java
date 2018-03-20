package com.atguigu.atcrowdfunding.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.atcrowdfunding.bean.Permission;
import com.atguigu.atcrowdfunding.bean.Role;
import com.atguigu.atcrowdfunding.common.util.ResultMessage;
import com.atguigu.atcrowdfunding.common.util.RoleModel;
import com.atguigu.atcrowdfunding.manager.service.PermissionService;
import com.atguigu.atcrowdfunding.manager.service.RoleService;

@Controller
@RequestMapping("/role")
public class RoleController {
			
	@Autowired
	private RoleService roleService;
	@Autowired
	private PermissionService permissionService;
	
	@RequestMapping("/toRole")
	public String toRole() {
		return "user/role/role";
	}
	@RequestMapping("/tosaveRole")
	public String tosaveRole() {
		return "user/role/addRole";
	}
	@RequestMapping("/toRolePermission")
	public String toPermission(Integer roleid) {
		return "user/role/addPermissionRole";
	}
	
	//权限树的回显
	@ResponseBody
	@RequestMapping("/showTree")
	public Object showtree(Integer roleid) {
		ResultMessage result = new ResultMessage();
		//查询根节点W
		
			
			List<Permission> all = permissionService.queryAll();
			
			List<Integer> allPermission = roleService.queryAllByRoleId(roleid);
			Map<Integer, Permission> map = new HashMap<>();
			for (Permission permission : all) {
				if(allPermission.contains(permission.getId())) {
					permission.setChecked(true);
				}
				map.put(permission.getId(), permission);
			}
			Permission root = null;
			for (Permission permission : all) {
				if(permission.getPid()==null) {
					root = permission;
				}else {
					Permission parent = map.get(permission.getPid());
					parent.getChildren().add(permission);
				}
			}
			result.setFlag(true);
			result.setObj(root);
			return result;
		 
	}
	
	
	
	
	//给角色添加权限
	@ResponseBody
	@RequestMapping("/addPermissionRole")
	public Object addPermissionRole(Integer roleid,RoleModel roleModel) {
		ResultMessage result = new ResultMessage();
		//查询根节点W
	
		try {
			
			roleService.insertPermissionRole(roleid,roleModel);
			
			result.setFlag(true);
			return result;
		} catch (Exception e) {
			result.setFlag(false);
			result.setMessage(e.getMessage());
			e.printStackTrace();
			return result;
		}
	}

	
	
	
	
	//递归树   
	@ResponseBody
	@RequestMapping("/index")
	public Object loadData(Integer userid) {
		ResultMessage result = new ResultMessage();
		//查询根节点W
	
		try {
			Permission root = permissionService.getRootPermission();
			//递归 节点的树
			queryPermission(root);
			result.setObj(root);
			result.setFlag(true);
			return result;
		} catch (Exception e) {
			result.setFlag(false);
			result.setMessage(e.getMessage());
			e.printStackTrace();
			return result;
		}
	}
	private void queryPermission(Permission root) {
		
		List<Permission> childrenList = permissionService.queryChildrenPermission(root.getId());
		root.setChildren(childrenList);
		for (Permission permission : childrenList) {
			queryPermission(permission);
		}
	}
	
	
	@ResponseBody
	@RequestMapping(value="/deleteRoleById",method=RequestMethod.POST)
	public Object deleteRoleById(@RequestParam("userid")Integer userid,RoleModel roleModel) {
		ResultMessage resultMessage = new ResultMessage();
			try {
				roleService.deleteRoleById(userid,roleModel);
				System.out.println("----------------"+roleModel.getIds());
				resultMessage.setFlag(true);
				resultMessage.setMessage("删除成功");
				return resultMessage;
			} catch (Exception e) {
				resultMessage.setFlag(false);
				resultMessage.setMessage(e.getMessage());
				
				e.printStackTrace();
				return resultMessage;
			}
	}
	
	@ResponseBody
	@RequestMapping(value="/saveRoleById",method=RequestMethod.POST)
	public Object saveRoleById(@RequestParam("userid")Integer userid,RoleModel roleModel) {
		ResultMessage resultMessage = new ResultMessage();
			try {
				roleService.insertByUseridAndRoleId(userid,roleModel);
				
					resultMessage.setFlag(true);
					resultMessage.setMessage("添加成功");
					
					
			
				return resultMessage;
			} catch (Exception e) {
				resultMessage.setFlag(false);
				resultMessage.setMessage(e.getMessage());
				
				e.printStackTrace();
				return resultMessage;
			}
	}
	
	
	@RequestMapping(value="/toassignRole",method=RequestMethod.GET)
	public String toassignRole(@RequestParam("userid")Integer userid,Map<String,Object> map) {
		List<Role> rolelist = roleService.queryAllRole();
		
		List<Integer> roleids = roleService.queryRoleByUserId(userid);
		
		List<Role> unassignRoles = new ArrayList<>();
		
		List<Role> assignRoles = new ArrayList<>();
		
		for (Role role : rolelist) {
			Integer roleid = role.getId();
			
			if(roleids.contains(roleid)) {
				assignRoles.add(role);
			}else {
				unassignRoles.add(role);
			}
		}
		map.put("unassignRoles", unassignRoles);
		map.put("assignRoles", assignRoles);
		return "user/role/assignRole";
	}
	
	
	@RequestMapping(value="/addRole",method=RequestMethod.POST)
	public String addRole(String prefixing,String suffering,Map map) {
		
		System.out.println(prefixing +" -------------------------" +suffering);
		String name = prefixing+"-"+suffering;
		Role role = new Role();
		role.setName(name);
		ResultMessage resultMessage = new ResultMessage();
		try {
			int result  = roleService.saveRole(role);
			if(result<=0) {
				resultMessage.setFlag(false);
				resultMessage.setMessage("角色添加失败");
				map.put("result", resultMessage);
				return "role/role";
			}
			resultMessage.setFlag(true);
			resultMessage.setMessage("角色添加成功");
			map.put("result", resultMessage);
			return "";
		} catch (Exception e) {
			resultMessage.setFlag(false);
			resultMessage.setMessage(e.getMessage());
			e.printStackTrace();
			map.put("result", resultMessage);
			return "";
		}
	}
		@ResponseBody
		@RequestMapping(value="/queryRole",method=RequestMethod.POST)
		public Object queryRole(@RequestParam(value="name",required=false,defaultValue="")String name) {
			ResultMessage resultMessage = new ResultMessage();
				try {
					List<Role> list = roleService.queryByName(name);
					if(list!=null) {
						resultMessage.setFlag(true);
						resultMessage.setMessage("查询成功");
						resultMessage.setList(list);
						return resultMessage;
					}
					resultMessage.setFlag(false);
					resultMessage.setMessage("查询失败");
					
					return resultMessage;
				} catch (Exception e) {
					resultMessage.setFlag(false);
					resultMessage.setMessage(e.getMessage());
					
					e.printStackTrace();
					return resultMessage;
				}
		}
		
		
		
		/**
		 * 删除角色信息
		 */
		@ResponseBody
		@RequestMapping(value="/deleterole",method=RequestMethod.POST)
		public Object deleteRole(Integer id) {
			ResultMessage resultMessage
										= new ResultMessage();
			try {
				int result = roleService.deleterole(id);
				if(result <=0) {
					resultMessage.setFlag(false);
					resultMessage.setMessage("删除失败");
					return resultMessage;
				}
				resultMessage.setFlag(true);
				resultMessage.setMessage("删除成功");
				return resultMessage;
				
			} catch (Exception e) {
				resultMessage.setFlag(false);
				resultMessage.setMessage(e.getMessage());
				e.printStackTrace();
				return resultMessage;
			}
		}
		
		
		
		
}
