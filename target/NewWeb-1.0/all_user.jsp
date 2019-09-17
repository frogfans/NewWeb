<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>饼图测试</title>
    <!-- 引入jQuery -->
    <script src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js" ></script>
    <!-- 引入echarts -->
    <script src="${pageContext.request.contextPath}/js/echarts.min.js" ></script>
    <script type="text/javascript">
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

    </script>

</head>
<body style="background-color: white;overflow-x:hidden;">
<div style="min-width: 100%;">
    <div id="echartsPie" style="width: 600px;height:400px;"></div>
</div>
</body>
</html>
