<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/AdminMaster.master"
    AutoEventWireup="true" CodeFile="UniformBillingReport.aspx.cs" EnableViewState="true" Inherits="Reports_UniformBillingReport" %>

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
                Uniform Billing Report</h2>
            <div class="clear">
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
                                        <asp:DropDownList ID="ddlClass" runat="server" AppendDataBoundItems="True" AutoPostBack="true"
                                            OnSelectedIndexChanged="ddlClass_SelectedIndexChanged">
                                            <asp:ListItem Selected="True" Value="">-----Select-----</asp:ListItem>
                                        </asp:DropDownList>
                                        &nbsp;
                                        <label>
                                            Section :</label>&nbsp;
                                        <asp:DropDownList ID="ddlSection" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlSection_SelectedIndexChanged">
                                        </asp:DropDownList>
                                        &nbsp;
                                        <asp:Button ID="btnSearch" class="btn-icon button-search" Text="Search" runat="server"
                                            OnClick="btnSearch_Click" />&nbsp;</td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" OldValuesParameterFormatString="original_{0}"
                                            SelectMethod="GetData" 
                                            
                                            TypeName="dsUnifromDataTableAdapters.DataTable1TableAdapter">
                                            <SelectParameters>
                                                <asp:SessionParameter Name="AcademicId" SessionField="AcademicID" 
                                                    Type="Int32" />
                                                <asp:ControlParameter ControlID="ddlClass" Name="ClassId" 
                                                    PropertyName="SelectedValue" Type="Int32" />
                                                <asp:ControlParameter ControlID="ddlSection" Name="SectionId" 
                                                    PropertyName="SelectedValue" Type="Int32" />
                                            </SelectParameters>
                                        </asp:ObjectDataSource>
                                        <rsweb:ReportViewer ID="UniformReport" runat="server" Font-Names="Verdana" Font-Size="8pt"
                                            InteractiveDeviceInfos="(Collection)" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt"
                                            Width="1000px">
                                            <LocalReport ReportPath="Rpt\UniformBillReport.rdlc">
                                                <DataSources>
                                                    <rsweb:ReportDataSource DataSourceId="ObjectDataSource2" Name="DataSet1" />
                                                </DataSources>
                                            </LocalReport>
                                        </rsweb:ReportViewer>
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                        <Triggers>
                            <asp:PostBackTrigger ControlID="UniformReport" />
                            <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="ddlClass" EventName="SelectedIndexChanged" />
                            <asp:AsyncPostBackTrigger ControlID="ddlSection" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
