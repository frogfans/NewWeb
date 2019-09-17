<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
	<head>
		<meta charset="UTF-8">
		<link href="http://manage.xiyuan.tv/favicon.ico?v=1.0.0.25" rel="shortcut icon" type="image/x-icon" />
		<title>戏缘数据中台系统</title>
		<link rel="stylesheet" href="layui/css/layui.css" />
		<script type="text/javascript" src="layui/layui.js"></script>
		<script type="text/javascript" src="js/jquery-1.12.4.js" ></script>
	</head>
	<body class="layui-layout-body">
		<div class="layui-layout layui-layout-admin">
		  <div class="layui-header">
		    <div class="layui-logo"><img src="images/logo.png" style="width: 40px; height: 40px">戏缘数据中台系统</div>
		    <!-- 头部区域（可配合layui已有的水平导航） -->
<%--		    <ul class="layui-nav layui-layout-left">--%>
<%--		      <li class="layui-nav-item"><a href="javascript:alert('该功能正在努力开发中，敬请期待……');">控制台</a></li>--%>

<%--		      <li class="layui-nav-item"><a href="javascript:alert('该功能正在努力开发中，敬请期待……');">后台用户</a></li>--%>
<%--		      <li class="layui-nav-item">--%>
<%--		        <a href="javascript:alert('该功能正在努力开发中，敬请期待……');">其它系统</a>--%>
<%--		      </li>--%>
<%--		    </ul>--%>
		    <ul class="layui-nav layui-layout-right">
		      <li class="layui-nav-item">
		        <a href="javascript:;">
		          <img src="https://gss2.bdstatic.com/9fo3dSag_xI4khGkpoWK1HF6hhy/baike/w%3D268%3Bg%3D0/sign=0871d5160124ab18e016e6310dc181f0/b3119313b07eca803f2f09d7992397dda14483d3.jpg" class="layui-nav-img">
		          ${user.username}
		        </a>
		        <dl class="layui-nav-child">
		          <dd><a href="">基本资料</a></dd>
		          <dd><a href="">安全设置</a></dd>
		        </dl>
		      </li>
		      <li class="layui-nav-item"><a href="${pageContext.request.contextPath}/user/loginOut.do">退了</a></li>
		    </ul>
		  </div>
		  
		  <div class="layui-side layui-bg-black">
		    <div class="layui-side-scroll">
		      <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
		      <ul class="layui-nav layui-nav-tree"  lay-filter="test" id="menus">
		        <li class="layui-nav-item layui-nav-itemed">
		          <a class="" href="javascript:;">实时</a>
		          <dl class="layui-nav-child">
		            <dd><a href="${pageContext.request.contextPath}/realDataInfo.jsp"  target="myframe">实时点击数统计</a></dd>
		            <dd><a href="realUserVideotop10.jsp"  target="myframe">实时Top10</a></dd>
		          </dl>
		        </li>

              <li class="layui-nav-item layui-nav-itemed">
                  <a class="" href="javascript:;">离线数据统计</a>
                  <dl class="layui-nav-child">
                      <dd><a href="${pageContext.request.contextPath}/offLineVideoCollect.jsp"  target="myframe">戏曲数据管理</a></dd>
                      <dd><a href="${pageContext.request.contextPath}/offLineDataTop10.jsp"  target="myframe">大戏Top10</a></dd>
                  </dl>
              </li>
		        <li class="layui-nav-item layui-nav-itemed">
		          <a class="" href="javascript:;">用户</a>
		          <dl class="layui-nav-child">
		            <dd><a href="${pageContext.request.contextPath}/userDataInfo.jsp"  target="myframe">用户数据管理</a></dd>
		            <dd><a href="${pageContext.request.contextPath}/userCompare.jsp"  target="myframe">用户数据对比</a></dd>
		            <dd><a href="${pageContext.request.contextPath}/userQuShi.jsp"  target="myframe">用户趋势数据</a></dd>
		          </dl>
				</li>

		      </ul>
		    </div>
		  </div>
		  
		  <div class="layui-body">
		    <!-- 内容主体区域 -->
		    <!--<div style="padding: 15px;">内容主体区域</div>-->
		    <iframe width="100%" height="100%" name="myframe"src="${pageContext.request.contextPath}/userDataInfo.jsp"></iframe>
		  </div>
		  
		  <div class="layui-footer">
		    <!-- 底部固定区域 -->
		    © www.xiyuan.tv
		  </div>
		</div>

	</body>
</html>
