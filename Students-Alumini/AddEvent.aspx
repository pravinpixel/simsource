<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/AdminMaster.master"
    AutoEventWireup="true" CodeFile="AddEvent.aspx.cs" Inherits="AddEvent" %>

<%@ MasterType VirtualPath="~/MasterPage/AdminMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="../js/jquery.min.js"></script>
    <%="<link href='" + ResolveUrl("~/js/jquery.timeentry.package-1.5.0/jquery.timeentry.css") + "' rel='stylesheet' type='text/css'  media='screen' />"%>    <%="<script src='" + ResolveUrl("~/js/jquery.timeentry.package-1.5.0/jquery.timeentry.js") + "' type='text/javascript'></script>"%>
    <script type="text/javascript">
        $(document).ready(function () {
            setDatePicker("[id*=txtDate]");
            $("[id*=txtTimings]").timeEntry();
        });
        $(function () {
            if (window.FormData) {
                formdata = new FormData();
            }

            if ($("[id*=hfEventID]").val() != '') {
                var EventID = $("[id*=hfEventID]").val();
                GetEventInfo(EventID);
            };
        });

        function GetEventInfo(ID) {
            if ($("[id*=hfViewPrm]").val() == 'true') {
                $.ajax({
                    type: "POST",
                    url: "../Students-Alumini/AddEvent.aspx/GetEventInfo",
                    data: '{eventID: ' + ID + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnEventSuccess,
                    failure: function (response) {
                        AlertMessage('info', response.d);
                    },
                    error: function (response) {
                        AlertMessage('info', response.d);
                    }
                });
            }
            else {
                return false;
            }
        }

        function OnEventSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var rel = xml.find("EventInfo");
            $.each(rel, function () {
                var status;
                status = $(this).find("status").text();
                if (status == "1") {
                    $("[id*=rbtnActive]").attr("checked", true);
                }
                else {
                    $("[id*=rbtnInActive]").attr("checked", true);
                }
                $("[id*=hfEventID]").val($(this).find("eventID").text());
                $("[id*=txtTitle]").val($(this).find("title").text());
                $("[id*=txtDescription]").val($(this).find("description").text());
                $("[id*=ddlBatchFrom]").val($(this).find("batchfrom").text());
                $("[id*=ddlBatchTo]").val($(this).find("batchto").text());
                $("[id*=txtDate]").val($(this).find("eventdate").text());
                $("[id*=txtTimings]").val($(this).find("eventtime").text());
                $("[id*=txtVenue]").val($(this).find("venue").text());
                $("[id*=txtOther]").val($(this).find("others").text());
                var eventID = $("[id*=hfEventID]").val();

            });
        };






        function SaveEvent() {
            if ($('#aspnetForm').valid()) {
                var Stat;
                if ($("[id*=rbtnActive]").is(':checked')) {
                    Stat = "1";
                }

                else if ($("[id*=rbtnInActive]").is(':checked')) {
                    Stat = "0";
                }

                var parameters = '{"eventid": "' + $("[id*=hfEventID]").val() + '","title": "' + $("[id*=txtTitle]").val() + '","description": "' + $("[id*=txtDescription]").val() + '","batchfrom": "' + $("[id*=ddlBatchFrom]").val() + '","batchto": "' + $("[id*=ddlBatchTo]").val() + '","eventdate": "' + $("[id*=txtDate]").val() + '","eventtime": "' + $("[id*=txtTimings]").val() + '","venue": "' + $("[id*=txtVenue]").val() + '","others": "' + $("[id*=txtOther]").val() + '","Status": "' + Stat + '"}';
                $.ajax({
                    type: "POST",
                    url: "../Students-Alumini/AddEvent.aspx/SaveEvent",
                    data: parameters,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnSaveSuccess,
                    failure: function (response) {
                        AlertMessage('info', response.d);
                    },
                    error: function (response) {
                        AlertMessage('info', response.d);
                    }
                });
            }
        }

        function OnSaveSuccess(response) {

            if (response.d == "Update Failed") {
                AlertMessage('fail', 'Update');
            }
            else if (response.d) {
                var eventID = response.d.toString();
                AlertMessage('success', 'Inserted');
                $("[id*=hfEventID]").val(eventID);
                if (formdata) {
                    formdata.append("eventID", eventID);
                    if (formdata) {
                        $.ajax({
                            url: "../Students-Alumini/AddEvent.aspx",
                            type: "POST",
                            data: formdata,
                            processData: false,
                            contentType: false,
                            success: function (res) {
                            }
                        });
                    }
                }
                Cancel();
                GetEventInfo(eventID);
            }
            else if (response.d == "Insert Failed") {
                AlertMessage('fail', 'Insert');
            }


        };


        function Cancel() {
            $("[id*=txtTitle]").val('');
            $("[id*=txtDescription]").val('');
            $("[id*=ddlBatchFrom]").val('');
            $("[id*=ddlBatchTo]").val('');
            $("[id*=txtDate]").val('');
            $("[id*=txtVenue]").val('');
            $("[id*=txtTimings]").val('');
            $("[id*=txtOther]").val('');
            $("[id*=hfEventID]").val('');
            $('#aspnetForm').validate().resetForm();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head2" runat="Server">
    <style type="text/css">
        .jsrequired
        {
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="grid_10">
        <div class="box round first">
            <h2>
                Add Event
            </h2>
            <div class="clear">
            </div>
            <div class="block content-wrapper2">
                <table width="100%">
                    <tr valign="top">
                        <td valign="top">
                            <table class="form">
                                <tr>
                                    <td class="col1" colspan="4">
                                        &nbsp;&nbsp;
                                    </td>
                                    <td rowspan="4">
                                        <div class="block">
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="col1">
                                        <span class="col1"><span style="color: Red">*</span>
                                            <label>
                                                Title</label>
                                    </td>
                                    <td class="col2">
                                        <asp:TextBox ID="txtTitle" CssClass="jsrequired" runat="server"></asp:TextBox>
                                    </td>
                                    <td class="col2">
                                        <span class="col1"><span style="color: Red">*</span>
                                            <label>
                                                Description</label>
                                    </td>
                                    <td class="col2">
                                        <asp:TextBox ID="txtDescription" CssClass="jsrequired" runat="server" 
                                            TextMode="MultiLine"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="col1">
                                        <span class="col1"><span style="color: Red">*</span>
                                            <label>
                                                Batch to Attend</label>
                                    </td>
                                    <td class="col2">
                                        <asp:DropDownList ID="ddlBatchFrom" runat="server">
                                        </asp:DropDownList>
                                        <asp:DropDownList ID="ddlBatchTo" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td class="col2">
                                        <span class="col1"><span style="color: Red">*</span>
                                            <label>
                                                Venue</label> &nbsp;
                                    </td>
                                    <td class="col2">
                                        <asp:TextBox ID="txtVenue" CssClass="jsrequired" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="col1">
                                        <span class="col1"><span style="color: Red">*</span>
                                            <label>
                                                Event Date</label>
                                    </td>
                                    <td class="col2">
                                        <asp:TextBox ID="txtDate" CssClass="jsrequired dateNL date-picker" runat="server"></asp:TextBox>
                                    </td>
                                    <td class="col2">
                                        <span class="col1"><span style="color: Red">*</span>
                                            <label>
                                                Event Time</label>
                                    </td>
                                    <td class="col2">
                                        <asp:TextBox ID="txtTimings" CssClass="jsrequired" Width="80px" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="col1">
                                        <span class="col1"><span style="color: Red">*</span>
                                            <label>
                                                Other Details</label>
                                    </td>
                                    <td class="col2">
                                        <span class="col1">
                                            <asp:TextBox ID="txtOther" CssClass="jsrequired" runat="server" 
                                            TextMode="MultiLine"></asp:TextBox>
                                    </td>
                                    <td class="col1">
                                        <span class="col1"><span style="color: Red">*</span>
                                            <label>
                                                Event Status</label>
                                    </td>
                                    <td class="col2">
                                        <label>
                                            <input type="radio" name="rb1" id="rbtnActive" value="1" checked="checked" />Active</label>
                                        <label>
                                            <input type="radio" name="rb1" id="rbtnInActive" value="0" />In-Active</label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="col1">
                                        &nbsp;
                                        <asp:HiddenField ID="hfEventID" runat="server" />
                                        <asp:HiddenField ID="hdnUserId" runat="server" />
                                    </td>
                                    <td>
                                        <button id="btnSubmit" type="button" class="btn-icon btn-orange btn-saving" onclick="SaveEvent();">
                                            <span></span>
                                            <div id="spSubmit">
                                                Save</div>
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
