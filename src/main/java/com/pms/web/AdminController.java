package com.pms.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Ming on 2018/3/3.
 */
@Controller
@RequestMapping("/admin")
public class AdminController {

    //跳转页面

    @RequestMapping("/studentPage")
    public String studentPage(){
        return "admin/student";
    }

    @RequestMapping("/teacherPage")
    public String teacherPage(){
        return "admin/teacher";
    }

    @RequestMapping("/collegePage")
    public String collegePage(){
        return "admin/college";
    }

    @RequestMapping("/majorPage")
    public String majorPage(){
        return "admin/major";
    }

    @RequestMapping("/coursePage")
    public String coursePage(){
        return "admin/course";
    }

    @RequestMapping("/projectPage")
    public String projectPage(){
        return "admin/project";
    }

    @RequestMapping("/questionPage")
    public String questionPage(){
        return "admin/question";
    }





}
