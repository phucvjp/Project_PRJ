<%-- 
    Document   : cart
    Created on : Jan 20, 2024, 2:32:57 PM
    Author     : TUF A15
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cart</title>
        <link rel="stylesheet" href="css/cart.css"/>
        <link rel="stylesheet" href="css/order.css"/>
        <script>
            function goHome() {
                window.location.href = "home";
            }

        </script>
    </head>
    <body>
        <div id="qr" class="qr" style="display: none;">
            <button onclick="closeQR()" id="exit" style="display:block; position: absolute; z-index: 2; top:3%;right: 3%; background:red; padding:5px">X</button>
            <div style="display: block;text-align: center">
                <img src="image/QR.jpg" style="width: 500px;" alt="qr code"></br>
                <div style="display: block; background: #ffff00cc;" >
                    <h2 style="color: red"> Nội dung chuyển khoản : 'Mã đặt hàng' - Phúc đẹp zai  </h2>
                    <h4 style="color: #f3f316">Chú ý: sau khi thanh toán sẽ không hoàn tiền</h4>
                </div>
            </div>

        </div>
        <button onclick="goHome()">HOME</button>

        <h1>Your Favourite Book</h1>
        <c:if test="${sessionScope.favList!=null}">
            <div class="shopping-cart">
                <div class="column-labels" style="border-bottom: 1px solid #eee; margin-bottom: 15px;">
                    <label class="product-image">Image</label>
                    <label class="product-details">Product</label>
                    <label class="product-price">Price</label>
                    <label class="product-removal">Remove</label>
                </div>

                <form action="" method="post" id="changeQuant">
                    <c:forEach items="${sessionScope.favList}" var="c"> 
                        <div class="product">
                            <div class="product-image">
                                <a href="detail?id=${c.PRODUCT_ID}"><img src="${c.image}"></a>
                            </div>
                            <div class="product-details">
                                <div class="product-title">${c.PRODUCT_NAME}</div>
                                <p class="product-description">${c.DESCRIPTION}</p>
                            </div>
                            <div class="product-price" >${c.PRICE}</div>
                            <div class="product-removal">
                                <a class="remove-product" onclick="remove(${c.PRODUCT_ID})">Remove</a>
                            </div>
                        </div>

                    </c:forEach>
                </form>
            </div>
        </c:if>
    </body>
    <script>

        function remove(id) {
            if (confirm("remove product have id=" + id + "?") === true) {
                location.href = "fav?remove=" + id;
            }
        }

    </script>
</html>
