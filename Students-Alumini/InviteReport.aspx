<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/AdminMaster.master"
    AutoEventWireup="true" CodeFile="InviteReport.aspx.cs" Inherits="Reports_InviteReport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head2" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="grid_10">
        <div class="box round first fullpage">
            <h2>
                Invitation Sent Report</h2>
            <div class="clear" align="center">
            </div>
            <div align="center" class="block john-accord content-wrapper2">
                <table align="center">
                    <tr>
                        <td>
                            <rsweb:ReportViewer ID="InviteReport" runat="server" Width="1000px" Font-Names="Verdana"
                                Font-Size="8pt" InteractiveDeviceInfos="(Collection)" WaitMessageFont-Names="Verdana"
                                WaitMessageFont-Size="14pt" Height="600px" onload="InviteReport_Load">
                                <LocalReport ReportPath="Rpt\InviteReport.rdlc">
                                    <DataSources>
                                        <rsweb:ReportDataSource DataSourceId="ObjectDataSource2" Name="DataSet1" />
                                    </DataSources>
                                </LocalReport>
                            </rsweb:ReportViewer>
                            <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" 
                                OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
                                TypeName="dsInvitationTableAdapters.sp_getInvitationTableAdapter">
                            </asp:ObjectDataSource>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
