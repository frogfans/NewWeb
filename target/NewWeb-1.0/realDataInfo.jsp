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

    <script src="${pageContext.request.contextPath}/js/echarts.min.js"></script>

    <!-- 引入 vintage 主题 -->
    <script src="${pageContext.request.contextPath}/js/vintage.js"></script>

    <style>
        h3{
            color:#333;
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
                昨日实时数据展示
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

<%--                    <table id="tb_list" class="table table-striped table-hover table-bordered">
                        <tr>

                            <td><div id="totalClick" style="width: 600px;height:400px;"></div></td>
                            <td><div id="fromArea" style="width: 600px;height:400px;"></div></td>
                        </tr>
                        <tr>

                            <td><div id="clickTo" style="width: 600px;height:500px;"></div></td>
                            <td></td>
                        </tr>

                        <tbody id="tid">

                        </tbody>
                    </table>--%>
                    <table id="tb_list" class="table table-striped table-hover table-bordered">
                        <tr>

                            <td>
                                <table class="table table-striped table-hover table-bordered">
                                    <tr>
                                        <td><div style="background-color: white; text-align:center; height:40px;"><h3>实时点击总数趋势图</h3></div></td>
                                    </tr>
                                    <tr>
                                        <td> <div id="totalClick" style="width: 600px;height:400px;"></div></td>
                                    </tr>
                                </table>

                            </td>
                            <td>
                                <table class="table table-striped table-hover table-bordered">
                                    <tr>
                                        <td><div style="background-color: white; text-align:center; height:40px;"><h3>累计访问来源Top10</h3></div></td>
                                    </tr>
                                    <tr>
                                        <td> <div id="fromArea" style="width: 600px;height:400px;"></div></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>

                            <td>
                                <table class="table table-striped table-hover table-bordered">
                                    <tr>
                                        <td><div style="background-color: white; text-align:center; height:40px;"><h3>各模块点击统计</h3></div></td>
                                    </tr>
                                    <tr>
                                        <td> <div id="clickTo" style="width: 600px;height:400px;"></div></td>
                                    </tr>
                                </table>
                            </td>
                            <td></td>
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

    $(function () {
        totalClick();
        fromArea();
        clickTo();
    });


  function totalClick(){
      // 基于准备好的dom，初始化echarts实例
      var myChart = echarts.init(document.getElementById('totalClick'),'vintage');
      // 指定图表的配置项和数据

      var option = {

          title: {

          },
          tooltip: {
              trigger: "axis"
          },
          legend: {
              data: ["点击量"]
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
                  name: "点击量",
                  nameLocation: "end"
              }
          ],
          grid: {
              x: 100, //默认是80px
              y: 60, //默认是60px
              x2: 40, //默认80px
              y2: 45 //默认60px
          },
          series: [
              {
                  name: "点击量",
                  type: "line",
                  data: []
              }
          ]
      };

      // 使用刚指定的配置项和数据显示图表。
      myChart.setOption(option);

      // 使用刚指定的配置项和数据显示图表。
      myChart.setOption(option);

      //4.设置加载动画(非必须)
      myChart.showLoading(); //数据加载完之前先显示一段简单的loading动画

      //5.定义数据存放数组(动态变)
      var dates = []; //建立一个类别数组（实际用来盛放X轴坐标值）
      var dayuser = []; //建立一个销量数组（实际用来盛放Y坐标值）
      var click = [];

      //6.ajax发起数据请求
      $.ajax({
          type : "post",
          async : true, //异步请求（同步请求将会锁住浏览器，其他操作须等请求完成才可执行）
          url : "${pageContext.request.contextPath}/realData/totalClick.do", //请求发送到dailystartuser
          dataType : "json", //返回数据形式为json

          //7.请求成功后接收数据name+num两组数据
          success : function(data) {
              if (data.code == 1){
                  var infos = data.info;
                  for (var i = 0; i <infos.length; i++){
                      dates.push(infos[i].date);
                  }
                  for (var i = 0; i <infos.length; i++){
                      click.push(infos[i].click);
                  }
                  myChart.hideLoading(); //隐藏加载动画
                  //9.覆盖操作-根据数据加载数据图表
                  myChart.setOption({
                      xAxis : {
                          data : dates
                      },
                      series:[
                          {
                              name: "点击量",
                              type: "line",
                              data: click
                          }
                      ]
                  });
              }else {
                  alert(data.info);
              }
          },
          error : function(errorMsg) {
              //请求失败时执行该函数
              alert("图表请求数据失败!");
              myChart.hideLoading();
          }
      })
  }
  
  function fromArea() {
      // 基于准备好的dom，初始化echarts实例
      var myChart = echarts.init(document.getElementById('fromArea'),'vintage');
      // 指定图表的配置项和数据

      var option = {

          title: {

              x:'center'
          },
          tooltip: {
              trigger: "item",
              formatter: "{a} <br/>{b} : {c} ({d}%)"
          },
          legend: {
              orient: 'vertical',
              left: 'left',
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
          series: [
              {
                  name:'访问来源',
                  type:'pie',
                  radius: ['50%', '70%'],
                  avoidLabelOverlap: false,
                  label: {
                      normal: {
                          show: false,
                          position: 'center'
                      },
                      emphasis: {
                          show: true,
                          textStyle: {
                              fontSize: '30',
                              fontWeight: 'bold'
                          }
                      }
                  },
                  labelLine: {
                      normal: {
                          show: false
                      }
                  },
                  data:[]
              }
          ]
      };

      // 使用刚指定的配置项和数据显示图表。
      myChart.setOption(option);

      // 使用刚指定的配置项和数据显示图表。
      myChart.setOption(option);

      //4.设置加载动画(非必须)
      myChart.showLoading(); //数据加载完之前先显示一段简单的loading动画

      //5.定义数据存放数组(动态变)
      var n = []; //建立一个销量数组（实际用来盛放模块名字）
      var v = []; //建立一个类别数组（实际用来盛放访问量）



      //6.ajax发起数据请求
      $.ajax({
          type : "post",
          async : true, //异步请求（同步请求将会锁住浏览器，其他操作须等请求完成才可执行）
          url : "${pageContext.request.contextPath}/realData/fromArea.do",
          dataType : "json", //返回数据形式为json

          //7.请求成功后接收数据name+num两组数据
          success : function(data) {
              if (data.code == 1){
                  var infos = data.info;
                  for (var i = infos.length-1; i >= infos.length-10; i--){
                      n.push(infos[i].name);
                      v.push(infos[i]);
                  }

                  myChart.hideLoading(); //隐藏加载动画
                  //9.覆盖操作-根据数据加载数据图表
                  myChart.setOption({
                      legend: {
                          data: n
                      },
                      series:[
                          {
                              name: "访问来源",
                              type: "pie",
                              radius : '55%',
                              center: ['50%', '60%'],
                              data: v
                          }
                      ]
                  });
              }else {
                  alert(data.info);
              }
          },
          error : function(errorMsg) {
              //请求失败时执行该函数
              alert("图表请求数据失败!");
              myChart.hideLoading();
          }
      })
  }

  function clickTo() {
      // 基于准备好的dom，初始化echarts实例
      var myChart = echarts.init(document.getElementById('clickTo'),'vintage');
      // 指定图表的配置项和数据

      var option = {

          title: {

              x:'center'
          },
          tooltip: {
              trigger: "item",
              formatter: "{a} <br/>{b} : {c} ({d}%)"
          },
          legend: {
              orient: 'vertical',
              left: 'left',
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
          series: [
              {
                  name: "访问来源",
                  type: "pie",
                  radius : '55%',
                  center: ['50%', '60%'],
                  data: []
              }
          ],
          itemStyle: {
              emphasis: {
                  shadowBlur: 10,
                  shadowOffsetX: 0,
                  shadowColor: 'rgba(0, 0, 0, 0.5)'
              }
          }
      };

      // 使用刚指定的配置项和数据显示图表。
      myChart.setOption(option);

      // 使用刚指定的配置项和数据显示图表。
      myChart.setOption(option);

      //4.设置加载动画(非必须)
      myChart.showLoading(); //数据加载完之前先显示一段简单的loading动画

      //5.定义数据存放数组(动态变)
      var n = []; //建立一个销量数组（实际用来盛放模块名字）
      var v = []; //建立一个类别数组（实际用来盛放访问量）



      //6.ajax发起数据请求
      $.ajax({
          type : "post",
          async : true, //异步请求（同步请求将会锁住浏览器，其他操作须等请求完成才可执行）
          url : "${pageContext.request.contextPath}/realData/clickTo.do",
          dataType : "json", //返回数据形式为json

          //7.请求成功后接收数据name+num两组数据
          success : function(data) {
              if (data.code == 1){
                  var infos = data.info;
                  for (var i = 0; i <infos.length; i++){
                      n.push(infos[i].name);
                      v.push(infos[i]);
                  }

                  myChart.hideLoading(); //隐藏加载动画
                  //9.覆盖操作-根据数据加载数据图表
                  myChart.setOption({
                      legend: {
                          data: n
                      },
                      series:[
                          {
                              name: "访问来源",
                              type: "pie",
                              radius : '55%',
                              center: ['50%', '60%'],
                              data: v
                          }
                      ]
                  });
              } else {
                  alert(data.info);
              }
              /*//result为服务器返回的json对象
              if (result) {
                  //8.取出数据存入数组
                  for (var i = 0; i < result.length; i++) {
                      dates.push(result[i].day_date); //迭代取出类别数据并填入类别数组
                      /!*   alert(result[i].simple_date_title);*!/
                  }

                  for (var i = 0; i < result.length; i++) {
                      dayuser.push(result[i].user_day); //迭代取出销量并填入销量数组
                      /!* alert(alert(nums[i]));*!/
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
              }*/
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