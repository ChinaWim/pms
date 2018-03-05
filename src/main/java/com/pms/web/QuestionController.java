package com.pms.web;

import com.pms.dto.JsonResult;
import com.pms.pojo.Question;
import com.pms.service.QuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * Created by Ming on 2018/3/3.
 */
@Controller
@RequestMapping("/question")
public class QuestionController {
    @Autowired
    private QuestionService questionService;


    //暴露问题 数据
    @RequestMapping("/questionList")
    @ResponseBody
    public List<Question> questionList(){
        return questionService.findAll();
    }

    @RequestMapping("/queById")
    @ResponseBody
    public Question queById(Integer queId){
        return questionService.findById(queId);
    }


    //删除问题
    @RequestMapping(value = "/remove",method = RequestMethod.POST)
    @ResponseBody
    public JsonResult remove(Integer queId){
        return questionService.deleteById(queId);
    }

    //删除问题
    @RequestMapping(value = "/addOrUpdate",method = RequestMethod.POST)
    @ResponseBody
    public JsonResult addOrUpdate(Question question){
        if(question.getQueId() == null){ //add
            return questionService.add(question);
        }else{
            return questionService.update(question);
        }

    }
}
