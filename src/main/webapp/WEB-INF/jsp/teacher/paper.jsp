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
    <title>论文管理页面</title>
    <style>
        tr{
            height: 50px;
        }
    </style>
</head>

<body>
<!--表单弹出层-->
<div id="win" class="easyui-window" title="上传论文" style="width:400px;height:300px"
     data-options="iconCls:'icon-edit',modal:true,closed:true">
    <div align="center" style="padding-top: 20px">
        <form id = "editForm"  method = "post" enctype="multipart/form-data">
            <table >
                <!--提交修改的时候要传入-->
                <input type="hidden" name = "paperId" id = "paperId">
                <tr >
                    <td>选择论文</td>
                    <td>
                        <input class="easyui-filebox" data-options="required:true" name="paperFile" style="width:220px">
                    </td>

                </tr>
                <tr >
                    <td>备注：</td>
                    <td>
                        <textarea name="paperComment" id = "paperComment">
                        </textarea>
                    </td>
                </tr>
                <tr class="mTr">
                    <td>
                        <a id = "submitBtn" href="javascript:void(0);" class="easyui-linkbutton" data-options="text:'上传',iconCls:'icon-save',plain:true"/>
                        <a id = "resetBtn" href="javascript:void(0);" class="easyui-linkbutton" data-options="text:'重置',iconCls:'icon-save',plain:true"/>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>

<!--操作表格-->
<div id="toolbar">

    <a id = "addBtn" href="javascript:void(0);" class="easyui-linkbutton" data-options="text:'上传已批改论文',iconCls:'icon-add',plain:true"> </a>
    <a id = "downloadMyBtn" href="javascript:void(0);" class="easyui-linkbutton" data-options="text:'下载学生论文',iconCls:'icon-ok',plain:true"> </a>
    <a id = "downloadTBtn" href="javascript:void(0);" class="easyui-linkbutton" data-options="text:'下载已批改论文',iconCls:'icon-ok',plain:true"> </a>
</div>
<!--论文表格-->
<table id="dg"></table>

</body>
<script type="text/javascript">
    $(function () {

        $('#dg').datagrid({
            url:'teacher/showPaper',
            columns:[[
                {field:'paperId',title:'论文ID号',width:100,align:'center'},
                {field:'projectName',title:'课题名称',width:100,align:'center'},
                {field:'student',title:'学号/姓名',width:100,align:'center',formatter: function(value,row,index){
                    return value.stuNo+"/"+value.stuName;
                }    },
                {field:'paperFlag',title:'目前情况',width:50,align:'center',formatter: function(value,row,index){
                    if(value == '0') return '<font color="blue">我未批改<font>';
                    if(value == '1')  return '<font color="green">我已批改<font>';
                }    },
                {field:'studentUploadtime',title:'学生上传论文日期',width:100,align:'center'},
                {field:'teacherUploadtime',title:'我批改论文日期',width:100,align:'center'},
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
            var paper = $('#dg').datagrid('getSelected');
            //设置paperId
            $("#paperId").val(paper.paperId);

            $('#editForm').form('submit', {
                url:"teacher/submitPaper",
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


        //点击 确认上传论文按钮 弹出表单提示框
        $('#addBtn').bind('click', function(){
            var paper = $('#dg').datagrid('getSelected');
            if(!paper){
                $.messager.alert('错误提醒','请选择一个学生！','info');
                return false;
            }
            $("#win").window("open");
        });



        //下载学生的上传的论文
        $('#downloadMyBtn').bind('click', function(){
            var paper = $('#dg').datagrid('getSelected');
            if(!paper){
                $.messager.alert('错误提醒','请选择一个学生！','info');
                return false;
            }
            if(!paper.studentPath){
                $.messager.alert('错误提醒','该学生还未上传论文！','error');
                return false;
            }
            location.href = "paper/downloadStudentPaper?paperId="+paper.paperId;
//                $('#dg').datagrid('reload');//刷新表格
        });

        //下载老师我上传的论文
        $('#downloadTBtn').bind('click', function(){
            var paper = $('#dg').datagrid('getSelected');
            if(!paper){
                $.messager.alert('错误提醒','请选择一个学生！','info');
                return false;
            }
            if(paper.paperFlag == '0'){
                $.messager.alert('错误提醒','我还未批改！','error');
                return false;
            }
            location.href = "paper/downloadTeacherPaper?paperId="+paper.paperId;//todo
//                $('#dg').datagrid('reload');//刷新表格
        });

    });

</script>
</html>
