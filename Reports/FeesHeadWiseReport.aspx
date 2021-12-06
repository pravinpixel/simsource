﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/AdminMaster.master"
    AutoEventWireup="true" CodeFile="FeesHeadWiseReport.aspx.cs" Inherits="Reports_FeesHeadWiseReport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

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
    <div class="grid_10">
        <div class="box round first fullpage">
            <h2>
                Fees Headwise Report</h2>
            <div class="clear">
                <asp:HiddenField ID="hfSDate" runat="server" />
                <asp:HiddenField ID="hfEDate" runat="server" />
            </div>
            <div align="center" class="block content-wrapper2">
                <div style="overflow:auto">
                <asp:UpdatePanel ID="ups" runat="server">
                <ContentTemplate>
                
                    <table align="left">
                        <tr align="left">
                            <td>
                                <asp:TextBox ID="txtStartdate" CssClass="jsrequired dateNL date-picker" 
                                    runat="server"></asp:TextBox>
                                &nbsp;&nbsp;
                                <asp:TextBox ID="txtEnddate" CssClass="jsrequired dateNL date-picker" runat="server"></asp:TextBox>
                                &nbsp;&nbsp;
                                <asp:Button ID="btnSearch" class="btn-icon button-search" Text="Search" runat="server" OnClick="btnSearch_Click" />
                                <asp:DropDownList ID="cmbPrinters" runat="server" Width="150px">
                                </asp:DropDownList>
                                <asp:Button ID="btnPrint" class="btn-icon button-print" Text="Print" runat="server" OnClick="btnPrint_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <rsweb:ReportViewer ID="FeesHeadWiseReport" runat="server" Width="1168px" 
                                    Font-Names="Verdana" Font-Size="8pt" InteractiveDeviceInfos="(Collection)" 
                                    WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Height="600px">
                                    <LocalReport ReportPath="Rpt\FeesHeadwiseReport.rdlc">
                                        <DataSources>
                                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource1" Name="DataSet1" />
                                        </DataSources>
                                    </LocalReport>
                                </rsweb:ReportViewer>
                                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
                                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
                                    TypeName="FeesHeadwiseTableAdapters.Vw_GetSchoolFeesTableAdapter">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="AcademicID" SessionField="AcademicID" 
                                            Type="Int32" />
                                        <asp:ControlParameter ControlID="hfSDate" Name="StartDate" PropertyName="Value" 
                                            Type="String" />
                                        <asp:ControlParameter ControlID="hfEDate" Name="Enddate" PropertyName="Value" 
                                            Type="String" />
                                    </SelectParameters>
                                </asp:ObjectDataSource>                              
                            </td>
                        </tr>
                    </table>
                    </ContentTemplate>
                <Triggers>
                <asp:PostBackTrigger ControlID="FeesHeadWiseReport" />
                <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btnPrint" EventName="Click" />
                </Triggers>
                </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
