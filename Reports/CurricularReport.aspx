<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/AdminMaster.master"
    AutoEventWireup="true" CodeFile="CurricularReport.aspx.cs" Inherits="Reports_CurricularReport" %>

<%@ MasterType VirtualPath="~/MasterPage/AdminMaster.master" %>
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
                Concession Report</h2>
            <div class="clear">
            </div>
            <div align="center" class="block john-accord content-wrapper2">
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
                              &nbsp;&nbsp;<label>
                                Type :</label><asp:RadioButton ID="rbtnSports" runat="server" 
                    Text="Sports" Checked="true"
                                    GroupName="Paid" 
                    oncheckedchanged="rbtnSports_CheckedChanged"  />
                            <asp:RadioButton ID="rbtnFineArts" runat="server" Text="FineArts" Checked="false"
                                GroupName="Paid" 
                    oncheckedchanged="rbtnFineArts_CheckedChanged"  />
                        &nbsp;&nbsp;
                        <asp:Button ID="btnSearch" class="btn-icon button-search" Text="Search" runat="server"
                            OnClick="btnSearch_Click" />&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <rsweb:ReportViewer ID="rptCurricular" runat="server" Width="944px" 
                    Font-Names="Verdana" Font-Size="8pt" InteractiveDeviceInfos="(Collection)" 
                    WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt">
                            <localreport reportpath="Rpt\CurricularReport.rdlc">
                                <datasources>
                                    <rsweb:ReportDataSource DataSourceId="ObjectDataSource1" Name="DataSet1" />
                                </datasources>
                            </localreport>
                        </rsweb:ReportViewer>
                    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
                    TypeName="dsCurricularTableAdapters.DataTable1TableAdapter">
                        <SelectParameters>
                            <asp:SessionParameter Name="AcademicID" SessionField="AcademicID" 
                                Type="String" />
                            <asp:ControlParameter ControlID="ddlClass" Name="_class" 
                                PropertyName="SelectedValue" Type="String" />
                            <asp:ControlParameter ControlID="ddlSection" Name="section" 
                                PropertyName="SelectedValue" Type="String" />
                            <asp:SessionParameter Name="Type" SessionField="strType" Type="String" />
                        </SelectParameters>
                </asp:ObjectDataSource>
                    </td>
                </tr>
            </div>
        </div>
    </div>
</asp:Content>
