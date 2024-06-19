<%-- 
    Document   : product
    Created on : Jan 20, 2024, 10:41:05 AM
    Author     : TUF A15
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product detail</title>
        <link rel="stylesheet" href="bootstrap-5.3.2-dist/css/bootstrap.css"/>
        <link rel="stylesheet" href="font/themify-icons-font/themify-icons/themify-icons.css">
        <link rel="stylesheet" href="css/home.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="css/product.css"/>
        <style>
            .detail{
                margin: 70px;
            }
            table{
                margin:20px 0 50px 0;
            }
            table td:first-child{
                width: 200px;
                padding: 5px 0;
            }
            tr{
                border-bottom: 1px solid gainsboro;
            }
        </style>
    </head>
    <body>
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
        <section class="py-5">
            <div class="container">
                <div class="row gx-5">
                    <aside class="col-lg-6">
                        <div class="border rounded-4 mb-3 d-flex justify-content-center">
                            <a data-fslightbox="mygalley" class="rounded-4" target="_blank" data-type="image" href="${requestScope.product.image}">
                                <img style="max-width: 100%; height: 80vh; margin: auto;" class="rounded-4 fit" src="${requestScope.product.image}" />
                            </a>
                        </div>

                        <!-- thumbs-wrap.// -->
                        <!-- gallery-wrap .end// -->
                    </aside>
                    <main class="col-lg-6">
                        <div class="ps-lg-3">
                            <h4 class="title text-dark">
                                ${requestScope.product.PRODUCT_NAME}
                            </h4>
                            <div class="d-flex flex-row my-3">
                                <div class="text-warning mb-1 me-2">
                                    <c:forEach begin="1" end="${requestScope.avg}" step="1" varStatus="loop">
                                        <i class="fa fa-star"></i>
                                        <c:set value="${loop.index}" var="i"></c:set>
                                    </c:forEach>
                                    <c:if test="${requestScope.avg-i>0}">
                                        <i class="fa fa-star-half-o"></i>
                                    </c:if>
                                    <c:forEach begin="1" end="${5-requestScope.avg}" step="1" varStatus="loop">
                                        <i class="fa fa-star-o"></i>
                                    </c:forEach>
                                    <span class="ms-1">
                                        ${requestScope.avg}
                                    </span>
                                </div>
                                <span class="text-muted"><i class="fa fa-shopping-basket fa-sm mx-1"></i>${requestScope.product.AMOUNT} left</span>
                                ${requestScope.product.AMOUNT!=0?'<span class="text-success ms-2">In stock</span>':'<span class="text-success ms-2" style="color:red!important;"><h5>Sold out</h5></span>'}
                            </div>

                            <div class="mb-3">
                                <span class="h5">${requestScope.product.PRICE} VNÐ</span>
                                <span class="text-muted">/product</span>
                            </div>

                            <p>
                                ${requestScope.product.DESCRIPTION}
                            </p>

                            <hr />
                            <form action="detail" method="post" >
                                <div class="row mb-4">
                                    <!-- col.// -->
                                    <div class="col-md-4 col-6 mb-3">
                                        <label class="mb-2 d-block">Quantity</label>
                                        <div class="input-group mb-3" style="width: 170px;">
                                            <button class="btn btn-white border border-secondary px-3" type="button" id="button-addon1" data-mdb-ripple-color="dark" onclick="minusQuan()" disabled>
                                                <i class="fa fa-minus"></i>
                                            </button>
                                            <input readonly="" name="${requestScope.product.PRODUCT_ID}" id="quantity" type="text" class="form-control text-center border border-secondary" value="1" aria-label="Example text with button addon" aria-describedby="button-addon1" min="1" max="${requestScope.product.AMOUNT}"/>
                                            <button class="btn btn-white border border-secondary px-3" type="button" id="button-addon2" data-mdb-ripple-color="dark" onclick="plusQuan()">
                                                <i class="fa fa-plus"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <h1 style="color: red">${requestScope.product.AMOUNT!=0?"":"Out of stock!"}</h1>
                                <a ${requestScope.product.AMOUNT!=0?"":"hidden"}  href="#" class="btn btn-warning shadow-0" onclick="buy()"> Buy now </a>
                                <a ${requestScope.product.AMOUNT!=0?"":"hidden"}  class="btn btn-primary shadow-0" onclick="this.parentNode.submit()"> <i class="me-1 fa fa-shopping-basket"></i> Add to cart </a>
                                <a href="fav?add=${requestScope.product.PRODUCT_ID}" class="btn btn-light border border-secondary py-2 icon-hover px-3"> <i class="me-1 fa fa-heart fa-lg"></i> Save </a>
                            </form>
                        </div>
                        <div class="detail">
                            <h3>Thông tin chi tiết</h3>
                            <table>
                                <tr>
                                    <td>Nhà phát hành</td>
                                    <td>${requestScope.pub}</td>
                                </tr>
                                <tr>
                                    <td>Ngày xuất bản</td>
                                    <td>${requestScope.product.PUBLIC_DAY}</td>
                                </tr>
                                <tr>
                                    <td>Kích cỡ</td>
                                    <td>${requestScope.product.SIZE} (cm)</td>
                                </tr>
                                <tr>
                                    <td>cân nặng</td>
                                    <td>${requestScope.product.WEIGHT} (g)</td>
                                </tr>
                                <tr>
                                    <td>Ngôn ngữ</td>
                                    <td>${requestScope.product.LANGUAGE}</td>
                                </tr>
                                <tr>
                                    <td>Loại bia</td>
                                    <td>${requestScope.product.BOOK_FORMAT}</td>
                                </tr>
                                <tr>
                                    <td>Số trang</td>
                                    <td>${requestScope.product.PAGES}</td>
                                </tr>
                                <tr>
                                    <td>Tác giả</td>
                                    <td>${requestScope.author}</td>
                                </tr>
                            </table>
                        </div>
                    </main>
                </div>
            </div>
            <br/>
            <div class="rate">
                <c:forEach begin="1" end="${requestScope.avg}" step="1" varStatus="loop">
                    <i class="fa fa-star"></i>
                    <c:set value="${loop.index}" var="i"></c:set>
                </c:forEach>
                <c:if test="${requestScope.avg-i>0}">
                    <i class="fa fa-star-half-o"></i>
                </c:if>
                <c:forEach begin="1" end="${5-requestScope.avg}" step="1" varStatus="loop">
                    <i class="fa fa-star-o"></i>
                </c:forEach>
                <p>${requestScope.avg} average based on ${requestScope.numEva} reviews.</p>
                <hr style="border:3px solid #f1f1f1">

                <div class="row">
                    <div class="side">
                        <div>5 star</div>
                    </div>
                    <div class="middle">
                        <div class="bar-container">
                            <div class="bar-5" style="width: 0;width: ${requestScope.star5/requestScope.numEva*100}%;"></div>
                        </div>
                    </div>
                    <div class="side right">
                        <div>${requestScope.star5}</div>
                    </div>
                    <div class="side">
                        <div>4 star</div>
                    </div>
                    <div class="middle">
                        <div class="bar-container">
                            <div class="bar-4" style="width: 0;width: ${requestScope.star4/requestScope.numEva*100}%" ></div>
                        </div>
                    </div>
                    <div class="side right">
                        <div>${requestScope.star4}</div>
                    </div>
                    <div class="side">
                        <div>3 star</div>
                    </div>
                    <div class="middle">
                        <div class="bar-container">
                            <div class="bar-3" style="width: 0;width: ${requestScope.star3/requestScope.numEva*100}%"></div>
                        </div>
                    </div>
                    <div class="side right">
                        <div>${requestScope.star3}</div>
                    </div>
                    <div class="side">
                        <div>2 star</div>
                    </div>
                    <div class="middle">
                        <div class="bar-container">
                            <div class="bar-2" style="width: 0;width: ${requestScope.star2/requestScope.numEva*100}%"></div>
                        </div>
                    </div>
                    <div class="side right">
                        <div>${requestScope.star2}</div>
                    </div>
                    <div class="side">
                        <div>1 star</div>
                    </div>
                    <div class="middle">
                        <div class="bar-container">
                            <div class="bar-1" style="width: 0;width: ${requestScope.star1/requestScope.numEva*100}%"></div>
                        </div>
                    </div>
                    <div class="side right">
                        <div>${requestScope.star1}</div>
                    </div>
                </div>
            </div>
            <div class="comment" id="comment">
                <form action="detail">
                    <input type="text" name="id" value="${requestScope.product.PRODUCT_ID}" hidden="">
                    <input type="radio" value="0" name="star" onclick="this.parentNode.submit()" checked>
                    All
                    <input type="radio" value="1" name="star" onclick="this.parentNode.submit()" ${requestScope.star==1?'checked':''}>
                    1 star
                    <input type="radio" value="2" name="star" onclick="this.parentNode.submit()" ${requestScope.star==2?'checked':''}>
                    2 star
                    <input type="radio" value="3" name="star" onclick="this.parentNode.submit()" ${requestScope.star==3?'checked':''}>
                    3 star
                    <input type="radio" value="4" name="star" onclick="this.parentNode.submit()" ${requestScope.star==4?'checked':''}>
                    4 star
                    <input type="radio" value="5" name="star" onclick="this.parentNode.submit()" ${requestScope.star==5?'checked':''}>
                    5 star
                </form>
                <hr/>
                <c:forEach items="${requestScope.eva}" var="c" >
                    <div style="margin: 10px 0; ">
                        <h3>${c.CUSTOMER_NAME}</h3>
                        <div class="text-warning mb-1 me-2">
                            <c:forEach begin="1" end="${c.EVA_SCORE}" step="1" varStatus="loop">
                                <i class="fa fa-star"></i>
                                <c:set value="${loop.index}" var="i"></c:set>
                            </c:forEach>
                            <c:if test="${c.EVA_SCORE-i>0}">
                                <i class="fa fa-star-half-o"></i>
                            </c:if>
                            <c:forEach begin="1" end="${5-c.EVA_SCORE}" step="1" varStatus="loop">
                                <i class="fa fa-star-o"></i>
                            </c:forEach>
                        </div>
                        <p>${c.EVA_TIME}</p>
                        <textarea style="width: 90%;" readonly>${c.EVA_CONTENT}</textarea>
                    </div>
                </c:forEach>
            </div>
        </section>
        <div id="footer">
            <div>&copy;copyright by Phuc</div><br/><!-- comment -->
            <div><div class="ti-mobile">contact:<a href="tel:+84123456789">0123456789</a></div><br/><!-- comment -->
                <div> Email me: <a href="mailto:Phucxuanvo@gmail.com">Phucxuanvo@gmail.com</a></div><br/><!-- comment -->

            </div>
        </div>
    </body>
    <script>
        function buy() {
            if (confirm("are you sure you want to buy " + document.getElementById("quantity").value + " of this stuff?")) {
                document.getElementsByTagName("form")[0].method = "get";
                document.getElementsByTagName("form")[0].submit();
            }
        }
        function minusQuan() {
            if (document.getElementById("quantity").value > 1) {
                document.getElementById("quantity").value--;
                document.getElementById("button-addon2").disabled = false;
                if (document.getElementById("quantity").value === 1) {
                    document.getElementById("button-addon1").disabled = true;
                }
            } else {
                document.getElementById("button-addon1").disabled = true;
            }
        }
        function plusQuan() {
            if (document.getElementById("quantity").max - document.getElementById("quantity").value > 0) {
                document.getElementById("quantity").value++;
                document.getElementById("button-addon1").disabled = false;
                if (document.getElementById("quantity").max - document.getElementById("quantity").value === 0) {
                    document.getElementById("button-addon2").disabled = true;
                }

            } else {
                document.getElementById("button-addon2").disabled = true;
            }
        }
    </script>
</html>
