package com.atguigu.atcrowdfunding.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.atcrowdfunding.bean.Page;
import com.atguigu.atcrowdfunding.bean.Permission;
import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.common.util.Constant;
import com.atguigu.atcrowdfunding.common.util.ResultMessage;
import com.atguigu.atcrowdfunding.manager.service.UserService;

@Controller
@RequestMapping("/user")
public class UserContrller {

	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	
	
	/**
	 * 前往管理员添加用户页面
	 */
	@RequestMapping("/toZtree")
	public String toZtree() {
		return "user/treeRBAC";
	}
	
	
	
	
	
	//异步提交
	@ResponseBody
	@RequestMapping(value="/dologin",method=RequestMethod.POST)
	public Object login(String loginacct,String userpswd,String userType ,HttpSession session) {
		ResultMessage result = new ResultMessage();
		if("member".equals(userType)) {
			
		}
			try {
				Map<String , String> params = new HashMap<>();
				params.put("loginacct", loginacct);
				params.put("userpswd", userpswd);
				User user = userService.doLogin(params);
				
				if(user != null) {
					//查询出用户所拥有的权限
					
					List<Permission> selfPermissionList = userService.queryPermissionRoleByUserId(user.getId());
					//将树之间的关系组合起来
					if(selfPermissionList.size()!=0) {
						Map<Integer,Permission> selfPermissionMap = new HashMap<Integer,Permission>(); 
						
						for (Permission permission : selfPermissionList) {
							selfPermissionMap.put(permission.getId(), permission);
						}
						
						Permission root = null ;
						
						for (Permission permission : selfPermissionList) {
							if(permission.getPid() == null) {
								root = permission;
							}else {
								Permission parent = selfPermissionMap.get(permission.getPid());
								parent.getChildren().add(permission);
							}
						}
						session.setAttribute(Constant.SELF_PERMISSION_ROLE_User, root.getChildren());
					}
				
					session.setAttribute(Constant.LOGINUSER, user);
					result.setFlag(true);
					return result;
				}
				
				result.setFlag(false);
				result.setMessage("用户名密码错误");
				return result;
			} catch (Exception e) {
				e.printStackTrace();
				result.setFlag(false);
				result.setMessage(e.getMessage());
				return result;
			}
	}
	
	/**同步调教
	 * 用户登录验证
	 * @param loginacct
	 * @param userpswd
	 * @param userType
	 * @param session
	 * @return
	 */
	/*@RequestMapping(value="/dologin",method=RequestMethod.POST)
	public String login(@RequestParam("loginacct")String loginacct,
			@RequestParam("userpswd")String userpswd,
			@RequestParam("userType")String userType ,HttpSession session) {
		
			Map<String , String> params = new HashMap<>();
			params.put("loginacct", loginacct);
			params.put("userpswd", userpswd);
			User user = userService.doLogin(params);
			session.setAttribute(Constant.LOGINUSER, user);
		return "main";
	}*/
	/**
	 * 用户注册功能
	 * @param user
	 * @return
	 */
	@RequestMapping(value="/doReg",method=RequestMethod.POST)
	public String register(@Valid User user,BindingResult bindingResult ,HttpSession session) {
		
		List<ObjectError> allErrors = bindingResult.getAllErrors();
		List<FieldError> fieldErrors = bindingResult.getFieldErrors();
		Map<String, Object> mapss = new HashMap<>();
		
		for (FieldError fieldError : fieldErrors) {
			String defaultMessage = fieldError.getDefaultMessage();
			mapss.put(fieldError.getField(), fieldError.getDefaultMessage());
			
		}
		System.out.println(mapss);
		
			boolean flag = userService.register(user);
			if(flag) {
				
				System.out.println("注册成功");
				session.setAttribute(Constant.LOGINUSER, user);
				return "main";
			}
			
		
			return "login";
	}
	
	/**同步请求
	 *分页查询
	 */
	@RequestMapping("/index")
	public String userPageByCondtion(@RequestParam(value="pageno",required=false,defaultValue="1") Integer pageno,
			@RequestParam(value="pagesize",required=false,defaultValue="5") Integer pagesize,Map<String,Object> map){
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("pageno", pageno);
		paramMap.put("pagesize", pagesize);
		
		Page<User> page = userService.queryUserPage(paramMap);
		
		map.put("page", page);
		
		
		return "user/index";
	}
	
	/*
	 * 
	 */
	@RequestMapping("/index1")
	public String index2() {
		return "user/index2";
	}

		
	/**分页查询
	 * 異步請求
	 */
	@ResponseBody
	@RequestMapping(value="/index2")
	public Object userpagebycondition(@RequestParam(value="pageno",required=false,defaultValue="1") Integer pageno,
			@RequestParam(value="pagesize",required=false,defaultValue="5") Integer pagesize,
			@RequestParam(value="condition",required=false,defaultValue="") String condition) {
		ResultMessage resultMessage = new ResultMessage();
		try {
			if(condition.contains("%")) {
				condition = condition.replaceAll("%", "\\\\%");
			}
			Map<String,Object> paramMap = new HashMap<>();
			paramMap.put("pageno", pageno);
			paramMap.put("pagesize", pagesize);
			paramMap.put("condition", condition);
			
			Page<User> page = userService.queryUserPage(paramMap);
			resultMessage.setFlag(true);
			resultMessage.setPage(page);
			return resultMessage;
		} catch (Exception e) {
			resultMessage.setMessage(e.getMessage());
			resultMessage.setFlag(false);
			e.printStackTrace();
			return resultMessage;
		}
		
		
	}
	/**
	 * 用户注销
	 */
	@RequestMapping("/loginout")
	public String dologinout(HttpSession session) {
		User user = (User) session.getAttribute(Constant.LOGINUSER);
		
		if(user==null) {
			return "login";
			
		}
		session.removeAttribute(Constant.LOGINUSER);
		session.invalidate();
		
		return "login";
	}
	
	/**
	 * 前往管理员添加用户页面
	 */
	@RequestMapping("/tosaveUser")
	public String tosaveUser() {
		return "user/add";
	}
	
	/**
	 * 管理员 添加用户  
	 */
	@ResponseBody
	@RequestMapping(value="/saveUser",method=RequestMethod.POST)
	public Object saveUser(User user) {
		ResultMessage resultMessage  = new ResultMessage();
		try {
			int result = userService.saveUser(user);
			if(result>0) {
				resultMessage.setFlag(true);
				resultMessage.setMessage("用户添加成功");
				return resultMessage;
			}else{
				resultMessage.setFlag(false);
				resultMessage.setMessage("未添加成功");
				return resultMessage;
			}
		} catch (Exception e) {
			resultMessage.setFlag(false);
			resultMessage.setMessage(e.getMessage());
			e.printStackTrace();
			return resultMessage;
		}
		
	}
	/**
	 * 删除单个用户
	 * @return
	 */
	@ResponseBody
    @RequestMapping(value="/deleteUser",method=RequestMethod.POST)
	public Object deleteUser(Integer id) {
		 ResultMessage resultMessage = new ResultMessage();
		 
		 try {
			int result = userService.deleteUserById(id);
			if(result>0) {
				resultMessage.setFlag(true);
				return resultMessage;
			}else {
				resultMessage.setFlag(false);
				resultMessage.setMessage("删除失败");
				return resultMessage;
			}
		} catch (Exception e) {
			resultMessage.setFlag(false);
			resultMessage.setMessage(e.getMessage());
			e.printStackTrace();
			return resultMessage;
		}
		
	}
	
	/**
	 * 删除用户
	 * @return
	 */
	@ResponseBody
    @RequestMapping(value="/deleteAllUser")
	public Object deleteUserAll(Integer[] id) {
		 ResultMessage resultMessage = new ResultMessage();
		 
		 try {
			int result = userService.deleteUserByIdArray(id);
			if(result>0) {
				resultMessage.setFlag(true);
				resultMessage.setMessage("删除成功");
				return resultMessage;
			}else {
				resultMessage.setFlag(false);
				resultMessage.setMessage("删除失败");
				return resultMessage;
			}
		} catch (Exception e) {
			resultMessage.setFlag(false);
			resultMessage.setMessage(e.getMessage());
			e.printStackTrace();
			return resultMessage;
		}
		
	}
	
	/*
	 * 修改用户信息
	 */
	@RequestMapping("/toupdateUser")
	public String getUserById(Integer id,Model model) {
		User user = userService.queryUserById(id);
		model.addAttribute("user", user);
		return "user/edituser";
	}
	
	/* @RequestMapping("/toupdateUser")
		public String toupdateUser() {
			return "user/edituser";
		}
	 */
	 @ResponseBody
	 @RequestMapping(value="/updateUser",method=RequestMethod.POST)
	 public Object updateUser(User user) {
		 ResultMessage resultMessage = new ResultMessage();
		 try {
			
			int count = userService.updateUser(user);
			 
			 if(count >0) {
				 resultMessage.setFlag(true);
				 resultMessage.setMessage("修改成功");
				 return resultMessage;
			 }
			 resultMessage.setFlag(false);
			 resultMessage.setMessage("修改失败");
			 return resultMessage;
		} catch (Exception e) {
			resultMessage.setFlag(false);
			resultMessage.setMessage(e.getMessage());
			e.printStackTrace();
			return resultMessage;
		}
		
	 }
	 
	 
	 
	 
}

