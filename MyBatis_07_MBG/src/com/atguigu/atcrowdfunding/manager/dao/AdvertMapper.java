package com.atguigu.atcrowdfunding.manager.dao;

import com.atguigu.atcrowdfunding.bean.Advert;
import java.util.List;

public interface AdvertMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Advert record);

    Advert selectByPrimaryKey(Integer id);

    List<Advert> selectAll();

    int updateByPrimaryKey(Advert record);
}