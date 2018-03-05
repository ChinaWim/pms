package com.pms.web;

import com.pms.dao.ProjectMapper;
import com.pms.dto.JsonResult;
import com.pms.pojo.Project;
import com.pms.service.ProjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * Created by Ming on 2018/3/2.
 */
@Controller
@RequestMapping("/project")
public class ProjectController {

    @Autowired
    private ProjectService projectService;

    @RequestMapping("/projectById")
    @ResponseBody
    public Project projectById(Integer projectId){
        return projectService.findAllById(projectId);
    }


    //显示课题 By teacherId
    @RequestMapping("/showProjectByTeacherId")
    @ResponseBody
    public List<Project> showProjectByTeacherId(Integer teacherId){
        return projectService.findAllByTeacherId(teacherId);
    }


    //添加或更新
    @RequestMapping(value = "/addOrUpdate",method = RequestMethod.POST)
    @ResponseBody
    public JsonResult addProject(Project project){
        if(project.getProjectId() == null){//add
            return projectService.addProject(project);
        }else{//更新
            return projectService.updateProject(project);
        }
    }

    //删除
    @RequestMapping(value = "/remove",method = RequestMethod.POST)
    @ResponseBody
    public JsonResult remove(Integer projectId){
        return projectService.deleteProject(projectId);
    }

    //暴露课题数据
    @RequestMapping("projectList")
    @ResponseBody
    public List<Project> projectList(){
        return projectService.findAll();
    }

}
