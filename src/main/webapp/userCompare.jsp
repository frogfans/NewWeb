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
    <script src="${pageContext.request.contextPath}/js/DatePicker.js"></script>
    <script src="${pageContext.request.contextPath}/layui/layui.js" charset="utf-8"></script>
    <title>用户信息统计对比</title>

</head>
<body>
<div class="row" style="width:98%;margin-left: 1%;">
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                用户信息统计对比
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                        <div class="form-group form-inline">
                            <span>请选择一个时间</span>
                            <input type="text" class="layui-input" id="ptime1" >
                        </div>
                    </div>
                    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                        <div class="form-group form-inline">
                            <span>请选择要对比的时间</span>
                            <input type="text" class="layui-input"  id="ptime2">
                        </div>
                    </div>
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
                        <button type="button" class="btn btn-primary" id="search" onclick="bind()">搜索</button>
                    </div>
                </div>
                <div style="height: 400px;overflow: scroll;">
                    <table id="tb_list" class="table table-striped table-hover table-bordered">
                        <tr>
                            <td>时间</td><td>该周活跃用户数</td><td>该周新注册用户数</td><td>该周登录用户数</td>
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
    var ptime1 = getDay(-7);
    var ptime2 = getDay(-14);

    $(function(){
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
        $("#tid").empty();
        if (!($("#ptime1").val() == "")){
            ptime1 = $("#ptime1").val();
        }
        if (!($("#ptime2").val() == "")){
            ptime2 = $("#ptime2").val();
        }
        $.ajax({
            type:"post",
            url:"${pageContext.request.contextPath}/user/compare.do",
            data:{
                time1:ptime1,
                time2: ptime2
            },
            dateType:"json",
            success:function(data){
                if (data.code == 1){

                    var infos = data.info;
                    var html = "<tr>\n" +
                        "                            <td>" + infos.time1 +"</td><td>" + infos.activeCount1 +"</td><td>" + infos.newRegister1 +"</td><td>" + infos.loginCount1 +"</td>" +
                        "                        </tr>\n" +
                        "                        <tr>\n" +
                        "                            <td>" + infos.time2 +"</td><td>" + infos.activeCount2 +"</td><td>" + infos.newRegister2 +"</td><td>" + infos.loginCount2 +"</td>" +
                        "                        </tr>\n" +
                        "                        <tr>\n" +
                        "                            <td>同比增长</td><td>" + infos.activeCountCompare +"%</td><td>" + infos.newRegisterCompare +"%</td><td>" + infos.loginCountCompare +"%</td>" +
                        "                        </tr>";
                    $("#tid").append($(html));
                }else {
                    alert(data.info);
                }
            }

        });
    }

</script>


</body>
</html>