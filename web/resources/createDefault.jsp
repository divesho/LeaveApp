<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--
To change this spancense header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../resources/css/bootstrap.min.css">
        <link rel="stylesheet" href="../resources/css/fullcalendar.css" />
        <script src="../resources/js/jquery.min.js"></script>
        <script src="../resources/js/bootstrap.min.js"></script>
        <script src="../resources/js/moment.min.js" ></script>
        <script src="../resources/js/fullcalendar.js" ></script>
    </head>
    <body>

        <div>
            <div class="panel panel-heading" style="font-size: 30px;color: #5BC0DE;">
                Leave App
                <div class="dropdown" style="float: right;">
                </div>
            </div>
            <div class="panel-body">
                <div style="float: left; width: 20%;">
                    <div data-toggle="modal" data-target="#regUsrAlert" class="btn btn-info" style="margin-top: 1%; height: 40px; width: 100%;">Register New User</div>
                </div>
            </div>
            <div class="panel panel-footer"></div>
        </div>
        <div id="regUsrAlert" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Register New User</h4>
                    </div>
                    <div class="modal-body" style="border: 1px solid #F5ECEC;">
                        <div style="padding: 11px;" id="regUserDiv">
                            <div class="panel-body" >
                                <div class="form-group">
                                    <label for="firstname" class="col-md-3 control-label">First Name</label>
                                    <div class="col-md-9">
                                        <input type="text" class="form-control" name="fname1" id="fname1" placeholder="First Name">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <br><br>
                                    <label for="lastname" class="col-md-3 control-label">Last Name</label>
                                    <div class="col-md-9">
                                        <input type="text" class="form-control" name="lname1" id="lname1" placeholder="Last Name">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <br><br>
                                    <label for="gender" class="col-md-3 control-label">Gender</label>
                                    <div class="col-md-9">
                                        <select name="gender" id="gender" class="form-control">
                                            <option value="male">Male</option>
                                            <option value="female">Female</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <br><br>
                                    <label for="email" class="col-md-3 control-label">Email</label>
                                    <div class="col-md-9">
                                        <input type="text" class="form-control" name="emailId1" id="emailId1" placeholder="Email Address">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <br><br>
                                    <label for="password" class="col-md-3 control-label">Password</label>
                                    <div class="col-md-9">
                                        <input type="password" class="form-control" name="passw1" id="passw1" placeholder="Password">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <br><br>
                                    <label for="password" class="col-md-3 control-label">Type</label>
                                    <div class="col-md-9">
                                        <select name="type1" id="type1" class="form-control">
                                            <option disabled selected>user type</option>
                                            <option value="princi">Principal</option>
                                            <option value="admin">Administrator</option>
                                            <option value="hod">HOD</option>
                                            <option value="staff">Staff</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div style="display:none; background-color: #9AD89A; margin-top: 6px;" id="notifyRegUsr"> Registration is done successfully.. </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-default" onclick="registerUSR('fname1', 'lname1', 'gender', 'emailId1', 'passw1', 'type1')">Register</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal" id="closeRegUsr">Close</button>
                    </div>
                </div>

            </div>
        </div>
        
    <script>
            
        function clearValues(id){
            $("#" + id).find('input[type=date]').val('');
            $("#" + id).find('textarea').val('');
            $("#" + id).find('input:text').val('');
            $("#" + id).find('input:password').val('');
            $("#" + id).find('input:radio').attr('checked', false);
        }


        function registerUSR(fname1, lname1, gender1, emailId1, passw1, type1) {
            var fname = $("#" + fname1)[0].value;
            var lname = $("#" + lname1)[0].value;
            var gender = $("#" + gender1)[0].value;
            var emailId = $("#" + emailId1)[0].value;
            var passw = $("#" + passw1)[0].value;
            var type = $("#" + type1)[0].value;
            var date = new Date();
            date = date.toLocaleDateString();

            var url = "/App/admin/usrReg?fname=" + fname + "&lname=" + lname + "&gender=" + gender + "&emailId=" + emailId + "&passw=" + passw + "&type=" + type + "&date=" + date;
            clearValues('regUserDiv');
            $.ajax({url: url, success: function (data) {
                    if (data == "success") {
                        $("#notifyRegUsr").show();
                        setTimeout(function () {
                            $("#notifyRegUsr").hide();
                            $("#closeRegUsr").click();
                        }, 1000);
                    }
                }});
        }
        </script>                  
    </body>
</html>
