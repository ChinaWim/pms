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
    <title>问题管理页面</title>
    <style>
        tr{
            height: 50px;
        }
    </style>
</head>

<body>
<!--表单弹出层-->
<div id="win" class="easyui-window" title="问题" style="width:600px;height:460px"
     data-options="iconCls:'icon-edit',modal:true,closed:true">
    <div align="center" style="padding-top: 20px">
        <form id = "editForm"  method = "post" enctype="multipart/form-data">
            <table >
                <!--提交修改的时候要传入-->
                <input type="hidden" name = "queId" id = "queId">
                <tr >
                    <td>问题：</td>
                    <td>
                        <textarea  data-options="required:true,validType:'length[0,500]'" class="easyui-validatebox" name="queName" style="width: 220px;height:100px"></textarea>
                    </td>
                </tr>
                <tr >
                    <td>A：</td><td><textarea data-options="required:true,validType:'length[0,500]'" class="easyui-validatebox" name="queA" style="width: 220px;height:100px"></textarea></td>
                </tr>
                <tr >
                    <td>B：</td><td><textarea data-options="required:true,validType:'length[0,500]'" class="easyui-validatebox" name="queB" style="width: 220px;height:100px"></textarea></td>
                </tr>
                <tr >
                    <td>C：</td><td><textarea data-options="required:true,validType:'length[0,500]'" class="easyui-validatebox" name="queC" style="width: 220px;height:100px"></textarea></td>
                </tr>
                <tr >
                    <td>D：</td><td><textarea data-options="required:true,validType:'length[0,500]'" class="easyui-validatebox" name="queD" style="width: 220px;height:100px"></textarea></td>
                </tr>

                <tr >
                    <td>答案:</td>
                    <td>
                        <select name="queAnswer" class="easyui-combobox easyui-validatebox" name="dept" data-options="required:true">
                            <option value="a" selected="selected">a</option>
                            <option value="b">b</option>
                            <option value="c">c</option>
                            <option value="d">d</option>
                        </select>
                    </td>
                </tr>

                <tr >
                    <td>所属课程：</td>
                    <td>
                        <input id="cc"   class="easyui-combobox"  name="courseId"
                               data-options="editable:false,required:true,valueField:'courseId',textField:'courseName',url:'course/courseList'" />
                    </td>
                </tr>
                <tr >
                    <td>分值:</td>
                    <td>
                        <input  data-options="required:true,min:0,precision:0" class="easyui-numberbox" type ="text" name ="queScore" />
                    </td>
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
    <a id = "updateBtn" href="javascript:void(0);" class="easyui-linkbutton" data-options="text:'修改问题',iconCls:'icon-edit',plain:true"> </a>
    <a id = "removeBtn" href="javascript:void(0);" class="easyui-linkbutton" data-options="text:'移除问题',iconCls:'icon-remove',plain:true"> </a>
</div>
<!--问题表格-->
<table id="dg"></table>
</body>
<script type="text/javascript">
    $(function () {

        $('#dg').datagrid({
            url:'question/questionList',
            columns:[[
                {field:'queId',title:'问题号',width:50,align:'center'},
                {field:'queName',title:'问题',width:100,align:'center'},
                {field:'queA',title:'A项',width:50,align:'center'},
                {field:'queB',title:'B项',width:50,align:'center'},
                {field:'queC',title:'C项',width:50,align:'center'},
                {field:'queD',title:'D项',width:50,align:'center'},
                {field:'queAnswer',title:'答案',width:50,align:'center'},
                {field:'queScore',title:'分值',width:50,align:'center'},
                {field:'course',title:'所属课程',width:100,align:'center',formatter: function(value,row,index){
                    return value.courseName;
                }    },
                {field:'queComment',title:'备注',width:50,align:'center'},
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

        //添加问题按钮 显示编辑问题窗口
        $("#addBtn").click(function () {
            $("#editForm").form("clear");
            //hidden的属性全部要清空才能add一个全新的
            $("#queId").val("");

            $("#win").window("open");
        });

        //更新问题按钮 显示编辑问题窗口
        $("#updateBtn").click(function () {

            var question = $('#dg').datagrid('getSelected');
            if(!question){
                $.messager.alert('错误提醒','请选择一个问题！','info');
                return false;
            }

            $("#editForm").form("load","question/queById?queId="+question.queId);
            $("#win").window("open");
        });


        //点击弹框确认
        $("#submitBtn").click(function () {
            $('#editForm').form('submit', {
                url:"question/addOrUpdate",
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

        //删除问题
        $('#removeBtn').bind('click', function(){
            var question = $('#dg').datagrid('getSelected');
            if(!question){
                $.messager.alert('错误提醒','请选择一个问题！','info');
                return false;
            }
            $.messager.confirm('确认','您确认想删除该问题吗？',function(r){
                if (r){
                    $.post('question/remove',{"queId":question.queId},function (data) {
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