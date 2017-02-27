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
        <title>Admin</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="/App/resources/css/bootstrap.min.css">
        <link rel="stylesheet" href="/App/resources/css/fullcalendar.css" />
        <script src="/App/resources/js/jquery.min.js"></script>
        <script src="/App/resources/js/bootstrap.min.js"></script>
        <script src="/App/resources/js/moment.min.js" ></script>
        <script src="/App/resources/js/fullcalendar.js" ></script>
    </head>
    <body>
        <%
            String user = null;
            if (session.getAttribute("user") == null) {
                response.sendRedirect("index.jsp");
            } else {
                user = (String) session.getAttribute("user");
                JSONObject obj = (JSONObject) request.getAttribute("obj");
        %>
        <input style="display:none" id="hidden1" value="<%=obj.getString("emailId")%>" />
        <input style="display:none" id="hidden2" value="<%=obj.getDouble("leaves")%>" />
        <input style="display:none" id="hidden3" value="<%=obj.getDouble("leaveBal")%>" />
        <div>
            <div class="panel panel-heading" style="font-size: 30px;color: #5BC0DE;">
                Leave App
                <div class="dropdown" style="float: right;">
                    <button class="btn btn-default dropdown-toggle" style="margin-top: -8%;" type="button" id="menu1" data-toggle="dropdown">User
                        <span class="caret"></span></button>
                    <ul class="dropdown-menu dropdown-menu-right" style="width: 180px !important;" role="menu" aria-labelledby="menu1" >
                        <li style="padding-left: 2%;"><span>*&nbsp;</span><%=obj.getString("usrFname")%> &nbsp; <%=obj.getString("usrLname")%></li>
                        <li class="divider"></li>
                        <!--                      <li data-toggle="modal" data-target="#completeLeaveAlert" style="padding-left: 2%; cursor: pointer;"><span>*&nbsp;</span>Leave Request Summary</li>-->
                        <li data-toggle="modal" data-target="#reqNotifyAlert" style="padding-left: 2%; cursor: pointer;"><span>*&nbsp;</span>Request Notifications</li>
                        <li data-toggle="modal" data-target="#settingAlert" style="padding-left: 2%; cursor: pointer;"><span>*&nbsp;</span>Settings</li>
                        <li class="divider"></li>
                        <li data-toggle="modal" data-target="#logoutAlert" style="padding-left: 2%; cursor: pointer;" id="logout"><span>*&nbsp;</span>Logout</li>
                    </ul>
                </div>
            </div>
            <div class="panel-body">
                <div style="float: left; width: 20%;">
                    <div data-toggle="modal" data-target="#reqAlert" class="btn btn-info" style="margin-top: 1%; height: 40px; width: 100%;display: none;">Request For Leave</div>
                    <div data-toggle="modal" data-target="#regUsrAlert" class="btn btn-info" style="margin-top: 1%; height: 40px; width: 100%;">Register New User</div>
                    <div data-toggle="modal" data-target="#delUsrAlert" class="btn btn-info" style="margin-top: 1%; height: 40px; width: 100%;">Delete User</div>
                    <div data-toggle="modal" data-target="#getAllUserAlert" class="btn btn-info allUser" style="margin-top: 1%; height: 40px; width: 100%;">All User</div>
                    <div data-toggle="modal" data-target="#getyearHLAlert" class="btn btn-info allUser" style="margin-top: 1%; height: 40px; width: 100%;">Add Year Holiday List</div>
                    <div data-toggle="modal" data-target="#" id="updateLeaveBalLink" class="btn btn-info" onclick="updateLeaveBal()" style="margin-top: 1%; height: 40px; width: 100%;">Update Month Leave Balance</div>

                </div>
                <div style="float: left; margin-left: 2%;">
                    <div id="calendarId" style="border: 1px solid #F5ECEC; padding: 1%; width:600px; height: 500px;"></div>
                    <div id="reference" style="border: 1px solid #F5ECEC; height: 30px;padding: 1%;margin-top: 1%;">
                        <span style="margin-left: 1%; height:3px;width:3px;background-color:#267ED8;">&nbsp;&nbsp;&nbsp;&nbsp;</span> Year Holiday List
                        <span style="margin-left: 1%; height:3px;width:3px;background-color:green;">&nbsp;&nbsp;&nbsp;&nbsp;</span> Accepted
                        <span style="margin-left: 1%; height:3px;width:3px;background-color:#FF7000;">&nbsp;&nbsp;&nbsp;&nbsp;</span> Pending
                        <span style="margin-left: 1%; height:3px;width:3px;background-color:red;">&nbsp;&nbsp;&nbsp;&nbsp;</span> Rejected
                    </div>
                </div>
                <div style="float: right; margin-right: 3%;">
                    <div style="width: 320px;margin-top: 5%; border: 1px solid #F5ECEC;;" >
                        <div class="panel-footer">Leave Summnary</div>
                        <div class="panel-body" style="height: 100px;">
                            Personal Leave Balance : <span id="leaveBal"></span><br>
                            Total Leave Balance : <span id="remaingLeaves"></span><br>
                        </div>
                        <div class="panel-footer"></div>
                    </div>
                    <div style="width: 320px;margin-top: 5%; border: 1px solid #F5ECEC;" >
                        <div class="panel-footer">Year Holidays</div>
                        <div class="panel-body" style="height: 250px;overflow-y: scroll;">
                            <table>
                                <%
                                    JSONArray yearArr = (JSONArray) obj.getJSONArray("yearHL");
                                    for (int i = 0; i < yearArr.length(); i++) {
                                        JSONObject yearObj = yearArr.getJSONObject(i);
                                        String yearReason = yearObj.getString("reason");
                                        String yearDate = yearObj.getString("date");

                                %>
                                <tr><td> <%=yearReason%> </td><td> : <%=yearDate%> </td></tr>

                                <%
                                    }
                                %>
                            </table>
                        </div>
                        <div class="panel-footer"></div>
                    </div>
                </div>
            </div>
            <div class="panel panel-footer"></div>
        </div>
        <div id="reqAlert" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Request For Leave</h4>
                    </div>
                    <div class="modal-body" style="border: 1px solid #F5ECEC;">
                        <div style="padding: 11px;" id="requestLeaveDiv">
                            <table>
                                <tr><td>From Date</td><td> : <input type="date" name="fromDate" id="fromDate"/><br><br></td></tr>
                                <tr><td>To Date</td><td> : <input type="date" name="toDate" id="toDate"/><br><br></td></tr>
                                <tr><td>reason</td><td> : <textarea id="reason" placeholder="reason"></textarea><br><br></td></tr>
                                <tr><td>To</td><td> : <input type="text" name="hod" id="hod" placeholder="abc@xyz.com" /><br><br></td></tr>
                                <tr id="FHday" style="display: none;"><td> : <input type="radio" name="FHday" value="halfday" id="halfday" /> Half-Day</td><td><input type="radio" name="FHday" value="fullday" id="fullday" /> Full-Day</td></tr>
                            </table>
                            <div style="display:none; background-color: #9AD89A; margin-top: 6px;" id="notifyreq"> Request is sent successfully.. </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-default" onclick="requestForLeave('fromDate', 'toDate', 'reason', 'hod')">Submit</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal" id="closeReq">Close</button>
                    </div>
                </div>

            </div>
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
                                    <label for="date" class="col-md-3 control-label">Date Of Join</label>
                                    <div class="col-md-9">
                                        <input type="date" class="form-control" name="dateOfJoin1" id="dateOfJoin1" placeholder="Date Of Join">
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
                            <div style="display:none; color: red; margin-top: 6px;" id="notifyErrorRegUsr"></div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-default" onclick="registerUSR('fname1', 'lname1', 'gender', 'emailId1', 'passw1', 'type1')">Register</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal" id="closeRegUsr">Close</button>
                    </div>
                </div>

            </div>
        </div>
        <div id="delUsrAlert" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Delete User</h4>
                    </div>
                    <div class="modal-body" style="border: 1px solid #F5ECEC;">
                        <div style="padding: 11px;" id="delUserDiv">
                            <div class="form-group">
                                <label for="email" class="col-md-3 control-label">Email-ID</label>
                                <div class="col-md-9">
                                    <input type="text" class="form-control" name="emailId" id="emailId" placeholder="Email Address">
                                </div>
                            </div>
                            <div style="display:none; background-color: #9AD89A; margin-top: 50px;" id="notifyDelUsr"> User is deleted successfully.. </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-default" onclick="removeUser('emailId')">Delete</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal" id="closeDelUsr">Close</button>
                    </div>
                </div>

            </div>
        </div>
        <div id="getAllUserAlert" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">All Users</h4>
                    </div>
                    <div class="modal-body" style="border: 1px solid #F5ECEC;">
                        <div style="padding: 11px;" id="allUserDiv"></div>
                        <div style="padding: 11px;" id="EditUserDiv" style="display: none;"></div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal"completeLeaveAlert">Close</button>
                    </div>
                </div>

            </div>
        </div>
        <div id="reqNotifyAlert" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Request Notifications</h4>
                    </div>
                    <div class="modal-body" style="border: 1px solid #F5ECEC;">
                        <div id="notifyLeavesDiv" style="height: 400px; overflow-y: scroll;">
                            <%
                                JSONArray objArr = (JSONArray) obj.getJSONArray("notify");
                                String id = "";
                                for (int i = 0; i < objArr.length(); i++) {
                                    id = "leaveApproveBtn" + i;
                            %>
                            <div style="padding: 2%;" id="divId<%=i%>">
                                <input type="textarea" style="display:none" id="hideId<%=i%>" value="<%=objArr.getJSONObject(i).getJSONObject("_id").getString("$oid")%>" />
                                <table>
                                    <tr><td>Employee</td><td> : <%=objArr.getJSONObject(i).getString("user")%></td></tr>
                                    <tr><td>From Date</td><td> : <%=objArr.getJSONObject(i).getString("fromDate")%></td></tr>
                                    <tr><td>TO Date</td><td> : <%=objArr.getJSONObject(i).getString("toDate")%></td></tr>
                                    <tr><td>leave Type</td><td> : <%=objArr.getJSONObject(i).getString("leaveType")%></td></tr>
                                    <tr><td>leave for </td><td> : <%=objArr.getJSONObject(i).getDouble("count")%> Days</td></tr>
                                    <tr><td>Reason</td><td> : <div style="width: 250px;float: right; word-break: break-all;"><%=objArr.getJSONObject(i).getString("reason")%></div></td></tr>   
                                </table>
                                <button class="btn btn-default" onclick="hsReqDiv('approval<%=i%>Btn', 'approval<%=i%>Tr')" id="approval<%=i%>Btn" style="float: right;"> Approve / Ignore </button>    
                                <div id="approval<%=i%>Tr"  style="display:none; margin-bottom: -7%;">
                                    <input type='radio' id='yes<%=i%>' name="yesorno<%=i%>"/> Aprrove &nbsp; &nbsp; &nbsp;
                                    <input type='radio' id='no<%=i%>' name="yesorno<%=i%>"/> Reject <br>
                                    <textarea placeholder="enter your message.." id='msg<%=i%>' style="margin-bottom: -2%;"></textarea>
                                    <button class="btn btn-default" style="margin-left: 40%;" onclick="acceptOrIgnore('yes<%=i%>', 'no<%=i%>', 'msg<%=i%>', '<%=objArr.getJSONObject(i).getString("user")%>', 'hideId<%=i%>', 'divId<%=i%>', '<%=objArr.getJSONObject(i).getDouble("leaves")%>', '<%=objArr.getJSONObject(i).getDouble("leaveBal")%>', '<%=objArr.getJSONObject(i).getDouble("count")%>')" > Send </button> &nbsp; &nbsp;
                                    <button class="btn btn-default" onclick="hsReqDiv('approval<%=i%>Btn', 'approval<%=i%>Tr')" > Cancel </button>
                                </div>
                            </div>
                            <br><hr>    
                            <% }%>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <div id="settingAlert" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Settings</h4>
                    </div>
                    <div class="modal-body" style="border: 1px solid #F5ECEC;">
                        <div id="passwChangeDiv">
                            <table>
                                <tr><td>old Password</td><td> : <input type="password" name="oldPassw" id="oldPassw"/><br><br></td></tr>
                                <tr><td>new Password</td><td> : <input type="password" name="newPassw" id="newPassw"/><br><br></td></tr>
                                <tr><td>conform new Password</td><td> : <input type="password" name="conNewPassw" id="conNewPassw"/><br><br></td></tr>
                            </table>
                            <div style="display:none; background-color: #9AD89A; margin-top: 6px;" id="notifypassw"> password is changed successfully.. </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button id="reqBtn" class="btn btn-default" onclick="changePassw('oldPassw', 'newPassw', 'conNewPassw')">Change</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal" id="closeChange">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <div id="completeLeaveAlert" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Leave Request Summary</h4>
                    </div>
                    <div class="modal-body" style="border: 1px solid #F5ECEC;">
                        <div id="fullLeaveData" style="height: 400px; overflow-y: scroll"></div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <div id="logoutAlert" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Logout</h4>
                    </div>
                    <div class="modal-body" style="border: 1px solid #F5ECEC;">
                        <div> <h3>Are you sure to logout..?</h3> </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" style="float:right;" class="btn btn-default" data-dismiss="modal">Close</button> &nbsp;  &nbsp;  &nbsp;  &nbsp; 
                        <form action="/App/main/logout" style="float:right;">
                            <input type="submit" class="btn btn-default" value="submit"/> &nbsp;  &nbsp;  &nbsp;  &nbsp; 
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div id="getyearHLAlert" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Add Year Holiday List</h4>
                    </div>
                    <div class="modal-body" style="border: 1px solid #F5ECEC;height: 350px;">
                        <div id="yearHL">
                            <lable>Enter Number Of Holiday List : &nbsp;</lable>
                            <input type="text" name="numHL" id="numHL" style="height: 34px; border-radius: 6px; padding: 1%; border-style: ridge;" />
                            <input type="button" class="btn btn-default" value="add" onclick="addHLBox()" />
                        </div>
                        <div id="addHL" style="height: 270px;margin-top: 3%;padding: 1%;overflow-y: scroll;" align="center"></div>
                        <div style="display:none; background-color: #9AD89A; margin-top: 20px;" id="notifyyearHL"> Year List added successfully.. </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" style="float:right;" class="btn btn-default" id="closeYearHL" data-dismiss="modal">Close</button> &nbsp;  &nbsp;  &nbsp;  &nbsp; 
                        <input type="button" class="btn btn-default" value="submit" onclick="saveYHL()" /> &nbsp;  &nbsp;  &nbsp;  &nbsp; 
                    </div>
                </div>
            </div>
        </div>
        <% }%>
        <script>
            $(document).ready(function () {
                getCalendarEvents();
                checkForUpdateMntLeaveBal();
            });

            $(".allUser").click(function () {
                getAllUsers();
            });

            function checkForUpdateMntLeaveBal() {
                $.ajax({
                    url: '/App/admin/getUpdateLeaveBalDate',
                    success: function (data) {
                        var date = new Date(data).getTime();
                        var today = new Date().getTime();
                        if (date < today) {
                            $("#updateLeaveBalLink").show();
                        } else {
                            $("#updateLeaveBalLink").hide();
                        }
                    },
                    error: function (data) {
                        alert("Error At checkForUpdateMntLeaveBal---" + JSON.stringify(data));
                    }
                });
            }
            var name = $("#hidden1")[0].value;
            var leaves = $("#hidden2")[0].value;
            var leaveBal = $("#hidden3")[0].value;
            $("#remaingLeaves").html(leaves);
            $("#leaveBal").html(leaveBal);
            /*$("#fromDate").on("change", function () {
                if ($("#fromDate")[0].value == $("#toDate")[0].value || $("#toDate")[0].value == "") {
                    $("#FHday").show();
                } else {
                    $("#FHday").hide();
                }
            });
            $("#toDate").on("change", function () {
                if ($("#fromDate")[0].value == $("#toDate")[0].value || $("#toDate")[0].value == "") {
                    $("#FHday").show();
                } else {
                    $("#FHday").hide();
                }
            });*/

            function changePassw(opsw, npsw, cpsw) {
                var oldPassw = $("#" + opsw)[0].value;
                var newPassw = $("#" + npsw)[0].value;
                var conNewPassw = $("#" + cpsw)[0].value;
                if (oldPassw == "" || newPassw == "" || conNewPassw == "") {
                    alert("please fill all fields..");
                    return;
                } else if (newPassw !== conNewPassw) {
                    alert("new password and conform new Password should match");
                    return;
                } else {
                    var url = "/App/staff/changePassw?newPassw=" + newPassw + "&oldPassw=" + oldPassw + "&user=" + name;
                    clearValues('passwChangeDiv');
                    $.ajax({url: url, success: function (data) {
                            if (data == "success") {
                                $("#notifypassw").show();
                                setTimeout(function () {
                                    $("#notifypassw").hide();
                                    $("#closeChange").click();
                                }, 1000);
                            } else if (data == "wrongPssw") {
                                alert("entered old password is wrong..");
                            } else {
                                alert("some error occured..");
                            }
                        }
                    });
                }
            }

            function clearValues(id) {
                $("#" + id).find('input[type=date]').val('');
                $("#" + id).find('textarea').val('');
                $("#" + id).find('input:text').val('');
                $("#" + id).find('input:password').val('');
                $("#" + id).find('input:radio').attr('checked', false);
            }

            function checkForValid(fdate, todate) {
                if (fdate == todate) {
                    todate = "";
                }
                var date = new Date();
                date.setHours("00");
                date.setMinutes("00");
                date.setSeconds("00");
                date.setMilliseconds("00");
                if (date.getTime() <= fdate.getTime() && todate == "")
                    return true;
                if (fdate.getTime() > todate.getTime())
                    return false;
                if (date.getTime() <= fdate.getTime() && date.getTime() <= todate.getTime())
                    return true;
                return false;
            }

            function requestForLeave(fromDate, toDate, reason, hod) {

                var fromD = new Date($("#" + fromDate).val());
                var toD = new Date($("#" + toDate).val());

                if (fromD == "Invalid Date" || fromD == "") {
                    alert("Please select dates");
                    return;
                }
                if (toD == "Invalid Date" || toD == "") {
                    toD = fromD;
                }
                if (!checkForValid(fromD, toD)) {
                    alert("selected Dates are not valid");
                    return;
                }
                var reason = $("#" + reason)[0].value;
                var hod = $("#" + hod)[0].value;
                var leaveType = "";
                if ($("#halfday").is(':checked')) {
                    leaveType = "halfday";
                } else if ($("#fullday").is(':checked')) {
                    leaveType = "fullday";
                }
                var count = ((toD.getTime() - fromD.getTime()) / (60 * 60 * 24 * 1000)) + 1;
                if (count == 1 && leaveType == "halfday") {
                    count = count - 0.5;
                }
                if (reason.trim() != "") {
                    var url = "/App/staff/reqForLeave?fromDate=" + fromD.toLocaleDateString() + "&toDate=" + toD.toLocaleDateString() + "&reason=" + reason + "&count=" + count + "&user=" + name + "&leaveType=" + leaveType + "&hod=" + hod + "&leaveBal=" + leaveBal + "&leaves=" + leaves;
                    clearValues('requestLeaveDiv');
                    $.ajax({url: url, success: function (data) {
                            $("#notifyreq").show();
                            setTimeout(function () {
                                $("#notifyreq").hide();
                                $("#closeReq").click();
                            }, 1000);
                        }
                    });
                } else {
                    alert("Please enter reason for leave");
                }
            }

            function getCalendarEvents() {
                var url = "/App/main/getCalendarEvents?user=" + name;
                $.ajax({url: url, success: function (data) {
                        var pending = [];
                        var approved = [];
                        var rejected = [];
                        var yearList = [];
                        data = JSON.parse(data);
                        for (i = 0; i < data.length; i++) {
                            if (data[i].status == "pending") {
                                pending.push(data[i]);
                            }
                            if (data[i].status == "approved") {
                                approved.push(data[i]);
                            }
                            if (data[i].status == "ignored") {
                                rejected.push(data[i]);
                            }
                            if (data[i].status == "yearHL") {
                                yearList.push(data[i]);
                            }
                        }
                        addEvents(pending, approved, rejected, yearList);
                        addEventInDetail(pending, approved, rejected);
                    }});
            }

            function addEvents(pendingArr, approvedArr, ignoredArr, yearList) {
                var eventsArr = [];
                for (i = 0; i < pendingArr.length; i++) {
                    var obj = {};
                    obj.title = pendingArr[i].reason;
                    obj.start = new Date(pendingArr[i].fromDate);
                    var date = new Date(pendingArr[i].toDate);
                    date.setDate(date.getDate() + 1);
                    obj.end = date;
                    obj.color = '#FF7000';
                    eventsArr.push(obj);
                }
                for (i = 0; i < approvedArr.length; i++) {
                    var obj = {};
                    obj.title = approvedArr[i].reason;
                    obj.start = new Date(approvedArr[i].fromDate);
                    var date = new Date(approvedArr[i].toDate);
                    date.setDate(date.getDate() + 1);
                    obj.end = date;
                    obj.color = 'green';
                    eventsArr.push(obj);
                }
                for (i = 0; i < ignoredArr.length; i++) {
                    var obj = {};
                    obj.title = ignoredArr[i].reason;
                    obj.start = new Date(ignoredArr[i].fromDate);
                    var date = new Date(ignoredArr[i].toDate);
                    date.setDate(date.getDate() + 1);
                    obj.end = date;
                    obj.color = 'red';
                    eventsArr.push(obj);
                }
                for (i = 0; i < yearList.length; i++) {
                    var obj = {};
                    obj.title = yearList[i].reason;
                    obj.start = new Date(yearList[i].date);
                    var date = new Date(yearList[i].date);
                    date.setDate(date.getDate() + 1);
                    obj.end = date;
                    obj.color = '#267ED8';
                    eventsArr.push(obj);
                }
                $("#calendarId").fullCalendar({
                    fixedWeekCount: false,
                    url: '#',
                    events: eventsArr
                });
            }

            function addEventInDetail(pArr, aArr, rArr) {
                var divData = '';
                for (i = 0; i < pArr.length; i++) {
                    var data = '<div style="border:1px solid #FF7000; width: 75%; margin-left: 12%; margin-top: 1%; padding: 1%;">';
                    data += 'From Date : ' + pArr[i].fromDate + '<br>';
                    data += 'To Date : ' + pArr[i].toDate + '<br>';
                    data += 'Status : ' + pArr[i].status + '<br>';
                    if (pArr[i].leaveType === "halfday" || pArr[i].leaveType === "fullday") {
                        data += 'LeaveType : ' + pArr[i].leaveType + '<br>';
                    }
                    data += 'Leave for : ' + pArr[i].count + ' Days<br>';
                    data += 'Reason : <textarea>' + pArr[i].reason + '</textarea><br></div>';
                    divData += data;
                }
                for (i = 0; i < aArr.length; i++) {
                    var data = '<div style="border:1px solid green; width: 75%; margin-left: 12%; margin-top: 1%; padding: 1%;">';
                    data += 'From Date : ' + aArr[i].fromDate + '<br>';
                    data += 'To Date : ' + aArr[i].toDate + '<br>';
                    data += 'Status : ' + aArr[i].status + '<br>';
                    if (aArr[i].leaveType === "halfday" || aArr[i].leaveType === "fullday") {
                        data += 'LeaveType : ' + aArr[i].leaveType + '<br>';
                    }
                    data += 'Leave for : ' + aArr[i].count + ' Days<br>';
                    data += 'Reason : <textarea>' + aArr[i].reason + '</textarea><br></div>';
                    divData += data;
                }
                for (i = 0; i < rArr.length; i++) {
                    var data = '<div style="border:1px solid red; width: 75%; margin-left: 12%; margin-top: 1%; padding: 1%;">';
                    data += 'From Date : ' + rArr[i].fromDate + '<br>';
                    data += 'To Date : ' + rArr[i].toDate + '<br>';
                    data += 'Status : ' + rArr[i].status + '<br>';
                    if (rArr[i].leaveType === "halfday" || rArr[i].leaveType === "fullday") {
                        data += 'LeaveType : ' + rArr[i].leaveType + '<br>';
                    }
                    data += 'Leave for : ' + rArr[i].count + ' Days<br>';
                    data += 'Reason : <textarea>' + rArr[i].reason + '</textarea><br></div>';
                    divData += data;
                }
                $("#fullLeaveData").html(divData);
            }

            // -----------------------------------------------------------------------------------------------------------

            function hsReqDiv(id1, id2)
            {
                if (document.getElementById(id1).style.display == 'none') {
                    $("#" + id2).hide();
                    $("#" + id1).show();
                } else if (document.getElementById(id1).style.display !== 'none') {
                    $("#" + id1).hide();
                    $("#" + id2).show();
                    $("#" + id2).find('input[type=date]').val('');
                    $("#" + id2).find('textarea').val('');
                    $("#" + id2).find('input:text').val('');
                    $("#" + id2).find('input:password').val('');
                    $("#" + id2).find('input:radio').attr('checked', false);
                } else {
                    $("#" + id2).hide();
                    $("#" + id1).show();
                }
            }

            function updateLeaveBal() {
                $.ajax({url: "/App/admin/updateLeaveBal", success: function (data) {
                        alert(data);
                    }});
            }

            function registerUSR(fname1, lname1, gender1, emailId1, passw1, type1) {
                $("#notifyErrorRegUsr").hide();
                var fname = $("#" + fname1)[0].value;
                var lname = $("#" + lname1)[0].value;
                var gender = $("#" + gender1)[0].value;
                var emailId = $("#" + emailId1)[0].value;
                var passw = $("#" + passw1)[0].value;
                var type = $("#" + type1)[0].value;
                var date = $("#dateOfJoin1").val();
                if(fname === ""){
                    $("#notifyErrorRegUsr").show();
                    $("#notifyErrorRegUsr").html("first name is empty..!");
                    return;
                }
                if(lname === ""){
                    $("#notifyErrorRegUsr").show();
                    $("#notifyErrorRegUsr").html("last name is empty..!");
                    return;
                }
                if(gender === ""){
                    $("#notifyErrorRegUsr").show();
                    $("#notifyErrorRegUsr").html("Select the gender..!");
                    return;
                }
                if(emailId === ""){
                    $("#notifyErrorRegUsr").show();
                    $("#notifyErrorRegUsr").html("emailId field is empty..!");
                    return;
                }
                if(passw === ""){
                    $("#notifyErrorRegUsr").hide();
                    $("#notifyErrorRegUsr").html("passw field is empty..!");
                    return;
                }
                if(type === ""){
                    $("#notifyErrorRegUsr").hide();
                    $("#notifyErrorRegUsr").html("type field is empty..!");
                    return;
                }
                if(date === ""){
                    $("#notifyErrorRegUsr").hide();
                    $("#notifyErrorRegUsr").html("date of join field is empty..!");
                    return;
                }
                date = new Date(date);
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

            function removeUser(emailId) {
                var emailId = $("#" + emailId)[0].value;
                var url = "/App/admin/removeUsr?emailId=" + emailId;
                clearValues('delUserDiv');
                $.ajax({url: url, success: function (data) {
                        if (data == "success") {
                            $("#notifyDelUsr").show();
                            setTimeout(function () {
                                $("#notifyDelUsr").hide();
                                $("#closeDelUsr").click();
                            }, 1000);
                        }
                    }});
            }

            var allUsers = [];
            function getAllUsers() {
                $("#EditUserDiv").hide('fast');
                $("#allUserDiv").show();
                var url = "/App/admin/getAllUsers";
                $.ajax({url: url, success: function (data) {
                        if (data != "" || typeof data != null) {
                            var objArr = JSON.parse(data);
                            allUsers = objArr;
                            var divData = "<table styel=\"border: 1px solid grey;\" cellspacing=\"5\" cellpadding=\"5\" border=\"1\">";
                            divData += "<tr><th> First Name </th><th> Last Name </th><th> Email-Id </th><th> User Type </th><th> Leaves </th><th> Leave Balance </th><th>Action</th></tr>";
                            for (var i = 0; i < objArr.length; i++) {
                                var item = "<tr>";
                                item += "<td>" + objArr[i].usrFname + "</td>";
                                item += "<td>" + objArr[i].usrLname + "</td>";
                                item += "<td>" + objArr[i].emailId + "</td>";
                                item += "<td>" + objArr[i].utype + "</td>";
                                item += "<td>" + objArr[i].leaves + "</td>";
                                item += "<td>" + objArr[i].leaveBal + "</td>";
                                item += "<td><button class=\"btn btn-default\" onclick=\"editUserFun('" + i + "')\">Edit</button></td>";
                                item += "</tr>";
                                divData += item;
                            }
                            divData += "</table>";
                            $("#allUserDiv").html(divData);
                        }
                    }});
            }

            function editUserFun(i) {
                $("#allUserDiv").hide();
                var princ = '';
                var admin = '';
                var hod = '';
                var staff = '';
                var leaveFlag = false;
                var permFlag = false;
                if (allUsers[i].utype == 'princi') {
                    princ = 'selected';
                } else if (allUsers[i].utype == 'admin') {
                    admin = 'selected';
                } else if (allUsers[i].utype == 'hod') {
                    hod = 'selected';
                } else if (allUsers[i].utype == 'staff') {
                    staff = 'selected';
                }
                var divData = "<table styel=\"border: 1px solid grey;\" cellspacing=\"5\" cellpadding=\"5\" border=\"1\">";
                divData += "<tr><td>User Name</td><td>" + allUsers[i].usrFname + " " + allUsers[i].usrLname + "</td></tr>";
                divData += "<tr><td>Email Id</td><td>" + allUsers[i].emailId + "</td></tr>";
                divData += "<tr><td>Date Of Join</td><td>" + allUsers[i].dateOfJoin + "</td></tr>";

                divData += "<tr><td>Type</td><td>"; //"</td></tr>";
                divData += '<select name="editType" id="editType" >'
                        + '<option disabled>user type</option>'
                        + '<option value="princi" ' + princ + ' >Principal</option>'
                        + '<option value="admin" ' + admin + ' >Administrator</option>'
                        + '<option value="hod" ' + hod + ' >HOD</option>'
                        + '<option value="staff" ' + staff + ' >Staff</option>'
                        + '</select>';
                if (allUsers[i].permStaff == "no") {
                    permFlag = true;
                    divData += '<tr><td>Is Permant..?</td><td>';  // + allUsers[i].dateOfJoin + "</td></tr>";
                    divData += '<input type="radio" name="isperm" id="ispermyes" value="yes" checked> Yes &nbsp;';
                    divData += '<input type="radio" name="isperm" id="ispermno" value="no" > No &nbsp;';
                    divData += '</td></tr>';
                }

                if (allUsers[i].firstEdit == "yes") {
                    leaveFlag = true;
                    divData += "<tr><td>Leaves</td><td><input type=\"text\" name=\"editLeaves\" id=\"editLeaves\" value=\"" + allUsers[i].leaves + "\" /></td></tr>";
                    divData += "<tr><td>Current Leave Balance</td><td><input type=\"text\" name=\"editLeavesbal\" id=\"editLeavesbal\" value=\"" + allUsers[i].leaveBal + "\" /></td></tr>";
                } else {
                    divData += "<tr><td>Leaves</td><td>" + allUsers[i].leaves + "</td></tr>";
                    divData += "<tr><td>Current Leave Balance</td><td>" + allUsers[i].leaveBal + "</td></tr>";
                }

                divData += "<tr><td><button class=\"btn btn-default\" onclick=\"updateUserInfo('" + i + "','" + permFlag + "','" + leaveFlag + "')\">Update</button></td>";
                divData += "<td><button class=\"btn btn-default\" onclick=\"cancelUpdate()\">Cancel</button></td></tr>";
                divData += "</table>";
                $("#EditUserDiv").html(divData);
                $("#EditUserDiv").show('slow');
            }

            function cancelUpdate() {
                $("#EditUserDiv").hide();
                $("#allUserDiv").show('slow');
            }

            function updateUserInfo(i, permFlag, leaveFlag) {
                var utype = $("#editType").val();
                var permStaff = allUsers[i].permStaff;
                var leaves = allUsers[i].leaves;
                var leaveBal = allUsers[i].leaveBal;
                var emailId = allUsers[i].emailId;
                var firstEdit = 'yes';
                if (permFlag == 'true') {
                    permStaff = $("#ispermyes").is(":checked");
                    if (permStaff) {
                        permStaff = 'yes';
                    } else {
                        permStaff = 'no';
                    }
                }
                if (leaveFlag == 'true') {
                    leaves = $("#editLeaves").val();
                    leaveBal = $("#editLeavesbal").val();
                    firstEdit = 'no';
                }

                var update = confirm("Are You Sure To Update the Info..?");
                if (update) {
                    $.ajax({
                        url: '/App/admin/usrRegUpdate?firstEdit=' + firstEdit + '&emailId=' + emailId + '&utype=' + utype + '&permStaff=' + permStaff + '&leaves=' + leaves + '&leaveBal=' + leaveBal,
                        success: function (data) {
                            if (data == "success") {
                                getAllUsers();
                            } else {
                                alert(data + "--success");
                            }
                        },
                        error: function (data) {
                            alert(JSON.stringify(data) + "---------");
                        }
                    });
                } else {
                    alert("no");
                }
            }

            function acceptOrIgnore(yes, no, msg, user, objId, divId, uleaves, uleaveBal, ucount) {
                var id = $("#" + objId)[0].value;
                if (!$("#" + yes).is(":checked") && !$("#" + no).is(":checked")) {
                    alert(" You Should select one of accept or ingone option ");
                    return;
                }
                var status = "";
                if ($("#" + yes).is(":checked")) {
                    status = "approved";
                } else if ($("#" + no).is(":checked")) {
                    status = "ignored";
                }
                uleaveBal -= ucount;
                uleaves -= ucount;
                var url = '/App/hod/approveOrIgnoreReq?user=' + user + "&id=" + id + "&msg=" + $("#" + msg)[0].value + "&status=" + status + "&uleaveBal=" + uleaveBal + "&uleaves=" + uleaves;
                $.ajax({url: url, success: function (data) {
                        if (data == "success") {
                            $("#" + divId).remove();
                        } else {
                            alert("error occured");
                        }
                    }});
            }

            var boxCnt = 0;
            function addHLBox() {
                var num = $("#numHL").val();
                boxCnt = num;
                var str = "<div>";
                for (var i = 0; i < parseInt(num); i++) {
                    str += '<div style="padding:1%;">'
                            + '<lable>' + (i + 1) + '. <lable>'
                            + '<input type="text" placeholder="reason.." name="holiday' + i + '" id="holiday' + i + '" />&nbsp;:&nbsp;'
                            + '<input type="date" name="hlDate' + i + '" id="hlDate' + i + '" />'
                            + '</div>';
                }
                str += '</div>';
                $("#addHL").html(str);
            }

            function saveYHL() {
                if (boxCnt == 0) {
                    alert("please add some holiday list, then submit..");
                    return;
                }
                var dataArr = [];
                for (i = 0; i < boxCnt; i++) {
                    var obj = {};
                    obj.reason = $("#holiday" + i).val();
                    var date = new Date($("#hlDate" + i).val());
                    obj.date = date.toLocaleDateString();
                    obj.status = "yearHL";
                    dataArr.push(obj);
                }
                console.log(JSON.stringify(dataArr.toString()));
                var url = '/App/admin/addYL?data=' + JSON.stringify(dataArr);
                $.ajax({
                    url: url,
                    success: function (data) {
                        $("#notifyyearHL").show();
                        setTimeout(function () {
                            $("#notifyyearHL").hide();
                            $("#closeYearHL").click();
                        }, 2000);
                    },
                    error: function (data) {
                        alert(data);
                    }
                });
            }

        </script>                  
    </body>
</html>
