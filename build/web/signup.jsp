<%-- 
    Document   : Register
    Created on : Feb 8, 2024, 7:53:08 PM
    Author     : TUF A15
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login</title>
        <link rel="stylesheet" href="bootstrap-5.3.2-dist/css/bootstrap.css">
        <link rel="stylesheet" href="css/login.css">
        <link rel="stylesheet" href="css/signup.css"/>

        <script>
            <%if(request.getAttribute("errorBuy")!=null){
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
                            <a href="login">Login</a>|<a href="" style="background: grey;border-radius: 5px;">Sign Up</a>
                        </div>
                    </div>
                    <form action="signup" method="post">

                        <div class="beside">
                            <input type="text" placeholder="NAME" name="name">
                            <select name="gender">
                                <option value="M">MALE</option>
                                <option value="F">FEMALE</option>
                            </select>
                        </div>
                        <input type="tel" placeholder="PHONE NUMBER" name="phone" >
                        <br/><!-- comment -->
                        <br/><!-- comment -->

                        BirthDay:
                        <input type="date" name="birthday">
                        <input type="text" placeholder="ADDRESS" name="address">
                        <input type="email" placeholder="EMAIL " name="email" required="">
                        <input type="password" placeholder="PASSWORD " name="pass" id="pass">
                        <input type="password" placeholder="CONFIRM UR PASSWORD " id="confirm">
                        <br>
                        <button type="button" onclick="check(this)">Submit</button>
                    </form>
                </div>

            </div>
            <img class="banner" src="image/signin.jpg" alt="">
        </div>
    </body>
    <script>
        function check(i) {
            if (document.getElementById("confirm").value === document.getElementById("pass").value) {
                var inp = document.getElementsByTagName("input");
                if (inp[1].value.match('[0]{1}[0-9]{9}')===null || inp[1].value.match('[0]{1}[0-9]{9}')[0] !== inp[1].value) {
                    alert("you must input a phone number like : 0987654321");
                    return;
                }
                if (inp[2].value.substr(0, 4) > 2012) {
                    alert("you must over 12 yeard old to sign up");
                    return;
                }
                for (var z = 0; z < inp.length; z++) {
                    if (inp[z].value.length === 0) {
                        alert("please enter all fields");
                        return;
                    }
                }
                i.parentNode.submit();
            } else {
                alert("wrong confirming password!!!");
            }
        }
    </script>
</html>
