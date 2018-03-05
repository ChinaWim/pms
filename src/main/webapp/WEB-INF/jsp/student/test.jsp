<%--
  Created by IntelliJ IDEA.
  User: Ming
  Date: 2018/2/28
  Time: 17:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="/WEB-INF/jsp/common/head.jsp"%>
    <title>测试</title>
</head>
<body>
<div style="padding: 10px 5px 5px 0px">
    <select class="form-control" style="width: 200px;" name="courseId" id="changeBtn">
        <option value="">选择题目</option>
        <c:forEach items="${courseList}" var="course">
        <option value="${course.courseId}">${course.courseName}</option>
        </c:forEach>
    </select>
</div>
<c:if test="${!empty sessionScope.questionList}">
    <hr>
    <h2 id="courseName"><mark>${sessionScope.questionCourse.courseName}</mark></h2>
    <form id="questionForm" method="post" >
        <c:forEach var="question" items="${questionList}" varStatus="state">
        <div class="panel panel-default">
            <div class="panel-heading">第${state.index + 1}题：${question.queName}
            </div>
            <div class="panel-body" style="padding: 10px" questionBodyItem>
                <input  selectItem  type="radio" name="${state.index}" value="${question.queId}-a">&nbsp;A：${question.queA}<br>
                <input  selectItem  type="radio" name="${state.index}" value="${question.queId}-b">&nbsp;B：${question.queB}<br>
                <input  selectItem  type="radio" name="${state.index}" value="${question.queId}-c">&nbsp;C：${question.queC}<br>
                <input  selectItem  type="radio" name="${state.index}" value="${question.queId}-d">&nbsp;D：${question.queD}<br>
            </div>
            </c:forEach>
        </div>
        <div>
            <button type="button" id="submitBtn" class="btn btn-info">提交</button>
            <button type="reset" id="resetBtn" class="btn btn-default">重做</button>
        </div>
    </form>
</c:if>
</body>
<script>
    //抽题按钮changeBtn

    $("#changeBtn").change(function () {
        var courseId = $(this).val();
        if(courseId != ""){
            $.post("test/student/showQuestion",{'courseId':courseId},function (data) {
                location.reload();
            });

        }


    });

    //点击弹框确认
    $("#submitBtn").click(function () {
        if (confirm("是否提交答卷?")){
            //提交答卷
            var replayCount = 0;
            var replayArray = new Array();
            $.each($("[selectItem]"), function(i, n){
                if(n.checked) {
                    replayCount++;
                    replayArray.push(n.value);
                }
            });
            if(replayCount != $("[questionBodyItem]").length){
                alert("你还有没未做完的！");
                return false;	// 返回false终止表单提交
            }
            var submitStr = replayArray.join("#");
            //异步提交
            $.post("test/student/submitQuestion",{'replay':submitStr},function (data) {
                $.messager.show({
                    title:'消息',
                    msg:data.message,
                    timeout:3000,
                    showType:'slide',
                    height:120,
                    width:200
                });
            });
        }


    });

</script>
</html>
