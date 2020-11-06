package com.tct.iids.web;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @Description
 * @Author zhaoke
 * @Date 2020/10/19 13:46
 */
@RestController
public class JenkinsWeb {

    @GetMapping("test")
    public String test(){
        return "hello jenkins!";
    }
}
