package com.pms.web;

import com.pms.dao.ProjectMapper;
import com.pms.dao.TeacherMapper;
import com.pms.dto.JsonResult;
import com.pms.dto.User;
import com.pms.pojo.*;
import com.pms.service.*;
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
 * Created by Ming on 2018/3/2.
 */
@Controller
@RequestMapping("/teacher")
public class TeacherController {


    @Autowired
    private TeacherService teacherService;

    @Autowired
    private PreselectionService preselectionService;

    @Autowired
    private CourseService courseService;

    @Autowired
    private ProjectService projectService;

    @Autowired
    private StudentService studentService;

    @Autowired
    private PaperService paperService;

    //学生预选页面
    @RequestMapping("/preselectionPage")
    public String preselectionPage(){
        return "/teacher/preselection";
    }

    @RequestMapping("/showPreselection")
    @ResponseBody
    public List<Preselection> showPreselection(HttpSession session){
        User user = (User) session.getAttribute("user");
        return preselectionService.findAllByTeacherId(user.getUid());
    }

    //回复学生
    @RequestMapping("/replay")
    @ResponseBody
    public JsonResult replay(Preselection preselection){
        return preselectionService.replayStudent(preselection);
    }

    //课题管理页面
    @RequestMapping("/projectPage")
    public String projectPage(){
        return "/teacher/project";
    }



    //分配课题页面
    @RequestMapping("/allotProjectPage")
    public String allotProjectPage(){
        return "/teacher/allotProject";
    }
    @RequestMapping("/showChooseMeStudent")
    @ResponseBody
    public List<Student> showAllotProject(HttpSession session){
        User user = (User) session.getAttribute("user");
        return studentService.findAllByChooseTeacherId(user.getUid());
    }

    //给学生添加一个课题 创建一个paper数据
    @RequestMapping("/addProjectToStudent")
    @ResponseBody
    public JsonResult addProjectToStudent(HttpSession session,Paper paper){
        User user = (User) session.getAttribute("user");
        paper.setTeacherId(user.getUid());
        Project project = projectService.findAllById(paper.getProjectId());
        if(project != null)
            paper.setProjectName(project.getProjectName());
        return paperService.add(paper);
    }



    //批改论文页面
    @RequestMapping("/paperPage")
    public String paperPage(){
        return "/teacher/paper";
    }

    //显示老师管理的的论文
    @RequestMapping("/showPaper")
    @ResponseBody
    public List<Paper> showPaper(HttpSession session){
        User user = (User) session.getAttribute("user");
        return paperService.findPaperByTeacherId(user.getUid());
    }


    //添加或更新课程
    @RequestMapping("/addOrUpdateProject")
    @ResponseBody
    public JsonResult addProject(Project project,HttpSession session){

        if(project.getProjectId() == null){//add
            User user = (User) session.getAttribute("user");
            Teacher teacher = teacherService.findAllById(user.getUid());
            Course course = courseService.findAllById(teacher.getCourseId());
            project.setTeacherId(user.getUid());
            project.setCourseId(teacher.getCourseId());
            project.setCourseName(course.getCourseName());

            return projectService.addProject(project);
        }else{//更新
            return projectService.updateProject(project);
        }
    }

    //提交老师的论文
    @RequestMapping("/submitPaper")
    @ResponseBody
    public JsonResult submitPaper(Paper paper, MultipartFile paperFile, HttpServletRequest request){
        return paperService.teacherSubmitPaper(paper,paperFile,request);
    }

    //暴露所有老师
    @RequestMapping("/teacherList")
    @ResponseBody
    public  List<Teacher> teacherList(){
        return teacherService.findAll();
    }

    @RequestMapping(value = "/addOrUpdate",method = RequestMethod.POST)
    @ResponseBody
    public  JsonResult addOrUpdate(Teacher teacher){
        if(teacher.getTeacherId() == null){
            return teacherService.add(teacher);
        }else {
            return teacherService.update(teacher);
        }
    }

    //remove老师
    @RequestMapping(value = "/remove",method = RequestMethod.POST)
    @ResponseBody
    public  JsonResult remove(Integer teacherId){
        return teacherService.deleteById(teacherId);
    }

    //teacherById
    @RequestMapping(value = "/teacherById")
    @ResponseBody
    public  Teacher teacherById(Integer teacherId){
        return teacherService.findAllById(teacherId);
    }



}
