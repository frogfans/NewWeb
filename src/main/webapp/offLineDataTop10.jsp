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
    <script src="${pageContext.request.contextPath}/layui/layui.js" charset="utf-8"></script>
    <title>离线数据Top10</title>
    <style type="text/css">
        ul li {
            list-style: none;
            line-height: 30px;
            color: #fff;
            font-family:"宋体";
            font-size: 15px;
        }
        h3{
            color: #fff;
            font-family: "楷体";
        }
    </style>

</head>
<body>
<div class="row" style="width:98%;margin-left: 1%;">
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                离线数据Top10
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                        <div class="form-group form-inline">
                            <span>请选择一个时间</span>
                            <input type="text" class="layui-input" id="ptime">
                        </div>
                    </div>
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
                        <button type="button" class="btn btn-primary" id="search" onclick="bind()">搜索</button>
                    </div>
                </div>
                <div style="overflow: scroll;">
                    <table id="tb_list" class="table table-striped table-hover table-bordered">
                        <tr>
                            <td>大戏Top10</td><%--<td>热播大戏</td>--%>
                        </tr>
                        <tr>
                            <td>
                                <div style="width: 350px;height:550px; background: #333;">
                                    <table>
                                        <tr>
                                            <div style="background-color: #333; text-align:center; height:40px;">
                                                <h3 id="h31"></h3>
                                            </div>

                                        </tr>
                                        <tr>
                                            <ul id="ul1"></ul>
                                        </tr>
                                    </table>
                                </div>
                            </td>
<%--                            <td>--%>
<%--                                <div style="width: 350px;height:550px; background: #333;">--%>
<%--                                    <table>--%>
<%--                                        <tr>--%>
<%--                                            <div style="background-color: #009688; text-align:center; height:40px;">--%>
<%--                                                <h3 id="h32"></h3>--%>
<%--                                            </div>--%>

<%--                                        </tr>--%>
<%--                                        <tr>--%>
<%--                                            <ul id="ul2"></ul>--%>
<%--                                        </tr>--%>
<%--                                    </table>--%>
<%--                                </div>--%>
<%--                            </td>--%>
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

    var ptime = getDay(-1);
    //jQuery的页面加载完成时触发的事件
    $(document).ready(function(){
        $("#ptime").attr('placeholder',ptime);
        video();
        // collect();

    });

    function bind(){
        if (!($("#ptime").val() == "")){
            ptime = $("#ptime").val();
        }
        video();
    }

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
            elem: '#ptime'
        });

    });

    function video() {
        $("#ul1").empty();
        $("#h31").text(ptime + "热播大戏Top10");
        $.ajax({
            type : "post",
            url : "${pageContext.request.contextPath}/offLineData/findVideoCount.do", //请求发送到dailystartuser
            data:{
                time:ptime
            },
            dataType : "json", //返回数据形式为json
            success:function (data) {
                if (data.code==1){

                    var infos = data.info;
                    var html = "";
                    for (var i = 0; i < infos.length; i++){
                        html += "<li>NO."+ (i+1) +" 用户 " + infos[i].videoName +" (" + infos[i].realWatchCount +")</li>";
                    }
                    $("#ul1").append($(html));
                }else {
                    alert(data.info);
                }
            },
            error : function(errorMsg) {
                //请求失败时执行该函数
                alert("图表请求数据失败!");
                myChart.hideLoading();
            }

        });
    }
    // function collect() {
    //     $("#ul2").empty();
    //     $("#h32").text(ptime + "大戏收藏Top10");
    // }



</script>


</body>
</html>