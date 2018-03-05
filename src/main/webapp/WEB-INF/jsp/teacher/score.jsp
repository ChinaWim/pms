<%--
  Created by IntelliJ IDEA.
  User: Ming
  Date: 2018/3/1
  Time: 17:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="/WEB-INF/jsp/common/head.jsp"%>
    <title>所有学生分数页面</title>
    <style>
    </style>
</head>

<body>
<!--分类表格-->
<table id="dg"></table>

</body>
<script type="text/javascript">
    $(function () {

        $('#dg').datagrid({
            url:'test/teacher/showScore',
            columns:[[
                {field:'testId',title:'测试ID',width:100,align:'center'},
                {field:'stuNo',title:'学号',width:100,align:'center'},
                {field:'stuName',title:'姓名',width:100,align:'center'},
                {field:'stuSex',title:'性别',width:100,align:'center'},
                {field:'stuEamil',title:'邮箱',width:100,align:'center'},
                {field:'majorName',title:'专业',width:100,align:'center'},
                {field:'courseName',title:'测试课程',width:100,align:'center'},
                {field:'testScore',title:'分数',width:100,align:'center',formatter: function(value,row,index){
                    return '<font color="red">'+value+'</font>';

                }   },
                {field:'testDate',title:'测试时间',width:100,align:'center'},
                {field:'testComment',title:'备注',width:100,align:'center'}
            ]],
            singleSelect:true,
            fitColumns:true,
            pageNumber:1,
            pageSize:15,
            pageList:[10,15,20,25,30],
            pagination:true,
            toolbar:'#toolbar',
            fit:true,
            nowrap:false

        });
        //启用过滤
        $('#dg').datagrid('enableFilter');



    });

</script>
</html>