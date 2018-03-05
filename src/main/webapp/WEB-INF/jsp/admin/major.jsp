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
    <title>专业管理页面</title>
    <style>
        tr{
            height: 50px;
        }
    </style>
</head>

<body>
<!--表单弹出层-->
<div id="win" class="easyui-window" title="专业" style="width:600px;height:460px"
     data-options="iconCls:'icon-edit',modal:true,closed:true">
    <div align="center" style="padding-top: 20px">
        <form id = "editForm"  method = "post" enctype="multipart/form-data">
            <table >
                <!--提交修改的时候要传入-->
                <input type="hidden" name = "majorId" id = "majorId">
                <tr >
                    <td>专业名称：</td><td>
                    <input  data-options="required:true,validType:'length[0,20]'" class="easyui-validatebox" type ="text" name ="majorName" />
                </td>
                </tr>
                <tr >
                    <td>所属院系：</td>
                    <td>
                        <input id="cc"   class="easyui-combobox"  name="collegeId"
                               data-options="editable:false,required:true,valueField:'collegeId',textField:'collegeName',url:'college/collegeList'" />
                    </td>
                </tr>
                <tr >
                    <td>备注：</td><td><textarea name="majorComment" style="width: 220px;height:100px"></textarea></td>
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
    <a id = "updateBtn" href="javascript:void(0);" class="easyui-linkbutton" data-options="text:'修改专业',iconCls:'icon-edit',plain:true"> </a>
    <a id = "removeBtn" href="javascript:void(0);" class="easyui-linkbutton" data-options="text:'移除专业',iconCls:'icon-remove',plain:true"> </a>
</div>
<!--专业表格-->
<table id="dg"></table>
</body>
<script type="text/javascript">
    $(function () {

        $('#dg').datagrid({
            url:'major/majorList',
            columns:[[
                {field:'majorId',title:'专业号',width:100,align:'center'},
                {field:'majorName',title:'专业名',width:100,align:'center'},
                {field:'college',title:'所属院系',width:100,align:'center',formatter: function(value,row,index){
                    return value.collegeName;
                }    },
                {field:'majorComment',title:'备注',width:100,align:'center'},
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

        //添加专业按钮 显示编辑专业窗口
        $("#addBtn").click(function () {
            $("#editForm").form("clear");
            //hidden的属性全部要清空才能add一个全新的
            $("#majorId").val("");

            $("#win").window("open");
        });

        //更新专业按钮 显示编辑专业窗口
        $("#updateBtn").click(function () {

            var major = $('#dg').datagrid('getSelected');
            if(!major){
                $.messager.alert('错误提醒','请选择一个专业！','info');
                return false;
            }

            $("#editForm").form("load","major/majorById?majorId="+major.majorId);
            $("#win").window("open");
        });


        //点击弹框确认
        $("#submitBtn").click(function () {
            $('#editForm').form('submit', {
                url:"major/addOrUpdate",
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

        //删除专业
        $('#removeBtn').bind('click', function(){
            var major = $('#dg').datagrid('getSelected');
            if(!major){
                $.messager.alert('错误提醒','请选择一个专业！','info');
                return false;
            }
            $.messager.confirm('确认','您确认想删除该专业吗？',function(r){
                if (r){
                    $.post('major/remove',{"majorId":major.majorId},function (data) {
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