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
    <!-- <script src="../js/jquery.min.js"></script> -->
    <script src="${pageContext.request.contextPath}/js/jquery-1.12.4.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/DatePicker.js"></script>
    <title>今日Top10</title>
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
                昨日Top10
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">

                    </div>
                    <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">

                    </div>
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">

                    </div>
                </div>
                <div style="overflow: scroll;">
                    <table id="tb_list" class="table table-striped table-hover table-bordered">
                        <tr>
                            <td>热门用户</td><td>热播大戏</td>
                        </tr>
                        <tr>
                            <td>
                                <div style="width: 350px;height:550px; background: #333;">
                                    <table>
                                        <tr>
                                            <div style="background-color: #333; text-align:center; height:40px;">
                                                <h3>昨日活跃用户Top10</h3>
                                            </div>

                                        </tr>
                                        <tr>
                                            <ul id="ul1"></ul>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                            <td>
                                <div style="width: 350px;height:550px; background: #333;">
                                    <table>
                                        <tr>
                                            <div style="background-color: #333; text-align:center; height:40px;">
                                                <h3>昨日热播大戏Top10</h3>
                                            </div>

                                        </tr>
                                        <tr>
                                            <ul id="ul2"></ul>
                                        </tr>
                                    </table>
                                </div>
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
    //jQuery的页面加载完成时触发的事件
    $(document).ready(function(){
        uid();
        video();
    });

    function uid() {
        $.ajax({
            type : "post",
            url : "${pageContext.request.contextPath}/realData/uidRank.do", //请求发送到dailystartuser
            dataType : "json", //返回数据形式为json
            success:function (data) {
                if (data.code==1){
                    var infos = data.info;
                    var html = "";
                    for (var i = 0; i < infos.length; i++){
                        html += "<li>NO."+ (i+1) +" 用户 " + infos[i].name +" (" + infos[i].value +")</li>";
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
    function video() {
        $.ajax({
            type : "post",
            url : "${pageContext.request.contextPath}/realData/videoRank.do", //请求发送到dailystartuser
            dataType : "json", //返回数据形式为json
            success:function (data) {
                if (data.code==1){
                    var infos = data.info;
                    var html = "";
                    for (var i = 0; i < infos.length; i++){
                        html += "<li>NO."+ (i+1) +" 曲剧 " + infos[i].name +" (" + infos[i].value +")</li>";

                    }
                    $("#ul2").append($(html));
                } else {
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

</script>


</body>
</html>