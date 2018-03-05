package com.pms.utils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

/**
 * Created by Ming on 2018/2/26.
 */
@WebServlet(name = "ImageServlet",value = "/codeImage")
public class ImageServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        //生成一张随机验证码图片，并写出到浏览器
        OutputStream out = response.getOutputStream();
        String code = ValidateCodeUtils.genNewCode(out);
        //把sCode共享给用户登录时使用
        session.setAttribute("code", code);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }
}
