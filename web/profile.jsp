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
        <script>
            <%if (request.getAttribute("status") != null) {%>
            alert("${requestScope.status}");
            <%}%>

        </script>
    </head>
    <body style="margin: 0;">
        <div id="qr" class="qr" style="display: none;">
            <button onclick="closeQR()" id="exit" style="display:block; position: absolute; z-index: 2; top:3%;right: 3%; background:red; padding:5px">X</button>
            <div style="background: #0df7fddb;padding: 20px;text-align: center;border-radius:20%; ">
                <h2>Change your password to:</h2>
                <form action="profile" method="post" style="width: 500px;">
                    <input style="margin-bottom: 5px;" type="password" placeholder="NEW PASSWORD " name="pass" id="pass" minlength="1"><br/>
                    <input style="margin-bottom: 5px;" type="password" placeholder="CONFIRM UR PASSWORD " id="confirm" minlength="1"><br/>
                    <button onclick="checkP(this)" type="button" style="color: pink">CHANGE</button>
                </form>
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
                <% if (session.getAttribute("account") == null) {%>
                <a href="login">Account<div class="ti-angle-down" style="margin-left: 5px; margin-top: 2px;"></div></a>
                    <% } else {%>
                <div id="profile">
                    <a href="">Account<div class="ti-angle-down" style="margin-left: 5px; margin-top: 2px;"></div></a>
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
        <div class="v2-content__user">
            <div class="title">
                <p>Thông tin tài khoản</p>
            </div>
            <form class="form-signin" action="" method="post" id="main">
                <input type="hidden" name="_token" value="6AZX8loiqN3ifT3xedmNSMOuQA0TrdqbCNqLBwlt">

                <div class="form-group">
                    <label>Họ và tên</label>
                    <input type="text" name="name" class="name" value="${sessionScope.account.CUSTOMER_NAME}" placeholder="Họ và tên..." required="">

                </div>
                <div class="form-group">
                    <label>Email</label>
                    <input type="text" name="email" class="email" value="${sessionScope.account.EMAIL}" placeholder="Email..." required="" readonly="" disabled="true">
                </div>
                <div class="form-group">
                    <label>Số điện thoại</label>
                    <input type="text" name="phone" id="phone" value="${sessionScope.account.PHONE}"  readonly="">
                    <a class="btn" onclick="change('new-phone')" style="margin-left: 15px;">Thay đổi</a>
                </div>
                <div class="form-group" id="new-phone" style="display: none">
                    <label>Số điện thoại mới</label>
                    <input type="text" placeholder="${sessionScope.account.PHONE}" id="new-p">
                    <button type="button" onclick="changePhone()">CHANGE</button>
                </div>
                <div class="form-group">
                    <label>Địa chỉ</label>
                    <input type="text" name="address" value="${sessionScope.account.ADDRESS}" placeholder="your address" readonly="" id="address">
                    <a class="btn" onclick="change('new-addr')" style="margin-left: 15px;">Thay đổi</a>
                </div>
                <div class="form-group  " id="new-addr" style="display: none">
                    <label>Địa chỉ mới</label>
                    <input type="text" placeholder="${sessionScope.account.ADDRESS}" id="new-a">
                    <button type="button" onclick="changeAddress()">CHANGE</button>
                </div>
                <div class="form-group">
                    <label>Giới tính</label>
                    <input type="radio" name="gender" class="gender" value="M" ${sessionScope.account.SEX=='M'?'checked':''}>
                    <span >Nam</span>
                    <input type="radio" name="gender" class="gender" value="F" ${sessionScope.account.SEX=='F'?'checked':''}>
                    <span >Nữ</span>
                </div>
                <div class="form-group">
                    <label>Ngày sinh</label>
                    <input type="date" name="birthday" value="${sessionScope.account.BIRTHDAY}" />
                </div>
                <div class="form-group">
                    <label></label>
                    <a style="cursor: pointer" onclick="openQR()">Thay đổi mật khẩu</a>
                </div>
                <div class="form-group">
                    <label></label>
                    <button type="button" onclick="check(this)">Cập nhật</button>
                </div>
            </form>
        </div>

    </body>
    <script>
        function change(i) {
            document.getElementById(i).style.display = "flex";
        }
        function changeAddress() {
            document.getElementById("address").value = document.getElementById("new-a").value;
            document.getElementById("new-addr").style.display = "none";
        }
        function changePhone() {
            document.getElementById("phone").value = document.getElementById("new-p").value;
            document.getElementById("new-phone").style.display = "none";
        }
        function openQR() {
            document.getElementById("qr").style.display = "flex";
        }
        function closeQR() {
            document.getElementById("qr").style.display = "none";
        }
        function checkP(i) {
            if (document.getElementById("confirm").value === document.getElementById("pass").value) {
                i.parentNode.submit();
            } else {
                alert("wrong confirming password!!!");
            }
        }
        function check() {
            var inp = document.getElementsByTagName("input");
            if (inp[5].value.match('[0]{1}[0-9]{9}') === null || inp[5].value.match('[0]{1}[0-9]{9}')[0] !== inp[5].value) {
                alert("you must input a phone number like : 0987654321");
                return;
            }
            if (inp[11].value.substr(0, 4) > 2012) {
                alert("you must over 12 yeard old");
                return;
            }
            document.getElementById("main").submit();
        }
    </script>
</html>
