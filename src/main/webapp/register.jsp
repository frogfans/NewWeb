<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/7/4
  Time: 16:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>注册</title>
    <script src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
</head>
<body>
      <c:set var="ctx" value="${pageContext.request.contextPath}"/>
      <form id="loginform" action="${pageContext.request.contextPath}/user/addUser.do"  method="post">
          <table>
              <tr>
                  <td>用户名:</td>
                  <td><input type="text" name="username"/></td>
              </tr>
              <tr>
                  <td>密&nbsp;&nbsp;码:</td>
                  <td><input  type="password" name="password"/></td>
              </tr>
              <tr>
                  <td>验证码：</td>
                  <td><input  type="text" name="code"></td>
                  <td><img id="codeImg" alt="验证码" src="${ctx}/code/getCodeImg.do" onclick="changeImg()"/></td>
              </tr>

              <tr>
                  <td>权限：</td>
                  <td><input  type="checkbox" name="quanxian" value="1">高级用户权限</td>
                  <td><input  type="checkbox" name="quanxian" value="2">普通用户权限</td>
              </tr>

              <tr>
                  <td colspan="2">
                      <input type="submit" value="注册">
                  </td>
              </tr>
          </table>
      </form>

</body>

<script type="text/javascript">
    function changeImg() {
        var imgSrc = $("#codeImg");
        var src = imgSrc.attr("src");
        imgSrc.attr("src", chgUrl(src));
    }

    //加入时间戳，去缓存机制
    function chgUrl(url) {
        var timestamp = (new Date()).valueOf();if ((url.indexOf("&") >= 0)) {
            url = url + "&timestamp=" + timestamp;
        } else {
            url = url + "?timestamp=" + timestamp;
        }
        return url;
    }

</script>
</html>
