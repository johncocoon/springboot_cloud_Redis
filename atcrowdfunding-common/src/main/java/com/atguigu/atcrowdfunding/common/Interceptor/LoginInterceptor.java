package com.atguigu.atcrowdfunding.common.Interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.common.util.Constant;
public class LoginInterceptor extends HandlerInterceptorAdapter {
			
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		User user = (User) request.getSession().getAttribute(Constant.LOGINUSER);
		if(user == null) {
			response.sendRedirect(request.getContextPath()+"/toLogin.htm");
			return true;
		}
		return true;
	}
}
