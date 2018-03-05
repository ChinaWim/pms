<%--
  Created by IntelliJ IDEA.
  User: Ming
  Date: 2018/3/1
  Time: 18:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="/WEB-INF/jsp/common/head.jsp"%>
    <title>错误页面</title>
</head>
<body>
  <div class="panel panel-danger">
      <div class="panel-heading">错误信息</div>
      <div class="panel-body-noborder">
              ${msg}
      </div>
  </div>



</body>
</html>
