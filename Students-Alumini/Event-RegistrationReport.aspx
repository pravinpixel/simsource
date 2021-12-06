<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/AdminMaster.master"
    AutoEventWireup="true" CodeFile="Event-RegistrationReport.aspx.cs" Inherits="Reports_Event_RegistrationReport" %>

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
                Event Registration Report</h2>
            <div class="clear" align="center">
            </div>
            <div align="center" class="block john-accord content-wrapper2">
                <table align="center">
                    <tr>
                        <td>
                            <rsweb:ReportViewer ID="EventReport" runat="server" Width="1000px" Font-Names="Verdana"
                                Font-Size="8pt" InteractiveDeviceInfos="(Collection)" WaitMessageFont-Names="Verdana"
                                WaitMessageFont-Size="14pt" Height="600px" onload="EventReport_Load">
                                <LocalReport ReportPath="Rpt\EventRegReport.rdlc">
                                    <DataSources>
                                        <rsweb:ReportDataSource DataSourceId="ObjectDataSource2" Name="DataSet1" />
                                    </DataSources>
                                </LocalReport>
                            </rsweb:ReportViewer>
                            <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" 
                                OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
                                TypeName="dsEventBookTableAdapters.sp_getEventBookinglistTableAdapter">
                            </asp:ObjectDataSource>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
