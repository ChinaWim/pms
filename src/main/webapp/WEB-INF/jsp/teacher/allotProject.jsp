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
    <title>分配学生页面</title>
    <style>
        tr{
            height: 50px;
        }
    </style>
</head>

<body>
<!--表单弹出层-->
<div id="win" class="easyui-window" title="分配学生" style="width:400px;height:300px"
     data-options="iconCls:'icon-edit',modal:true,closed:true">
    <div align="center" style="padding-top: 20px">
        <form id = "editForm"  method = "post" enctype="multipart/form-data">
            <table >
                <!--传入-->
                <input type="hidden" name="stuId" id = "stuId">
                <tr>
                    <td>选择课题:</td>
                    <td>
                        <input id="cc" class="easyui-combobox" name="projectId"
                               data-options="editable:false,required:true,valueField:'projectId',textField:'projectName',url:'project/showProjectByTeacherId?teacherId=${sessionScope.user.uid}'" />
                    </td>

                </tr>
                <tr >
                    <td>备注：</td>
                    <td>
                        <textarea name="paperComment" id = "paperComment" style="height: 100px;width: 220px">
                        </textarea>
                    </td>
                </tr>
                <tr >
                    <td>
                        <a id = "submitBtn" href="javascript:void(0);" class="easyui-linkbutton" data-options="text:'确定',iconCls:'icon-save',plain:true"/>
                        <a id = "resetBtn" href="javascript:void(0);" class="easyui-linkbutton" data-options="text:'重置',iconCls:'icon-save',plain:true"/>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>


<!--操作表格-->
<div id="toolbar">

    <a id = "addBtn" href="javascript:void(0);" class="easyui-linkbutton" data-options="text:'分配课题',iconCls:'icon-add',plain:true"> </a>
</div>
<!--分配情况表格-->
<table id="dg"></table>

</body>
<script type="text/javascript">
    $(function () {

        $('#dg').datagrid({
            url:'teacher/showChooseMeStudent',
            columns:[[
                {field:'stuNo',title:'学号',width:100,align:'center'},
                {field:'stuName',title:'学生姓名',width:50,align:'center'},
                {field:'stuSex',title:'姓别',width:50,align:'center'},
                {field:'major',title:'专业',width:100,align:'center',formatter: function(value,row,index){
                     return value.majorName;
                }    },
                {field:'stuEamil',title:'Eamil',width:100,align:'center'},
                {field:'stuComment',title:'备注',width:100,align:'center'},
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

        //重置按钮
        $("#resetBtn").click(function () {
            $("#editForm").form("reset");
        });

        //点击提交按钮
        $("#submitBtn").click(function () {
            var student = $('#dg').datagrid('getSelected');
            $("#stuId").val(student.stuId);
            $('#editForm').form('submit', {
                url:"teacher/addProjectToStudent",
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

        // 弹出表单提示框
        $('#addBtn').bind('click', function(){
            var student = $('#dg').datagrid('getSelected');
            if(!student){
                $.messager.alert('错误提醒','请选择一个学生！','info');
                return false;
            }
            $("#win").window("open");
        });
        

        

        
        
    });

</script>
</html>