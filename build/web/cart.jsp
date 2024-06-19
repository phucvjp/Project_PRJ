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
            function openQR() {
                document.getElementById("qr").style.display = "flex";
                alert("click on the X button to confirm the transaction");

            }
            function closeQR() {
                document.getElementById("qr").style.display = "none";
                document.getElementById("changeQuant").action = "checkout";
                document.getElementById("changeQuant").submit();
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

        <h1>Shopping Cart</h1>

        <div class="shopping-cart">

            <div class="column-labels" style="border-bottom: 1px solid #eee; margin-bottom: 15px;">
                <label class="product-image">Image</label>
                <label class="product-details">Product</label>
                <label class="product-price">Price</label>
                <label class="product-quantity">Quantity</label>
                <label class="product-removal">Remove</label>
                <label class="product-line-price">Total</label>
            </div>

            <form action="" method="post" id="changeQuant" >
                <c:forEach items="${sessionScope.cartM}" var="c"> 
                    ${c.value<= c.key.AMOUNT?"":"<h3 style='color:red' id='error'>this product is out of stock or not enough. Add again or remove it to continue buying!!!</h3>"}
                    <div class="product">
                        <div class="product-image">
                            <a href="detail?id=${c.key.PRODUCT_ID}"><img src="${c.key.image}"></a>
                        </div>
                        <div class="product-details">
                            <div class="product-title">${c.key.PRODUCT_NAME}</div>
                            <p class="product-description">${c.key.DESCRIPTION}</p>
                        </div>
                        <div class="product-price" id="P${c.key.PRODUCT_ID}">${c.key.PRICE}</div>
                        <div class="product-quantity">
                            <input type="number" value="${c.value}" min="1" onchange="change(${c.key.PRODUCT_ID})" id="Q${c.key.PRODUCT_ID}" name="${c.key.PRODUCT_ID}" max="${c.key.AMOUNT}" ${c.value<= c.key.AMOUNT?'':'disabled'}>
                        </div>
                        <div class="product-removal">
                            <a class="remove-product" onclick="remove(${c.key.PRODUCT_ID})">Remove</a>
                        </div>
                        <div class="product-line-price" id="L${c.key.PRODUCT_ID}">${c.value<= c.key.AMOUNT?c.key.PRICE*c.value:0}</div>
                    </div>

                </c:forEach>
            </form>

            <h2>${requestScope.error}</h2>

            <div class="totals">
                <div class="totals-item">
                    <label>Total</label>
                    <div class="totals-value" id="cart-subtotal">
                        <c:set var="i" value="0"></c:set>
                        <c:forEach items="${sessionScope.cartM}" var="c">
                            <c:set var="i" value="${c.value<= c.key.AMOUNT?i+c.key.PRICE*c.value:i}"></c:set>
                        </c:forEach>
                        ${i}
                    </div>
                </div>

            </div>
            <button class="checkout" form="changeQuant">Save</button>
            <button style="margin-right: 20px" class="checkout" onclick="checkOut()">Checkout</button>
        </div>
    </body>
    <script>
        function change(id) {
            var price = document.getElementById("P" + id).innerHTML;
            var quant = document.getElementById("Q" + id).value;
            document.getElementById("L" + id).innerHTML = price * quant;
            var total = 0;
            for (var i = 1; i < document.getElementsByClassName("product-line-price").length; i++) {
                total += parseFloat(document.getElementsByClassName("product-line-price")[i].innerHTML);
            }
            document.getElementById("cart-subtotal").innerHTML = total;
        }
        function remove(id) {
            if (confirm("remove product have id=" + id + "?") === true) {
                location.href = "cart?remove=" + id;
            }
        }
        function saveCart() {
            document.getElementById("changeQuant").action = "cart";
            document.getElementById("changeQuant").submit();
        }
        function checkOut() {
            var quan = document.getElementsByTagName("input");
            var check = true;
            for (var i = 0; i < quan.length; i++) {
                if (quan[i].value - quan[i].max > 0) {
                    alert("some products are out of stock");
                    return 0;
                }
            }
            if (check === true) {
                if (confirm("sub total : " + ${i} + "$  . confirm buying?")) {
                    if (document.getElementById("error") === null) {
                        openQR();
                    } else
                        alert("look at the error");
                }
            }
            return 1;
        }
    </script>
</html>
