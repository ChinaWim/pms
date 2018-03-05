package com.pms.web;

import com.pms.dto.JsonResult;
import com.pms.dto.User;
import com.pms.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Date;

/**
 * Created by Ming on 2018/2/26.
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping(value = "/index")
    public String index(){
        return "index";
    }

    //验证登陆
    @RequestMapping(value = "/login",method = RequestMethod.POST)
    public String login(User user, HttpSession session){
        Object o = userService.checkLogin(user);
        if( o instanceof String ){
            session.setAttribute("msg",(String)o);
            return "redirect:/login.jsp";
        }else{
            session.setAttribute("msg","");
            session.setAttribute("user",(User)o);
            return "redirect:/user/index";
        }
    }
    //退出登陆
    @RequestMapping("/logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "redirect:/login.jsp";
    }

    //更改密码页面
    @RequestMapping("/rePassword")
    public String rePassword(){
        return "rePassword";
    }


    //更改密码
    @RequestMapping(value = "/submitResetPwd",method = RequestMethod.POST)
    @ResponseBody
    public JsonResult submitRestPwd(HttpSession session,String password,String newPassword){
        User user = (User) session.getAttribute("user");
        return userService.updatePassword(user,password,newPassword);
    }

}
