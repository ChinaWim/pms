package com.pms.web;

import com.pms.dto.JsonResult;
import com.pms.pojo.College;
import com.pms.service.CollegeService;
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
@RequestMapping("/college")
public class CollegeController {


    @Autowired
    private CollegeService collegeService;


    @RequestMapping("/collegeList")
    @ResponseBody
    private List<College> collegeList(){
        return collegeService.finAll();
    }

    @RequestMapping(value = "/remove",method = RequestMethod.POST)
    @ResponseBody
    private JsonResult remove(Integer collegeId){
        return collegeService.deleteById(collegeId);
    }

    @RequestMapping(value = "/addOrUpdate",method = RequestMethod.POST)
    @ResponseBody
    private JsonResult addOrUpdate(College college){
        if(college.getCollegeId() == null){ //add
            return collegeService.add(college);
        }else {
            return collegeService.update(college);
        }
    }
    @RequestMapping("/collegeById")
    @ResponseBody
    private College collegeById(Integer collegeId){
        return collegeService.findById(collegeId);
    }



}
