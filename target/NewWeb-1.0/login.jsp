<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<!-- saved from url=(0022)http://web.17uhui.com/ -->
<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="http://manage.xiyuan.tv/favicon.ico?v=1.0.0.25" rel="shortcut icon" type="image/x-icon" />
		
		<title>戏缘大数据统计系统登录页面</title>
		<link href="http://static.websiteonline.cn/oempage/css/style.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" type="text/css" href="https://www.17uhui.com/weblogin/css/cssreset.css"/>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/loginStyle.css"/>
		<script type="text/javascript" src="http://static.websiteonline.cn/oempage/js/jquery.js"></script>
		<script type="text/javascript" src="http://static.websiteonline.cn/oempage/js/main.js"></script>
		<script type="text/javascript" src="http://web.17uhui.com/website/template/default/js/js.js"></script>
		<script src="http://web.17uhui.com/website/template/default/js/ProgressBarWars.js" type="text/javascript"></script>
		<script src="http://web.17uhui.com/website/template/default/js/highcharts.js" type="text/javascript"></script>
		<script src="http://web.17uhui.com/website/template/default/js/jquery.mCustomScrollbar.concat.min.js" type="text/javascript"></script>
		</head>
<body class="login-body" style="">
		<!--必须引用的js_end-->
		<script type="text/javascript">
			$(document).ready(function() {
				//回车登陆
				$(document).keydown(function(e) {
					var ev = window.event || e;
					if(ev.keyCode == 13) {
						$('.submitbtn').trigger('click');
					}
				});

				//提交登录信息
				$('.submitbtn').click(function() {
					var currbox_state = $(this).parent().parent().parent().css('display') || '';
					if(currbox_state == 'block') {
						var $current_box = $(this).parent().parent().parent();
						var username = $current_box.find('input[name=username]');
						var password = $current_box.find('input[name=password]');
						var code = $current_box.find('input[name=code]');
						var token = $current_box.find('input[name=token]');
						if(username.val() == '') {
							error(username.parent(), '账号不能为空！');
							return false;
						}
						if(password.val() == '') {
							error(password.parent(), '密码不能为空！');
							return false;
						}
						if(code.val() == '') {
							error(code.parent(), '验证码不能为空！');
							return false;
						}

						/*提交的js_start
						  提交方法：ajax - post() 
						  请求url：index.php?_m=frontpage&_a=do_login
						  提交的参数：username（用户名）、password（密码）、code（验证码）、token（token变量）
						  返回值说明：1：提交成功；3：验证码错误；其他：用户名或密码
						*/
						$.ajax({
							//几个参数需要注意一下
							type: "POST",//方法类型
							dataType: "json",//预期服务器返回的数据类型
							url: "${pageContext.request.contextPath}/user/login.do" ,//url
							data: {
								username: username.val(),
								password: password.val(),
								code: code.val()
							},
							success: function (data) {
								if(data.code == 1){
									window.location.href="${pageContext.request.contextPath}/main.jsp"
								}else {
									alert(data.info);
								}
							},
							error : function() {
								alert("请求异常！");
							}
						});

					} else {
						return false;
					}
				});

			});
			
			
		</script>
	

	
		<header class="header">
			<div class="header-in">
				<a href="http://www.xiyuan.tv/" class="logo">
					<img src="http://www.xiyuan.tv/Content/xiyuan-image/bar_logo.png" height="80" width="80">
				</a>
				<nav class="nav">
					<a href="http://www.xiyuan.tv/" class="nav-item" id="m1" target="_blank">戏缘网官网</a>
					<a href="http://www.xiyuan.tv/appXiYuan/AppIndex" class="nav-item" id="m5" target="_blank">戏缘app</a>
				</nav>
			</div>
		</header>
		<section class="container">
			<div id="particles-js"><canvas width="1920" height="618" style="width: 100%; height: 100%;"></canvas></div>
			<div class="container-in">
				<div class="left">
<%--					<h2 class="title">实时数据随时掌握</h2>--%>
<%--					<h2 class="titlex">数据对比一目了然</h2>--%>
<%--                    <h2 class="titlex">助力全方位营销</h2>--%>
				</div>
				<div class="right login-form" style="opacity: 0.7" >
					<h2 class="form-title"> 戏缘大数据统计系统</h2>
					<ul>
						<!--必要的输入参数_start-->
						<li class="windx form-col">
							<div class="lita"><img src="https://www.17uhui.com/weblogin/images/icon-account.png" alt="" class="icon account-icon"></div>
							<div class="rita">
								<!--登录名输入框-->
								<input type="text" placeholder="网站管理用户名" name="username">
							</div>
						</li>
						<li class="windx form-col">
							<div class="lita a1"><img src="https://www.17uhui.com/weblogin/images/icon-pwd.png" alt="" class="icon password-icon"></div>
							<div class="rita">
								<!--密码输入框-->
								<input type="password" placeholder="网站管理密码" name="password">
							</div>
						</li>
						<li class="windx form-col">
							<div class="lita a2"><img src="https://www.17uhui.com/weblogin/images/icon-safeCode.png" alt="" class="icon safe-icon"></div>
							<div style="position:absolute; z-index:2;margin-left: 80px;margin-top: 7px;">
								<!--验证码img-->
								<img id="codeImg" class="yzsite" width="63" height="19" src="${pageContext.request.contextPath}/code/getCodeImg.do" onclick="changeImg()">
							</div>
							<div class="rita">
								<!--验证码输入框写法-->
								<input type="text" value="" class="xux safe-code" name="code">

							</div>
						</li>
						<li class="windx form-col">
							<div class="rita">
								<a href="#" class="subt submitbtn submit-button"> 登录</a>
							</div>
						</li>
						<!--必要的输入参数_end-->
					</ul>

				</div>
			</div>

		</section>

		<footer class="footer">
			<div class="footer-in">
				<p class="top">
					<span class="text">
						河南恒品文化传播有限公司&copy;版权所有
					</span>
				</p>
				<p class="copy">
					备案号：豫ICP15029898—1号&nbsp;&nbsp;&nbsp;&nbsp;网络文化经营许可证：豫网文（2016）3036—025号
				</p>
			</div>
		</footer>
		<script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
		<script src="https://www.17uhui.com/weblogin/js/particles.min.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript">

			

		</script>
	

<script type="text/javascript">
    function changeImg() {
        var imgSrc = $("#codeImg");
        var src = imgSrc.attr("src");
        imgSrc.attr("src", chgUrl(src));
    }

    //加入时间戳，去缓存机制
    function chgUrl(url) {
        var timestamp = (new Date()).valueOf();
        if ((url.indexOf("?") >= 0)) {
            url = url + "&timestamp=" + timestamp;
        } else {
            url = url + "?timestamp=" + timestamp;
        }
        return url;
    }



</script>
</body>
</html>