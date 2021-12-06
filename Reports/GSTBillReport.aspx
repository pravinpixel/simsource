<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/AdminMaster.master"
    AutoEventWireup="true" CodeFile="GSTBillReport.aspx.cs" Inherits="Reports_GSTBillReport" %>

<%@ MasterType VirtualPath="~/MasterPage/AdminMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="../js/jquery.min.js"></script>
     <script type="text/javascript">
         $(document).ready(function () {
             setDatePicker("[id*=txtStartdate]");
             setDatePicker("[id*=txtEnddate]");
         }); 
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head2" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%="<script src='" + ResolveUrl("~/js/jquery.printElement.js") + "' type='text/javascript'></script>"%>
    <%="<link href='" + ResolveUrl("../css/ManageFees.css") + "' rel='stylesheet' type='text/css'  media='screen' />"%>
    <%="<link href='" + ResolveUrl("../css/PrintschoolFees.css") + "' rel='stylesheet' type='text/css'  media='screen' />"%>
    <style type="text/css">
        .billcont
        {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 19px;
        }
        .ph
        {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 16px;
        }
    </style>
    <script type="text/javascript">
        function Print() {
            $.ajax({
                type: "POST",
                url: "../Reports/GSTBillReport.aspx/PrintBillDetails",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnPrintSuccess,
                failure: function (response) {
                    AlertMessage('info', response.d);
                },
                error: function (response) {
                    AlertMessage('info', response.d);
                }
            });
        }


        function OnPrintSuccess(response) {
            $(".IDprint").html('');
            if (response.d != '') {
                $(".IDprint").html(response.d);

                $(".IDprint").printElement(
            {
                async: false,
                leaveOpen: true,

                overrideElementCSS: [

                        '../css/PrintschoolFees.css',

                        { href: '../css/PrintschoolFees.css', media: 'print'}]
            });

            }
        }
    </script>
    <div class="grid_10">
        <div class="box round first fullpage">
            <h2>
                EOD Report</h2>
         <div class="clear">
                <asp:HiddenField ID="hfSDate" runat="server" />
                <asp:HiddenField ID="hfEDate" runat="server" />
            </div>
            <div align="center" class="block content-wrapper2">
                <div style="overflow: auto">
                <asp:UpdatePanel ID="ups" runat="server">
                <ContentTemplate>
                
                    <table align="left">
                        <tr align="left">
                            <td>
                                <label>
                                    Class :</label>&nbsp;
                                <asp:DropDownList ID="ddlClass" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                    OnSelectedIndexChanged="ddlClass_SelectedIndexChanged">
                                    <asp:ListItem Selected="True" Value="">-----Select----</asp:ListItem>
                                </asp:DropDownList>
                                &nbsp;
                                <label>
                                    Section :</label>&nbsp;
                                <asp:DropDownList ID="ddlSection" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlSection_SelectedIndexChanged">
                                    <asp:ListItem Selected="True" Value="">-----Select----</asp:ListItem>
                                </asp:DropDownList>
                               
                            </td>
                             <td>
                                <asp:TextBox ID="txtStartdate" CssClass="jsrequired dateNL date-picker" 
                                    runat="server" ontextchanged="txtStartdate_TextChanged" AutoPostBack="True"></asp:TextBox>
                                &nbsp;&nbsp;
                                <asp:TextBox ID="txtEnddate" CssClass="jsrequired dateNL date-picker" 
                                     runat="server" ontextchanged="txtEnddate_TextChanged" AutoPostBack="True"></asp:TextBox>
                                &nbsp;&nbsp;                             
                            </td>
                            <td> &nbsp; <asp:Button ID="btnPrint" class="btn-icon button-print" Text="Print" runat="server"
                                    OnClientClick="Print();" /></td>
                        </tr>
                        <tr align="left">
                            <td align="center" colspan="3">
                                <asp:Button ID="btnSearch" class="btn-icon button-search" Visible="false" Text="Search" runat="server"
                                    OnClick="btnSearch_Click" />
                               
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <div id="dvCard" runat="server">
                                </div>
                            </td>
                        </tr>
                    </table>

                       </ContentTemplate>
                <Triggers>
                <asp:AsyncPostBackTrigger ControlID="txtStartdate" EventName="TextChanged" />
                <asp:AsyncPostBackTrigger ControlID="txtEnddate" EventName="TextChanged" />
                </Triggers>
                </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
    <div class="IDprint">
    </div>
</asp:Content>
