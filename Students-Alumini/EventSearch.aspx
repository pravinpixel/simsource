<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/AdminMaster.master"
    AutoEventWireup="true" CodeFile="EventSearch.aspx.cs" Inherits="EventSearch" %>

<%@ MasterType VirtualPath="~/MasterPage/AdminMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="../js/jquery.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            setDatePicker("[id*=txtDate]");
        });
        $(function () {
            //        GetEventInfos Function on page load

            var view = $("[id*=hfViewPrm]").val();
            if (view == 'true')
                GetEventInfo(1);
            GetModuleID('Students-Alumini/AddEvent.aspx');
            var add = $("[id*=hfAddPrm]").val();
            if (add == 'false') {
                $("table.form :input").prop('disabled', true);
            }
            else
                $("table.form :input").prop('disabled', false);
        });
        function goto() {
            if ($("[id*=txtpage]").val() != null && $("[id*=txtpage]").val() != "") {
                GetEventInfo(parseInt($("[id*=txtpage]").val()));
                $("[id*=txtpage]").val('');
            }
        }
        function GetEventInfo(pageIndex) {
            if ($("[id*=hfViewPrm]").val() == 'true') {
                var eventID = "", batchfrom = "", batchto = "", eventdate = "", title = "";
                eventID = $("[id*=hfeventID]").val();

                batchfrom = $("[id*=ddlBatchFrom]").val();
                if (batchfrom == "Select") {
                    batchfrom = "";
                }

                batchto = $("[id*=ddlBatchTo]").val();
                if (batchto == "Select") {
                    batchto = "";
                }
                eventdate = $("[id*=txtDate]").val();
                title = $("[id*=txtTitle]").val();

                var parameters = '{pageIndex: ' + pageIndex + ',"eventID": "' + eventID + '","title": "' + title + '","batchfrom": "' + batchfrom + '","batchto": "' + batchto + '","eventdate": "' + eventdate + '"}';

                $.ajax({
                    type: "POST",
                    url: "../Students-Alumini/EventSearch.aspx/GetEventInfo",
                    data: parameters,
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
                return false;
            }
        }


        function OnSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var EventInfoes = xml.find("EventInfo");

            var row = $("[id*=dgEventInfo] tr:last-child").clone(true);
            $("[id*=dgEventInfo] tr").not($("[id*=dgEventInfo] tr:first-child")).remove();
            var eanchor = ''
            var eanchorEnd = '';
            var danchor = ''
            var danchorEnd = '';
            if ($("[id*=hfEditPrm]").val() == 'false') {
                eanchor = "<a>";
                eanchorEnd = "</a>";
            }
            else {
                eanchor = "<a  href=\"javascript:EditEventInfo('";
                eanchorEnd = "');\">Edit</a>";
            }
            if ($("[id*=hfDeletePrm]").val() == 'false') {
                danchor = "<a>";
                danchorEnd = "</a>";
            }
            else {
                danchor = "<a  href=\"javascript:DeleteEventInfo('";
                danchorEnd = "');\">Delete</a>";
            }

            if (EventInfoes.length == 0) {
                $("td", row).eq(0).html("");
                $("td", row).eq(1).html("");
                $("td", row).eq(2).html("");
                $("td", row).eq(3).html("No Record Found").attr("align", "left");
                $("td", row).eq(4).html("");
                $("td", row).eq(5).html("");
                $("td", row).eq(6).html("");
                $("td", row).eq(7).html("").removeClass("editacc edit-links");
                $("td", row).eq(8).html("").removeClass("deleteacc delete-links"); ;

                $("[id*=dgEventInfo]").append(row);
                row = $("[id*=dgEventInfo] tr:last-child").clone(true);

                var pager = xml.find("Pager");
                $(".Pager").ASPSnippets_Pager({
                    ActiveCssClass: "current",
                    PagerCssClass: "pager",
                    PageIndex: parseInt(1),
                    PageSize: parseInt(1),
                    RecordCount: parseInt(0)
                });
            }
            else {

                $.each(EventInfoes, function () {
                    var iEventInfo = $(this);
                    var ehref = eanchor + $(this).find("eventID").text() + eanchorEnd;
                    var dhref = danchor + $(this).find("eventID").text() + danchorEnd;
                    row.addClass("even");
                    $("td", row).eq(0).html($(this).find("RowNumber").text());
                    $("td", row).eq(1).html($(this).find("title").text());
                    $("td", row).eq(2).html($(this).find("batchfrom").text());
                    $("td", row).eq(3).html($(this).find("batchto").text());
                    $("td", row).eq(4).html($(this).find("eventdate").text());
                    $("td", row).eq(5).html($(this).find("venue").text());
                    $("td", row).eq(6).html($(this).find("Status").text());
                    $("td", row).eq(7).html(ehref).addClass("editacc edit-links");
                    $("td", row).eq(8).html(dhref).addClass("deleteacc delete-links");
                    $("[id*=dgEventInfo]").append(row);
                    row = $("[id*=dgEventInfo] tr:last-child").clone(true);
                });

                if ($("[id*=hfEditPrm]").val() == 'false') {
                    $('.editacc').hide();
                }
                else {
                    $('.editacc').show();
                }
                if ($("[id*=hfDeletePrm]").val() == 'false') {
                    $('.deleteacc').hide();
                }
                else {
                    $('.deleteacc').show();
                }
                var pager = xml.find("Pager");
                $(".Pager").ASPSnippets_Pager({
                    ActiveCssClass: "current",
                    PagerCssClass: "pager",
                    PageIndex: parseInt(pager.find("PageIndex").text()),
                    PageSize: parseInt(pager.find("PageSize").text()),
                    RecordCount: parseInt(pager.find("RecordCount").text())
                });
            }
        };


        // Delete EventInfo
        function DeleteEventInfo(id) {
            var parameters = '{"eventID": "' + id + '"}';
            if (jConfirm('Are you sure to delete this?', 'Confirm', function (r) {
                if (r) {
                    $.ajax({

                        type: "POST",
                        url: "../Students-Alumini/EventSearch.aspx/DeleteEventInfo",
                        data: parameters,
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: OnDeleteSuccess,
                        failure: function (response) {
                            AlertMessage('info', response.d);
                        },
                        error: function (response) {
                            AlertMessage('info', response.d);
                        }

                    });
                }

            })) {
            }

        }

        //        Edit Function

        function EditEventInfo(eventID) {
            if ($("[id*=hfEditPrm]").val() == 'true') {
                $("table.form :input").prop('disabled', false);
                $.ajax({
                    type: "POST",
                    url: "../Students-Alumini/AddEvent.aspx/GetEventInfo",
                    data: '{eventID: ' + eventID + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        var url = "../Students-Alumini/AddEvent.aspx?menuId=" + $("[id*=hdnMenuIndex]").val() + "&activeIndex=" + $("[id*=hdnIndex]").val() + "&moduleId=" + $("[id*=hfModuleID]").val() + "&eventID=" + eventID + "";
                        $(location).attr('href', url)
                    },
                    failure: function (response) {
                        AlertMessage('info', response.d);
                    },
                    error: function (response) {
                        AlertMessage('info', response.d);
                    }
                });

            }
            else {
                $("table.form :input").prop('disabled', true);
                return false;
            }
        }


        function GetModuleID(path) {
            $.ajax({
                type: "POST",
                url: "../Students-Alumini/EventSearch.aspx/GetModuleId",
                data: '{"path": "' + path + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnModuleIDSuccess,
                failure: function (response) {
                    AlertMessage('info', response.d);
                },
                error: function (response) {
                    AlertMessage('info', response.d);
                }
            });

        }
        function OnModuleIDSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var cls = xml.find("ModuleMenusByPath");
            $.each(cls, function () {
                $("[id*=hfModuleID]").val($(this).find("modulemenuid").text());
                $("[id*=hdnMenuIndex]").val($(this).find("menuid").text())
            });
        }
        // Delete On Success
        function OnDeleteSuccess(response) {
            var currentPage = $("[id*=currentPage]").text();
            if (response.d == "Deleted") {
                AlertMessage('success', 'Deleted');
                GetEventInfo(parseInt(currentPage));
                Cancel();
            }
            else if (response.d == "Delete Failed") {
                AlertMessage('fail', 'Delete');
                Cancel();
            }
        };

        //        Pager Click Function
        $(".Pager .page").live("click", function (e) {
            GetEventInfo(parseInt($(this).attr('page')));
        });

        function Cancel() {
            $("[id*=txtTitle]").val("");
            $("[id*=txtDate]").val("");
            $("[id*=ddlBatchFrom]").val("");
            $("[id*=ddlBatchTo]").val("");
            $('#aspnetForm').validate().resetForm();
            $("[id*=spSubmit]").html("Save");
            if ($("[id*=hfAddPrm]").val() == 'false') {
                $("table.form :input").prop('disabled', true);
            }
            else
                $("table.form :input").prop('disabled', false);
        };
       
    </script>
    <script type="text/javascript">
        function Delete() {
            return confirm("Are You Sure to Delete ?");
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="grid_10">
        <div class="box round first fullpage">
            <h2>
                Event Search
            </h2>
            <div class="block john-accord content-wrapper2">
                <div class="block1">
                    <table class="form" width="100%">
                        <tr>
                            <td>
                                <div id="stud_1" style="display: block;">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="9%">
                                                <label>
                                                    Event Title :</label>
                                            </td>
                                            <td width="18%">
                                                <asp:TextBox ID="txtTitle" CssClass="bloodgroup" runat="server"></asp:TextBox>
                                            </td>
                                            <td width="11%">
                                                <label>
                                                    Batch :</label>
                                            </td>
                                            <td width="20%">
                                                <asp:DropDownList ID="ddlBatchFrom" runat="server" Width="75px">
                                                </asp:DropDownList>
                                                &nbsp;<asp:DropDownList ID="ddlBatchTo" runat="server" Width="75px">
                                                </asp:DropDownList>
                                            </td>
                                            <td width="10%">
                                                <label>
                                                    Event Date :</label>
                                            </td>
                                            <td width="32%">
                                                <asp:TextBox ID="txtDate" CssClass="jsrequired dateNL date-picker" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="col1">
                            </td>
                        </tr>
                        <tr>
                            <td class="col1">
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" align="center">
                                <button id="btnSearch" type="button" class="btn-icon btn-navy btn-search" onclick="GetEventInfo(1);">
                                    <span></span>Search</button>
                                &nbsp;
                                <button id="btnkCancel" type="button" class="btn-icon btn-navy btn-cancel1" runat="server"
                                    onclick="return Cancel();">
                                    <span></span>Cancel</button>
                                <asp:HiddenField ID="hfeventID" runat="server" />
                                <asp:HiddenField ID="hfModuleID" runat="server" />
                            </td>
                        </tr>
                        <tr valign="top">
                            <td align="right" style="display: none;" valign="top">
                                &nbsp; Goto Page No :
                                <asp:TextBox ID="txtpage" runat="server" Width="50px"></asp:TextBox>
                                <button id="btngoto" type="button" class="btn-icon btn-navy btn-add" onclick="goto();">
                                    <span></span>Go</button>
                            </td>
                        </tr>
                    </table>
                </div>
                <table width="100%">
                    <tr valign="top">
                        <td valign="top">
                            <asp:GridView ID="dgEventInfo" runat="server" Width="100%" AutoGenerateColumns="False"
                                AllowPaging="True" ShowFooter="True" HorizontalAlign="Center" RowStyle-CssClass="even"
                                AlternatingRowStyle-CssClass="odd" EnableModelValidation="True" CssClass="display">
                                <Columns>
                                    <asp:BoundField DataField="SlNo" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                        HeaderText="Sl.No." SortExpression="SlNo">
                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="title" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                        HeaderText="Title" SortExpression="title">
                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="batchfrom" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                        HeaderText="Batch From" SortExpression="batchfrom">
                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                    </asp:BoundField>
                                     <asp:BoundField DataField="batchto" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                        HeaderText="Batch To" SortExpression="batchto">
                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="eventdate" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                        HeaderText="Event Date" SortExpression="eventdate">
                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="venue" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                        HeaderText="venue" SortExpression="venue">
                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Status" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                        HeaderText="Status" SortExpression="Status">
                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                        HeaderStyle-CssClass="sorting_mod editacc">
                                        <HeaderTemplate>
                                            Edit</HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandArgument='<%# Eval("eventID") %>'
                                                CommandName="Edit" CausesValidation="false" CssClass="links"></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                        HeaderStyle-CssClass="sorting_mod deleteacc">
                                        <HeaderTemplate>
                                            Delete</HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkDelete" runat="server" Text="Delete" CommandArgument='<%# Eval("eventID") %>'
                                                CommandName="Delete" CausesValidation="false" CssClass="links"></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="Pager">
                            </div>
                            <br />
                            <br />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
