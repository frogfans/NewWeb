<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
	<link rel="Stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/Styles/bridging.css"/>
	<link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/Styles/bootstrap-datetimepicker.min.css">
	<title>用户管理</title>
	<style>
		.dataWrap{
			width:800px;margin-bottom:30px;
		}
		input[type="text"]{
			height:40px;
		}
		.data-select-sure{
			height: 40px;
			line-height: 40px;
			font-size: 18px;
			font-weight: bold;
			border: 1px solid #ccc;
			box-sizing: border-box;
			padding: 0 15px;
			border-radius: 5px;
			margin-top: 23px;
			cursor: pointer;
		}
	</style>
</head>
<body>

<div class="dataWrap row">
	<div class='col-sm-4'>
		<div class="form-group">
			<label>选择开始时间：</label>
			<!--指定 date标记-->
			<div class='input-group date' id='datetimepicker1'>
				<input type='text' class="form-control" id="time1" name="start_time"/>
				<span class="input-group-addon">
                    <span class="glyphicon glyphicon-calendar"></span>
                </span>
			</div>
		</div>
	</div>
	<div class='col-sm-4'>
		<div class="form-group">
			<label>选择结束时间：</label>
			<!--指定 date标记-->
			<div class='input-group date' id='datetimepicker2'>
				<input type='text' class="form-control" id="time2" name="end_time" />
				<span class="input-group-addon">
                    <span class="glyphicon glyphicon-calendar"></span>
                </span>
			</div>
		</div>
	</div>
	<div class="col-sm-4">
		<div class='input-group data-select-sure'>确认</div>
	</div>
</div>
<div class="dataShowWrap">
	<div id="daymonth" style="width: 600px;height:400px;"></div>
	<div id="oldNew" style="width: 600px;height:400px;"></div>
	<div id="echartsPie" style="width: 600px;height:400px;"></div>
	<div id="channel_user" style="width: 1200px;height:500px;"></div>
	<div id="activeUser" style="width: 1200px;height:500px;"></div>
</div>
</body>
<script src="${pageContext.request.contextPath}/js/echarts.min.js"></script>
<!-- 引入 vintage 主题 -->
<script src="${pageContext.request.contextPath}/js/dark.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/moment-with-locales.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap-datetimepicker/4.17.47/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript">
    dataPicker();//时间初始化
    activeUser();//近七日活跃用户 图表初始化
    oldNew();//新老用户留存 图表初始化
    channeluser();//分渠道新老用户 图表初始化
    allUser();//戏缘用户数据 图表初始化
    dayMonth();//日活月活数据 图表初始化

	$('.data-select-sure').on('click',function(){
	    var startTime = $('#time1').val(),
			endTime = $('#time2').val();
          var d = new Date();
        var str = d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate();//获取当前实际日期
        if (Date.parse(str) < Date.parse(endTime)) {//时间戳对比
            alert("超越时间,再次选择")
			return
        }


        dayMonth(startTime,endTime)
        allUser()
		activeUser(startTime,endTime)
		oldNew(startTime,endTime)
		channeluser(startTime,endTime)
	});

	function activeUser(startTime,endTime){
        var myChart = echarts.init(document.getElementById('activeUser'));
        var option = {

            title: {
                text: "新增用户趋势"
            },
            tooltip:{},
            legend: {
                data: ["新增用户"]
            },
            xAxis: {
                type: 'category',
                boundaryGap: false ,
                name:'日期',
                data: []
            },
            yAxis: {
                type: 'value',
                name: "新增用户/人"

            },
            series: [{
                data: [],
                type: 'line',
                areaStyle: {},
                name:'新增用户'
            }]
        };
        myChart.setOption(option);
        myChart.showLoading();
        var names = [];
        var nums = [];
        var dataRequest = startTime && endTime ? {'quanxian':${quanxian},'start_time':startTime,'end_time':endTime} :{'quanxian':${quanxian}};
        $.ajax({
            type : "post",
            async : true, //异步请求（同步请求将会锁住浏览器，其他操作须等请求完成才可执行）
            url : "${pageContext.request.contextPath}/userpage/activeuser.do", //请求发送到dailystartuser
            data : dataRequest,
            dataType : "json", //返回数据形式为json
            //7.请求成功后接收数据name+num两组数据
            success : function(result) {
                //result为服务器返回的json对象
                if (result) {
                    //8.取出数据存入数组
                    for (var i = 0; i < result.length; i++) {
                        names.push(result[i].simple_date_title); //迭代取出类别数据并填入类别数组
                        /*   alert(result[i].simple_date_title);*/
                    }

                    for (var i = 0; i < result.length; i++) {
                        nums.push(result[i].new_user_count); //迭代取出销量并填入销量数组
                        /* alert(alert(nums[i]));*/
                    }
                    myChart.hideLoading(); //隐藏加载动画
                    //9.覆盖操作-根据数据加载数据图表
                    myChart.setOption({
                        xAxis : {
                            data : names
                        },
                        series:[
                            {
                                name: "新增用户",
                                type: "line",
                                data: nums
                            }
                        ]
                    });

                }
            },
            error : function(errorMsg) {
                //请求失败时执行该函数
                alert("图表请求数据失败!");
                myChart.hideLoading();
            }
        })
	}
	function oldNew(startTime,endTime){
         var myChart = echarts.init(document.getElementById('oldNew'));
        var option = {

            title: {
                text: "新老用户隔日留存"
            },
            tooltip: {
                trigger: "axis"
            },
            legend: {
                data: []
            },
            toolbox: {
                show: true,
                feature: {
                    mark: {
                        show: true
                    },
                    dataView: {
                        show: true,
                        readOnly: false
                    },
                    restore: {
                        show: true
                    },
                    saveAsImage: {
                        show: true
                    }
                }
            },
            calculable: true,
            xAxis: [
                {
                    type: "category",
                    axisLine: {
                        onZero: false
                    },
                    data: []
                }
            ],
            grid: {
                y: 70
            },
            yAxis: [
                {
                    type: "value",
                    name: "人数"
                },
                {
                    type: "value",
                    name: "隔日留存",
                    min: 0,
                    max: 100
                }
            ],
            series: [
                {
                    name: "新增用户",
                    type: "bar",
                    data: []
                },
                {
                    name: "活跃用户",
                    type: "bar",
                    data: []
                },
                {
                    name: "活跃用户隔日留存",
                    type: "line",
                    yAxisIndex: 1,
                    data: []
                },
                {
                    name: "新增用户隔日留存",
                    type: "line",
                    yAxisIndex: 1,
                    data: []
                }
            ]
        };
        myChart.setOption(option);
        myChart.showLoading();
        var x_dates = [];
        var old_user = [];
        var new_user = [];
        var oliu =[];
        var nliu =[];
        var dataRequest = startTime && endTime ? {'start_time':startTime,'end_time':endTime} :{};
        $.ajax({
            type : "post",
            async : true, //异步请求（同步请求将会锁住浏览器，其他操作须等请求完成才可执行）
            url : "${pageContext.request.contextPath}/userpage/oldnew.do", //请求发送到dailystartuser
            data : dataRequest,
            dataType : "json", //返回数据形式为json

            //7.请求成功后接收数据name+num两组数据
            success : function(result) {
                //result为服务器返回的json对象
                if (result) {
                    //8.取出数据存入数组
                    for (var i = 0; i < result.length; i++) {
                        x_dates.push(result[i].date); //迭代取出类别数据并填入类别数组
                    }

                    for (var i = 0; i < result.length; i++) {
                        old_user.push(result[i].active_count); //迭代取出类别数据并填入类别数组
                    }
                    for (var i = 0; i < result.length; i++) {
                        new_user.push(result[i].nuser); //迭代取出类别数据并填入类别数组
                    }
                    for (var i = 0; i < result.length; i++) {
                        nliu.push(result[i].nliu); //迭代取出类别数据并填入类别数组
                    }

                    for (var i = 0; i < result.length; i++) {
                        oliu .push(result[i].oliu ); //迭代取出销量并填入销量数组
                    }

                    myChart.hideLoading(); //隐藏加载动画

                    //9.覆盖操作-根据数据加载数据图表
                    myChart.setOption({
                        xAxis : {
                            data : x_dates
                        },
                        series:[
                            {
                                name: "新增用户",
                                type: "bar",
                                data: old_user
                            },
                            {
                                name: "活跃用户",
                                type: "bar",
                                data: new_user
                            },
                            {
                                name: "活跃用户隔日留存",
                                type: "line",
                                data: oliu
                            },
                            {
                                name: "新增用户隔日留存",
                                type: "line",
                                data: nliu
                            }
                        ]
                    });
                }
            },
            error : function(errorMsg) {
                //请求失败时执行该函数
                alert("图表请求数据失败!");
                myChart.hideLoading();
            }
        })
	}
    function channeluser(startTime,endTime) {
        var myChart = echarts.init(document.getElementById('channel_user'),'dark');
        var option = {

            title: {
                text: "分渠道新老用户",
            },
            tooltip: {
                trigger: "axis"
            },
            legend: {
                data: ["新增用户", "老用户"],
                selectedMode: "multiple"
            },
            toolbox: {
                show: true,
                feature: {
                    mark: {
                        show: true
                    },
                    dataView: {
                        show: true,
                        readOnly: true
                    },
                    magicType: {
                        show: false,
                        type: ["line", "bar"]
                    },
                    restore: {
                        show: true
                    },
                    saveAsImage: {
                        show: true
                    }
                }
            },
            calculable: true,
            xAxis: [
                {
                    type: "category",
                    data: [],
                    nameLocation: "end",
                    position: "bottom",
                    name: "渠道",
                    nameTextStyle: {
                        fontSize: 12
                    }
                }
            ],
            yAxis: [
                {
                    type: "value",
                    position: "left",
                    name: "人数",
                    nameLocation: "end",
                    nameTextStyle: {
                        fontSize: 12
                    }
                }
            ],
            series: [
                {
                    name: "新增用户",
                    type: "bar",
                    data: [],
                    smooth: false
                },
                {
                    name: "老用户",
                    type: "bar",
                    data: [],
                    smooth: false
                }
            ],
            backgroundColor: "rgba(0, 0, 0, 0)",
            color: ["#ff7f50", "#87cefa", "#da70d6", "rgb(50, 205, 50)", "#6495ed", "#ff69b4", "#ba55d3", "#cd5c5c", "#ffa500", "#40e0d0", "#1e90ff", "#ff6347", "#7b68ee", "#00fa9a", "#ffd700", "#6699FF", "#ff6666", "#3cb371", "#b8860b", "#30e0e0"]

        };
        myChart.setOption(option);
        myChart.showLoading();
        var channel = [];
        var new_user = [];
        var old_user = [];
        var dataRequest = startTime && endTime ? {'quanxian':${quanxian},'start_time':startTime,'end_time':endTime} :{'quanxian':${quanxian}};
        $.ajax({
            type : "post",
            async : true, //异步请求（同步请求将会锁住浏览器，其他操作须等请求完成才可执行）
            url : "${pageContext.request.contextPath}/userpage/userchannel.do", //请求发送到dailystartuser
            data : dataRequest,
            dataType : "json", //返回数据形式为json

            //7.请求成功后接收数据name+num两组数据
            success : function(result) {
                //result为服务器返回的json对象
                if (result) {
                    //8.取出数据存入数组
                    for (var i = 0; i < result.length; i++) {
                        channel.push(result[i].channl);

                    }

                    for (var i = 0; i < result.length; i++) {
                        new_user.push(result[i].new_user);
                    }

                    for (var i = 0; i < result.length; i++) {
                        old_user.push(result[i].old_user);
                    }

                    myChart.hideLoading(); //隐藏加载动画

                    //9.覆盖操作-根据数据加载数据图表
                    myChart.setOption({
                        xAxis : {
                            data : channel
                        },
                        series:[
                            {
                                name: "新增用户",
                                type: "bar",
                                data: new_user
                            },
                            {
                                name: "老用户",
                                type: "bar",
                                data: old_user
                            }
                        ]
                    });

                }

            },
            error : function(errorMsg) {
                //请求失败时执行该函数
                alert("图表请求数据失败!");
                myChart.hideLoading();
            }
        })
    }
    function allUser() {
        var json = [];
        var datas =[];
        $(function(){
            //ajax调用
            ajaxGetData();
        });
        function ajaxGetData(){
            $.ajax({
                url:"${pageContext.request.contextPath}/users/getPie.do",
                type: "post",
                data : {'quanxian':${quanxian}},
                success:function(data){
                    //以下两种解析json的方法都可以
                    //var jsonObject = JSON.parse(data);
                    var jsonObject = eval("("+data+")");
                    for(var i=0;i<jsonObject.length;i++){
                        json.push({value:jsonObject[i].count,name:jsonObject[i].name});
                        datas.push(jsonObject[i].name);
                    }
                    printPie();
                }
            });
        }
        function printPie(){
            var echartsPie = echarts.init(document.getElementById('echartsPie'));
            var option = {
                title : {
                    text: '戏缘用户数据',
                    x:'center'
                },
                tooltip : {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} 人"
                },
                legend: {
                    orient : 'vertical',
                    x : 'left',
                    data:datas
                },
                toolbox: {
                    show : true,
                    feature : {
                        mark : {show: true},
                        dataView : {show: true, readOnly: false},
                        magicType : {
                            show: true,
                            type: ['pie', 'funnel'],
                            option: {
                                funnel: {
                                    x: '25%',
                                    width: '50%',
                                    funnelAlign: 'left',
                                    max: 1548
                                }
                            }
                        },
                        restore : {show: true},
                        saveAsImage : {show: true}
                    }
                },
                calculable : true,
                series : [
                    {
                        name:'用户',
                        type:'pie',
                        radius : '55%',//饼图的半径大小
                        center: ['50%', '60%'],//饼图的位置
                        data:json
                    }
                ]
            };
            echartsPie.setOption(option);
        }
    }
    function dayMonth(startTime,endTime) {
        var myChart = echarts.init(document.getElementById('daymonth'));
        var option = {
            title: {
                text: "日活月活趋势"
            },
            tooltip: {
                trigger: "axis"
            },
            legend: {
                data: ["日活跃用户", "最近月活"]
            },
            toolbox: {
                show: true,
                feature: {
                    mark: {
                        show: true
                    },
                    dataView: {
                        show: true,
                        readOnly: true
                    },
                    magicType: {
                        show: false,
                        type: ["line", "bar"]
                    },
                    restore: {
                        show: true
                    },
                    saveAsImage: {
                        show: true
                    }
                }
            },
            calculable: true,
            xAxis: [
                {
                    type: "category",
                    boundaryGap: false,
                    data: []
                }
            ],
            yAxis: [
                {
                    type: "value",
                    name: "活跃人数",
                    nameLocation: "end"
                }
            ],
            series: [
                {
                    name: "日活跃用户",
                    type: "line",
                    data: []
                },
                {
                    name: "最近月活",
                    type: "line",
                    data: []
                }
            ]
        };
        myChart.setOption(option);
        myChart.showLoading();
        var dates = [];
        var dayuser = [];
        var monthuser = [];
        var dataRequest = startTime && endTime ? {'quanxian':${quanxian},'start_time':startTime,'end_time':endTime} :{'quanxian':${quanxian}};
        $.ajax({
            type : "post",
            async : true, //异步请求（同步请求将会锁住浏览器，其他操作须等请求完成才可执行）
            url : "${pageContext.request.contextPath}/userpage/daymonth.do", //请求发送到dailystartuser
            data : dataRequest,
            dataType : "json", //返回数据形式为json
            //7.请求成功后接收数据name+num两组数据
            success : function(result) {
                //result为服务器返回的json对象
                if (result) {
                    //8.取出数据存入数组
                    for (var i = 0; i < result.length; i++) {
                        dates.push(result[i].day_date); //迭代取出类别数据并填入类别数组
                        /*   alert(result[i].simple_date_title);*/
                    }

                    for (var i = 0; i < result.length; i++) {
                        dayuser.push(result[i].user_day); //迭代取出销量并填入销量数组
                        /* alert(alert(nums[i]));*/
                    }

                    for (var i = 0; i < result.length; i++) {
                        monthuser.push(result[i].user_month); //迭代取出销量并填入销量数组
                    }
                    myChart.hideLoading(); //隐藏加载动画
                    //9.覆盖操作-根据数据加载数据图表
                    myChart.setOption({
                        xAxis : {
                            data : dates
                        },
                        series:[
                            {
                                name: "日活跃用户",
                                type: "line",
                                data: dayuser
                            },
                            {
                                name: "最近月活",
                                type: "line",
                                data: monthuser
                            }
                        ]
                    });
                }
            },
            error : function(errorMsg) {
                //请求失败时执行该函数
                alert("图表请求数据失败!");
                myChart.hideLoading();
            }
        })
    }
    function dataPicker(){
        $('#datetimepicker1').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: moment.locale('zh-cn'),
            // defaultDate: "2019-07-06"
        });
        var picker1 = $('#datetimepicker1').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: moment.locale('zh-cn'),
            //minDate: '2016-7-1'
        });
        var picker2 = $('#datetimepicker2').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: moment.locale('zh-cn')
        });


        //动态设置最小值
        picker1.on('dp.change', function (e) {
            picker2.data('DateTimePicker').minDate(e.date);
        });
        //动态设置最大值
        picker2.on('dp.change', function (e) {
            picker1.data('DateTimePicker').maxDate(e.date);
        });
    }
</script>
</html>



