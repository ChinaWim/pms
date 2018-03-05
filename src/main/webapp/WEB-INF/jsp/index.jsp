<%--
  Created by IntelliJ IDEA.
  Date: 2018/2/8
  Time: 14:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="common/head.jsp"%>
    <title>PMS在线毕业论文管理系统</title>
    <style type="text/css">
        ui{
            line-height: 30px;
        }
        *{
            text-decoration:none;
        }
        a:link {color: #1e2c09
        }		/* 未访问的链接 */
        a:visited {color: rgba(255, 65, 41, 0.98);
        }	/* 已访问的链接 */
        a:hover {color: #9fecff
        }	/* 鼠标移动到链接上 */
        a:active {color: #9fecff
        }
        /* 正在被点击的链接 */
        @font-face {
            font-family: 'MyNewFont';   /*字体名称*/
            src: url('fonts/樱花字体.ttf');       /*字体源文件*/
        }
    </style>

</head>
<body class="easyui-layout">
<!--导航栏-->
<div data-options="region:'north',split:true" style="height:95px;">
    <div style="margin: 0px 50px;" >
        <img  src="images/login/logo.png" height="80px">
    </div>
    <div style="position:absolute; left: 32%;top: 10px">
        <p  style="font-family: MyNewFont"><font size="7px" color="#ff508b">在线毕业论文管理系统</font></p>
    </div>
    <div style="position:absolute; right: 30px;top: 25px">
        <font color="red">[${sessionScope.user.realname}]&nbsp;</font>${sessionScope.user.role}&nbsp;你好!&nbsp;你上次登陆的时间是:<mark>${sessionScope.user.lastLoginTime}</mark>
        <a href="user/logout">[退出登陆]</a>
    </div>
    <div style="position: absolute;right:30px; top:50px;">
        <a href="javascript:void(0)" id="mb" class="easyui-menubutton"
           data-options="menu:'#changeTheme',iconCls:'icon-edit'">改变风格</a>
        <div id="changeTheme" style="width:150px;">
            <div >default</div>
            <div >bootstrap</div>
            <div >gray</div>
            <div >black</div>
            <div >metro</div>
            <div >material</div>
        </div>
    </div>
</div>
<!--foot-->
<div data-options="region:'south',title:'版权所属',split:true" style="height:80px;">
    <div id = "copyrightDiv" style = "text-align: center">
        copyright@归xxx所有
        <br>
    </div>
</div>
<!--左边菜单-->
<div data-options="region:'west',title:'系统菜单',split:true" style="width:200px;">
    <div id="aa" class="easyui-accordion" style="width:193px" data-options="multiple:true,border:0">

        <%-- <c:if test="${sessionScope.user.role eq '管理员' }">
             <div title="系统用户管理" data-options="iconCls:'icon-man',selected:true " style="overflow:auto;padding:10px;">
                 <ui>
                     <li><a href="javascript:void(0);" pageUrl="admin/adminManage" >用户管理</a></li>
                     <li><a href="javascript:void(0);" pageUrl="place/placeManage" >服务点管理</a></li>
                 </ui>
             </div>
         </c:if>--%>
        <!--学生功能-->
        <c:if test="${sessionScope.user.role eq '学生'}">
            <div title="我要测试" data-options="iconCls:'icon-edit'" style="overflow:auto;padding:10px;">
                <ui>
                    <li><a href="javascript:void(0);" pageUrl="test/student/testPage" >开始测试</a></li>
                </ui>
            </div>

            <div title="我的成绩单" data-options="iconCls:'icon-sum'" style="padding:10px;">
                <ui>
                    <li><a href="javascript:void(0);" pageUrl="test/student/scorePage">查看成绩</a></li>
                    <li><a href="javascript:void(0);" pageUrl="test/student/reportPage"  >测试报告</a></li>
                </ui>
            </div>
            <div title="预选管理" data-options="iconCls:'icon-search'" style="padding:10px;">
                <ui>
                    <li><a href="javascript:void(0);" pageUrl="student/teacherPage"  >预选老师</a></li>
                    <li><a href="javascript:void(0);" pageUrl="student/preselectionPage"  >预选情况</a></li>
                </ui>
            </div>
            <div title="管理论文" data-options="iconCls:'icon-ok' " style="padding:10px;">
                <ui>
                    <li><a href="javascript:void(0);" pageUrl="student/paperPage" >上传下载</a></li>
                </ui>
            </div>
            <div title="个人信息" data-options="iconCls:'icon-edit' " style="padding:10px;">
                <ui>
                    <li><a href="javascript:void(0);" pageUrl="user/rePassword">更改密码</a></li>
                </ui>
            </div>
        </c:if>
        <!--老师功能-->
        <c:if test="${sessionScope.user.role eq '老师'}">
            <div title="预选管理" data-options="iconCls:'icon-edit' " style="padding:10px;">
                <ui>
                    <li><a href="javascript:void(0);" pageUrl="test/teacher/scorePage" >学生测试情况</a></li>
                    <li><a href="javascript:void(0);" pageUrl="teacher/preselectionPage" >管理学生预选</a></li>
                </ui>
            </div>
            <div title="课题管理" data-options="iconCls:'icon-edit' " style="padding:10px;">
                <ui>
                    <li><a href="javascript:void(0);" pageUrl="teacher/projectPage" >管理课题</a></li>
                    <li><a href="javascript:void(0);" pageUrl="teacher/allotProjectPage" >分配课题</a></li>
                </ui>
            </div>
            <div title="论文管理" data-options="iconCls:'icon-edit' " style="padding:10px;">
                <ui>
                    <li><a href="javascript:void(0);" pageUrl="teacher/paperPage" >批改学生论文</a></li>
                </ui>
            </div>
            <div title="个人信息" data-options="iconCls:'icon-edit' " style="padding:10px;">
                <ui>
                    <li><a href="javascript:void(0);" pageUrl="user/rePassword">更改密码</a></li>
                </ui>
            </div>
        </c:if>
        <!--管理员功能-->
        <c:if test="${sessionScope.user.role eq '管理员'}">
            <div title="用户信息管理" data-options="iconCls:'icon-man' " style="padding:10px;">
                <ui>
                    <li><a href="javascript:void(0);" pageUrl="admin/studentPage" >学生管理</a></li>
                    <li><a href="javascript:void(0);" pageUrl="admin/teacherPage" >老师管理</a></li>
                </ui>
            </div>
            <div title="学校信息管理" data-options="iconCls:'icon-edit' " style="padding:10px;">
                <ui>
                    <li><a href="javascript:void(0);" pageUrl="admin/collegePage">院系管理</a></li>
                    <li><a href="javascript:void(0);" pageUrl="admin/majorPage">专业管理</a></li>
                    <li><a href="javascript:void(0);" pageUrl="admin/coursePage">课程管理</a></li>

                </ui>
            </div>
            <div title="毕业课题管理" data-options="iconCls:'icon-edit' " style="padding:10px;">
                <ui>
                    <li><a href="javascript:void(0);" pageUrl="admin/projectPage">课题管理</a></li>
                    <li><a href="javascript:void(0);" pageUrl="admin/questionPage" >题库管理</a></li>
                </ui>
            </div>

            <div title="个人信息" data-options="iconCls:'icon-edit' " style="padding:10px;">
                <ui>
                    <li><a href="javascript:void(0);" pageUrl="user/rePassword" >更改密码</a></li>
                </ui>
            </div>
        </c:if>

    </div>
</div>
<!--内容-->
<div data-options="region:'center',title:'内容显示'" style="padding:5px;background:#eee;">
    <div id="tt" class="easyui-tabs"  data-options="fit:true">
        <div title="欢迎页" style="padding:20px;display:none;">
            欢迎你登陆pms系统！
        </div>
    </div>
</div>
</body>
<script type="text/javascript">
    //左边菜单点击事件
    $(function () {

        $("a[pageUrl]").click(function () {
            var pageUrl = $(this).attr("pageUrl");
            var title = $(this).html();

            //判断选项卡标题，是否有左边菜单标题
            var isExist = $('#tt').tabs("exists",title);
            if(!isExist){
                $('#tt').tabs('add',{
                    title:title,
                    content:"<iframe  frameborder ='0' width = '100%' height= '99%' src='"+pageUrl+"'></iframe>",
                    closable:true,
                    fit:true,
                    tools:[{
                        iconCls:'icon-mini-refresh',
                        handler:function(){
                        }
                    }]
                });
            }else{//存在这个标题选项卡，则选择这个卡
                $("#tt").tabs("select",title);
            }
        });

        //改变风格Menu   使用easyui menu方法
        $("#changeTheme").menu({
            onClick:function(item){
                var themeName = item.text;
                var href = $("#styleId").attr("href");
                href =  href.substring(0,href.indexOf("themes"))+"themes/"+themeName+"/easyui.css";
                $("#styleId").attr("href",href);
            }

        });

    });


</script>


</html>
