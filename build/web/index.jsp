<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<!--
Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Html.html to edit this template
-->

<html>

    <head>
        <title>Home</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="bootstrap-5.3.2-dist/css/bootstrap.css"/>
        <link rel="stylesheet" href="font/themify-icons-font/themify-icons/themify-icons.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
              integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <!-- Optional theme -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
              integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <!-- Latest compiled and minified JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
                integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
        crossorigin="anonymous"></script>
        <!--        <link href="https://fonts.googleapis.com/css?family=Josefin+Sans:300,400,700&subset=latin-ext" rel="stylesheet">-->
        <link rel="stylesheet" href="css/home.css">
        <style>
            .type {
                display: flex;
                justify-content: center;
                gap: 10px;
            }

            .type a {
                text-decoration: none;
                padding: 5px 10px;
                border: 1px solid #007BFF;
                border-radius: 5px;
                color: #007BFF;
            }

            .type a.orange {
                background-color: #007BFF;
                color: white;
            }
            /* Add these styles to your existing styles or create a new CSS file */

            .top-buyer {
                margin: 0 0 0 10px; /* Center the table */
                width: 80%; /* Set a width for better responsiveness */
                background-color: #f8f9fa; /* Add a background color to the table */
                border-radius: 8px; /* Add rounded corners to the table */
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Add a subtle box shadow */
            }

            table {
                width: 100%;
                border-collapse: collapse; /* Collapse borders for a cleaner look */
            }

            th, td {

                padding: 5px;
                text-align: center;
                border-bottom: 1px solid #dee2e6; /* Add a border between rows */
            }

            th {
                background-color: #007bff; /* Header background color */
                color: #ffffff; /* Header text color */
            }

            tbody tr:hover {
                background-color: #e2e6ea; /* Change background color on hover */
            }


        </style>
        <script>

            <%if (request.getAttribute("status") != null) {
            %>
            alert("${requestScope.status}");
            <%
                }%>
        </script>
    </head>

    <body>
        <div>
            <button onclick="topFunction()" id="myBtn" title="Go to top"><div class="ti-arrow-up"></div></button>
            <div class="header">
                <a href="home" id="logo"><img loading='lazy' class="logo" src="image/logo.png" alt="logo" ></a>
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
                        <a href="profile">Account<div class="ti-angle-down" style="margin-left: 5px; margin-top: 2px;" data-toggle="collapse" data-target="#demo"></div></a>
                        <div  id="demo" class="collapse">
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

                    ${sessionScope.account!=null?"| <img loading='lazy' style='width:30px;margin:10px'
                      src='https://cdn.sforum.vn/sforum/wp-content/uploads/2023/10/avatar-trang-4.jpg'
                      class='rounded-circle'>":""}

                </div>

            </div>

            <div style="width: 100%">
                <div class="banner1" style="background: url(image/background.jpg) ;background-size: 100% 100%; height: 60vh;align-content: center;">
                    <div style="width: 50vw;">
                        <h1 style="margin-top: 15vh;font-size: 3.5em;">BOOK STORE</h1>
                        <h3>find yourself in ourself</h3>
                    </div>
                </div>
            </div>
        </div>
        <br />
        <div style="position: absolute; height: 100vh; margin-top: 40px; width: 19vw">
            <div class="top-buyer" style="border-radius: 10px;">
                <table >
                    <thead >
                        <tr style=" animation: color-change 1s infinite;">
                            <th colspan="3">Top Đại Cao Thủ</th>
                        </tr>
                        <tr>
                            <th>No</th>
                            <th>Name</th>
                            <th>Ðã Mua</th>

                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${requestScope.listTop}" var="c" varStatus="i">
                            <tr>
                                <td>
                                    <c:if test="${i.index+1==1}">
                                        🥇
                                    </c:if>
                                    <c:if test="${i.index+1==2}">
                                        🥈
                                    </c:if><c:if test="${i.index+1==3}">
                                        🥉
                                    </c:if>
                                    <c:if test="${i.index+1>3}">
                                        ${i.index+1}
                                    </c:if>
                                </td>
                                <td>
                                    ${c.CUSTOMER_NAME}
                                </td>
                                <td>
                                    ${(c.TOTAL-(c.TOTAL%10000))/1000000 } M
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="container" style="width: 65vw;">
            <div class="slider" id="slider">
                <h2>NEW COLLECTION</h2>
                <div class="type">
                    <a href="home?type=0#slider" class="${requestScope.type==0?'orange':''}" >All</a>
                    <c:forEach items="${sessionScope.listC}" var="c" begin="0" step="2">
                        <a href="home?type=${c.CATEGORY_ID}#slider" class="${requestScope.type==c.CATEGORY_ID?'orange':''}">${c.CATEGORY_NAME}</a>
                    </c:forEach>
                </div>
                <div class="container-fluid" >
                    <div class="row">
                        <div class="col-xs-12 col-sm-12 col-md-12">
                            <div class="carousel carousel-showmanymoveone slide" id="itemslider">
                                <div class="carousel-inner">

                                    <c:forEach items="${requestScope.listP}" var="c" varStatus="loop" >
                                        <div class="item ${loop.index==0?'active':''}"> 
                                            <a href="detail?id=${c.PRODUCT_ID}">
                                                <div class="col-xs-12 col-sm-6 col-md-2" >
                                                    <img loading='lazy' src="${c.image}"
                                                         class="img-responsive center-block">
                                                    <h4 class="text-center">${c.PRODUCT_NAME}</h4>
                                                    <h6 style="color: red;text-decoration: line-through">${c.PRICE*120/100} VNÐ</h6>
                                                    <h5 class="text-center" style="color: #ff7800">${c.PRICE} VNÐ</h5>
                                                </div>
                                            </a>
                                        </div>
                                    </c:forEach>

                                </div>
                                <div id="slider-control">
                                    <a class="left carousel-control" href="#itemslider" data-slide="prev"><img loading='lazy'
                                            src="https://cdn0.iconfinder.com/data/icons/website-kit-2/512/icon_402-512.png"
                                            alt="Left" class="img-responsive"></a>
                                    <a class="right carousel-control" href="#itemslider" data-slide="next"><img loading='lazy'
                                            src="http://pixsector.com/cache/81183b13/avcc910c4ee5888b858fe.png"
                                            alt="Right" class="img-responsive"></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>          
            <!-- Item slider-->
            <h1 style="text-align: center;margin: 50px;">Best Seller</h1>
            <div class="banner">
                <c:forEach items="${requestScope.bestSeller.keySet()}" var="c" >
                    <a href="detail?id=${c.PRODUCT_ID}">
                        <div class="banner1" style="background: url(${c.image}) ;background-size: 100% 100%;     width: 15vw;
                             height: 15vw;">
                            <h3>Best Seller</h3>
                            <h1>${requestScope.bestSeller.get(c)}</h1>
                            <h3>was sold</h3>
                        </div>
                    </a>
                </c:forEach>
            </div>

            <div id="about" style="background: url(image/about.jpg);    background-size: 100% 100%;">
                <div style="margin: 30px">
                    <h1>BOOK STORE</h1>
                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
                </div>
            </div>

        </div>
        <div id="footer">
            <div>&copy;copyright by Phuc</div><br/><!-- comment -->
            <div><div class="ti-mobile">contact:<a href="tel:+84123456789">0123456789</a></div><br/><!-- comment -->
                <div> Email me: <a href="mailto:Phucxuanvo@gmail.com">Phucxuanvo@gmail.com</a></div><br/><!-- comment -->

            </div>
        </div>
        <script>

            $(document).ready(function () {

                $('#itemslider').carousel({interval: 2000});

                $('.carousel-showmanymoveone .item').each(function () {
                    var itemToClone = $(this);
                    var length = 6;
                    if ($('.carousel-showmanymoveone .item').length < 6) {
                        length = $('.carousel-showmanymoveone .item').length;
                    }


                    for (var i = 1; i < length; i++) {
                        itemToClone = itemToClone.next();
                        if (!itemToClone.length) {
                            itemToClone = $(this).siblings(':first');
                        }
                        itemToClone.children(':first-child').clone()
                                .addClass("cloneditem-" + (i))
                                .appendTo($(this));

                    }


                });
            });
            let mybutton = document.getElementById("myBtn");

// When the user scrolls down 20px from the top of the document, show the button
            window.onscroll = function () {
                scrollFunction()
            };

            function scrollFunction() {
                if ((document.body.scrollTop > 20 || document.documentElement.scrollTop > 20)) {
                    mybutton.style.display = "block";
                } else {
                    mybutton.style.display = "none";
                }
            }

// When the user clicks on the button, scroll to the top of the document
            function topFunction() {
                document.body.scrollTop = 0;
                document.documentElement.scrollTop = 0;
            }

        </script>
    </body>
</html>