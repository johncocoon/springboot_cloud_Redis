package com.atguigu.atcrowdfunding.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.atguigu.atcrowdfunding.bean.Advert;
import com.atguigu.atcrowdfunding.bean.Page;
import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.common.util.BaseController;
import com.atguigu.atcrowdfunding.common.util.Constant;
import com.atguigu.atcrowdfunding.manager.service.AdvertService;

@Controller
public class AdvertController extends BaseController{
		
	@Autowired
	private AdvertService advertService;
	
	@RequestMapping("/advert/index")
	public String toindex() {
		return "advertisement/index2";
	}
	
	@RequestMapping("/advert/add")
	public String toadd() {
		return "advertisement/add";
	}
	
	@ResponseBody
	@RequestMapping(value="/advert/toindex")
	public Object index(@RequestParam(value="pageno",required=false,defaultValue="1")Integer pageno,
			@RequestParam(value="pagesize",required=false,defaultValue="3")Integer pagesize,
			@RequestParam(value="pagetext",required=false,defaultValue="")String pagetext) {
			
		Map<String,Object> params = new HashMap<>();
		params.put("pageno", pageno);
		params.put("pagesize", pagesize);
		params.put("startindex", (pageno-1)*pagesize);
		params.put("name", pagetext);
		Page<Advert> page= advertService.queryAllAdvert(params);
		
		start();
		try {
			Page(page);
			flag(true);
		} catch (Exception e) {
			message(e.getMessage());
			flag(false);
			e.printStackTrace();
		}
	
		
		return end();
	}
	
	
	@ResponseBody
	@RequestMapping(value="/advert/delete",method=RequestMethod.POST)
	public Object delete(Integer[] ids) {
		start();
		try {
			Integer count = advertService.deleteByUseridAndIds(ids);
			if(count<=0) {
				flag(false);
				return end();
			}
			
			flag(true);
			return end();
		} catch (Exception e) {
			message(e.getMessage());
			flag(false);
			e.printStackTrace();
			return end();
		}
		
	}
	
	
	
	
	
	/**
	 * 添加广告
	 * @param mfile
	 * @param advert
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/advert/add",method=RequestMethod.POST)
	public Object addAdvert(MultipartFile mfile ,Advert advert,HttpSession session) {
		String suffer = mfile.getOriginalFilename();
		String realPath = session.getServletContext().getRealPath("/upload");
		String path = realPath+"\\"+UUID.randomUUID().toString()+"."+suffer;
		System.out.println(realPath);
		System.out.println(suffer);
		start();
		try {
			mfile.transferTo(new File(path));
			System.out.println(advert);
			advert.setStatus("1");
			advert.setUserid(((User)session.getAttribute(Constant.LOGINUSER)).getId());
			advert.setUrl(path);
			
			advertService.saveAdvert(advert);
			flag(true);
		} catch (Exception e) {
			message(e.getMessage());
			flag(false);
			e.printStackTrace();
		}
	
		
		return end();
	}
	
	
	
}
