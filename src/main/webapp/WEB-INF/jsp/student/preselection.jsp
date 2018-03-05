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
    <title>预选情况管理页面</title>
    <style>
    </style>
</head>

<body>

<!--操作表格-->
<div id="toolbar">

    <a id = "addBtn" href="javascript:void(0);" class="easyui-linkbutton" data-options="text:'确认选择该老师',iconCls:'icon-add',plain:true"> </a>
    <%--<a id = "removeBtn" href="javascript:void(0);" class="easyui-linkbutton" data-options="text:'取消选择该老师',iconCls:'icon-remove',plain:true"> </a>--%>
</div>
<!--预选情况表格-->
<table id="dg"></table>

</body>
<script type="text/javascript">
    $(function () {

        $('#dg').datagrid({
            url:'student/showPreselection',
            columns:[[
                {field:'teacherId',title:'预选老师ID',width:100,align:'center'},
                {field:'teacher',title:'预选老师姓名',width:100,align:'center',formatter: function(value,row,index){
                    return value.teacherName;
                }    },
                {field:'preFlag',title:'是否选择该老师',width:100,align:'center',formatter: function(value,row,index){
                    if(value == '0') return '<font color="red">未选择<font>';
                    if(value == '1')  return '<font color="green">已选择<font>';
                }    },
                {field:'prePassFlag',title:'目前情况',width:50,align:'center',formatter: function(value,row,index){
                    if(value == '0') return '<font color="blue">等待老师回复<font>';
                    if(value == '1')  return '<font color="green">老师已同意<font>';
                    if(value == '-1') return '<font color="red">老师已拒绝<font>';
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

        //点击 确认选择
        $('#addBtn').bind('click', function(){
            var preselection = $('#dg').datagrid('getSelected');
            if(!preselection){
                $.messager.alert('错误提醒','请选择一个老师！','info');
                return false;
            }
            if(preselection.prePassFlag != '1'){
                $.messager.alert('错误提醒','未得到老师批准！','error');
                return;
            }

            $.messager.confirm('确认','您确认想选择该老师吗？<br>注意！选择后不能更改！',function(r){
                if (r){
                    $.post('student/chooseTeacher',{"preId":preselection.preId,"teacherId":preselection.teacherId},function (data) {
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

       /* //取消选择
        $('#removeBtn').bind('click', function(){
            var preselection = $('#dg').datagrid('getSelected');
            if(!preselection){
                $.messager.alert('错误提醒','请选择一个老师！','info');
                return false;
            }
            if(preselection.preFlag != '1'){
                $.messager.alert('错误提醒','你未选择该老师！','error');
                return;
            }

            $.messager.confirm('确认','您确认想取消选择该老师吗？',function(r){
                if (r){
                    $.post('student/cancelChooseTeacher',{"preId":preselection.preId,"teacherId":preselection.teacherId},function (data) {
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
*/
    });

</script>
</html>