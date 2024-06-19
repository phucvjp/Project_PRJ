<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cart</title>
        <link rel="stylesheet" href="css/cart.css"/>
        <script>
            function goHome() {
                window.location.href = "home";
            }
        </script>
    </head>
    <body>
        <button onclick="goHome()">HOME</button>

        <h1>Your Order</h1>

        <div class="shopping-cart">

            <div class="column-labels">
                <label class="product-image">Image</label>
                <label class="product-details">Product</label>
                <label class="product-price">Price</label>
                <label class="product-removal" >Remove</label>

            </div>
            <c:set property="d" value="${requestScope.d}" var="d"/>
            <form action="" method="post" id="changeQuant">
                <c:forEach items="${requestScope.orderDetail}" var="c"> 
                    <div class="product">
                        <div class="product-image">
                            <a href="detail?id=${c.PRODUCT_ID}"><img src="${d.getP(c.PRODUCT_ID).image}"></a>
                        </div>
                        <div class="product-details">
                            <div class="product-title">${d.getP(c.PRODUCT_ID).PRODUCT_NAME}</div>
                            <p class="product-description">${d.getP(c.PRODUCT_ID).DESCRIPTION}</p>
                        </div>
                        <div class="product-price">${d.getP(c.PRODUCT_ID).PRICE}</div>
                        <div class="product-quantity">
                            <input type="number" value="${c.AMOUNT}" readonly >
                        </div>
                        <div class="product-removal" >
                            <c:if test="${requestScope.order.PAYING}">        
                                <a class="remove-product" style="float: right" href="rate?pid=${c.EVALUATED==false?c.PRODUCT_ID:0}&oid=${c.ORDER_ID}" ${c.EVALUATED==false?'':'hidden'}>${c.EVALUATED==false?"rating":"have been rated"}</a>
                            </c:if>
                        </div>
                    </div>

                </c:forEach>
            </form>

            <div class="totals">
                <div class="totals-item">
                    <label>Total</label>
                    <div class="totals-value" id="cart-subtotal">
                        ${requestScope.order.TOTAL_PRICE}
                    </div>
                </div>


            </div>
        </div>
    </body>
</html>