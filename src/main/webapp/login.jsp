<%@page contentType="text/html; UTF-8" pageEncoding="UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<!DOCTYPE html>
<html lang="en">
<head>
 <meta charset="utf-8"/>
 <title>PMS系统登录</title>
 <meta name="author" content="DeathGhost" />
 <link rel="stylesheet" type="text/css" href="css/style.css" tppabs="css/style.css" />
 <style>
  body{height:100%;background:#16a085;overflow:hidden;}
  canvas{z-index:-1;position:absolute;}
 </style>
 <script src="js/jquery.js"></script>
 <script src="js/verificationNumbers.js" tppabs="js/verificationNumbers.js"></script>
 <script src="js/Particleground.js" tppabs="js/Particleground.js"></script>
 <script>
     $(document).ready(function() {
         //粒子背景特效
         $('body').particleground({
             dotColor: '#5cbdaa',
             lineColor: '#5cbdaa'
         });
         //验证码
         createCode();
         //测试提交，对接程序删除即可
         $(".submit_btn").click(function(){
             if(validateUsername()  && validatePassword() &&  validate()){
               $("#ocsform").submit();
             }

         });
     });
 </script>
</head>
<body id = "body">
<c:if test="${! empty sessionScope.msg}">
 <script type="text/javascript">
     alert("账号或密码错误");
 </script>
</c:if>

<dl class="admin_login">
 <dt>
  <strong>PMS毕业论管理系统</strong>
  <em>PAPER MANAGEMENT SEVER</em>
 </dt>
 <form action="user/login" method="post" id = "ocsform" >
  <dd class="user_icon">
   <input type="text" placeholder="账号" id = "username" name = "username" class="login_txtbx" onblur="validateUsername()" />
  </dd>
  <dd class="pwd_icon">
   <input type="password" placeholder="密码" id ="password"   name = "password" class="login_txtbx"/>
  </dd>
  <dd class="val_icon">
   <div class="checkcode">
    <input type="text" id="J_codetext" placeholder="验证码" maxlength="4" class="login_txtbx">
    <canvas class="J_codeimg" id="myCanvas" onclick="createCode()">对不起，您的浏览器不支持canvas，请下载最新版浏览器!</canvas>
   </div>
   <input type="button" value="验证码核验" class="ver_btn" onClick="validate();">
  </dd>

  <div class="user_icon" >
   <input  type="radio" name = "role" value = "管理员" placeholder=""  class="login_txtbx" >&nbsp;&nbsp;&nbsp;管理员
   &nbsp;&nbsp;
   <input type="radio" name = "role" value = "老师" placeholder=""  class="login_txtbx" >&nbsp;&nbsp;&nbsp;老师
   &nbsp;&nbsp;&nbsp;
   <input checked type="radio" name = "role" value = "学生"  placeholder=""   class="login_txtbx">&nbsp;&nbsp;学生
  </div>


  <dd>
   <input type="button" value="立即登陆" class="submit_btn"/>
  </dd>
 </form>
 <dd>
  <p>© 2017-2018xxx 版权所有</p>
  <p></p>
 </dd>
</dl>
</body>
<script TYPE="text/javascript">


</script>

</html>