package com.pms.exception;

import com.pms.dto.JsonResult;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Ming on 2018/3/1.
 */
@ControllerAdvice
public class GlobalException {


    @ExceptionHandler(Exception.class)
    @ResponseBody
    public JsonResult globalException(Exception e, HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setAttribute("msg",e.getMessage());
        System.out.println(e.getMessage());

        return new JsonResult(false,"错误信息："+e.getMessage());
    }
}
