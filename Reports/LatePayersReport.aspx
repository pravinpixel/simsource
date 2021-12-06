<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/AdminMaster.master"
    AutoEventWireup="true" CodeFile="LatePayersReport.aspx.cs" Inherits="Reports_LatePayersReport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ MasterType VirtualPath="~/MasterPage/AdminMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="../js/jquery.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head2" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="grid_10">
        <div class="box round first fullpage">
            <h2>
                Late Payer List Report</h2>
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
                                        </asp:DropDownList>
                                        <label>
                                            Month :</label>
                                        <asp:DropDownList ID="ddlMonth" runat="server" OnSelectedIndexChanged="ddlMonth_SelectedIndexChanged"
                                            AutoPostBack="True">
                                        </asp:DropDownList>
                                        &nbsp;
                                        <asp:TextBox ID="txtStartdate" runat="server" CssClass="jsrequired dateNL date-picker"></asp:TextBox>
                                        <asp:Button ID="btnSearch" class="btn-icon button-search" Text="Search" runat="server"
                                            OnClick="btnSearch_Click" />&nbsp;
                                        <asp:DropDownList ID="cmbPrinters" runat="server" Width="150px">
                                        </asp:DropDownList>
                                        <asp:Button ID="btnPrint" class="btn-icon button-print" Text="Print" runat="server"
                                            OnClick="btnPrint_Click" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <rsweb:ReportViewer ID="LatePayersReport" Width="979px" Height="498px" runat="server"
                                            Font-Names="Verdana" Font-Size="8pt" InteractiveDeviceInfos="(Collection)" WaitMessageFont-Names="Verdana"
                                            WaitMessageFont-Size="14pt">
                                            <LocalReport ReportPath="Rpt\LatePayersReport.rdlc">
                                                <DataSources>
                                                    <rsweb:ReportDataSource DataSourceId="ObjectDataSource1" Name="DataSet1" />
                                                </DataSources>
                                            </LocalReport>
                                        </rsweb:ReportViewer>
                                        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                                            SelectMethod="GetData" TypeName="dsLatePayersTableAdapters.sp_getLatePayersTableAdapter">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="ddlMonth" Name="month" 
                                                    PropertyName="SelectedValue" Type="String" />
                                                <asp:ControlParameter ControlID="hfSDate" Name="StartDate" PropertyName="Value" Type="String" />
                                                <asp:ControlParameter ControlID="hfEDate" Name="EndDate" PropertyName="Value" Type="String" />
                                                <asp:SessionParameter Name="AcademicID" SessionField="AcademicID" Type="String" />
                                                <asp:ControlParameter ControlID="ddlClass" Name="_class" PropertyName="SelectedValue"
                                                    Type="String" />
                                                <asp:ControlParameter ControlID="ddlSection" Name="section" PropertyName="SelectedValue"
                                                    Type="String" />
                                            </SelectParameters>
                                        </asp:ObjectDataSource>
                                        <iframe id="frmPrint" name="IframeName" width="1500" height="200" runat="server"
                                            style="display: none"></iframe>
                                        <%-- <CR:CrystalReportViewer ID="LatePayersReport" runat="server" AutoDataBind="True"
                                            GroupTreeImagesFolderUrl="" Height="1174px" PrintMode="ActiveX" ToolbarImagesFolderUrl=""
                                            ReportSourceID="CrystalReportSource1" EnableDatabaseLogonPrompt="False" EnableDrillDown="False"
                                            EnableParameterPrompt="False" HasCrystalLogo="False" HasGotoPageButton="False"   
                                            HasSearchButton="False" HasDrilldownTabs="False"
                                            HasDrillUpButton="False" HasToggleGroupTreeButton="False" HasToggleParameterPanelButton="False"
                                            ToolPanelView="None" HasPrintButton="False" />
                                        <CR:CrystalReportSource ID="CrystalReportSource1" runat="server">
                                            <Report FileName="../Rpt/cryLatePayersReport.rpt">
                                            </Report>
                                        </CR:CrystalReportSource>--%>
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                        <Triggers>
                            <asp:PostBackTrigger ControlID="LatePayersReport" />
                            <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnPrint" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="ddlClass" EventName="SelectedIndexChanged" />
                            <asp:AsyncPostBackTrigger ControlID="ddlSection" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
