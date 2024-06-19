<%-- 
    Document   : manage
    Created on : Mar 2, 2024, 4:33:06 PM
    Author     : TUF A15
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            body {
                font-family: 'Arial', sans-serif;
                margin: 20px;
                background-color: #f4f4f4;
            }

            button {
                padding: 10px;
                background-color: #3498db;
                color: #fff;
                border: none;
                cursor: pointer;
            }

            button:hover {
                background-color: #2980b9;
            }

            h1 {
                color: #333;
            }

            table {
                width: 80%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            th, td {
                padding: 10px;
                border: 1px solid #ddd;
                text-align: left;
            }

            th {
                background-color: #3498db;
                color: #fff;
            }


            canvas {
                border: 1px dotted red;
            }

            .chart-container {
                position: relative;
                margin: auto;
                height: 80vh;
                width: 80vw;
                background: #1D1F20;
                padding: 16px;
            }

        </style>
        <script>
            function goHome() {
            window.location.href = "home";
            }
        </script>

    </head>
    <body>
        <button onclick="goHome()">HOME</button>

        <h1>Revenue By Quarter</h1>

        <table border="1">
            <thead>
                <tr>
                    <th>
                        Quarter
                    </th>
                    <th>
                        Total
                    </th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${requestScope.revenue.keySet()}" var="i">
                    <tr>
                        <td>${i}</td>
                        <td>${requestScope.revenue.get(i)} k VNĐ</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <div class="chart-container">
            <canvas id="chart"></canvas>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.5.1/chart.min.js"></script>
            <script>
            var data = {
            labels: [
                <c:forEach items="${requestScope.revenue.keySet()}" var="i" end="${requestScope.revenue.keySet().size()}" begin="${requestScope.revenue.keySet().size()-7}">
            "${i}",
                </c:forEach>
            ],
                    datasets: [{
                    label: "doanh thu (k VNĐ)",
                            backgroundColor: "rgba(255,99,132,0.2)",
                            borderColor: "rgba(255,99,132,1)",
                            borderWidth: 2,
                            hoverBackgroundColor: "rgba(255,99,132,0.4)",
                            hoverBorderColor: "rgba(255,99,132,1)",
                            data: [
                <c:forEach items="${requestScope.revenue.keySet()}" var="i" end="${requestScope.revenue.keySet().size()}" begin="${requestScope.revenue.keySet().size()-7}">
                    ${requestScope.revenue.get(i)},
                </c:forEach>
                            ],
                    }]
            };
            var options = {
            maintainAspectRatio: false,
                    scales: {
                    y: {
                    stacked: true,
                            grid: {
                            display: true,
                                    color: "rgba(255,99,132,0.2)"
                            }
                    },
                            x: {
                            grid: {
                            display: false
                            }
                            }
                    }
            };
            new Chart('chart', {
            type: 'bar',
                    options: options,
                    data: data
            });
            </script>
        </div>

    </body>
</html>
