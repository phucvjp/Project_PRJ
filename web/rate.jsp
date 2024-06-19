<%-- 
    Document   : rate
    Created on : Feb 7, 2024, 10:25:41 AM
    Author     : TUF A15
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="css/cart.css"/>
        <link rel="stylesheet" href="css/rate.css"/>
        <style>
            /* css/rate.css */

            body {
                font-family: 'Arial', sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }

            .container {
                max-width: 800px;
                margin: 20px auto;
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            h2 {
                color: #333;
                text-align: center;
            }

            .rate {
                list-style-type: none;
                padding: 0;
                margin: 10px 0;
                text-align: center;
            }

            .rate input {
                display: none;
            }

            .rate label {
                font-size: 24px;
                color: #ddd;
                float: right;
                cursor: pointer;
                transition: color 0.3s ease;
            }

            .rate input:checked + label {
                color: #ffc107;
            }

            textarea {
                width: 100%;
                padding: 10px;
                margin-top: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
                resize: none;
            }

            input[type="submit"],
            input[type="reset"] {
                display: inline-block;
                padding: 10px 20px;
                margin-top: 20px;
                background-color: #4caf50;
                color: #fff;
                text-decoration: none;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            input[type="reset"] {
                background-color: #f44336;
            }

            input[type="submit"]:hover,
            input[type="reset"]:hover {
                background-color: #45a049;
            }


        </style>
    </head>
    <body>
        <div class="product" style="display: flex; justify-content: center">
            <div class="product-image" style="text-align: right;margin-right: 20px;">
                <img style="width:70px; " src="${requestScope.pro.image}">
            </div>
            <div class="product-details">
                <div class="product-title">${requestScope.pro.PRODUCT_NAME}</div>
            </div>
        </div>
        <div style="display: flex;justify-content: center">
            <form action="rate" method="post" style="padding: 20px 50px; box-shadow: 10px 10px 30px #333;border-radius: 20%">
                <input type="hidden" readonly value="${requestScope.pid}" name="pid">
                <input type="hidden" readonly value="${requestScope.oid}" name="oid">
                <div>
                Rating:
                </div>
                <div class="rate">
                    <input type="radio" id="star5" name="rate" value="5" checked/>
                    <label for="star5" title="oh yeah BABY 😍">5 stars</label>
                    <input type="radio" id="star4" name="rate" value="4" />
                    <label for="star4" title="very good 😲">4 stars</label>
                    <input type="radio" id="star3" name="rate" value="3" />
                    <label for="star3" title="not so bad 👍">3 stars</label>
                    <input type="radio" id="star2" name="rate" value="2" />
                    <label for="star2" title="bruh 😞">2 stars</label>
                    <input type="radio" id="star1" name="rate" value="1" />
                    <label for="star1" title="we need to talk 😿">1 star</label>
                </div>
                <br/>
                <div style="clear: both;"></div>
                Comment:            <br/>
                <textarea style="width: 20vw;height: 8vw;" placeholder="enter your experience..." name="content"></textarea>
                <br/>

                <input type="submit">
                <input type="reset">
            </form>
        </div>

    </body>
</html>
