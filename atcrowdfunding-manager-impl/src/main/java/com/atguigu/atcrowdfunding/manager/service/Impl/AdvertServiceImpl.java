package com.atguigu.atcrowdfunding.manager.service.Impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.atcrowdfunding.bean.Advert;
import com.atguigu.atcrowdfunding.bean.Page;
import com.atguigu.atcrowdfunding.manager.mapper.AdvertMapper;
import com.atguigu.atcrowdfunding.manager.service.AdvertService;

@Service
public class AdvertServiceImpl implements AdvertService {
		
	
	@Autowired
	private AdvertMapper advertMapper;
	
	@Override
	public void saveAdvert(Advert advert) {
		advertMapper.insert(advert);
	}

	@Override
	public Page<Advert> queryAllAdvert(Map<String, Object> params) {
		Page<Advert> page = new Page<>();
		
	
		Integer  pageno = (Integer) params.get("pageno");
		
		Integer  pagesize = (Integer) params.get("pagesize");
		List<Advert> list = advertMapper.selectAll(params);
		Integer count = advertMapper.selectCount(params);
		page.setDatas(list);
		page.setPageno(pageno);
		page.setPagesize(pagesize);
		page.setTotalno(count);
		Integer totalsize = count%pagesize==0?(count/pagesize):(count/pagesize+1);
		page.setTotalsize(totalsize);
		return page;
	}

	@Override
	public Integer deleteByUseridAndIds(Integer[] ids) {
		
		return advertMapper.deleteBatchByPrimaryKey(ids);
	}

}
