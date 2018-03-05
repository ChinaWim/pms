package com.pms.web;

import com.pms.dao.MultiTableMapper;
import com.pms.dao.StudentMapper;
import com.pms.dao.TeacherMapper;
import com.pms.dto.JsonResult;
import com.pms.dto.StuAndTestAndCourseAndMajor;
import com.pms.dto.User;
import com.pms.pojo.Course;
import com.pms.pojo.Question;
import com.pms.pojo.Student;
import com.pms.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by Ming on 2018/2/28.
 */
@Controller
@RequestMapping("/test")
public class TestController {

    @Autowired
    private QuestionService questionService;

    @Autowired
    private CourseService courseService;

    @Autowired
    private StudentService studentService;

    @Autowired
    private TestService testService;

    @Autowired
    private MultiTableMapper multiTableMapper;

    @Autowired
    private TeacherService teacherService;


    //跳转到testPage
    @RequestMapping("/student/testPage")
    public String testPage(HttpSession session,Model model){

        User user = (User)session.getAttribute("user");
        Student student = studentService.findAllById(user.getUid());
        //1 代表已经测试了
        if(student.getTestFlag() == 1) {
            model.addAttribute("msg","你已经测试完所有课程，请查看成绩和测试报告!");
            return "forward:/500.jsp";
        }
        List<Course> courseList = courseService.findAllByMajorId(student.getMajorId());
        model.addAttribute("courseList",courseList);
        return "/student/test";

    }

    @RequestMapping(value = "/student/showQuestion",method = RequestMethod.POST)
    @ResponseBody
    public List<Question> showQuestion(Integer courseId,HttpSession session){
        List<Question> questionList = null;
        if(courseId != null) {
            questionList = questionService.getRandomList(courseId);
            session.setAttribute("questionList",questionList);
            session.setAttribute("questionCourse",courseService.findAllById(courseId));
        }
        return questionList;
    }

    @RequestMapping("/student/submitQuestion")
    @ResponseBody
    public JsonResult submitQuestion(String replay,HttpSession session){
        User user = (User) session.getAttribute("user");
        return  testService.importReplay(replay,studentService.findAllById(user.getUid()));
    }


    //显示学生分数页面
    @RequestMapping("/student/scorePage")
    public String studentScorePage(){
        return "student/score";
    }

    @RequestMapping("/student/showScore")
    @ResponseBody
    public List<StuAndTestAndCourseAndMajor> showScore(HttpSession session){
        User user = (User) session.getAttribute("user");
        return multiTableMapper.findTestByStuId(user.getUid());
    }

    //老师查看 所教课程分数页面
    @RequestMapping("/teacher/scorePage")
    public String teacherScorePage(){
        return "teacher/score";
    }

    @RequestMapping("/teacher/showScore")
    @ResponseBody
    public List<StuAndTestAndCourseAndMajor> showAllStudentScore(HttpSession session){
        User user = (User) session.getAttribute("user");
        return multiTableMapper.findTestByCourseId(teacherService.findAllById(user.getUid()).getCourseId());
    }





    //显示学生报告页面 //显示出学生top3的课程
    @RequestMapping("student/reportPage")
    public String reportPage(HttpSession session,Model model){
        User user = (User) session.getAttribute("user");
        testService.findTop3Info(user.getUid(),model);
        return "student/report";
    }

}

