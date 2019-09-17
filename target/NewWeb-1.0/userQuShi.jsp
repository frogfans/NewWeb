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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">

    <!-- <script src="../js/jquery.min.js"></script> -->
    <script src="${pageContext.request.contextPath}/js/jquery-1.12.4.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/DatePicker.js"></script>
    <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <title>用户趋势</title>

</head>
<body>
<div class="row" style="width:98%;margin-left: 1%;">
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                用户趋势
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                        <div class="form-group form-inline">
                            <span>开始时间</span>
                            <input type="text" class="layui-input" id="ptime1">
                        </div>
                    </div>
                    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                        <div class="form-group form-inline">
                            <span>结束时间</span>
                            <input type="text" class="layui-input" id="ptime2">
                        </div>
                    </div>
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
                        <button type="button" class="btn btn-primary" id="search" onclick="bind()">搜索</button>
                    </div>
                </div>
                <div style="overflow: scroll;">
                    <table class="layui-hide" id="demo" lay-filter="test"></table>
                </div>
            </div>

        </div>
    </div>
</div>
<script type="text/javascript">

</script>
<script type="text/javascript">
    var ptime1;
    var ptime2;

    $(function () {
        dataPicker();//时间初始化
        $("#ptime1").attr('placeholder',ptime1);
        $("#ptime2").attr('placeholder',ptime2);
        bind();
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
        ptime1 = getDay(-7);

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


    function bind(){

        if (!($("#ptime1").val() == "")){
            ptime1 = $("#ptime1").val();
        }
        if (!($("#ptime2").val() == "")){
            ptime2 = $("#ptime2").val();
        }
        layui.use(['laydate', 'laypage', 'layer', 'table'], function(){
            var laydate = layui.laydate //日期
                ,laypage = layui.laypage //分页
                ,layer = layui.layer //弹层
                ,table = layui.table //表格


            //执行一个 table 实例
            table.render({
                elem: '#demo'
                ,height: 400
                ,url: "${pageContext.request.contextPath}/offLineData/findUserQuShi.do?time1=" + ptime1 + "&time2=" + ptime2 //数据接口
                ,title: '用户趋势表'
                ,page: true //开启分页
                ,toolbar: true //开启工具栏，此处显示默认图标，可以自定义模板，详见文档
                ,totalRow: true //开启合计行pp
                ,cols: [[ //表头
                    {field: 'simpleDateTitle', title: '时间', width:120, sort: true, fixed: 'left', totalRowText: '合计：'}
                    ,{field: 'newUserCount', title: '新用户数', width:120, sort: true, totalRow: true}
                    ,{field: 'newUserRatio', title: '新用户占比', width: 120, sort: true, totalRow: true}
                    ,{field: 'oldUserCount', title: '老用户数', width: 120, sort: true, totalRow: true}
                    ,{field: 'oldUserRatio', title: '老用户占比', width: 120, sort: true, totalRow: true}
                    ,{field: 'userCount', title: '启动用户数', width: 120, sort: true, totalRow: true}
                    ,{field: 'sessionCount', title: '启动次数', width: 120, sort: true, totalRow: true}
                    ,{field: 'averageSessionTime', title: '次均使用时长(秒)', width: 150, sort: true, totalRow: true}
                    ,{field: 'sessionTimePerPerson', title: '人均使用时长(秒)', width: 150, sort: true, totalRow: true}
                ]]
            });
        });
    }
</script>


</body>
</html>