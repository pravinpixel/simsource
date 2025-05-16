<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/AdminMaster.master"
    AutoEventWireup="true" CodeFile="PaidUnPaidReport.aspx.cs" Inherits="Reports_PaidUnPaidReport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ MasterType VirtualPath="~/MasterPage/AdminMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="../js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $("[id$=btnExport]").click(function (e) {
                window.open('data:application/vnd.ms-excel,' + encodeURIComponent($('div[id$=dvCard]').html()));
                e.preventDefault();
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head2" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="grid_10">
        <div class="box round first fullpage">
            <h2>
                Paid/UnPaid Report</h2>
            <div class="clear">
            </div>
            <div align="center" class="block john-accord content-wrapper2">
                <table align="center">
                    <tr align="center">
                        <td>
                            <label>
                                Class :</label>&nbsp;
                            <asp:DropDownList ID="ddlClass" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                OnSelectedIndexChanged="ddlClass_SelectedIndexChanged">
                                <asp:ListItem Selected="True" Value="">-----Select-----</asp:ListItem>
                            </asp:DropDownList>
                            &nbsp;
                            <label>
                                Section :</label>&nbsp;
                            <asp:DropDownList ID="ddlSection" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlSection_SelectedIndexChanged">
                            </asp:DropDownList>
                            &nbsp;
                            <label>
                                Month :</label>
                            <asp:DropDownList ID="ddlMonth" runat="server" OnSelectedIndexChanged="ddlMonth_SelectedIndexChanged">
                            </asp:DropDownList>
                            &nbsp;&nbsp;<label>
                                Type :</label><asp:RadioButton ID="rbtnPaid" runat="server" Text="PaidList" Checked="true"
                                    GroupName="Paid" OnCheckedChanged="rbtnPaid_CheckedChanged" />
                            <asp:RadioButton ID="rbtnUnPaid" runat="server" Text="UnPaidList" Checked="false"
                                GroupName="Paid" OnCheckedChanged="rbtnUnPaid_CheckedChanged" />
                           <%-- <label>
                                Fees Type :</label>
                            <asp:DropDownList ID="dpFeesType" runat="server" CssClass="jsrequired" AutoPostBack="False">
                                <asp:ListItem Value="Regular" Selected="True">Regular</asp:ListItem>
                                <asp:ListItem Value="Advance">Advance</asp:ListItem>
                            </asp:DropDownList>--%>
                            <asp:Button ID="btnSearch" class="btn-icon button-search" Text="Search" runat="server"
                                OnClick="btnSearch_Click" />&nbsp;
                            <input type="button" id="btnExport" value="Export" class="btn-icon button-exprots" />
                        </td>
                    </tr>
                    <div style="overflow-y: scroll;">
                        <table align="center">
                            <tr align="center">
                                <td>
                                    <div class="IDprint">
                                        <div id="dvCard" runat="server" class="staff-list-report">
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
