<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/AdminMaster.master"
    AutoEventWireup="true" CodeFile="AluminiSearch.aspx.cs" Inherits="AluminiSearch" %>

<%@ MasterType VirtualPath="~/MasterPage/AdminMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
<style type="text/css">
    .modal
    {
        position: fixed;
        top: 0;
        left: 0;
        background-color: black;
        z-index: 99;
        opacity: 0.8;
        filter: alpha(opacity=80);
        -moz-opacity: 0.8;
        min-height: 100%;
        width: 100%;
    }
    .loading
    {
        font-family: Arial;
        font-size: 10pt;
        border: 5px solid #67CFF5;
        width: 200px;
        height: 100px;
        display: none;
        position: fixed;
        background-color: White;
        z-index: 999;
    }
</style>
<script type="text/javascript">
    function ShowProgress() {
        setTimeout(function () {
            var modal = $('<div />');
            modal.addClass("modal");
            $('body').append(modal);
            var loading = $(".loading");
            loading.show();
            var top = Math.max($(window).height() / 2 - loading[0].offsetHeight / 2, 0);
            var left = Math.max($(window).width() / 2 - loading[0].offsetWidth / 2, 0);
            loading.css({ top: top, left: left });
        }, 200);
    }
    $('form').live("submit", function () {
        ShowProgress();
    });
</script>
    <script type="text/javascript" src="../js/jquery.min.js"></script>
    <script type="text/javascript">

        $(function () {
            //        GetAluminiInfos Function on page load

            var view = $("[id*=hfViewPrm]").val();
            if (view == 'true')
                GetAluminiInfo(1);
            GetModuleID('Students-Alumini/Alumini-Registration.aspx');
            var add = $("[id*=hfAddPrm]").val();
            if (add == 'false') {
                $("table.form :input").prop('disabled', true);
            }
            else
                $("table.form :input").prop('disabled', false);
        });
        function goto() {
            if ($("[id*=txtpage]").val() != null && $("[id*=txtpage]").val() != "") {
                GetAluminiInfo(parseInt($("[id*=txtpage]").val()));
                $("[id*=txtpage]").val('');
            }
        }
        function GetAluminiInfo(pageIndex) {
            if ($("[id*=hfViewPrm]").val() == 'true') {
                var alumniID = "", batch = "", mobileno = "", StudentName = "";
                var status = "";
                if ($("[id*=rbtnpending]").is(':checked')) {
                    status = "0";
                }

                else if ($("[id*=rbtnactive]").is(':checked')) {
                    status = "1";
                }
                alumniID = $("[id*=hfalumniID]").val();

                batch = $("[id*=ddlBatch]").val();
                if (batch == "Select") {
                    batch = "";
                }
                StudentName = $("[id*=txtStudentName]").val();
                mobileno = $("[id*=txtMobile]").val();

                var parameters = '{pageIndex: ' + pageIndex + ',"alumniID": "' + alumniID + '","batch": "' + batch + '","studentname": "' + StudentName + '","mobileno": "' + mobileno + '","status": "' + status + '"}';

                $.ajax({
                    type: "POST",
                    url: "../Students-Alumini/AluminiSearch.aspx/GetAluminiInfo",
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
            var AluminiInfoes = xml.find("AluminiInfo");

            var row = $("[id*=dgAluminiInfo] tr:last-child").clone(true);
            $("[id*=dgAluminiInfo] tr").not($("[id*=dgAluminiInfo] tr:first-child")).remove();
            var eanchor = ''
            var eanchorEnd = '';
            var danchor = ''
            var danchorEnd = '';
            if ($("[id*=hfEditPrm]").val() == 'false') {
                eanchor = "<a>";
                eanchorEnd = "</a>";
            }
            else {
                eanchor = "<a  href=\"javascript:EditAluminiInfo('";
                eanchorEnd = "');\">Edit</a>";
            }
            if ($("[id*=hfDeletePrm]").val() == 'false') {
                danchor = "<a>";
                danchorEnd = "</a>";
            }
            else {
                danchor = "<a  href=\"javascript:DeleteAluminiInfo('";
                danchorEnd = "');\">Delete</a>";
            }
            if (AluminiInfoes.length == 0) {
                $("td", row).eq(0).html("");
                $("td", row).eq(1).html("");
                $("td", row).eq(2).html("");
                $("td", row).eq(3).html("No Record Found").attr("align", "left");
                $("td", row).eq(4).html("");
                $("td", row).eq(5).html("");
                $("td", row).eq(6).html("");
                $("td", row).eq(7).html("").removeClass("editacc edit-links");
                $("td", row).eq(8).html("").removeClass("deleteacc delete-links"); ;

                $("[id*=dgAluminiInfo]").append(row);
                row = $("[id*=dgAluminiInfo] tr:last-child").clone(true);

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

                $.each(AluminiInfoes, function () {
                    var iAluminiInfo = $(this);
                    var ehref = eanchor + $(this).find("alumniID").text() + eanchorEnd;
                    var dhref = danchor + $(this).find("alumniID").text() + danchorEnd;
                    row.addClass("even");
                    $("td", row).eq(0).html($(this).find("RowNumber").text());
                    $("td", row).eq(1).html($(this).find("Batch").text());
                    $("td", row).eq(2).html($(this).find("aluminicode").text());
                    $("td", row).eq(3).html($(this).find("alumnipwd").text());
                    $("td", row).eq(4).html($(this).find("StudentName").text());
                    $("td", row).eq(5).html($(this).find("Mobile").text());
                    $("td", row).eq(6).html($(this).find("Status").text());
                    $("td", row).eq(7).html(ehref).addClass("editacc edit-links");
                    $("td", row).eq(8).html(dhref).addClass("deleteacc delete-links");
                    $("[id*=dgAluminiInfo]").append(row);
                    row = $("[id*=dgAluminiInfo] tr:last-child").clone(true);
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


        // Delete AluminiInfo
        function DeleteAluminiInfo(id) {
            var parameters = '{"alumniID": "' + id + '"}';
            if (jConfirm('Are you sure to delete this?', 'Confirm', function (r) {
                if (r) {
                    $.ajax({

                        type: "POST",
                        url: "../Students-Alumini/AluminiSearch.aspx/DeleteAluminiInfo",
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

        function EditAluminiInfo(alumniID) {
            if ($("[id*=hfEditPrm]").val() == 'true') {
                $("table.form :input").prop('disabled', false);
                $.ajax({
                    type: "POST",
                    url: "../Students-Alumini/Alumini-Registration.aspx/GetAluminiInfo",
                    data: '{alumniID: ' + alumniID + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        var url = "../Students-Alumini/Alumini-Registration.aspx?menuId=" + $("[id*=hdnMenuIndex]").val() + "&activeIndex=" + $("[id*=hdnIndex]").val() + "&moduleId=" + $("[id*=hfModuleID]").val() + "&alumniID=" + alumniID + "";
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
        function Sync() {
            $.ajax({
                type: "POST",
                crossDomain: true,
                url: "../Students-Alumini/AluminiSearch.aspx/Sync",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    AlertMessage('success', response.d);
                },
                failure: function (response) {
                    AlertMessage('info', response.d);
                },
                error: function (response) {
                    AlertMessage('fail', response.d);
                }
            });

        }


        function GetModuleID(path) {
            $.ajax({
                type: "POST",
                url: "../Students-Alumini/AluminiSearch.aspx/GetModuleId",
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
                GetAluminiInfo(parseInt(currentPage));
                Cancel();
            }
            else if (response.d == "Delete Failed") {
                AlertMessage('fail', 'Delete');
                Cancel();
            }
        };

        //        Pager Click Function
        $(".Pager .page").live("click", function (e) {
            GetAluminiInfo(parseInt($(this).attr('page')));
        });

        function Cancel() {
            $("[id*=txtMobile]").val("");
            $("[id*=txtStudentName]").val("");
            $("[id*=ddlBatch]").val("");
            $('#aspnetForm').validate().resetForm();
            $("[id*=spSubmit]").html("Save");
            if ($("[id*=hfAddPrm]").val() == 'false') {
                $("table.form :input").prop('disabled', true);
            }
            else
                $("table.form :input").prop('disabled', false);
        };
        5
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
                Alumini Search
            </h2>
            <div class="block john-accord content-wrapper2">
                <div class="block1">
                    <table class="form" width="100%">
                        <tr>
                            <td>
                                <div id="stud_1" style="display: block;">
                                    <strong class="searchby"><b>Alumini Pending</b>&nbsp;&nbsp;: <b>Total Count:
                                        <asp:Label ID="lblpendcnt" runat="server"></asp:Label>(s) &nbsp;&nbsp;|&nbsp;&nbsp;
                                    </strong><strong class="searchby"><b>Alumini Approved</b>&nbsp;&nbsp;: <b>Total Count:
                                        <asp:Label ID="lblappcnt" runat="server"></asp:Label>(s) </b>
                                        <br />
                                        <br />
                                    </strong>
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="9%">
                                                <label>
                                                    Mobile No :</label>
                                            </td>
                                            <td width="18%">
                                                <asp:TextBox ID="txtMobile" CssClass="bloodgroup" runat="server"></asp:TextBox>
                                            </td>
                                            <td width="11%">
                                                <label>
                                                    Batch :</label>
                                            </td>
                                            <td width="20%">
                                                <asp:DropDownList ID="ddlBatch" runat="server">
                                                </asp:DropDownList>
                                            </td>
                                            <td width="10%">
                                                <label>
                                                    Student Name :</label>
                                            </td>
                                            <td width="32%">
                                                <asp:TextBox ID="txtStudentName" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong class="searchby">Search By&nbsp;&nbsp;&nbsp;
                                    <label>
                                        <input type="radio" name="Tb1" id="rbtnactive"  value="1" onclick="javascript:GetAluminiInfo(1);" />Approved</label>
                                    <label>
                                        <input type="radio" name="Tb1" id="rbtnpending"  value="0" onclick="javascript:GetAluminiInfo(1);" />Pending Approval</label>
                                    <label>
                                        <input type="radio" name="Tb1" id="rbtnAll" value="" checked="checked" onclick="javascript:GetAluminiInfo(1);" />All</label>
                                </strong>
                            </td>
                        </tr>
                        <tr>
                            <td class="col1">
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" align="center">
                                <button id="btnSearch" type="button" class="btn-icon btn-navy btn-search" onclick="GetAluminiInfo(1);">
                                    <span></span>Search</button>
                                &nbsp;
                                <button id="btnkCancel" type="button" class="btn-icon btn-navy btn-cancel1" runat="server"
                                    onclick="return Cancel();">
                                    <span></span>Cancel</button>
                                <button id="btnSync" type="button" class="btn-icon btn-navy btn-update" runat="server"
                                    onclick="return Sync();">
                                    <span></span>Sync Online Data with SIM Application</button>
                                <asp:HiddenField ID="hfalumniID" runat="server" />
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
                            <asp:GridView ID="dgAluminiInfo" runat="server" Width="100%" AutoGenerateColumns="False"
                                AllowPaging="True" ShowFooter="True" HorizontalAlign="Center" RowStyle-CssClass="even"
                                AlternatingRowStyle-CssClass="odd" EnableModelValidation="True" CssClass="display">
                                <Columns>
                                    <asp:BoundField DataField="SlNo" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                        HeaderText="Sl.No." SortExpression="SlNo">
                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Batch" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                        HeaderText="Batch" SortExpression="Batch">
                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="aluminicode" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                        HeaderText="Alumini Code" SortExpression="aluminicode">
                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="alumnipwd" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                        HeaderText="Password" SortExpression="alumnipwd">
                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="name" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                        HeaderText="Student Name" SortExpression="name">
                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="mobile" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                        HeaderText="Mobile" SortExpression="mobile">
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
                                            <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandArgument='<%# Eval("alumniID") %>'
                                                CommandName="Edit" CausesValidation="false" CssClass="links"></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                       <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                        HeaderStyle-CssClass="sorting_mod deleteacc">
                                        <HeaderTemplate>
                                            Delete</HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkDelete" runat="server" Text="Delete" CommandArgument='<%# Eval("alumniID") %>'
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

            <div class="loading" align="center">
    Loading. Please wait.<br />
    <br />
    <img src="loader.gif" alt="" />
</div>
        </div>
    </div>
</asp:Content>
