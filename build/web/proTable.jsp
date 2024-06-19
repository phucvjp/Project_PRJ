<%-- Document : proTable Created on : Jan 16, 2024, 10:49:18 PM Author : TUF A15 --%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product manager</title>
        <link rel="stylesheet" href="css/table.css" />
    </head>

    <body>
        <button onclick="goHome()">HOME</button>
        Search:
        <input type="radio" name="search" id="s1" onclick="openS1()"><label for="s1" checked="checked">By
            Name/Author Name/Category</label>
        <input type="radio" name="search" id="s2" onclick="openS2()"><label for="s2">By Type/Price</label>

        <form action="setting" method="get" id="search1" style="display: none">
            Name/Author Name/Category<input type="text" name="name">
            <input type="submit" value="SEARCH">
        </form>



        <form action="setting" method="get" id="search2" style="display: none">

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
                            <input type="number" class="min-input" value="${requestScope.max*10/100}">
                        </div>
                        <div class="price-field">
                            <span>Maximum Price</span>
                            <input type="number" class="max-input" value="${requestScope.max*90/100}">
                        </div>
                    </div>
                    <div class="slider-container">
                        <div class="price-slider">
                        </div>
                    </div>
                </div>

                <!-- Slider -->
                <div class="range-input">
                    <input type="range" class="min-range" min="0" max="${requestScope.max}"
                           value="${requestScope.max*10/100}" name="minP">
                    <input type="range" class="max-range" min="0" max="${requestScope.max}"
                           value="${requestScope.max*90/100}" name="maxP">
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
                <input type="radio" name="ord" value="asc" id="asc"><label for="asc"
                                                                           checked="checked">Ascending</label>
                <input type="radio" name="ord" value="desc" id="desc"><label for="desc">Descending</label>
            </div>
            <hr />
            <input type="submit" value="SEARCH">

        </form>
        <hr>
        <table border="1px">
            <tr>
                <th>ID</th>
                <th>NAME</th>
                <th>PRICE</th>
                <th>PAGES</th>
                <th>SIZE</th>
                <th>WEIGHT</th>
                <th>DESCRIPTION</th>
                <th> LANGUAGE</th>
                <th> BOOK_FORMAT</th>
                <th>AUTHOR</th>
                <th>PUBLISHER</th>
                <th>CATEGORY</th>
                <th>PUBLIC_DAY</th>
                <th>AMOUNT</th>
                <th>image</th>
                <th>Make Change</th>
            </tr>
            <c:forEach items="${requestScope.listP}" var="c">
                <tr>
                    <td>${c.PRODUCT_ID}</td>
                    <td>${c.PRODUCT_NAME}</td>
                    <td>${c.PRICE}</td>
                    <td>${c.PAGES}</td>
                    <td>${c.SIZE}</td>
                    <td>${c.WEIGHT}</td>
                    <td>${c.DESCRIPTION}</td>
                    <td>${c.LANGUAGE}</td>
                    <td>${c.BOOK_FORMAT} </td>
                    <c:forEach items="${requestScope.listA}" var="a">
                        <c:if test="${c.AUTHOR_ID==a.AUTHOR_ID}">
                            <td>${a.AUTHOR_NAME}</td>
                        </c:if>
                    </c:forEach>
                    <c:forEach items="${requestScope.listPu}" var="pu">
                        <c:if test="${c.PUBLISHER_ID==pu.PUBLISHER_ID}">
                            <td>${pu.PUBLISHER_NAME}</td>
                        </c:if>
                    </c:forEach>
                    <c:forEach items="${requestScope.listC}" var="ca">
                        <c:if test="${c.CATEGORY_ID==ca.CATEGORY_ID}">
                            <td>${ca.CATEGORY_NAME}</td>
                        </c:if>
                    </c:forEach>
                    <td>${c.PUBLIC_DAY}</td>
                    <td>${c.AMOUNT}</td>
                    <td><img style="width: 60px" src="${c.image}"></td>
                    <td>
                        <button onclick="confirmDel(${c.PRODUCT_ID})">Delete</button>
                        <a href="AdUpdate?id=${c.PRODUCT_ID}"><button>Update</button></a>
                    </td>
                </tr>
            </c:forEach>

        </table>
        <hr /><!-- comment -->
        <a href="AdInsert"><button style="background: pink;">INSERT</button></a>
    </body>
    <script>
        function goHome() {
            window.location.href = "home";
        }
        function openOrd() {
            document.getElementById("ord").style.display = "block";
        }

        function confirmDel(id) {
            if (confirm("Delete product have id=" + id + "?") === true) {
                window.location.href = "AdDelete?delete=" + id + "";
            }

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

</html>