<%--
  Created by IntelliJ IDEA.
  User: Ming
  Date: 2018/3/1
  Time: 19:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="/WEB-INF/jsp/common/head.jsp"%>
    <title>测试报告</title>
</head>
<body>

<div class="panel panel-info">
    <!-- Default panel contents -->
    <div class="panel-heading">你的TOP3成绩</div>
    <!-- Table -->
    <table class="table table-striped table-bordered">
        <tr>
            <th>课程名</th>
            <th>分数</th>
            <th>测试日期</th>
        </tr>
        <c:forEach var="stuAndTestAndCourse" items="${to3List}" >
            <tr>
                <td>
                        ${stuAndTestAndCourse.courseName}
                </td>
                <td>
                        ${stuAndTestAndCourse.testScore}
                </td>
                <td>
                        ${stuAndTestAndCourse.testDate}
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
<div class="panel panel-success">
    <!-- Default panel contents -->
    <div class="panel-heading">推荐的老师</div>
    <!-- Table -->
    <table class="table table-striped table-bordered">
        <tr>
            <th>老师号</th>
            <th>老师名</th>
            <th>课程名称</th>
            <th>课题名称</th>
            <th>课题简介</th>
            <th>课题建议</th>
        </tr>
        <c:forEach var="project" items="${projectList}" >
            <tr>
                <td>
                        ${project.teacher.teacherId}
                </td>
                <td>
                        ${project.teacher.teacherName}
                </td>
                <td>
                        ${project.courseName}
                </td>
                <td>
                        ${project.projectName}
                </td>
                <td>
                        ${project.info}
                </td>
                <td>
                        ${project.suggest}
                </td>
            </tr>
        </c:forEach>
    </table>
</div>

</body>
</html>
