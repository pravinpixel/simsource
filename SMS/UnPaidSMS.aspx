﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/AdminMaster.master"
    AutoEventWireup="true" CodeFile="UnPaidSMS.aspx.cs" Inherits="UnPaidSMS" %>

<%@ MasterType VirtualPath="~/MasterPage/AdminMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head2" runat="Server">
    <script type="text/javascript" src="../js/maxlength.js"></script>
    <script type="text/javascript">
        $(function () {
            //        GetSMSCopy Function on page load
            MessageType();
            GetStudents();

        });

        function MessageType() {
            if ($("[id*=MsgText]").is(':checked')) {
                $("[id*=ddlTemplate]").attr('disabled', true);
                $("[id*=txtMessage]").val("");
            }
            else if ($("[id*=msgTemplate]").is(':checked')) {

                $("[id*=ddlTemplate]").attr('disabled', false);
                $("[id*=txtMessage]").val("");
            }
        }

        function GetMessageTemplate() {
            if ($("[id*=hfViewPrm]").val() == 'true') {
                var MessTempID = $("[id*=ddlTemplate]").val();
                if (MessTempID != "") {
                    $.ajax({
                        type: "POST",
                        url: "../SMS/UnPaidSMS.aspx/GetMessageTemplate",
                        data: '{MessTempID: ' + MessTempID + '}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: OnSuccess,
                        failure: function (response) {
                            AlertMessage('info', response.d);
                        },
                        error: function (response) {
                            AlertMessage('info', response.d);
                        }
                    });
                }
                else {
                    $("[id*=txtMessage]").val("");
                    $("[id*=status1]").html("(0/160) Left(Max.160 Charactes only allowed)").addClass("status2");
                    return false;
                }
            }

        }

        function OnSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var MessageTemplates = xml.find("GetMessageTemplate");
            $.each(MessageTemplates, function () {
                var MessageTemplate = $(this);
                $("[id*=txtMessage]").val($(this).find("Message").text());
                var myLength = $(this).find("Message").text().length;
                if (myLength != "") {
                    if (myLength <= 160) {
                        $("[id*=status1]").html("(" + myLength + "/160) Left(Max.160 Charactes only allowed)").addClass("status2");
                    }
                }

            });

        };
        function GetSection(ID) {
            $.ajax({
                type: "POST",
                url: "../SMS/UnPaidSMS.aspx/GetSectionByClassID",
                data: '{ClassID: ' + ID + '}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnGetSectionByClassSuccess,
                failure: function (response) {
                    AlertMessage('info', response.d);
                },
                error: function (response) {
                    AlertMessage('info', response.d);
                }
            });
        }

        function OnGetSectionByClassSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var cls = xml.find("SectionByClass");
            var select = $("[id*=ddlSection]");
            select.children().remove();
            select.append($("<option>").val('').text('---Select---'));
            $.each(cls, function () {
                var icls = $(this);
                var SectionID = $(this).find("SectionID").text();
                var SectionName = $(this).find("SectionName").text();
                select.append($("<option>").val(SectionID).text(SectionName));

            });


        }

        function GetStudents() {
            $.ajax({
                type: "POST",
                url: "../SMS/UnPaidSMS.aspx/GetStudents",
                data: '{"classId": "' + $("[id*=ddlClass]").val() + '","sectionId": "' + $("[id*=ddlSection]").val() + '","Month": "' + $("[id*=ddlMonth]").val() + '","FeesType": "' + $("[id*=dpFeesType]").val() + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnGetStudentSuccess,
                failure: function (response) {
                    AlertMessage('info', response.d);
                },
                error: function (response) {
                    AlertMessage('info', response.d);
                }
            });
        }
        function OnGetStudentSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var Sections = xml.find("StudentBySection");
            var row = $("[id*=dgStudentList] tr:last-child").clone(true);
            $("[id*=dgStudentList] tr").not($("[id*=dgStudentList] tr:first-child")).remove();
            row.addClass("even");
            if (Sections.length != 0) {
                $.each(Sections, function () {
                    var chkAdd = null;
                    chkAdd = "<input name=\"chkAdd\" value=\"" + $(this).find("regno").text() + "\" id=\"" + $(this).find("regno").text() + "\" type=\"checkbox\">";
                    $("td", row).eq(0).html(chkAdd);
                    $("td", row).eq(1).html($(this).find("regno").text());
                    $("td", row).eq(2).html($(this).find("student").text());
                    $("td", row).eq(3).html($(this).find("fathercell").text());
                    $("td", row).eq(4).html($(this).find("mothercell").text());
                    $("[id*=dgStudentList]").append(row);
                    row = $("[id*=dgStudentList] tr:last-child").clone(true);
                });
            }
            else {
                $("td", row).eq(0).html("");
                $("td", row).eq(1).html("");
                $("td", row).eq(2).html("No Records Found").attr("align", "left");
                $("td", row).eq(3).html("");
                $("td", row).eq(4).html("");
                $("[id*=dgStudentList]").append(row);
                row = $("[id*=dgStudentList] tr:last-child").clone(true);
            }
        }

        function CheckAll(id) {
            $("[id*=dgStudentList]").find("input[name*='" + id + "']:checkbox").each(function () {
                if ($("[id*=" + id + "]").is(':checked')) {
                    $(this).attr('checked', true);
                }
                else {
                    $(this).attr('checked', false);
                }
            });
        }
        function SMSSelectAll() {

            $(".checkbox1").each(function () {
                if ($("[id*=chkSMSSelectAll]").is(':checked')) {

                    $(this).find('input.chkSmscopy').attr('checked', true);

                    //$(this).attr('checked', true);
                }
                else {
                    $(this).find('input.chkSmscopy').attr('checked', false);
                }
            });

        }
        function Cancel() {

            $("[id*=chkSMSSelectAll]").attr("checked", false);
            SMSSelectAll();
            $("[id*=txtMessage]").val("");
            $("[id*=ddlClass]").val("");
            $("[id*=ddlSection]").val("");
            $("[id*=ddlMonth]").val("");
            $("[id*=dpFeesType]").val("");
            $("[id*=ddlTemplate]").attr('disabled', true);
             $("[id*=btnSubmit]").attr('disabled', false);
            $('#aspnetForm').validate().resetForm();
            $("[id*=spSubmit]").html("Send");
            var row = $("[id*=dgStudentList] tr:last-child").clone(true);
            $("[id*=dgStudentList] tr").not($("[id*=dgStudentList] tr:first-child")).remove();
            $("[id*=status1]").html("(0/160) Left(Max.160 Charactes only allowed)").addClass("status2");
            $("td", row).eq(0).html("");
            $("td", row).eq(1).html("");
            $("td", row).eq(2).html("No Records Found").attr("align", "left");
            $("td", row).eq(3).html("");
            $("td", row).eq(4).html("");
            $("[id*=dgStudentList]").append(row);
            row = $("[id*=dgStudentList] tr:last-child").clone(true);
            if ($("[id*=hfAddPrm]").val() == 'false') {
                $("table.form :input").prop('disabled', true);
            }
            else
                $("table.form :input").prop('disabled', false);
        };



        <%--Save SMS--%>
          // Save Module
        function SaveSMS() {
             
                    $("[id*=btnSubmit]").attr("disabled", "true");
                    var studList = '';
                    var staffList='';
                    var Psendto =  $("[id*=ddlSendTo]").val();
                    var Message =  $("[id*=txtMessage]").val().replace("'", "\'\'");
                    var userID =   $("[id*=hfuserid]").val();
                    studList = GetQuery(); 
                    staffList = GetQuery1();            
                    var parameters = '{"studlist": "' + studList + '","sendto": "' + Psendto + '","msg": "' + Message + '","userid": "' + userID + '","stafflist": "' + staffList + '"}';
                    $.ajax({
                        type: "POST",
                        url: "../SMS/UnPaidSMS.aspx/SaveSMS",
                        data: parameters,
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: OnSavePermissionSuccess,
                        failure: function (response) {
                           AlertMessage('info', response.d);
                        },
                        error: function (response) {
                           AlertMessage('info', response.d);
                        }
                    });
                
        }

        

         function GetQuery() {
            var sqlstr = '';
            var userId = $("[id*=dpUsers]").val();
         
            $(".even").each(function () {       
                var addPrm = $(this).find("input[name*='chkAdd']").is(':checked');
                if(addPrm == true)
                {
                var subQuery = $(this).find("input[name*='chkAdd']").val();
                
                if(sqlstr =='')
                    sqlstr = subQuery;
                
                else
                    sqlstr +=','+subQuery;
               
                }                
            });
           
            return sqlstr;
        }


      function GetQuery1() {
            var sqlstr1 = '';
            var subQuery;

            $(".checkbox1").each(function () {
                        var chk = $(this).find('input.chkSmscopy').is(':checked');
                        if (chk == true) {
                        subQuery = $(this).find('input.chkSmscopy').val();
                         if(sqlstr1 =='')
                          sqlstr1 = subQuery;
                         else
                          sqlstr1 +=','+subQuery;
                        }             
            });

            return sqlstr1;
        }


         // Save On Success
        function OnSavePermissionSuccess(response) {
            if (response.d == "success" || response.d == "Inserted") {
                AlertMessage('success', response.d);
                 Cancel();
                GetPermission();
            }
            else if (response.d == "UpdateFailed") {
                AlertMessage('fail', 'Update');
            }
            else if (response.d == "InsertFailed") {
                AlertMessage('fail', 'Insert');
            }   
            $("[id*=btnSubmit]").attr("disabled", false);

        }





    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="grid_10">
        <div class="box round first">
            <h2>
                UnPaid Students SMS</h2>
            <div class="block content-wrapper2">
                <table width="100%">
                    <tr valign="top">
                        <td valign="top">
                            <table width="95%">
                                <tr>
                                    <td colspan="2">
                                        <b>Class</b>&nbsp;&nbsp;&nbsp;
                                        <asp:DropDownList ID="ddlClass" runat="server" AppendDataBoundItems="True" onchange="GetSection(this.value);">
                                            <asp:ListItem Selected="True" Value="">-----Select----</asp:ListItem>
                                        </asp:DropDownList>
                                        &nbsp;&nbsp;&nbsp; <b>Section</b>&nbsp;&nbsp;&nbsp;
                                        <asp:DropDownList ID="ddlSection" runat="server" AppendDataBoundItems="True" onchange="GetStudents();">
                                            <asp:ListItem Selected="True" Value="">-----Select----</asp:ListItem>
                                        </asp:DropDownList>
                                        &nbsp;&nbsp;&nbsp;<b>For Month</b>&nbsp;&nbsp;&nbsp;
                                        <asp:DropDownList ID="ddlMonth" runat="server" AutoPostBack="False" onchange="GetStudents();">
                                        </asp:DropDownList>
                                        &nbsp;&nbsp;&nbsp;<b>Fees Type</b>&nbsp;&nbsp;&nbsp;
                                        <asp:DropDownList ID="dpFeesType" runat="server" CssClass="jsrequired" AutoPostBack="False"
                                            onchange="GetStudents();">
                                            <asp:ListItem Selected="True">---Select---</asp:ListItem>
                                            <asp:ListItem>School</asp:ListItem>
                                            <asp:ListItem>Hostel</asp:ListItem>
                                            <asp:ListItem>Bus</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">&nbsp;
                                        
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top" colspan="2">
                                        <div style="overflow: auto; height: 300px">
                                            <b>Student Name List</b>
                                            <asp:GridView ID="dgStudentList" runat="server" Width="100%" AutoGenerateColumns="False"
                                                AllowPaging="false" ShowFooter="True" HorizontalAlign="Center" RowStyle-CssClass="even"
                                                AlternatingRowStyle-CssClass="odd" EnableModelValidation="True" CssClass="display">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="CheckAll" HeaderStyle-CssClass="sorting_mod">
                                                        <HeaderTemplate>
                                                            <input id="chkAdd" type="checkbox" onchange="CheckAll(this.id);" />Select All
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkAddSelect" runat="server" AutoPostBack="false" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField HeaderStyle-CssClass="sorting_mod" DataField="RegNo" HeaderText="RegNo"
                                                        SortExpression="RegNo" />
                                                    <asp:BoundField HeaderStyle-CssClass="sorting_mod" DataField="StudentName" HeaderText="Student Name"
                                                        SortExpression="StudentName" />
                                                    <asp:BoundField HeaderStyle-CssClass="sorting_mod" DataField="FatherCell" HeaderText="Father Cell"
                                                        SortExpression="FatherCell" />
                                                    <asp:BoundField HeaderStyle-CssClass="sorting_mod" DataField="MotherCell" HeaderText="Mother Cell"
                                                        SortExpression="MotherCell" />
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="10%">
                                        <b>Send To</b>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlSendTo" runat="server">
                                            <asp:ListItem Text="Priority" Selected="True" Value="P"></asp:ListItem>
                                            <asp:ListItem Text="Father" Value="F"></asp:ListItem>
                                            <asp:ListItem Text="Mother" Value="M"></asp:ListItem>
                                            <asp:ListItem Text="Gaurdian" Value="G"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="10%">&nbsp;
                                        
                                    </td>
                                    <td>&nbsp;
                                        
                                    </td>
                                </tr>
                                <tr>
                                    <td width="10%">
                                        <b>Message By</b>
                                    </td>
                                    <td>
                                        <input type="radio" checked="checked" class="Mess" id="MsgText" onclick="MessageType();"
                                            name="mes" />Entry
                                        <input type="radio" class="Mess" id="msgTemplate" name="mes" onclick="MessageType();" />Template
                                        <asp:DropDownList ID="ddlTemplate" onchange="GetMessageTemplate();" runat="server"
                                            AppendDataBoundItems="True">
                                            <asp:ListItem Selected="True" Value="">---Select---</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="10%">&nbsp;
                                        
                                    </td>
                                    <td>&nbsp;
                                        
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top" width="10%">
                                        <b>Message</b>
                                    </td>
                                    <td>
                                        <textarea rows="6" cols="40" id="txtMessage" data-maxsize="160" data-output="status1"
                                            wrap="virtual"></textarea><br />
                                        <div id="status1" class="status1">
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top" width="10%">&nbsp;
                                        
                                    </td>
                                    <td>&nbsp;
                                        
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top" width="10%">
                                        <b>SMS Copy To</b>
                                    </td>
                                    <td>
                                        <input type="checkbox" id="chkSMSSelectAll" onclick="SMSSelectAll();" /><b>Select All</b>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top">
                                        &nbsp;&nbsp;&nbsp;
                                    </td>
                                    <td>
                                       <%-- <asp:CheckBoxList ID="chkSmsCopy" runat="server" CssClass="checkboxlist" Font-Bold="False"
                                           RepeatColumns="1" RepeatDirection="Vertical" CellPadding="0" CellSpacing="0">
                                        </asp:CheckBoxList>--%>

                                         <%=BindSMScopy()%>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top">&nbsp;
                                        
                                    </td>
                                    <td>&nbsp;
                                        
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top">&nbsp;
                                        
                                    </td>
                                    <td id="buttonCss">
                                        <button id="btnSubmit" type="button" class="btn-icon btn-navy btn-send" onclick="SaveSMS();">
                                            <span></span>
                                            <div id="spSubmit">
                                                Send</div>
                                        </button>
                                        <button id="btnCancel" type="button" class="btn-icon btn-navy btn-cancel1" runat="server"
                                            onclick="return Cancel();">
                                            <span></span>Cancel</button>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
