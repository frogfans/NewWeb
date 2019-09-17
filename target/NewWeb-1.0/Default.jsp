<!DOCTYPE html>
<html>
<head>
<meta content="数据中台" name="keywords" />
<meta content="数据中台" name="description" />
<title>戏缘数据中台系统</title>
	<!--有提示需要导入servlet jsp包-->
<link rel="Stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/Styles/bridging.css"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/Scripts/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/Scripts/common.js"></script>
</head>

<body>
	<form id="form1" >
		<!--====这里放主导航====-->
		<div class="header">
			<div class="header_top">
				<header>
					<div class="header_logo">
						<h1>戏缘数据中台展示</h1>
					</div>
					<div class="header_tab">
						<ul>
							<li><h2 class="version"></h2></li>
							<li><span class="header_hi">Hi,</span><span
								class="header_usename">${user}</span>！</li>
							<li><a href="javascript:void(0)" onclick="this.href='#'">注销</a></li>
							<li class="rel"><a href="#" class="system_infor"
								id="system_infor" onclick="showMessageList();">系统消息(0)</a>
								<div id="Div1" class="dn"></div></li>
							<li class="password_nav"><a href="#"
								class="change_password nav_current otherNavigation">修改密码</a></li>
							<li><a href="#">帮助中心</a></li>
						</ul>
						<div class="cf"></div>
					</div>
					<div class="cf"></div>
				</header>
			</div>
			<div class="header_nav">
				<%--<a>${quanxian}</a>--%>
				<nav>
					<ul id="showMainNav" class="fix">

						<li class="navContent nav_current">
							<a href="#" class="showNav" id="user" data-name="main_iframe"
							   onclick="Common.switchNavigation(this);"
							   data-url="${pageContext.request.contextPath}/user/manage.do">用户管理</a>
						</li>

						<li class="navContent">
							<a href="#" class="showNav" id="finance" data-name="main_iframe"
							onclick="Common.switchNavigation(this);"
							data-url="${pageContext.request.contextPath}/user/manage.do">内容统计</a>
						</li>
					</ul>
				</nav>
			</div>
		</div>

		<!--====下面是主要内容区域====-->
	<%--	<div id="main_iframe"
			class="index_mainIfram_position  mainIfram_position">
			<iframe class="main_iframe" id="home_iframe" frameborder="0"
				border="0" src="${pageContext.request.contextPath}/user/manage.do"></iframe>
		</div>--%>

		<div id="main_iframe"
			 class="index_mainIfram_position  mainIfram_position">
			<iframe class="main_iframe" id="home_iframe" frameborder="0"
					border="0" src="${pageContext.request.contextPath}/user/manage.do"></iframe>
		</div>



		<!--====下面是页脚====-->
		<div class="footer">
			<footer>
				<p>  版权所有 @ 2019 河南恒品文化传播有限公司 </p>
			</footer>
		</div>
	</form>
</body>
</html>
