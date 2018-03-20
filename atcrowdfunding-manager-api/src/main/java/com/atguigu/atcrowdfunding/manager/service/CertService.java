package com.atguigu.atcrowdfunding.manager.service;

import com.atguigu.atcrowdfunding.bean.Cert;
import com.atguigu.atcrowdfunding.bean.Page;

import java.util.List;
import java.util.Map;

/**
 * Created by John on 2018/3/8.
 */
public interface CertService  {

    Page<Cert> selectAll(Map params);
}
