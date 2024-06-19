<%-- 
    Document   : proUpdate
    Created on : Jan 17, 2024, 8:46:38 AM
    Author     : TUF A15
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            /* Basic styling for form elements */
            body {
                font-family: Arial, sans-serif;
                background-color: #f9f9f9;
            }

            form {
                max-width: 600px;
                margin: 0 auto;
                padding: 20px;
                background-color: #ffffff;
                border-radius: 5px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            input[type="text"],
            input[type="number"],
            textarea,
            select {
                width: 100%;
                padding: 10px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 3px;
                font-size: 14px;
            }

            /* Style the submit button */
            input[type="submit"] {
                background-color: #007bff;
                color: #ffffff;
                border: none;
                border-radius: 3px;
                padding: 10px 20px;
                cursor: pointer;
            }

            input[type="submit"]:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <form action="AdUpdate" method="post">
            id:<input type="number" value="${requestScope.proUpdate.PRODUCT_ID}" readonly name="id"><br/>
            name:<textarea name="name">${requestScope.proUpdate.PRODUCT_NAME}</textarea><br/>
            price:<input type="text" value="${requestScope.proUpdate.PRICE}" name="price" ><br/>
            pages:<input type="number" value="${requestScope.proUpdate.PAGES}" name="pages" ><br/>
            size:<input type="text" value="${requestScope.proUpdate.SIZE}" name="size" ><br/>
            weight:<input type="text" value="${requestScope.proUpdate.WEIGHT}" name="weight" ><br/>
            description:<textarea name="description">${requestScope.proUpdate.DESCRIPTION}</textarea>
            <br/>
            language:<input type="text" value="${requestScope.proUpdate.LANGUAGE}" name="language" ><br/>
            book format:<input type="text" value="${requestScope.proUpdate.BOOK_FORMAT}" name="format" ><br/>
            author id:
            <select name="author">
                <c:forEach items="${requestScope.listA}" var="c">
                    <option value="${c.AUTHOR_ID}" ${c.AUTHOR_ID==requestScope.proUpdate.AUTHOR_ID?'selected':''}>${c.AUTHOR_NAME}</option>
                </c:forEach>
            </select>
            <br/>
            publisher id:
            <select name="publisher">
                <c:forEach items="${requestScope.listPu}" var="c">
                    <option value="${c.PUBLISHER_ID}" ${c.PUBLISHER_ID==requestScope.proUpdate.PUBLISHER_ID?'selected':''}>${c.PUBLISHER_NAME}</option>
                </c:forEach>
            </select><br/>
            category id:
            <select name="category">
                <c:forEach items="${requestScope.listC}" var="c">
                    <option value="${c.CATEGORY_ID}" ${c.CATEGORY_ID==requestScope.proUpdate.CATEGORY_ID?'selected':''}>${c.CATEGORY_NAME}</option>
                </c:forEach>
            </select><br/>
            public day:<input type="datetime" value="${requestScope.proUpdate.PUBLIC_DAY}" name="day" ><br/>
            amount:<input type="number" value="${requestScope.proUpdate.AMOUNT}" name="amount" ><br/>
            image's link:<input type="text" value="${requestScope.proUpdate.image}" name="image" ><br/>
            <input type="submit" value="UPDATE"/>
        </form>
    </body>
</html>
