package com.atguigu.atcrowdfunding.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.atguigu.atcrowdfunding.manager.service.UserService;

@Controller
public class DispatcherController {

	
	@Autowired
	private UserService userService;
	
	@RequestMapping("/toindex")
	public String toindex() {
		return "index";
	}
	@RequestMapping("/toLogin")
	public String toLogin() {
		return "login";
	}
	@RequestMapping("/tomian")
	public String tomian() {
		return "main";
	}
	@RequestMapping("/toReg")
	public String toReg() {
		return "reg";
	}
	
	
	
	
}
