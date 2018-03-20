package com.atguigu.atcrowdfunding.bean;

import java.io.Serializable;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;

public class User implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = 7776701698201186869L;

	@Override
	public String toString() {
		return "User [id=" + id + ", loginacct=" + loginacct + ", userpswd=" + userpswd + ", username=" + username
				+ ", email=" + email + ", createtime=" + createtime + "]";
	}
    
	private Integer id;
	@NotEmpty(message="登录名不能为空")
    private String loginacct;
	@NotEmpty(message="密码不能为空")
	@Size(min=6,max=10)
    private String userpswd;
    private String username;
    
    private String email;
    
    private String createtime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getLoginacct() {
        return loginacct;
    }

    public void setLoginacct(String loginacct) {
        this.loginacct = loginacct == null ? null : loginacct.trim();
    }

    public String getUserpswd() {
        return userpswd;
    }

    public void setUserpswd(String userpswd) {
        this.userpswd = userpswd == null ? null : userpswd.trim();
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
    	this.createtime = createtime == null ? null : createtime.trim();
    	/*this.createtime = createtime;*/
    }
    
    
    
    
    
}