package com.pms.web;

import com.pms.dao.PaperMapper;
import com.pms.dto.JsonResult;
import com.pms.pojo.Paper;
import com.pms.service.PaperService;
import com.pms.utils.FileUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;

/**
 * Created by Ming on 2018/3/2.
 */
@Controller
@RequestMapping("/paper")
public class PaperController {

    @Autowired
    private PaperService paperService;

    //下载学生的论文
    @RequestMapping("/downloadStudentPaper")
    public void downloadStudentPaper(Integer paperId, HttpServletRequest request,HttpServletResponse response) throws Exception {
        Paper paper = paperService.findAllById(paperId);
        FileUtil.downloadFile(paper.getStudentPath(),request,response);
    }
    //下载老师批改的论文
    @RequestMapping("/downloadTeacherPaper")
    public void downloadTeacherPaper(Integer paperId,HttpServletRequest request,HttpServletResponse response) throws Exception {
        Paper paper = paperService.findAllById(paperId);
        FileUtil.downloadFile(paper.getTeacherPath(),request,response);
    }


}
