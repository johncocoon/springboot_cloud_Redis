package com.atguigu.atcrowdfunding.manager.service;

import java.util.Map;

import com.atguigu.atcrowdfunding.bean.Advert;
import com.atguigu.atcrowdfunding.bean.Page;

public interface AdvertService {

	public void saveAdvert(Advert advert);

	public Page<Advert> queryAllAdvert(Map<String, Object> params);

	public Integer deleteByUseridAndIds(Integer[] ids);

}
