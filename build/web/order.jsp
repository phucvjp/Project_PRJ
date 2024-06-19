<%-- 
    Document   : profile
    Created on : Feb 3, 2024, 10:44:06 AM
    Author     : TUF A15
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile</title>
        <link rel="stylesheet" href="bootstrap-5.3.2-dist/css/bootstrap-utilities.min.css"/>
        <link rel="stylesheet" href="font/themify-icons-font/themify-icons/themify-icons.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
        <link rel="stylesheet" href="css/home.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="css/profile.css">
        <link rel="stylesheet" href="css/order.css">

        <style>
            .title{
                padding: 0 35px;
                position: relative;
                height: 30px;
                line-height: 30px;
            }
            .title p {
                font-weight: 700;
                font-size: 20px;
                line-height: 23px;
                color: #c69a39
            }
            form {
                margin-top: 30px;
                padding: 0 35px
            }

            .v2-content__user{
                background: #fff;
                box-shadow: 0 1px 4px rgba(0,0,0,.25);
                border-radius: 5px;
                padding: 30px 0;
            }
            form .form-group {
                display: flex;
                margin-bottom: 20px;
                flex-wrap: wrap;
                align-items: center;
            }

            .v2-profile-user .v2-content form .form-group input {
                width: 50%;
                height: 35px;
                background: #fff;
                box-sizing: border-box;
                border-radius: 5px;
                padding-left: 15px;
                border: 1px solid #3e3e3e;
            }
            .v2-content__user .form-group label {
                width: 20%;
                display: block;
            }

            .form-group input {
                width: 50%;
                height: 35px;
                background: #fff;
                box-sizing: border-box;
                border-radius: 5px;
                padding-left: 15px;
                border: 1px solid #3e3e3e
            }
            .form-group a {
                font-size: 14px;
                line-height: 16px;
                text-decoration: underline;
                color: #03aef0;
            }
            .form-group span {
                margin: 0 20px 0 10px
            }
            input[type="radio"]{
                width: auto
            }
        </style>
    </head>
    <body style="margin: 0;">
        <div id="qr" class="qr" style="display: none;">
            <button onclick="closeQR()" id="exit" style="display:block; position: absolute; z-index: 2; top:3%;right: 3%; background:red; padding:5px">X</button>
            <div style="display: block;text-align: center">
                <img src="image/QR.jpg" style="width: 500px;"></br>
                <div style="display: block; background: #ffff00cc;" >
                    <h2 style="color: red"> Nội dung chuyển khoản : 'Mã đặt hàng' - Phúc đẹp zai  </h2>
                    <h4 style="color: #f3f316">Chú ý: sau khi thanh toán sẽ không hoàn tiền</h4>
                </div>
            </div>

        </div>
        <div class="header" style="position: relative">
            <a href="home" id="logo"><img class="logo" src="image/logo.png" alt="logo" ></a>
            <div class="center">
                <div id="collection" style="width: 8vw">
                    <a href="search?type=0" >Collection<div class="ti-angle-down" style="margin-left: 5px; margin-top: 2px;"></div></a>
                    <div id="listT" >
                        <c:forEach items="${sessionScope.listC}" var="c">
                            <a style="" href="search?type=${c.CATEGORY_ID}">${c.CATEGORY_NAME}</a>
                        </c:forEach>
                    </div>
                </div>
                <a href="home#about">About us</a>
                <a href="home#footer">Contact us</a>
                <% if(session.getAttribute("account")==null){%>
                <a href="login">Account<div class="ti-angle-down" style="margin-left: 5px; margin-top: 2px;"></div></a>
                    <% }else{%>
                <div id="profile">
                    <a href="profile">Account<div class="ti-angle-down" style="margin-left: 5px; margin-top: 2px;"></div></a>
                    <div  >
                        <a style="" href="profile">Profile</a>
                        <a style="" href="order">Your Order</a>
                        <a style="" href="fav">Fav List</a>
                        ${sessionScope.account.role==1?' <a style="" href="setting">Setting</a>':''}
                        ${sessionScope.account.role==1?' <a style="" href="manage">Manage</a>':''}

                        <a style="" href="home?logout=1">Log out</a>
                    </div>
                </div>

                <% }%>
            </div>
            <div class="end">
                <a href="search">
                    <div class="ti-search"></div>
                </a>
                <a href="${sessionScope.account==null?"login":"profile"}">
                    <div class="ti-user"></div>
                </a>
                <a href="fav">
                    <div class="ti-heart"></div>
                </a>
                <a href="cart">
                    <div class="ti-shopping-cart"></div>
                    <span class="badge">${sessionScope.cartM.size()==0?'':sessionScope.cartM.size()}</span>

                </a>
                ${sessionScope.account!=null?"| <img style='width:30px;margin:10px'
                  src='https://cdn.sforum.vn/sforum/wp-content/uploads/2023/10/avatar-trang-4.jpg'
                  class='rounded-circle'>":""}
            </div>
        </div>
        <div class="info">
            <img style='width:10vw;margin:0 50px'
                 src='https://cdn.sforum.vn/sforum/wp-content/uploads/2023/10/avatar-trang-4.jpg'
                 class='rounded-circle'>
            <h3>${sessionScope.account.CUSTOMER_NAME}</h3>
        </div>
        <br><!-- comment -->
        <table style="width:70vw;margin: auto;" border="1px">
            <tr>
                <th> NO. </th>
                <th>
                    ORDER ID
                </th>
                <th>
                    ORDER DATE
                </th>
                <th>
                    TOTAL PRICE
                </th>
                <th>
                    PAYING STATUS
                </th>
            </tr>
            <c:forEach items="${requestScope.listOrder}" var="c" varStatus="loop">
                <tr>
                    <td>${loop.index+1}</td>
                    <td>
                        <a style="width: 100%" href="orderDetail?oid=${c.ORDER_ID}">${c.ORDER_ID}</a>
                    </td>
                    <td>
                        ${c.ORDER_DATE}
                    </td>
                    <td>
                        ${c.TOTAL_PRICE}
                    </td>
                    <td>
                        ${c.PAYING==false?"<button onclick='openQR()'>click here to pay</button>":"payed"}
                    </td>
                </tr>
            </c:forEach>
        </table>

    </body>
    <script>
        <%if(request.getAttribute("success")!=null){
        %>
        alert("${requestScope.success}");
        <%
            }%>
        function openQR() {
            document.getElementById("qr").style.display = "flex";
        }
        function closeQR() {
            document.getElementById("qr").style.display = "none";
        }
    </script>
</html>
