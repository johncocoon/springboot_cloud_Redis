package com.atguigu.atcrowdfunding.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.atcrowdfunding.bean.Permission;
import com.atguigu.atcrowdfunding.common.util.ResultMessage;
import com.atguigu.atcrowdfunding.manager.service.PermissionService;

@Controller
@RequestMapping("/permission")
public class PermissionController {
			
	@Autowired
	private PermissionService permissionService;
	
	
	@RequestMapping("/indexasync")
	public String indexasync() {
		return "permission/indexasync";
	}
	@RequestMapping("/toindex")
	public String toindex() {
		return "permission/index";
	}
	@RequestMapping("/toadd")
	public String toadd() {
		return "permission/add";
	}
	@RequestMapping("/toupdate")
	public String toupdate(Integer id,Map<String,Object> map) {
		
		Permission permission = permissionService.queryPermissionById(id);
		
		map.put("permission", permission);
		return "permission/update";
	}
	
	
	/**
	 * 修改节点
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/update")
	public Object update(Permission permission) {
		ResultMessage result = new ResultMessage();
		//查询根节点
	
		try {
			int i = permissionService.updatePermissionById(permission);
			if(i<=0) {
				result.setFlag(false);
				result.setMessage("删除失败");
				return result;
			}
			result.setFlag(true);
			result.setMessage("删除成功");
			return result;
		} catch (Exception e) {
			result.setFlag(false);
			result.setMessage(e.getMessage());
			e.printStackTrace();
			return result;
		}
	}
	
	/**
	 * 删除节点
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/delete")
	public Object delete(Integer id) {
		ResultMessage result = new ResultMessage();
		//查询根节点
	
		try {
			int i = permissionService.deleteById(id);
			if(i<=0) {
				result.setFlag(false);
				result.setMessage("删除失败");
				return result;
			}
			result.setFlag(true);
			result.setMessage("删除成功");
			return result;
		} catch (Exception e) {
			result.setFlag(false);
			result.setMessage(e.getMessage());
			e.printStackTrace();
			return result;
		}
	}
	
	
	/**
	 * 添加节点
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/savePermission")
	public Object savePermission(Permission permission) {
		ResultMessage result = new ResultMessage();
		//查询根节点
	
		try {
			int i = permissionService.savePermission(permission);
			if(i<=0) {
				result.setFlag(false);
				result.setMessage("添加失败");
				return result;
			}
			result.setFlag(true);
			result.setMessage("添加成功");
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
	public Object loadData() {
		ResultMessage result = new ResultMessage();
		//查询根节点
	
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
	//递归树   
		@ResponseBody
		@RequestMapping("/loadindexasync")
		public Object loadindexasync() {
			ResultMessage result = new ResultMessage();
		// 查询根节点

		try {
			Permission root = permissionService.getRootPermission();
			// 递归 节点的树
			queryPermission(root);
			result.setObj(root);
			result.setFlag(true);
			return root;
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
	
	//加载树
	/*@ResponseBody
	@RequestMapping()
	public Object loadData() {
		//查询所有的树的节点  共有三级树
		List<Permission> list = permissionService.getAllPermission();
		Map<Integer , Permission> permissionMap = new HashMap<>();
		Permission root = null;
		for (Permission permission : list) {
			Integer id = permission.getId();
			permissionMap.put(id, permission);
		}
		for (Permission permission : list) {
			Permission child = permission;
			
			if(permission.getPid()==null) {
				root = permission;
			}else {
				
				Permission parent = permissionMap.get(permission.getId());
				parent.getChildren().add(child);
				
			}
		}
		
		
		return "";
	}*/
	
	
}
