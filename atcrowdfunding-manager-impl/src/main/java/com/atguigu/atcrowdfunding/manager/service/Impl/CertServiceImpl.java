package com.atguigu.atcrowdfunding.manager.service.Impl;

import com.atguigu.atcrowdfunding.bean.Cert;
import com.atguigu.atcrowdfunding.bean.Page;
import com.atguigu.atcrowdfunding.manager.mapper.CertMapper;
import com.atguigu.atcrowdfunding.manager.service.CertService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by John on 2018/3/8.
 */
@Service
public class CertServiceImpl implements CertService {
    @Autowired
    private CertMapper certMapper;

    @Override
    public Page<Cert> selectAll(Map params) {
        Page<Cert> page = new Page<>();
        Integer pagesize = (Integer) params.get("pagesize");
        Integer pageno = (Integer) params.get("pageno");
        page.setPageno(pageno);
        page.setPagesize(pagesize);
        int startindex = page.getStartindex();
        params.put("startindex",startindex);
        //查询集合
        List<Cert> list = certMapper.selectAll(params);
        //查询个数
        int count = certMapper.getCountByName(params);
        page.setDatas(list);
        page.setTotalsize(count);

        int totalno = count%pagesize ==0? (count/pagesize):(count/pagesize+1);
        page.setTotalno(totalno);
        return page;
    }
}
