<%--
  Created by IntelliJ IDEA.
  User: Ming
  Date: 2018/2/9
  Time: 22:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="/WEB-INF/jsp/common/head.jsp"%>
    <title>老师管理页面</title>
    <style>
    </style>
</head>

<body>

<!--操作表格-->
<div id="toolbar">

    <a id = "addBtn" href="javascript:void(0);" class="easyui-linkbutton" data-options="text:'预选该老师',iconCls:'icon-add',plain:true"> </a>
    <a id = "removeBtn" href="javascript:void(0);" class="easyui-linkbutton" data-options="text:'取消预选该老师',iconCls:'icon-remove',plain:true"> </a>
</div>
<!--老师表格-->
<table id="dg"></table>

</body>
<script type="text/javascript">
    $(function () {

        $('#dg').datagrid({
            url:'student/showTeacher',
            columns:[[
                {field:'teacherId',title:'老师ID',width:100,align:'center'},
                {field:'teacherName',title:'老师姓名',width:100,align:'center'},
                {field:'course',title:'所教课程',width:100,align:'center',formatter: function(value,row,index){
                    return value.courseName;
                }    },
                {field:'teacherSex',title:'性别',width:50,align:'center'},
                {field:'teacherEmail',title:'Email',width:100,align:'center'},
                {field:'limitCount',title:'老师还剩指导学生的名额',width:100,align:'center',formatter: function(value,row,index){
                    if(value == '0')
                        return '<font color="red">'+value+'<font>';
                    return '<font color="green">'+value+'<font>';
                }    },
                {field:'teacherComment',title:'备注',width:100,align:'center'},
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

        //点击预选老师按钮
        $('#addBtn').bind('click', function(){
            var teacher = $('#dg').datagrid('getSelected');
            if(!teacher){
                $.messager.alert('错误提醒','请选择一个老师！','info');
                return false;
            }
            $.messager.confirm('确认','您确认想预选该老师吗？',function(r){
                if (r){
                    $.post('student/addPreTeacher',{"teacherId":teacher.teacherId},function (data) {
                        $.messager.show({
                            title:'消息',
                            msg:data.message,
                            timeout:3000,
                            showType:'slide',
                            height:120,
                            width:200
                        });
                    });
                    $('#dg').datagrid('reload');//刷新表格
                }
            },"application/json;charset=utf-8");
        });

        //取消该老师选择
        $('#removeBtn').bind('click', function(){
            var teacher = $('#dg').datagrid('getSelected');
            if(!teacher){
                $.messager.alert('错误提醒','请选择一个老师！','info');
                return false;
            }
            $.messager.confirm('确认','您确认想取消预选该老师吗？',function(r){
                if (r){
                    $.post('student/removePreTeacher',{"teacherId":teacher.teacherId},function (data) {
                        $.messager.show({
                            title:'消息',
                            msg:data.message,
                            timeout:3000,
                            showType:'slide',
                            height:120,
                            width:200
                        });
                    });
                    $('#dg').datagrid('reload');//刷新表格
                }
            },"application/json;charset=utf-8");
        });

    });

</script>
</html>