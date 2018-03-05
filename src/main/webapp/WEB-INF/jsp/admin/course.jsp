<%--
  Created by IntelliJ IDEA.
  User: Ming
  Date: 2018/3/2
  Time: 14:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="/WEB-INF/jsp/common/head.jsp"%>
    <title>课程管理页面</title>
    <style>
        tr{
            height: 50px;
        }
    </style>
</head>

<body>
<!--表单弹出层-->
<div id="win" class="easyui-window" title="课程" style="width:600px;height:460px"
     data-options="iconCls:'icon-edit',modal:true,closed:true">
    <div align="center" style="padding-top: 20px">
        <form id = "editForm"  method = "post" enctype="multipart/form-data">
            <table >
                <!--提交修改的时候要传入-->
                <input type="hidden" name = "courseId" id = "courseId">
                <tr >
                    <td>课程名称：</td><td>
                    <input  data-options="required:true,validType:'length[0,20]'" class="easyui-validatebox" type ="text" name ="courseName" />
                </td>
                </tr>
                <tr >
                    <td>专业：</td>
                    <td>
                        <input id="cc"   class="easyui-combobox"  name="majorId"
                               data-options="editable:false,required:true,valueField:'majorId',textField:'majorName',url:'major/majorList'" />
                    </td>
                </tr>
                <tr >
                    <td>备注：</td><td><textarea name="courseComment" style="width: 220px;height:100px"></textarea></td>
                </tr>
                <tr class="mTr">
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
    <a id = "addBtn" href="javascript:void(0);" class="easyui-linkbutton" data-options="text:'添加',iconCls:'icon-add',plain:true"> </a>
    <a id = "updateBtn" href="javascript:void(0);" class="easyui-linkbutton" data-options="text:'修改课程',iconCls:'icon-edit',plain:true"> </a>
    <a id = "removeBtn" href="javascript:void(0);" class="easyui-linkbutton" data-options="text:'移除课程',iconCls:'icon-remove',plain:true"> </a>
</div>
<!--课程表格-->
<table id="dg"></table>
</body>
<script type="text/javascript">
    $(function () {

        $('#dg').datagrid({
            url:'course/courseList',
            columns:[[
                {field:'courseId',title:'课程号',width:100,align:'center'},
                {field:'courseName',title:'课程名',width:100,align:'center'},
                {field:'major',title:'归属专业',width:100,align:'center',formatter: function(value,row,index){
                    return value.majorName;
                }    },
                {field:'courseComment',title:'备注',width:100,align:'center'},
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

        //添加课程按钮 显示编辑课程窗口
        $("#addBtn").click(function () {
            $("#editForm").form("clear");
            //hidden的属性全部要清空才能add一个全新的
            $("#courseId").val("");

            $("#win").window("open");
        });

        //更新课程按钮 显示编辑课程窗口
        $("#updateBtn").click(function () {

            var course = $('#dg').datagrid('getSelected');
            if(!course){
                $.messager.alert('错误提醒','请选择一个课程！','info');
                return false;
            }

            $("#editForm").form("load","course/courseById?courseId="+course.courseId);
            $("#win").window("open");
        });


        //点击弹框确认
        $("#submitBtn").click(function () {
            $('#editForm').form('submit', {
                url:"course/addOrUpdate",
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

        //删除课程
        $('#removeBtn').bind('click', function(){
            var course = $('#dg').datagrid('getSelected');
            if(!course){
                $.messager.alert('错误提醒','请选择一个课程！','info');
                return false;
            }
            $.messager.confirm('确认','您确认想删除该课程吗？',function(r){
                if (r){
                    $.post('course/remove',{"courseId":course.courseId},function (data) {
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