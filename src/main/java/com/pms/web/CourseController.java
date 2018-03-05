package com.pms.web;

import com.pms.dto.JsonResult;
import com.pms.pojo.Course;
import com.pms.service.CourseService;
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
@RequestMapping("/course")
public class CourseController {

    @Autowired
    private CourseService courseService;

    @RequestMapping("/courseList")
    @ResponseBody
    public List<Course> courseList(){
        return courseService.findAll();
    }

    @RequestMapping("/courseById")
    @ResponseBody
    public Course courseById(Integer courseId){
        return courseService.findAllById(courseId);
    }


    @RequestMapping(value = "/remove",method = RequestMethod.POST)
    @ResponseBody
    public JsonResult remove(Integer courseId){
        return courseService.deleteById(courseId);
    }

    @RequestMapping(value = "/addOrUpdate",method = RequestMethod.POST)
    @ResponseBody
    public JsonResult addOrUpdate(Course course){
        if(course.getCourseId() == null) {
            return courseService.add(course);
        }else{
            return courseService.update(course);
        }
    }

}
