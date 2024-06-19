<%-- 
    Document   : search
    Created on : Jan 12, 2024, 10:45:57 PM
    Author     : TUF A15
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search</title>
        <link rel="stylesheet" href="css/table.css"/>
        <link rel="stylesheet" href="bootstrap-5.3.2-dist/css/bootstrap.css"/>
        <link rel="stylesheet" href="font/themify-icons-font/themify-icons/themify-icons.css">
        <link rel="stylesheet" href="css/home.css">
        <link rel="stylesheet" href="css/search.css">


    </head>
    <body>
        <div>
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
        </div>
        <div class="searchPro">
            Search:
            <input type="radio" name="search" id="s1" onclick="openS1()"><label
                for="s1" checked="checked">By Name/Author Name/Category</label>
            <input type="radio" name="search" id="s2" onclick="openS2()"><label
                for="s2">By Type/Price</label>

            <form action="search" method="get" id="search1" style="display: none">
                Name/Author Name/Category<input type="text" name="name">
                <input type="submit" value="SEARCH">
            </form>



            <form action="search" method="get" id="search2" style="display: none">

                Type:<select name="type">
                    <option value="0">All</option>
                    <c:forEach items="${requestScope.listC}" var="c">
                        <option value="${c.CATEGORY_ID}">${c.CATEGORY_NAME}</option>
                    </c:forEach>
                </select>
                <div class="custom-wrapper">
                    <h2 class="projtitle"> 
                        Price Range:
                    </h2> 
                    <!--                <label for="price-min">Price:</label>
                                    <input type="text" name="price-min" id="price-min" value="${requestScope.max*15/100}" min="0"
                                           max="${requestScope.max}">
                                    <label for="price-max">Price:</label>
                                    <input type="text" name="price-max" id="price-max" value="${requestScope.max*85/100}" min="0"
                                           max="${requestScope.max}">-->
                    <div class="price-input-container"> 
                        <div class="price-input"> 
                            <div class="price-field"> 
                                <span>Minimum Price</span> 
                                <input type="number" 
                                       class="min-input" 
                                       value="${requestScope.max*10/100}"> 
                            </div> 
                            <div class="price-field"> 
                                <span>Maximum Price</span> 
                                <input type="number" 
                                       class="max-input" 
                                       value="${requestScope.max*90/100}"> 
                            </div> 
                        </div> 
                        <div class="slider-container"> 
                            <div class="price-slider"> 
                            </div> 
                        </div> 
                    </div> 

                    <!-- Slider -->
                    <div class="range-input"> 
                        <input type="range" 
                               class="min-range" 
                               min="0" 
                               max="${requestScope.max}" 
                               value="${requestScope.max*10/100}" 
                               name="minP"
                               > 
                        <input type="range" 
                               class="max-range" 
                               min="0" 
                               max="${requestScope.max}" 
                               value="${requestScope.max*90/100}" 
                               name="maxP"
                               > 
                    </div> 
                </div>

                Sort by: <select onchange="openOrd()" name="sort">
                    <option value="0"></option>
                    <option value="PRODUCT_NAME">Name</option>
                    <option value="price">Price</option>
                    <option value="public_day">Public Day</option>
                    <option value="PRODUCT_ID">ID</option>
                    <option value="pages">Page</option>
                </select>
                <div id="ord" style="display: none;">
                    Order by: 
                    <input type="radio" name="ord" value="asc" id="asc"><label
                        for="asc" checked="checked">Ascending</label>
                    <input type="radio" name="ord" value="desc" id="desc"><label
                        for="desc">Descending</label>
                </div>
                <hr />
                <input type="submit" value="SEARCH">

            </form>
            <hr>       
        </div>
        <div class="product">
            <c:forEach items="${requestScope.listP}" var="c" varStatus="loop" >

                <div class="item"> 
                    <div style="background: red;color: yellow;height: fit-content;padding: 7px;border-radius:50% ;position: absolute">
                        Sale 20%
                    </div>
                    <a href="detail?id=${c.PRODUCT_ID}" style="margin: auto">
                        
                        <h4 class="text-center">${c.PRODUCT_NAME}</h4>
                        <img src="${c.image}"
                             class="img-responsive center-block ">
                        <h6 style="color: red;text-decoration: line-through">${c.PRICE*120/100} VNÐ</h6>
                        <h5 class="text-center">${c.PRICE} VNÐ</h5>
                        
                    </a>
                </div>
                
            </c:forEach>
        </div>
        <script> function openOrd() {
                document.getElementById("ord").style.display = "block";
            }

            function openS1() {
                document.getElementById("search1").style.display = "block";
                document.getElementById("search2").style.display = "none";

            }
            function openS2() {
                document.getElementById("search2").style.display = "block";
                document.getElementById("search1").style.display = "none";
            }

            // Script.js 
            const rangevalue =
                    document.querySelector(".slider-container .price-slider");
            const rangeInputvalue =
                    document.querySelectorAll(".range-input input");

// Set the price gap 
            let priceGap = 500;

// Adding event listners to price input elements 
            const priceInputvalue =
                    document.querySelectorAll(".price-input input");
            for (let i = 0; i < priceInputvalue.length; i++) {
                priceInputvalue[i].addEventListener("input", e => {

                    // Parse min and max values of the range input 
                    let minp = parseInt(priceInputvalue[0].value);
                    let maxp = parseInt(priceInputvalue[1].value);
                    let diff = maxp - minp;

                    if (minp < 0) {
                        alert("minimum price cannot be less than 0");
                        priceInputvalue[0].value = 0;
                        minp = 0;
                    }

                    // Validate the input values 
                    if (maxp > 10000) {
                        alert("maximum price cannot be greater than 10000");
                        priceInputvalue[1].value = 10000;
                        maxp = 10000;
                    }

                    if (minp > maxp - priceGap) {
                        priceInputvalue[0].value = maxp - priceGap;
                        minp = maxp - priceGap;

                        if (minp < 0) {
                            priceInputvalue[0].value = 0;
                            minp = 0;
                        }
                    }

                    // Check if the price gap is met 
                    // and max price is within the range 
                    if (diff >= priceGap && maxp <= rangeInputvalue[1].max) {
                        if (e.target.className === "min-input") {
                            rangeInputvalue[0].value = minp;
                            let value1 = rangeInputvalue[0].max;
                            rangevalue.style.left = `${(minp / value1) * 100}%`;
                        } else {
                            rangeInputvalue[1].value = maxp;
                            let value2 = rangeInputvalue[1].max;
                            rangevalue.style.right =
                                    `${100 - (maxp / value2) * 100}%`;
                        }
                    }
                });

                // Add event listeners to range input elements 
                for (let i = 0; i < rangeInputvalue.length; i++) {
                    rangeInputvalue[i].addEventListener("input", e => {
                        let minVal =
                                parseInt(rangeInputvalue[0].value);
                        let maxVal =
                                parseInt(rangeInputvalue[1].value);

                        let diff = maxVal - minVal;

                        // Check if the price gap is exceeded 
                        if (diff < priceGap) {

                            // Check if the input is the min range input 
                            if (e.target.className === "min-range") {
                                rangeInputvalue[0].value = maxVal - priceGap;
                            } else {
                                rangeInputvalue[1].value = minVal + priceGap;
                            }
                        } else {

                            // Update price inputs and range progress 
                            priceInputvalue[0].value = minVal;
                            priceInputvalue[1].value = maxVal;

                        }
                    });
                }
            }
        </script>
    </body>
</html>
