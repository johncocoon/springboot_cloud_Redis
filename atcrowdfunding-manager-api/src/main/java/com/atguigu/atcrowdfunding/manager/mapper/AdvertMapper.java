package com.atguigu.atcrowdfunding.manager.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.atguigu.atcrowdfunding.bean.Advert;

public interface AdvertMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Advert record);

    Advert selectByPrimaryKey(Integer id);

    List<Advert> selectAll(Map<String, Object> params);

    int updateByPrimaryKey(Advert record);

	Integer selectCount(Map<String, Object> params);

	Integer deleteBatchByPrimaryKey(@Param("ids") Integer[] ids);
}