<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/AdminMaster.master"
    AutoEventWireup="true" CodeFile="AlumniReport.aspx.cs" Inherits="Reports_AlumniReport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
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
    <div class="grid_10">
        <div class="box round first fullpage">
            <h2>
                Alumni Report</h2>
            <div class="clear">
                <asp:HiddenField ID="hfSDate" runat="server" />
                <asp:HiddenField ID="hfEDate" runat="server" />
            </div>
            <div class="clear" align="center">
            </div>
            <div align="center" class="block john-accord content-wrapper2">
             <asp:UpdatePanel ID="ups" runat="server">
                <ContentTemplate>
                <table align="center">
                    <tr>
                        <td>
                            <asp:TextBox ID="txtStartdate" CssClass="jsrequired dateNL date-picker" runat="server"
                                OnTextChanged="txtStartdate_TextChanged" AutoPostBack="True"></asp:TextBox>
                            &nbsp;&nbsp;
                            <asp:TextBox ID="txtEnddate" CssClass="jsrequired dateNL date-picker" runat="server"
                                OnTextChanged="txtEnddate_TextChanged" AutoPostBack="True"></asp:TextBox>
                            &nbsp;&nbsp;
                            <asp:Button ID="btnSearch" class="btn-icon button-search" Text="Search" runat="server"
                                OnClick="btnSearch_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <rsweb:ReportViewer ID="AlumniReport" runat="server" Width="1000px" Font-Names="Verdana"
                                Font-Size="8pt" InteractiveDeviceInfos="(Collection)" WaitMessageFont-Names="Verdana"
                                WaitMessageFont-Size="14pt" Height="600px" onload="AlumniReport_Load">
                                <LocalReport ReportPath="Rpt\AluminiReport.rdlc">
                                    <DataSources>
                                        <rsweb:ReportDataSource DataSourceId="ObjectDataSource2" Name="DataSet1" />
                                    </DataSources>
                                </LocalReport>
                            </rsweb:ReportViewer>
                            <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" OldValuesParameterFormatString="original_{0}"
                                SelectMethod="GetData" TypeName="dsAlumniTableAdapters.sp_GetAluminiListTableAdapter">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="hfSDate" Name="fromdate" PropertyName="Value" 
                                        Type="String" />
                                    <asp:ControlParameter ControlID="hfEDate" Name="todate" PropertyName="Value" 
                                        Type="String" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                        </td>
                    </tr>
                </table>
                 </ContentTemplate>
                <Triggers>
                <asp:PostBackTrigger ControlID="AlumniReport" />
                <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                </Triggers>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>
</asp:Content>
