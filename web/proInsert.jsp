<%-- 
    Document   : proInsert
    Created on : Jan 17, 2024, 8:46:20 AM
    Author     : TUF A15
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <c:forEach items="${requestScope.listP}" var="i">
            <c:set value="${i.PRODUCT_ID}" var="id" ></c:set>
        </c:forEach>

        <form action="AdInsert" method="post">
            id:<input type="number" value="${id+1}" readonly name="id"><br/>
            name:<textarea name="name"></textarea><br/>
            price:<input type="text" value="" name="price" ><br/>
            pages:<input type="number" value="" name="pages" ><br/>
            size:<input type="text" value="" name="size" ><br/>
            weight:<input type="text" value="" name="weight" ><br/>
            description:<textarea name="description"></textarea>
            <br/>
            language:<input type="text" value="" name="language" ><br/>
            book format:<input type="text" value="" name="format" ><br/>
            author id:
            <select name="author">
                <c:forEach items="${requestScope.listA}" var="c">
                    <option value="${c.AUTHOR_ID}">${c.AUTHOR_NAME}</option>
                </c:forEach>
            </select>
            <br/>
            publisher id:
            <select name="publisher">
                <c:forEach items="${requestScope.listPu}" var="c">
                    <option value="${c.PUBLISHER_ID}">${c.PUBLISHER_NAME}</option>
                </c:forEach>
            </select><br/>
            category id:
            <select name="category">
                <c:forEach items="${requestScope.listC}" var="c">
                    <option value="${c.CATEGORY_ID}">${c.CATEGORY_NAME}</option>
                </c:forEach>
            </select><br/>
            public day:<input type="date" value="" name="day" ><br/>
            amount:<input type="number" value="" name="amount" ><br/>
            image's link:<input type="text" value="" name="image" ><br/>
            <input type="submit" value="INSERT"/>
        </form>
    </body>
</html>
