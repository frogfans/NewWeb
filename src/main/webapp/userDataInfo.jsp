<%--
  Created by IntelliJ IDEA.
  User: ctg
  Date: 2019/7/12
  Time: 14:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" />
    <!-- <script src="../js/jquery.min.js"></script> -->
    <script src="${pageContext.request.contextPath}/js/jquery-1.12.4.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>

    <script src="${pageContext.request.contextPath}/js/echarts.min.js"></script>

    <!-- 引入 vintage 主题 -->
    <script src="${pageContext.request.contextPath}/js/vintage.js"></script>
    <script src="${pageContext.request.contextPath}/layui/layui.js" charset="utf-8"></script>



    <style>
        h3{
            color: #333333;
            font-family: "楷体";
        }
    </style>
    <title>用户管理</title>

</head>
<body>
<div class="row" style="width:98%;margin-left: 1%;">
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                用户信息管理
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                        <div class="form-group form-inline">
                            <span>请选择开始时间</span>
                            <input type="text" class="layui-input" id="ptime1">
                        </div>
                    </div>
                    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                        <div class="form-group form-inline">
                            <span>请选择结束时间</span>
                            <input type="text" class="layui-input" id="ptime2">
                        </div>
                    </div>
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
                        <button type="button" class="btn btn-primary" id="search" onclick="go()">搜索</button>
                    </div>
                </div>
                <div style="overflow: scroll;">

                    <table id="tb_list" class="table table-striped table-hover table-bordered">
                        <tr>
                            <td>
                                <table class="table table-striped table-hover table-bordered">
                                    <tr>
                                        <td><div style="background-color: white; text-align:center; height:40px;"><h3>日活月活趋势图</h3></div></td>
                                    </tr>
                                    <tr>
                                        <td><div id="daymonth" style="width: 600px;height:400px;"></div></td>
                                    </tr>
                                </table>

                            </td>
                            <td>
                                <table class="table table-striped table-hover table-bordered">
                                    <tr>
                                        <td><div style="background-color: white; text-align:center; height:40px;"><h3>新老用户隔日留存</h3></div></td>
                                    </tr>
                                    <tr>
                                        <td><div id="oldNew" style="width: 600px;height:400px;"></div></td>
                                    </tr>
                                </table>
                            </td>



                        </tr>
                        <tr>
                            <td>
                                <table class="table table-striped table-hover table-bordered">
                                    <tr>
                                        <td><div style="background-color: white; text-align:center; height:40px;"><h3>新增用户趋势图</h3></div></td>
                                    </tr>
                                    <tr>
                                        <td><div id="activeUser" style="width: 600px;height:400px;"></div></td>
                                    </tr>
                                </table>
                            </td>
                            <td>
                                <table class="table table-striped table-hover table-bordered">
                                    <tr>
                                        <td><div style="background-color: white; text-align:center; height:40px;"><h3>分渠道新老用户</h3></div></td>
                                    </tr>
                                    <tr>
                                        <td><div id="channel_user" style="width: 600px;height:500px;"></div></td>
                                    </tr>
                                </table>
                            </td>



                        </tr>


                        <tbody id="tid">

                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </div>
</div>
<script type="text/javascript">
    var ptime1;
    var ptime2;

    $(function () {
        dataPicker();//时间初始化
        $("#ptime1").attr('placeholder',ptime1);
        $("#ptime2").attr('placeholder',ptime2);
        activeUser();//近七日活跃用户 图表初始化
        oldNew();//新老用户留存 图表初始化
        channeluser();//分渠道新老用户 图表初始化
        dayMonth();//日活月活数据 图表初始化
    });

    function getDay(day){
        var today = new Date();
        var targetday_milliseconds=today.getTime() + 1000*60*60*24*day;
        today.setTime(targetday_milliseconds); //注意，这行是关键代码
        var tYear = today.getFullYear();
        var tMonth = today.getMonth();
        var tDate = today.getDate();
        tMonth = doHandleMonth(tMonth + 1);
        tDate = doHandleMonth(tDate);
        return tYear+"-"+tMonth+"-"+tDate;
    }
    function doHandleMonth(month){
        var m = month;
        if(month.toString().length == 1){
            m = "0" + month;
        }
        return m;
    }

    function dataPicker(){
        ptime2 = getDay(0);
        ptime1 = getDay(-31);

    }
    layui.use('laydate', function(){
        var laydate = layui.laydate;

        //常规用法
        laydate.render({
            elem: '#ptime1'
        });
        laydate.render({
            elem: '#ptime2'
        });
    });

    function go() {

        if (!($("#ptime2").val() == "")){
            ptime2 = $("#ptime2").val();
        }
        if (!($("#ptime1").val() == "")){
            ptime1 = $("#ptime1").val();
        }
        dayMonth();
        activeUser();
        oldNew();
        channeluser();
    }
    function activeUser(){
        var myChart = echarts.init(document.getElementById('activeUser'),'vintage');
        var option = {

            title: {
            },
            tooltip:{},
            legend: {
                data: ["新增用户"]
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
        var dataRequest = {'quanxian':${quanxian},'start_time':ptime1,'end_time':ptime2};
        <%--var dataRequest = startTime && endTime ? {'quanxian':${quanxian},'start_time':startTime,'end_time':endTime} :{'quanxian':${quanxian}};--%>
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
    function oldNew(){
        var myChart = echarts.init(document.getElementById('oldNew'),'vintage');
        var option = {

            title: {

            },
            tooltip: {
                trigger: "axis"
            },
            legend: {
                data: ["新增用户","活跃用户","新增隔日留存","活跃隔日留存"]
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
                    name: "活跃隔日留存",
                    type: "line",
                    yAxisIndex: 1,
                    data: []
                },
                {
                    name: "新增隔日留存",
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

        var dataRequest = {'quanxian':${quanxian},'start_time':ptime1,'end_time':ptime2};
        // var dataRequest = startTime && endTime ? {'start_time':startTime,'end_time':endTime} :{};
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
                                data: new_user
                            },
                            {
                                name: "活跃用户",
                                type: "bar",
                                data: old_user
                            },
                            {
                                name: "活跃隔日留存",
                                type: "line",
                                data: oliu
                            },
                            {
                                name: "新增隔日留存",
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
    function channeluser() {
        var myChart = echarts.init(document.getElementById('channel_user'),'vintage');
        var option = {

            title: {
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
        <%--var dataRequest = startTime && endTime ? {'quanxian':${quanxian},'start_time':startTime,'end_time':endTime} :{'quanxian':${quanxian}};--%>
        var dataRequest = {'quanxian':${quanxian},'start_time':ptime1,'end_time':ptime2};
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
    /*function allUser() {
        var json = [];
        var datas =[];
        $(function(){
            //ajax调用
            ajaxGetData();
        });
        function ajaxGetData(){
            $.ajax({
                url:"users/getPie.do",
                type: "post",
                data : {},
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
            var echartsPie = echarts.init(document.getElementById('echartsPie'),'vintage');
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
    }*/
    function dayMonth() {
        var myChart = echarts.init(document.getElementById('daymonth'),'vintage');
        var option = {
            title: {
            },
            tooltip: {
                trigger: "axis"
            },
            legend: {
                data: ["日活跃用户", "周活跃用户","月活跃用户"]
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
                    name: "周活跃用户",
                    type: "line",
                    data: []
                },
                {
                    name: "月活跃用户",
                    type: "line",
                    data: []
                }
            ]
        };
        myChart.setOption(option);
        myChart.showLoading();
        var dates = [];
        var dayuser = [];
        var weekuser =[];
        var monthuser = [];
        var dataRequest = {'quanxian':${quanxian},'start_time':ptime1,'end_time':ptime2};
        <%--var dataRequest = startTime && endTime ? {'quanxian':${quanxian},'start_time':startTime,'end_time':endTime} :{'quanxian':${quanxian}};--%>
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
                        weekuser.push(result[i].user_week); //迭代取出销量并填入销量数组
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
                                name: "周活跃用户",
                                type: "line",
                                data: weekuser
                            },
                            {
                                name: "月活跃用户",
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




</script>


</body>
</html>