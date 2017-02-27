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
        <script src="/App/resources/js/jquery.min.js"></script>
        <script src="/App/resources/js/bootstrap.min.js"></script>
        <script src="/App/resources/js/moment.min.js" ></script>
        <script src="/App/resources/js/fullcalendar.js" ></script>
    </head>
    <body>
        <%
            String user = null;
            if(session.getAttribute("user") == null){
                response.sendRedirect("index.jsp");
            }else {
                user = (String) session.getAttribute("user");
            JSONObject obj = (JSONObject) request.getAttribute("obj");
        %>
        <input style="display:none" id="hidden1" value="<%=obj.getString("emailId")%>" />
        <input style="display:none" id="hidden2" value="<%=obj.getDouble("leaves")%>" />
        <input style="display:none" id="hidden3" value="<%=obj.getDouble("leaveBal")%>" />
        <div>
            <div class="panel panel-heading"  style="font-size: 30px;color: #5BC0DE;">
                Leave App
                <div class="dropdown" style="float: right;">
                    <button class="btn btn-default dropdown-toggle" style="margin-top: -8%;" type="button" id="menu1" data-toggle="dropdown">User
                        <span class="caret"></span></button>
                    <ul class="dropdown-menu dropdown-menu-right" style="width: 180px !important;" role="menu" aria-labelledby="menu1" >
                        <li style="padding-left: 2%;"><span>*&nbsp;</span><%=obj.getString("usrFname")%> &nbsp; <%=obj.getString("usrLname")%></li>
                        <li class="divider"></li>
                        <!--<li data-toggle="modal" data-target="#completeLeaveAlert" style="padding-left: 2%; cursor: pointer;"><span>*&nbsp;</span>Leave Request Summary</li>-->
                        <li data-toggle="modal" data-target="#reqNotifyAlert" style="padding-left: 2%; cursor: pointer;"><span>*&nbsp;</span>Request Notifications</li>
                        <li data-toggle="modal" data-target="#settingAlert" style="padding-left: 2%; cursor: pointer;"><span>*&nbsp;</span>Settings</li>
                        <li class="divider"></li>
                        <li data-toggle="modal" data-target="#logoutAlert" style="padding-left: 2%; cursor: pointer;" id="logout"><span>*&nbsp;</span>Logout</li>
                    </ul>
                </div>
            </div>
            <div class="panel-body">
                <div style="float: left; width: 20%;">
                    <!--<div data-toggle="modal" data-target="#reqAlert" class="btn btn-info" style="margin-top: 1%; height: 40px; width: 100%;">Request For Leave</div>-->
<!--                    <div style="margin-top: 5%; border: 1px solid #F5ECEC;;" >
                        <div class="panel-footer">Leave Summnary</div>
                        <div class="panel-body">
                            Annual Leave Balance : <span id="annuaBal"></span><br>
                            Personal Leave Balance : <span id="leaveBal"></span><br>
                            Total Leave Balance : <span id="remaingLeaves"></span><br>
                        </div>
                        <div class="panel-footer"></div>
                    </div>-->
                    <div style="margin-top: 5%; border: 1px solid #F5ECEC;" >
                        <div class="panel-footer">Year Holidays</div>
                        <div class="panel-body" style="height: 250px;overflow-y: scroll;">
                            <table>
                            <%
                            JSONArray yearArr = (JSONArray) obj.getJSONArray("yearHL");
                            for(int i=0; i<yearArr.length(); i++){
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
                <div style="float: left; margin-left: 2%;">
                    <div id="calendarId" style="border: 1px solid #F5ECEC; padding: 1%; width:600px; height: 500px;"></div>
                    <div id="reference" style="border: 1px solid #F5ECEC; height: 30px;padding: 1%;margin-top: 1%;">
                        <span style="margin-left: 1%; height:3px;width:3px;background-color:#267ED8;">&nbsp;&nbsp;&nbsp;&nbsp;</span> Year Holiday List
                        <span style="margin-left: 1%; height:3px;width:3px;background-color:green;">&nbsp;&nbsp;&nbsp;&nbsp;</span> Accepted
                        <span style="margin-left: 1%; height:3px;width:3px;background-color:#FF7000;">&nbsp;&nbsp;&nbsp;&nbsp;</span> Pending
                        <span style="margin-left: 1%; height:3px;width:3px;background-color:red;">&nbsp;&nbsp;&nbsp;&nbsp;</span> Rejected
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
                                <tr><td>Leave Type</td><td> : 
                                        <select name="leaveType" id="leaveType">
                                            <option value="casual">Casual Leave</option>
                                            <option value="duty">Duty Leave</option>
                                        </select>
                                        <br><br>
                                    </td>
                                </tr>
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
                        <button id="reqBtn" class="btn btn-default" onclick="requestForLeave('leaveType','fromDate', 'toDate', 'reason', 'hod')">Submit</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal" id="closeReq">Close</button>
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
        <div id="reqNotifyAlert" class="modal fade" role="dialog">
            <div class="modal-dialog" style="width: 1000px !important;">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Request Notifications</h4>
                    </div>
                    <div class="modal-body" style="border: 1px solid #F5ECEC;">
                        <div id="notifyLeavesDiv" style="height: 400px; overflow-y: scroll;">
                            <table border="1" style="text-align: center;">
                                <tr>
                                    <th>Employee</th>
                                    <th>Leave [casual/duty]</th>
                                    <th>Total Leaves</th>
                                    <th>Current Balance</th>
                                    <th>From Date</th>
                                    <th>To Date</th>
                                    <th>Count [in Days]</th>
                                    <th>Reason</th>
                                    <th>Approve</th>
                                    <th>Ignore</th>
                                </tr>
                            
                            <%
                                JSONArray objArr = (JSONArray) obj.getJSONArray("notify");
                                String id = "";
                                for (int i = 0; i < objArr.length(); i++) {
                                    id = "leaveApproveBtn" + i;
                            %>
                            <tr  id="divId<%=i%>">
                                <td>
                                    <input type="textarea" style="display:none" id="hideId<%=i%>" value="<%=objArr.getJSONObject(i).getJSONObject("_id").getString("$oid")%>" />
                                    <%=objArr.getJSONObject(i).getString("user")%>
                                </td>
                                <td><%=objArr.getJSONObject(i).getString("casOrDuty")%></td>
                                <td><%=objArr.getJSONObject(i).getDouble("leaves")%></td>
                                <td><%=objArr.getJSONObject(i).getDouble("leaveBal")%></td>
                                <td><%=objArr.getJSONObject(i).getString("fromDate")%></td>
                                <td><%=objArr.getJSONObject(i).getString("toDate")%></td>
                                <td><%=objArr.getJSONObject(i).getDouble("count")%></td>
                                <td style="width: 250px;word-break: break-all;"><%=objArr.getJSONObject(i).getString("reason")%></td>
                                <td><button class="btn btn-default" onclick="acceptOrIgnore('yes', 'msg<%=i%>', '<%=objArr.getJSONObject(i).getString("user")%>', 'hideId<%=i%>', 'divId<%=i%>', '<%=objArr.getJSONObject(i).getDouble("leaves")%>', '<%=objArr.getJSONObject(i).getDouble("leaveBal")%>', '<%=objArr.getJSONObject(i).getDouble("count")%>', '<%=objArr.getJSONObject(i).getString("casOrDuty")%>', '<%=objArr.getJSONObject(i).getString("hodStatus")%>', '<%=obj.getString("utype")%>')" > Approve </button></td>
                                <td><button class="btn btn-default" onclick="acceptOrIgnore('no', 'msg<%=i%>', '<%=objArr.getJSONObject(i).getString("user")%>', 'hideId<%=i%>', 'divId<%=i%>', '<%=objArr.getJSONObject(i).getDouble("leaves")%>', '<%=objArr.getJSONObject(i).getDouble("leaveBal")%>', '<%=objArr.getJSONObject(i).getDouble("count")%>', '<%=objArr.getJSONObject(i).getString("casOrDuty")%>', '<%=objArr.getJSONObject(i).getString("hodStatus")%>', '<%=obj.getString("utype")%>')" > Reject </button></td>
                            </tr>   
                            <% }%>
                        </table>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
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
    <% } %>                    
        <script>
            $(document).ready(function () {
                getCalendarEvents();
            });
            //alert(arrrr);
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

            function requestForLeave(leaveType,fromDate, toDate, reason, hod) {

                var casOrDuty = $("#"+leaveType).val();
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
                    var url = "/App/staff/reqForLeave?casOrDuty="+casOrDuty+"&fromDate=" + fromD.toLocaleDateString() + "&toDate=" + toD.toLocaleDateString() + "&reason=" + reason + "&count=" + count + "&user=" + name + "&leaveType=" + leaveType + "&hod=" + hod + "&leaveBal=" + leaveBal + "&leaves=" + leaves;
                    clearValues('requestLeaveDiv');
                    $.ajax({url: url, success: function (data) {
                            $("#notifyreq").show();
                            getCalendarEvents();
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
                            if (data[i].status === "pending") {
                                pending.push(data[i]);
                            }
                            if (data[i].status == "approved") {
                                approved.push(data[i]);
                            }
                            if (data[i].status == "ignored") {
                                rejected.push(data[i]);
                            }
                            if(data[i].status == "yearHL"){
                                yearList.push(data[i]);
                            }
                        }
                        addEvents(pending, approved, rejected,yearList);
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
                for(i=0; i<yearList.length; i++){
                    var obj = {};
                    obj.title = yearList[i].reason;
                    obj.start = new Date(yearList[i].date);
                    var date = new Date(yearList[i].date);
                    date.setDate(date.getDate() + 1);
                    obj.end = date;
                    obj.color = '#267ED8';
                    eventsArr.push(obj);
                }
                $("#calendarId").html();
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
            
            function hsReqDiv(id1,id2)
            {
                if(document.getElementById(id1).style.display == 'none'){
                    $("#"+id2).hide();
                    $("#"+id1).show();
                }else if(document.getElementById(id1).style.display !== 'none'){
                    $("#"+id1).hide();
                    $("#"+id2).show();
                    $("#"+id2).find('input[type=date]').val('');
                    $("#"+id2).find('textarea').val('');
                    $("#"+id2).find('input:text').val('');
                    $("#"+id2).find('input:password').val('');
                    $("#"+id2).find('input:radio').attr('checked', false);
                }else{
                    $("#"+id2).hide();
                    $("#"+id1).show();
                }
            }
            
            function acceptOrIgnore(yesNoFlag,msg,user,objId,divId,uleaves,uleaveBal,ucount,casOrDuty,otherStatus,utype){
                var id = $("#"+objId)[0].value;
                /*if(!$("#"+yes).is(":checked") && !$("#"+no).is(":checked")){
                    alert(" You Should select one of accept or ingone option ");
                    return;
                }*/
                var status = "";
                msg = "testing";
                if(yesNoFlag === "yes"){
                    status = "approved";
                }else if(yesNoFlag === "no"){
                    status = "ignored";
                }
                /*if(casOrDuty == "casual"){
                    uleaveBal -= ucount;
                    uleaves -= ucount;
                }*/
                
                var url = '/App/hod/approveOrIgnoreReq?user='+user+"&id="+id+"&msg="+msg+"&status="+status+"&uleaveBal="+uleaveBal+"&uleaves="+uleaves+"&otherStatus="+otherStatus+"&utype="+utype;
                $.ajax({url:url, success:function(data){
                    if(data == "success"){
                        $("#"+divId).remove();
                    }else{
                        alert("error occured");
                    }
                }});
            }
            
            
        </script>                  
    </body>
</html>
