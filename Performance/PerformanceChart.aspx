<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/AdminMaster.master"
    AutoEventWireup="true" CodeFile="PerformanceChart.aspx.cs" Inherits="Performance_PerformanceChart" %>

<%@ MasterType VirtualPath="~/MasterPage/AdminMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="../js/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="../css/terms.css" />
    <style type="text/css">
        @media print
        {
            .printContent
            {
                display: block;
            }
        }
        @media screen
        {
            .printContent
            {
                display: none;
            }
        }
        
        .signature img
        {
            max-width: inherit;
        }
    </style>
    <script type="text/javascript">

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head2" runat="Server">
    <%="<script src='" + ResolveUrl("~/js/jquery.printElement.js") + "' type='text/javascript'></script>"%>
    <%="<link href='" + ResolveUrl("~/css/print-terms.css") + "' rel='stylesheet' type='text/css'  media='print, handheld' />"%>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            setDatePicker("[id*=txtIssueDate]");
        });
        function Print() {

            $(".formsc").printElement(
            {
                leaveOpen: true,
                printBodyOptions:
            {
                styleToAdd: 'padding:5px 20px 0px 20px;margin:5px 25px 0px 20px;color:#000 !important;'

            }
                            ,
                overrideElementCSS: [

                        '../css/terms.css',

                        { href: '../css/print-terms.css', media: 'print'}]
            });
        }
    </script>
    <asp:HiddenField ID="hdnUserName" runat="server" />
    <asp:HiddenField ID="hfUserId" runat="server" />
    <div class="grid_10">
        <div class="box round first fullpage">
            <h2>
                Performance Chart</h2>
            <div class="clear">
            </div>
            <div align="center" class="block john-accord content-wrapper2">
                <table class="form" width="100%">
                    <tr>
                        <td width="40%" align="left">
                            <label>
                                Class :</label>
                            <asp:DropDownList ID="ddlClass" CssClass="jsrequired" runat="server" AppendDataBoundItems="True"
                                AutoPostBack="true" OnSelectedIndexChanged="ddlClass_SelectedIndexChanged">
                                <asp:ListItem Selected="True" Value="">---Select---</asp:ListItem>
                            </asp:DropDownList>
                            <label>
                                Section :</label>
                            <asp:DropDownList ID="ddlSection" runat="server" AppendDataBoundItems="True" AutoPostBack="true"
                                CssClass="jsrequired" OnSelectedIndexChanged="ddlSection_SelectedIndexChanged">
                                <asp:ListItem Selected="True" Value="">---Select---</asp:ListItem>
                            </asp:DropDownList>
                            &nbsp;
                        </td>
                        <td align="left" width="7%">
                            <label>
                                Exam Name :</label>
                        </td>
                        <td align="left">
                            <%-- <asp:CheckBoxList ID="chkExamName" runat="server" CssClass="checkboxlist" RepeatColumns="7"
                                        RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    </asp:CheckBoxList>--%>
                            <asp:DropDownList ID="ddlExamName" CssClass="jsrequired" runat="server">
                                <asp:ListItem Selected="True" Value="">---Select---</asp:ListItem>
                            </asp:DropDownList>
                           
                        </td>
                       <td>
                        <label>
                                Display Type :</label>
                            <asp:DropDownList ID="ddlType" runat="server" AutoPostBack="True">
                                <asp:ListItem Selected="True" Value="">---Select---</asp:ListItem>
                                <asp:ListItem Value="Grade">Grade</asp:ListItem>
                            </asp:DropDownList>
                       </td>
                    </tr>
                    <tr>
                        <td>
                            <label>
                                Date of Issue :</label>
                            <asp:TextBox ID="txtIssueDate" CssClass="dateNL date-picker" runat="server"></asp:TextBox>
                        </td>
                        <td colspan="2" align="left">
                            <label>
                                Upload Image :</label>
                            <input type='file' id="FuPhoto" runat="server" />
                        </td>
                          <td align="left">
                            &nbsp;
                            <label>
                                Search by Regno(enter with comma separated):</label>
                            <asp:TextBox ID="txtSearch" runat="server" TextMode="MultiLine" Width="244px"></asp:TextBox>
                        </td>
                    </tr>
                </table>
                <table class="form">
                    <tr>
                        <td align="center" class="col1">
                            &nbsp;<asp:Button ID="btnUpdate" runat="server" class="btn-icon button-search" OnClick="btnUpdate_Click"
                                Text="Update" />
                            <asp:Button ID="btnSearch" runat="server" class="btn-icon button-search" Text="Search"
                                OnClick="btnSearch_Click" />
                            <asp:Button ID="Button2" runat="server" class="btn-icon button-cancel" OnClientClick="return Cancel();"
                                Text="Cancel" />
                            <asp:Button ID="btnPrint" runat="server" class="btn-icon button-print" OnClientClick="Print();"
                                Text="Print" />
                        </td>
                    </tr>
                </table>
                <table width="100%">
                    <tr>
                        <td>
                            <div id="printContent" class="formsc">
                                <div id="dvCard" style="overflow: auto; width: 1000px;" runat="server">
                                </div>
                            </div>
                            <br />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
