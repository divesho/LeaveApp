<!DOCTYPE html>
<html>
    <head>
        <title>PAGE | Sign Up</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="/leaveApp/resources/css/bootstrap.min.css">
        <script src="/leaveApp/resources/js/jquery.min.js"></script>
        <script src="/leaveApp/resources/js/bootstrap.min.js"></script>
    </head>
    <body>

        <div class="container">
            <div id="loginbox" style="margin-top:50px;" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">                    
                <div class="panel panel-info" >
                    <div class="panel-heading">
                        <div class="panel-title">Add User</div>
                        <div class="pull-right" style="font-size: 18px;position: relative; top:-20px"><span style="color: #DD4B39;">Jain</span> <span style="color: #BE1E21;">College</span> <span style="color: #7D5000;">Of</span> <span style="color: #2D79A5;">Engineering</span></div>
                    </div>
                    <div style="padding-top:30px;" class="panel-body" >
                        <div style="display:none" id="login-alert" class="alert alert-danger col-sm-12"></div>
                        <form id="loginform" class="form-horizontal" role="form" action="/leaveApp/main/signup" >
                            <%
                                String err = (String) request.getAttribute("err");
                                if (err != null) {

                            %>
                                <div class="alert alert-danger">
                                    <p>Error: <%=err%></p>
                                    <span></span>
                                </div>
                            <%
                                }
                            %>
                            <div id="signupalert" style="display:none" class="alert alert-danger">
                                <p></p>
                                <span></span>
                            </div>
                            <div style="margin-bottom: 25px" class="input-group">
                                <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                <input type="text" class="form-control" name="user" id="user" placeholder="user">                                        
                            </div>
                            <div style="margin-bottom: 25px" class="input-group">
                                <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                <input type="text" class="form-control" name="emailId" id="emailId" placeholder="email">                                        
                            </div>
                            <div style="margin-bottom: 25px" class="input-group">
                                <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                                <input type="password" class="form-control" name="passw" id="passw" placeholder="password">
                            </div>
                            <div style="margin-bottom: 25px" class="input-group">
                                <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                                <select name="type" id="type" class="form-control">
                                    <option disabled selected>user type</option>
                                    <option value="princi">Principal</option>
                                    <option value="admin">Administrator</option>
                                    <option value="hod">HOD</option>
                                    <option value="staff">Staff</option>
                                </select>
                            </div>
                            <div style="margin-top:10px" class="form-group">
                                <!-- Button -->
                                <div class="col-sm-12 controls">
                                    <input type="submit" class="form-control" value="submit" />
<!--                                    <input type="button" class="form-control" value="Login" onclick="login('emailId', 'passw', 'type')" />-->
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-12 control">
                                    <div style="border-top: 1px solid#888; padding-top:15px; font-size:85%" >
                                       Migrate to Sign in page! 
                                        <a href="index.jsp" >
                                            Click Here
                                        </a>
                                    </div>
                                </div>
                            </div>    
                        </form>
                    </div>                     
                </div>  
            </div>
        </div>
    </body>
</html>
