package com.pms.web;

import com.pms.dto.JsonResult;
import com.pms.pojo.Major;
import com.pms.service.MajorService;
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
@RequestMapping("major")
public class MajorController {



    @Autowired
    private MajorService majorService;


    @RequestMapping("/majorList")
    @ResponseBody
    private List<Major> majorList(){
        return majorService.findAll();
    }

    @RequestMapping(value = "/remove",method = RequestMethod.POST)
    @ResponseBody
    private JsonResult remove(Integer majorId){
        return majorService.deleteById(majorId);
    }

    @RequestMapping(value = "/addOrUpdate",method = RequestMethod.POST)
    @ResponseBody
    private JsonResult addOrUpdate(Major major){
        if(major.getMajorId() == null){ //add
            return majorService.add(major);
        }else {
            return majorService.update(major);
        }
    }
    @RequestMapping("/majorById")
    @ResponseBody
    private Major majorById(Integer majorId){
        return majorService.findAllById(majorId);
    }

}
