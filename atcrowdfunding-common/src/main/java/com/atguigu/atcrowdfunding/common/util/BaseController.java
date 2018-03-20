package com.atguigu.atcrowdfunding.common.util;

import com.atguigu.atcrowdfunding.bean.Page;

public class BaseController {
		
	//简化代码
	
	private ThreadLocal<ResultMessage> threadLocal = new ThreadLocal<>();
	
	
	public void start() {
		 ResultMessage resultMessage = new ResultMessage();
		 threadLocal.set(resultMessage);
	}
	public void flag(boolean flag) {
		threadLocal.get().setFlag(flag);
	}
	
	public void message(String flag) {
		threadLocal.get().setMessage(flag);
	}
	public void Page(Page page) {
		threadLocal.get().setPage(page);
	}
	
	public ResultMessage end() {
		return threadLocal.get();
	}
	
}
