package com.atguigu.atcrowdfunding.common.util;

import java.util.List;

import com.atguigu.atcrowdfunding.bean.Page;


public class ResultMessage {
	private String message;
	private boolean flag;
	private Page page;
	private List list;
	
	private Object obj;
	public String getMessage() {
		return message;
	}
	public Page getPage() {
		return page;
	}
	public void setPage(Page page) {
		this.page = page;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public boolean isFlag() {
		return flag;
	}
	public void setFlag(boolean flag) {
		this.flag = flag;
	}
	public List getList() {
		return list;
	}
	public void setList(List list) {
		this.list = list;
	}
	@Override
	public String toString() {
		return "ResultMessage [message=" + message + ", flag=" + flag + ", page=" + page + ", list=" + list + "]";
	}
	public Object getObj() {
		return obj;
	}
	public void setObj(Object obj) {
		this.obj = obj;
	}

	
}

