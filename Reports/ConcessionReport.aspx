﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/AdminMaster.master"
    AutoEventWireup="true" CodeFile="ConcessionReport.aspx.cs" Inherits="Reports_ConcessionReport" %>

<%@ MasterType VirtualPath="~/MasterPage/AdminMaster.master" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>   
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <!--<script type="text/javascript" src="../js/jquery.min.js"></script>-->
     
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head2" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="grid_10">
        <div class="box round first fullpage">
            <h2>
                Concession Report</h2>
            <div class="clear">
            </div>
            <div align="center" class="block john-accord content-wrapper2">
                <table align="center">
                    <tr align="center">
                        <td><label>
                                            Class :</label>&nbsp;
                                        <asp:DropDownList ID="ddlClass" runat="server"
                                            AppendDataBoundItems="True" AutoPostBack="True" 
                                            onselectedindexchanged="ddlClass_SelectedIndexChanged">
                                            <asp:ListItem Selected="True" Value="">-----Select-----</asp:ListItem>
                                        </asp:DropDownList>
                                        &nbsp;
                                        <label>
                                            Section :</label>&nbsp;
                                        <asp:DropDownList ID="ddlSection" runat="server"
                                            AutoPostBack="True" 
                                            onselectedindexchanged="ddlSection_SelectedIndexChanged">
                                        </asp:DropDownList>
                                        &nbsp;
                            <label>
                                Month :</label>
                            <asp:DropDownList ID="ddlMonth" runat="server" 
                                onselectedindexchanged="ddlMonth_SelectedIndexChanged">                                 
                            </asp:DropDownList>
                            &nbsp;&nbsp;
                            <asp:Button ID="btnSearch" class="btn-icon button-search" Text="Search" runat="server" OnClick="btnSearch_Click" />&nbsp;<asp:DropDownList 
                                ID="cmbPrinters" runat="server" Width="150px">
                                    </asp:DropDownList>
                                    <asp:Button
                                ID="btnPrint" class="btn-icon button-print" Text="Print" runat="server" OnClick="btnPrint_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <rsweb:ReportViewer ID="ConcessionReport" runat="server" Font-Names="Verdana" 
                                Font-Size="8pt" InteractiveDeviceInfos="(Collection)" 
                                WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="1000px" 
                                Height="600px">
                                <LocalReport ReportPath="Rpt\ConcessionReport.rdlc">
                                    <DataSources>
                                        <rsweb:ReportDataSource DataSourceId="ObjectDataSource1" Name="DataSet1" />
                                    </DataSources>
                                </LocalReport>
                            </rsweb:ReportViewer>
                            <%--<CR:CrystalReportViewer ID="ConcessionReport" runat="server" AutoDataBind="True"
                                GroupTreeImagesFolderUrl="" Height="1174px" ToolbarImagesFolderUrl="" ToolPanelWidth="200px"
                                Width="868px" ReportSourceID="CrystalReportSource1" EnableDatabaseLogonPrompt="False"
                                EnableDrillDown="False" EnableParameterPrompt="False" HasCrystalLogo="False"
                                HasDrilldownTabs="False" HasDrillUpButton="False" HasToggleGroupTreeButton="False"
                                HasToggleParameterPanelButton="False" ToolPanelView="None" 
                                HasPrintButton="False" PrintMode="ActiveX"  HasSearchButton="False" HasGotoPageButton="False" />
                            <CR:CrystalReportSource ID="CrystalReportSource1" runat="server">
                                <Report FileName="..\Rpt\cryConcessionReport.rpt">
                                </Report>
                            </CR:CrystalReportSource>--%>
                            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
                                OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
                                TypeName="dsConcessionReportTableAdapters.sp_ConcessionListTableAdapter">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="ddlMonth" Name="formonth" 
                                        PropertyName="SelectedValue" Type="String" />
                                    <asp:SessionParameter Name="academicid" SessionField="AcademicID" 
                                        Type="String" />
                                    <asp:ControlParameter ControlID="ddlClass" Name="_class" 
                                        PropertyName="SelectedValue" Type="String" />
                                    <asp:ControlParameter ControlID="ddlSection" Name="section" 
                                        PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
