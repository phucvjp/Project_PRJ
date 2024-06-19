<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login</title>
        <link rel="stylesheet" href="bootstrap-5.3.2-dist/css/bootstrap.css">
        <link rel="stylesheet" href="css/login.css">
        <script>
            <%if (request.getAttribute("errorBuy") != null) {
            %>
            alert("${requestScope.errorBuy}");
            <%
                }%>
        </script>
    </head>

    <body>
        <div class="page">
            <div class="login">
                <div class="form"  >
                    <div class="form-head">
                        <a href="home"><img src="image/logo.png" alt=""></a>
                        <div style="display: flex;">
                            <a href="" style="background: grey;border-radius: 5px; ">Login</a>|<a href="signup">Sign Up</a>
                        </div>
                    </div>
                    <form action="login" method="post" >
                        <h1>Log In</h1>
                        <small>Log in to continue in our website </small>
                        <div class="form-group">
                            <label></label>
                            <input type="email" class="form-control" id="username" placeholder="Enter username " name="username" value="${requestScope.user}">

                        </div>
                        <div class="form-group">
                            <label></label>
                            <input type="password" class="form-control" id="password" name="password" value="${requestScope.pass}"
                                   placeholder="Password">
                        </div>
                        <hr>
                        <div class="form-group form-check flex">
                            <div><input type="checkbox" class="form-check-input" id="remember" name="remember" ${requestScope.rem!=null?'checked':''}>

                                <label class="form-check-label" for="remember"> remember me</label>
                            </div>

                        </div>
                        <h1 style="color: red">${requestScope.error}</h1>
                        <button type="submit" class="btn btn-primary">Login</button>
                    </form>
                </div>

            </div>
            <img class="banner" src="image/signin.jpg" alt="">
        </div>
    </body>

</html>