package com.atguigu.atcrowdfunding.controller;

import com.atguigu.atcrowdfunding.bean.Cert;
import com.atguigu.atcrowdfunding.bean.Page;
import com.atguigu.atcrowdfunding.common.util.BaseController;
import com.atguigu.atcrowdfunding.manager.service.CertService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by John on 2018/3/8.
 */
@Controller
@RequestMapping("/cert")
public class CertController extends BaseController {

    @Autowired
    private CertService certService;


    @RequestMapping("index")
    public String toindex() {
        return "cert/index";
    }


    @ResponseBody
    @RequestMapping("/loadcert")
    public Object loadcert(@RequestParam(value = "pageno", required = false) Integer pageno,
                           @RequestParam(value = "pagesize", required = false, defaultValue = "5") Integer pagesize,
                           @RequestParam(value = "name", required = false, defaultValue = "") String name) {

        Map<String, Object> params = new HashMap<>();
        params.put("pageno", pageno);
        params.put("pagesize", pagesize);
        params.put("name", name);

        start();

        try {

            Page<Cert> page = certService.selectAll(params);
            if (page.getDatas() == null) {
                flag(false);
                return end();
            }
            Page(page);
            flag(true);
            return end();
        } catch (Exception e) {
            e.printStackTrace();
            message(e.getMessage());
            return end();
        }
    }


}
