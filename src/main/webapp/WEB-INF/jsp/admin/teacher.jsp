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
    <title>老师管理页面</title>
    <style>
        tr{
            height: 50px;
        }
    </style>
</head>

<body>
<!--表单弹出层-->
<div id="win" class="easyui-window" title="老师" style="width:600px;height:460px"
     data-options="iconCls:'icon-edit',modal:true,closed:true">
    <div align="center" style="padding-top: 20px">
        <form id = "editForm"  method = "post" enctype="multipart/form-data">
            <table >
                <!--提交修改的时候要传入-->
                <input type="hidden" name = "teacherId" id = "teacherId">
                <tr>
                    <td>教师号：</td><td>
                    <input  data-options="required:true,validType:'length[0,20]'" class="easyui-validatebox" type ="text" name ="teacherNo" />
                </td>
                <tr >
                    <td>教师姓名：</td><td>
                    <input  data-options="required:true,validType:'length[0,20]'" class="easyui-validatebox" type ="text" name ="teacherName" />
                </td>
                <tr>
                    <td>性别：</td>
                    <td>
                        <select name="teacherSex" id = "teacherSex" class="easyui-combobox easyui-validatebox"  data-options="required:true">
                        <option value="男">男</option>
                        <option value="女">女</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>密码：</td>
                    <td>
                        <input  data-options="required:true,validType:'length[0,20]'" class="easyui-validatebox" type ="text" name ="teacherPassword" />
                    </td>
                </tr>
                <tr>
                    <td>邮箱：</td>
                    <td>
                        <input  data-options="validType:'length[0,20]'" class="easyui-validatebox" type ="text" name ="teacherEmail" />
                    </td>
                </tr>
                <tr >
                    <td>课程：</td>
                    <td>
                        <input id="cc"   class="easyui-combobox"  name="courseId"
                               data-options="editable:false,required:true,valueField:'courseId',textField:'courseName',url:'course/courseList'" />
                    </td>
                </tr>
                <tr >
                    <td>指导学生名额：</td>
                    <td>
                        <input  data-options="required:true,min:0,precision:0,max:1000" class="easyui-numberbox"  name ="limitCount" />
                    </td>
                </tr>
                <tr >
                    <td>备注：</td><td><textarea name="teacherComment" style="width: 220px;height:100px"></textarea></td>
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
    <a id = "updateBtn" href="javascript:void(0);" class="easyui-linkbutton" data-options="text:'修改老师',iconCls:'icon-edit',plain:true"> </a>
    <a id = "removeBtn" href="javascript:void(0);" class="easyui-linkbutton" data-options="text:'移除老师',iconCls:'icon-remove',plain:true"> </a>
</div>
<!--老师表格-->
<table id="dg"></table>
</body>
<script type="text/javascript">
    $(function () {

        $('#dg').datagrid({
            url:'teacher/teacherList',
            columns:[[
                {field:'teacherNo',title:'教师号',width:100,align:'center'},
                {field:'teacherName',title:'教师名',width:100,align:'center'},
                {field:'teacherSex',title:'性别',width:100,align:'center'},
                {field:'course',title:'课程',width:100,align:'center',formatter: function(value,row,index){
                    return value.courseName;
                }    },
                {field:'teacherEmail',title:'邮箱',width:100,align:'center'},
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
        //重置按钮
        $("#resetBtn").click(function () {
            $("#editForm").form("reset");
        });

        //添加老师按钮 显示编辑老师窗口
        $("#addBtn").click(function () {
            $("#editForm").form("clear");
            //hidden的属性全部要清空才能add一个全新的
            $("#teacherId").val("");

            $("#win").window("open");
        });

        //更新老师按钮 显示编辑老师窗口
        $("#updateBtn").click(function () {

            var teacher = $('#dg').datagrid('getSelected');
            if(!teacher){
                $.messager.alert('错误提醒','请选择一个老师！','info');
                return false;
            }

            $("#editForm").form("load","teacher/teacherById?teacherId="+teacher.teacherId);
            $("#win").window("open");
        });


        //点击弹框确认
        $("#submitBtn").click(function () {
            $('#editForm').form('submit', {
                url:"teacher/addOrUpdate",
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

        //删除老师
        $('#removeBtn').bind('click', function(){
            var teacher = $('#dg').datagrid('getSelected');
            if(!teacher){
                $.messager.alert('错误提醒','请选择一个老师！','info');
                return false;
            }
            $.messager.confirm('确认','您确认想删除该老师吗？',function(r){
                if (r){
                    $.post('teacher/remove',{"teacherId":teacher.teacherId},function (data) {
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