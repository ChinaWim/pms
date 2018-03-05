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
    <title>学生预选情况管理页面</title>
    <style>
        tr{
            height: 50px;
        }
    </style>
</head>

<body>
<!--表单弹出层-->
<div id="win" class="easyui-window" title="答复学生" style="width:400px;height:300px"
     data-options="iconCls:'icon-edit',modal:true,closed:true">
    <div align="center" style="padding-top: 20px">
        <form id = "editForm"  method = "post" enctype="multipart/form-data">
            <table >
                <!--传入-->
                <input type="hidden" name = "preId" id = "preId">
                <tr >
                    <td>答复:</td>
                    <td>
                        <select name="prePassFlag" data-options="required:true">
                            <option value="1">同意</option>
                            <option value="-1">拒绝</option>
                        </select>
                    </td>

                </tr>
                <tr >
                    <td>拒绝理由：</td>
                    <td>
                        <textarea name="rejectReason" id = "rejectReason">
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

    <a id = "addBtn" href="javascript:void(0);" class="easyui-linkbutton" data-options="text:'答复学生',iconCls:'icon-add',plain:true"> </a>
    <%--<a id = "removeBtn" href="javascript:void(0);" class="easyui-linkbutton" data-options="text:'取消选择该老师',iconCls:'icon-remove',plain:true"> </a>--%>
</div>
<!--预选情况表格-->
<table id="dg"></table>

</body>
<script type="text/javascript">
    $(function () {

        $('#dg').datagrid({
            url:'teacher/showPreselection',
            columns:[[
                {field:'student',title:'学号/姓名',width:100,align:'center',formatter: function(value,row,index){
                    return value.stuNo+"/"+value.stuName;
                }    },
                {field:'prePassFlag',title:'我的许可',width:50,align:'center',formatter: function(value,row,index){
                    if(value == '0') return '<font color="blue">等待我回复<font>';
                    if(value == '1')  return '<font color="green">我已同意<font>';
                    if(value == '-1') return '<font color="red">我已拒绝<font>';
                }    },
                {field:'preFlag',title:'学生选择',width:100,align:'center',formatter: function(value,row,index){
                    if(value == '0') return '<font color="red">未选择<font>';
                    if(value == '1')  return '<font color="green">已选择我<font>';
                }    },
                {field:'rejectReason',title:'拒绝理由',width:100,align:'center'},
                {field:'preComment',title:'备注',width:100,align:'center'},
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

        //点击弹框的提交按钮
        $("#submitBtn").click(function () {
            var preselection = $('#dg').datagrid('getSelected');
            //设置preId
            $("#preId").val(preselection.preId);

            $('#editForm').form('submit', {
                url:"teacher/replay",
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

        //点击 回复学生按钮 弹出表单提示框
        $('#addBtn').bind('click', function(){
            var preselection = $('#dg').datagrid('getSelected');
            if(!preselection){
                $.messager.alert('错误提醒','请选择一个学生！','info');
                return false;
            }

            $("#win").window("open");
        });

    });

</script>
</html>