<%--
  Created by IntelliJ IDEA.
  User: Ming
  Date: 2018/3/2
  Time: 23:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="/WEB-INF/jsp/common/head.jsp"%>
    <title>老师管理课题页面</title>
    <style>
        tr{
            height: 70px;
        }
    </style>
</head>

<body>

<!--表单弹出层-->
<div id="win" class="easyui-window" title="课题" style="width:600px;height:460px"
     data-options="iconCls:'icon-edit',modal:true,closed:true">
    <div align="center" style="padding-top: 20px">
        <form id = "editForm"  method = "post" enctype="multipart/form-data">
            <table >
                <input type="hidden" name = "projectId" id = "projectId">
                <input type="hidden" name = "teacherId" id = "teacherId">
                <input type="hidden" name = "courseId" id = "courseId">
                <input type="hidden" name = "courseName" id = "courseName">
                <tr>
                    <td>课题名称：</td>
                    <td>
                        <input type ="text" name ="projectName" data-options="required:true," class="easyui-validatebox" />
                    </td>
                </tr>
                <tr>
                    <td>课题简介：</td>
                    <td>
                        <textarea name = "info" class="easyui-validatebox" data-options="required:true," style="width: 220px;height: 80px" ></textarea>
                    </td>
                </tr>
                <tr>
                    <td>课题建议：</td>
                    <td>
                        <textarea name = "suggest" class="easyui-validatebox" data-options="required:true," style="width: 220px;height: 80px" ></textarea>
                    </td>
                </tr>
                <tr>
                    <td>备注：</td>
                    <td>
                        <textarea name = "projectComment" style="width: 220px;height: 80px" ></textarea>
                    </td>
                </tr>
                <tr>
                    <td>
                        <a id = "submitBtn" href="javascript:void(0);" class="easyui-linkbutton" data-options="text:'保存',iconCls:'icon-save',plain:true"/>
                        <a id = "resetBtn" href="javascript:void(0);" class="easyui-linkbutton" data-options="text:'重置',iconCls:'icon-save',plain:true"/>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>



<!--操作表格-->
<div id="toolbar">

    <a id = "addBtn" href="javascript:void(0);" class="easyui-linkbutton" data-options="text:'添加课题',iconCls:'icon-add',plain:true"> </a>
    <a id = "updateBtn" href="javascript:void(0);" class="easyui-linkbutton" data-options="text:'修改课题',iconCls:'icon-edit',plain:true"> </a>
    <a id = "removeBtn" href="javascript:void(0);" class="easyui-linkbutton" data-options="text:'移除课题',iconCls:'icon-remove',plain:true"> </a>
</div>
<!--课题表格-->
<table id="dg"></table>

</body>
<script type="text/javascript">
    $(function () {
        $('#dg').datagrid({
            url:'project/showProjectByTeacherId?teacherId='+${sessionScope.user.uid},
            columns:[[
                {field:'projectId',title:'课题ID',width:100,align:'center'},
                {field:'projectName',title:'课题名称',width:100,align:'center'},
                {field:'courseName',title:'课题所属课程',width:100,align:'center'},
                {field:'info',title:'课题简介',width:300,},
                {field:'suggest',title:'课题建议',width:300,},
                {field:'projectComment',title:'备注',width:100},
            ]],
            singleSelect:true,
            fitColumns:true,
            pageNumber:1,
            pageSize:15,
            pageList:[10,15,20,25,30],
            pagination:true,
            toolbar:'#toolbar',
            fit:true,
            nowrap:false//true 将数据显示在同一行
        });
        //启用过滤
        $('#dg').datagrid('enableFilter');
        //重置按钮
        $("#resetBtn").click(function () {
            $("#editForm").form("reset");
        });

        //点击添加课题按钮 显示编辑课题窗口
        $("#addBtn").click(function () {
            $("#editForm").form("clear");
            //hidden的属性全部要清空才能add一个全新的
            $("#projectId").val("");

            $("#win").window("open");
        });
        //点击修改课题按钮 显示编辑课题窗口
        $("#updateBtn").click(function () {
            var project = $('#dg').datagrid('getSelected');
            if(!project){
                $.messager.alert('错误提醒','请选择一个课题！','info');
                return false;
            }
            $("#editForm").form("load","project/projectById?projectId="+project.projectId);
            $("#win").window("open");
        });


        //点击弹框确认
        $("#submitBtn").click(function () {
            $('#editForm').form('submit', {
                url:"teacher/addOrUpdateProject",
                onSubmit: function(){
                    var isValid = $(this).form('validate'); //判断表单是否无效
                    return isValid;	// 返回false终止表单提交
                },
                success:function(data){
                    var data = eval('(' + data + ')');  // change the JSON string to javascript object
                    $.messager.show({
                        title:'消息',
                        msg:data.message,
                        timeout:3000,
                        showType:'slide',
                        height:120,
                        width:200
                    });
                    $('#dg').datagrid('reload');//刷新表格
                    $("#win").window("close");
                }
            });

        });

        //删除课题
        $('#removeBtn').bind('click', function(){
            var project = $('#dg').datagrid('getSelected');
            if(!project){
                $.messager.alert('错误提醒','请选择一个课题！','info');
                return false;
            }
            $.messager.confirm('确认','您确认想删除该课题吗？',function(r){
                if (r){
                    $.post('project/remove',{"projectId":project.projectId},function (data) {
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
            },'json');
        });

    });

</script>
</html>