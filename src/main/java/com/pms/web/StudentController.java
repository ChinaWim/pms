package com.pms.web;

import com.pms.dao.StudentMapper;
import com.pms.dto.JsonResult;
import com.pms.dto.User;
import com.pms.pojo.Paper;
import com.pms.pojo.Preselection;
import com.pms.pojo.Student;
import com.pms.pojo.Teacher;
import com.pms.service.PaperService;
import com.pms.service.PreselectionService;
import com.pms.service.StudentService;
import com.pms.service.TeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by Ming on 2018/3/1.
 */
@Controller
@RequestMapping("/student")
public class StudentController {

    @Autowired
    private StudentService studentService;

    @Autowired
    private TeacherService teacherService;

    @Autowired
    private PreselectionService preselectionService;

    @Autowired
    private PaperService paperService;

    //跳转到预选老师页面
    @RequestMapping("/teacherPage")
    public String teacherPage(){
        return "student/teacher";
    }

    //显示老师
    @RequestMapping("/showTeacher")
    @ResponseBody
    public List<Teacher> showTeacher(HttpSession session){
        User user = (User) session.getAttribute("user");
        return teacherService.findAllByMajorId(studentService.findAllById(user.getUid()).getMajorId());
    }


    //添加预选老师
    @RequestMapping("/addPreTeacher")
    @ResponseBody
    public JsonResult addPreTeacher(HttpSession session,Integer teacherId){
        User user = (User) session.getAttribute("user");
        return studentService.addPreTeacher(user.getUid(),teacherId);
    }

    //删除预选老师
    @RequestMapping("/removePreTeacher")
    @ResponseBody
    public JsonResult removePreTeacher(HttpSession session,Integer teacherId){
        User user = (User) session.getAttribute("user");
        return studentService.removePreTeacher(user.getUid(),teacherId);
    }


    //跳转到预选情况页面
    @RequestMapping("/preselectionPage")
    public String preselectionPage(){
        return "student/preselection";
    }

    //显示预选的情况
    @RequestMapping("/showPreselection")
    @ResponseBody
    public List<Preselection> showPreselection(HttpSession session){
        User user = (User) session.getAttribute("user");
        return preselectionService.findAllByStuId(user.getUid());
    }

    //确认选择该老师 设置预选表的flag true 老师limit 数量 -1
    @RequestMapping("/chooseTeacher")
    @ResponseBody
    public JsonResult chooseTeacher(Integer preId,Integer teacherId,HttpSession session){
        User user = (User) session.getAttribute("user");
        return   studentService.chooseTeacher(preId,teacherId,user.getUid());
    }

    //取消选择该老师 设置预选表的flag true 老师limit 数量 +1
    @RequestMapping("/cancelChooseTeacher")
    @ResponseBody
    public JsonResult cancelChooseTeacher(Integer preId,Integer teacherId){
        return   studentService.cancelChooseTeacher(preId,teacherId);
    }

    //跳转到论文管理页面
    @RequestMapping("/paperPage")
    public String paperPage(){
        return "student/paper";
    }

    //显示自己的论文
    @RequestMapping("/showPaper")
    @ResponseBody
    public List<Paper> showPaper(HttpSession session){
        User user = (User) session.getAttribute("user");
        return paperService.findPaperByStuId(user.getUid());
    }

    //提交自己的论文
    @RequestMapping("/submitPaper")
    @ResponseBody
    public JsonResult submitPaper(Paper paper, MultipartFile paperFile, HttpServletRequest request){
        return paperService.studentSubmitPaper(paper,paperFile,request);
    }


    //暴露学生所有的数据
    @RequestMapping("/studentList")
    @ResponseBody
    public  List<Student> studentList(){
        return studentService.findAll();
    }

    //remove
    @RequestMapping(value = "/remove",method = RequestMethod.POST)
    @ResponseBody
    public  JsonResult remove(Integer stuId){
        return studentService.deleteById(stuId);
    }

    //addOrUpdate
    @RequestMapping(value = "/addOrUpdate",method = RequestMethod.POST)
    @ResponseBody
    public  JsonResult addOrUpdate(Student student){
        if(student.getStuId() == null){//add
            return studentService.add(student);
        }else{
            return studentService.update(student);
        }
    }

    //studentById
    @RequestMapping(value = "/studentById")
    @ResponseBody
    public  Student studentById(Integer stuId){
        return studentService.findAllById(stuId);
    }


}
