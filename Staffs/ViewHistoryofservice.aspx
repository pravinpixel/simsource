<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/AdminMaster.master"
    AutoEventWireup="true" CodeFile="ViewHistoryofservice.aspx.cs" Inherits="Staffs_ViewHistoryofservice" %>

<%@ MasterType VirtualPath="~/MasterPage/AdminMaster.master" %>
<asp:Content ID="headContent" runat="server" ContentPlaceHolderID="head">
    <script type="text/javascript" src="../js/jquery.min.js"></script>
    <style type="text/css">
        @font-face
        {
            font-family: 'MonotypeCorsivaRegular';
            src: url('../fonts/mtcorsva.eot');
            src: url('../fonts/mtcorsva.eot') format('embedded-opentype'), url('../mtcorsva.woff') format('woff'), url('fonts/mtcorsva.ttf') format('truetype'), url('../fonts/mtcorsva.svg#MonotypeCorsivaRegular') format('svg');
        }
    </style>
    <style type='text/css'>
        P.pagebreakhere
        {
            page-break-after: always;
        }
    </style>
    <style type='text/css'>
        @media print
        {
            P.pagebreakhere
            {
                 position: relative;
                 display: block;
                 page-break-after: always;
            }
          
        }
        html, body, .formsc { float: none; }

        .break-after {
            display: block;
            page-break-after: always;
            position: relative;
        }

        .break-before {
            display: block;
            page-break-before: always;
            position: relative;
        }
    </style>
</asp:Content>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="head2">
    <%="<script src='" + ResolveUrl("~/js/jquery.printElement.js") + "' type='text/javascript'></script>"%>
    <%-- <%="<link href='" + ResolveUrl("~/css/leaveprint.css") + "' rel='stylesheet' type='text/css'  media='print' />"%>--%>
    <script type="text/javascript">
        function Cancel() {
            $("[id*=ddlStaffName]").val('');
            $("[id*=ddlDepartment]").val('');
            $("[id*=dvService]").html('');
            $('#aspnetForm').validate().resetForm();
        }
        function Print() {


            $(".formsc").printElement(
            {
                leaveOpen: true,
                printBodyOptions:
            {
                styleToAdd: 'padding:5px 20px 0px 20px;margin:5px 20px 0px 20px;color:#000;font-family:Arial, Helvetica, sans-serif; font-size:12px; text-align: left; !important;'

            }
            });
    }

    jQuery.moveColumn = function (table, from, to) {
        var rows = jQuery('tr', table);
        var cols;
        rows.each(function () {
            cols = jQuery(this).children('th, td');
            cols.eq(from).detach().insertBefore(cols.eq(to));
        });
    }
    $(document).ready(function () {
//        var tbl = jQuery('table.salarytbl');
//        jQuery.moveColumn(tbl, 10, 9);
//		 var tbl = jQuery('table.salarytbl');
//        jQuery.moveColumn(tbl, 13, 4);
//		var tbl = jQuery('table.salarytbl');
//        jQuery.moveColumn(tbl, 14, 8);
//		var tbl = jQuery('table.salarytbl');
//        jQuery.moveColumn(tbl, 15, 10);
    });
    </script>
</asp:Content>
<asp:Content ID="mainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="grid_10">
        <div class="box round first fullpage">
            <h2>
                History of Service
            </h2>
            <div class="clear">
            </div>
            <div class="block john-accord content-wrapper2">
                <table class="form" width="100%">
                    <tr>
                        <td>
                            Staff Name<label>
                                :</label>
                            <asp:DropDownList ID="ddlStaffName" runat="server" AppendDataBoundItems="True">
                                <asp:ListItem Value="">-----Select-----</asp:ListItem>
                            </asp:DropDownList>
                            &nbsp;
                            <label>
                                Department :</label>
                            <asp:DropDownList ID="ddlDepartment" runat="server" AppendDataBoundItems="True">
                                <asp:ListItem Value="">-----Select-----</asp:ListItem>
                            </asp:DropDownList>
                            &nbsp;
                            <label>
                                Building :</label>
                            <asp:DropDownList ID="ddlBuilding" runat="server" AppendDataBoundItems="True">
                                <asp:ListItem Value="">-----Select-----</asp:ListItem>
                            </asp:DropDownList>
                            &nbsp;
                            <asp:Button ID="btnSearch" runat="server" class="btn-icon button-search" Text="Search"
                                OnClick="btnSearch_Click" />
                            <asp:Button ID="Button2" runat="server" class="btn-icon button-cancel" OnClientClick="return Cancel();"
                                Text="Cancel" />
                            <asp:Button ID="btnPrint" runat="server" class="btn-icon button-print" OnClientClick="Print(); return false;"
                                Text="Print" />
                        </td>
                    </tr>
                </table>
                <div class="clear">
                </div>
                <div id="printContent" class="formsc" runat="server">
                </div>
                <div class="clear">
                </div>
            </div>
        </div>
    </div>
    <div class="clear">
    </div>
</asp:Content>
