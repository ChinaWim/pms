package com.pms.utils;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;

/**@author Ming
 * Created on 2018/2/10.
 */

public class FileUtil {
    /**
     *
     * @param multipartFile 上传的文件
     * @param saveDir  在upload文件夹下面的哪个文件夹
     * @param request
     * @return 返回一个文件路径 如果null则上传失败
     */
    public static String upload(MultipartFile multipartFile,String saveDir, HttpServletRequest request){
/*            if(multipartFile.getContentType().startsWith("image/"))
                return null;*/
        String filename = multipartFile.getOriginalFilename();
        String type = filename.substring(filename.lastIndexOf("."));
        String newFilename = UUIDUtil.getUUIDByTime()+type;
        String path = request.getServletContext().getRealPath("/upload/"+saveDir)+"/"+newFilename;
        try{
            FileCopyUtils.copy(multipartFile.getInputStream(), new FileOutputStream(path));
            return "upload/"+saveDir+"/"+newFilename;
        }catch (IOException e){
            e.printStackTrace();
            return null;
        }

    }

    /**
     *
     * @param path 相对webapp目录下的路径
     * @param request
     * @param response
     * @throws Exception
     */
    public static void downloadFile(String path,HttpServletRequest request,HttpServletResponse response)throws  Exception{
        String realPath = request.getServletContext().getRealPath("/"+path);
        File file = new File(realPath);
        FileInputStream fileInputStream = new FileInputStream(file);
        response.setHeader("content-disposition","attachment;filename="+file.getName());
        OutputStream outputStream = response.getOutputStream();
        byte [] buff = new byte[1024];
        int length = 0;
        while((length = fileInputStream.read(buff)) != -1){
            outputStream.write(buff,0,length);
            outputStream.flush();
        }
        fileInputStream.close();
        outputStream.close();

    }

}
