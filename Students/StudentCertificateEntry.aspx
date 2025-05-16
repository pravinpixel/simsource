<%@ Page Language="C#" MasterPageFile="~/MasterPage/AdminMaster.master" AutoEventWireup="true"
    CodeFile="StudentCertificateEntry.aspx.cs" Inherits="Students_StudentCertificateEntry" %>

<%@ MasterType VirtualPath="~/MasterPage/AdminMaster.master" %>
<asp:Content ID="headContent" runat="server" ContentPlaceHolderID="head">
    <script type="text/javascript" src="../js/jquery.min.js"></script>
    <%--Save Personal Details--%>
    <script type="text/javascript">
        $(document).ready(function () {
            setDatePicker("[id*=txtDate]");
            setDatePicker("[id*=txtEndDate]");

        });
        $(function () {
            if ($("[id*=hdnSCID]").val() == "") {
                GetSerialNo();
            }

        });
        function GetStudentInfo() {
            if ($("[id*=txtRegNo]").val() != "") {
                $.ajax({
                    type: "POST",
                    url: "../Students/StudentCertificateEntry.aspx/StudentInfo",
                    data: '{regno: "' + $("[id*=txtRegNo]").val() + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        var xmlDoc = $.parseXML(response.d);
                        var xml = $(xmlDoc);
                        var cls = xml.find("StudentInfo");
                        $.each(cls, function () {
                            $("[id*=lblName]").html($(this).find("StudentName").text());
                            $("[id*=hdnRegNo]").val($(this).find("StudentID").text());
                            var PhotoFile = $(this).find("PhotoFile").text();
                            if (PhotoFile) {
                                $("[id*=img_prev]").attr('src', "../Students/Photos/" + PhotoFile.toString() + "?rand=" + Math.random()).width(114).height(114)
                            }
                            else {
                                $("[id*=img_prev]").attr('src', "../img/Photo.jpg").width(114).height(114);
                            }
                        });
                    },
                    failure: function (response) {
                        AlertMessage('info', response.d);
                    },
                    error: function (response) {
                        AlertMessage('info', response.d);
                    }
                });
            }
            else {
                return false;
            }
        }
        function GetSerialNo() {
            $.ajax({
                type: "POST",
                url: "../Students/StudentCertificateEntry.aspx/GetSerialNo",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnGetSerialNoSuccess,
                failure: function (response) {
                    AlertMessage('info', response.d);
                },
                error: function (response) {
                    AlertMessage('info', response.d);
                }
            });
        }

        function OnGetSerialNoSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var SCID = xml.find("SCIDs");
            $.each(SCID, function () {
                $("[id*=lblSLNo]").html($(this).find("SerialNo").text());
            });
        };

        function Save() {
            var ddlFor = $("#ctl00_ContentPlaceHolder1_ddlFor option:selected").text();
            var comptype;
            if ($("[id*=rbtntype1]").is(':checked')) {
                comptype = "Inter School";
            }

            else if ($("[id*=rbtntype2]").is(':checked')) {
                comptype = "Intra School";
            }

            var complevel;
            if ($("[id*=rbtnLevel1]").is(':checked')) {
                complevel = "National";
            }

            else if ($("[id*=rbtnLevel2]").is(':checked')) {
                complevel = "State";
            }

            else if ($("[id*=rbtnLevel3]").is(':checked')) {
                complevel = "Zonal";
            }

            else if ($("[id*=rbtnLevel4]").is(':checked')) {
                complevel = "School";
            }



            var Print;
            if ($("[id*=rbtnPrintYes]").is(':checked')) {
                Print = "1";
            }

            else if ($("[id*=rbtnPrintNo]").is(':checked')) {
                Print = "0";
            }
            var compdate = $("[id*=txtDate]").val();
            var compenddate = $("[id*=txtEndDate]").val();


            if ($('#aspnetForm').valid()) {
                var parameters = '{"slNo": "' + $("[id*=lblSLNo]").html() + '","RegNo": "' + $("[id*=hdnRegNo]").val() + '","AcademicId": "' + $("[id*=hfAcademicYear]").val() + '","title": "' + $("[id*=txtEvent]").val() + '","comptype": "' + comptype + '","complevel": "' + complevel + '","compfor": "' + ddlFor + '","compdate": "' + compdate + '","compenddate": "' + compenddate + '","awardtype": "' + $("[id*=txtawardtype]").val() + '","Conductby": "' + $("[id*=txtConductedby]").val() + '","remarks": "' + $("[id*=txtremarks]").val() + '","eventname": "' + $("[id*=txtEvent]").val() + '","result": "' + $("[id*=ddlresult]").val() + '","position": "' + $("[id*=ddlPosition]").val() + '","isprint": "' + Print + '","UserId": "' + $("[id*=hfuserid]").val() + '"}';
                $.ajax({
                    type: "POST",
                    url: "../Students/StudentCertificateEntry.aspx/Save",
                    data: parameters,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnSaveSuccess,
                    failure: function (response) {
                        AlertMessage('info', response.d);
                    },
                    error: function (response) {
                        AlertMessage('info', response.d);
                    }
                });
            }
        }

        function OnSaveSuccess(response) {
            if (response.d != "") {
                AlertMessage('info', 'Failed');
            }
            else {
                AlertMessage('success', 'Certificate Generated');
                GetModuleID('Students/StudentCertificateSearch.aspx');
            }
        }

        function GetModuleID(path) {
            $.ajax({
                type: "POST",
                url: "../Students/StudentCertificateEntry.aspx/GetModuleId",
                data: '{"path": "' + path + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnModuleIDSuccess,
                failure: function (response) {
                    AlertMessage('info', response.d);
                },
                error: function (response) {
                    AlertMessage('info', response.d);
                }
            });

        }
        function OnModuleIDSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var cls = xml.find("ModuleMenusByPath");
            $.each(cls, function () {
                $("[id*=hfModuleID]").val($(this).find("modulemenuid").text());
                $("[id*=hdnMenuIndex]").val($(this).find("menuid").text())
                var url = "../Students/StudentCertificateSearch.aspx?menuId=" + $("[id*=hdnMenuIndex]").val() + "&activeIndex=" + $("[id*=hdnIndex]").val() + "&moduleId=" + $("[id*=hfModuleID]").val() + "";
                $(location).attr('href', url)
            });
        }
        
    </script>
</asp:Content>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="head2">
    <style type="text/css">
        .style1
        {
            font-weight: bold;
        }
        .style2
        {
            width: 260px;
        }
    </style>
</asp:Content>
<asp:Content ID="mainContent" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <asp:HiddenField ID="hdnRegNo" runat="server" />
    <asp:HiddenField ID="hdnSCID" runat="server" />
    <asp:HiddenField ID="hfModuleID" runat="server" />
    <div class="grid_10">
        <div class="box round first fullpage">
            <h2>
                STUDENT CERTIFICATE</h2>
            <div class="block content-wrapper2">
                <table width="100%">
                    <tr valign="top">
                        <td valign="top">
                            <div id="dvCashVoucher" runat="server">
                                <table class="form">
                                    <tr>
                                        <td align="center">
                                            <h1>
                                                Student Certificate Entry</h1>
                                        </td>
                                    </tr>
                                </table>
                                <table width="100%" class="form" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td style="text-align: right">
                                            <label>
                                                Register No :
                                            </label>
                                        </td>
                                        <td class="style2">
                                            <input type="text" id="testid" value="" style="display: none" />
                                            <asp:TextBox ID="txtRegNo" CssClass="bloodgroup" runat="server"></asp:TextBox>
                                            <button id="btnSearch" type="button" class="btn-icon btn-orange btn-saving" onclick="GetStudentInfo();">
                                                <span></span>Search</button>
                                            <%--     <asp:Button ID="btnsearch" ValidationGroup="test" class="btn-icon button-search" runat="server" 
                                                Text="Search" onclick="btnsearch_Click">
                                            </asp:Button>--%>
                                        </td>
                                        <td>
                                            <img id="img_prev" src="../img/photo.jpg" class='zoom' runat="server" alt="Profile Photo"
                                                width="114" height="114" />
                                        </td>
                                    </tr>
                                </table>
                                <table width="100%" border="0" cellspacing="20" cellpadding="20" class="form">
                                    <tr>
                                        <td>
                                            <table width="100%" border="0" class="form">
                                                <tr>
                                                    <td class="col1" colspan="3" align="center" style="text-align: left">
                                                        <label>
                                                            Certificate Sl. No. :
                                                        </label>
                                                        <asp:Label ID="lblSLNo" runat="server" Style="text-align: left; font-weight: 700;"></asp:Label>
                                                        &nbsp;&nbsp;
                                                        <label style="text-align: left">
                                                            Name :
                                                        </label>
                                                        <asp:Label ID="lblName" runat="server" CssClass="style1"></asp:Label>
                                                    </td>
                                                    <td class="col1" align="center" style="text-align: left">
                                                        <label>
                                                            Academic Year:
                                                        </label>
                                                        <asp:Label ID="lblAcdYear" runat="server" CssClass="style1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="col1" align="left">
                                                        <label>
                                                            1. Name of Competition <span style="color: Red">*</span></label>
                                                    </td>
                                                    <td colspan="2">
                                                        :
                                                    </td>
                                                    <td style="text-align: left">
                                                        <asp:DropDownList ID="ddlFor" AppendDataBoundItems="true" CssClass="jsrequired" runat="server"
                                                            AutoPostBack="false" OnSelectedIndexChanged="ddlFor_SelectedIndexChanged">
                                                            <asp:ListItem Selected="True" Value="">Select</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="col1" align="left">
                                                        <label>
                                                            2. Title of Certificate <span style="color: Red">*</span>
                                                        </label>
                                                    </td>
                                                    <td width="4%" colspan="2">
                                                        :
                                                    </td>
                                                    <td width="48%">
                                                        <span>
                                                            <asp:DropDownList ID="ddlresult" CssClass="jsrequired" runat="server">
                                                                <asp:ListItem Selected="True" Value="">Select</asp:ListItem>
                                                                <asp:ListItem Value="Pariticpant">Certificate of Participant</asp:ListItem>
                                                                <asp:ListItem Value="Winner">Certificate of Merit</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="col1" align="left">
                                                        <label>
                                                            3. Competition Type <span style="color: Red">*</span>
                                                        </label>
                                                    </td>
                                                    <td colspan="2">
                                                        :
                                                    </td>
                                                    <td style="text-align: left">
                                                        <asp:RadioButton ID="rbtntype1" GroupName="Type" Checked="true" runat="server" Text="Inter School" />
                                                        <asp:RadioButton ID="rbtntype2" GroupName="Type" runat="server" Text="Intra School" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="col1" align="left">
                                                        <label>
                                                            4. competition Level <span style="color: Red">*</span>
                                                        </label>
                                                    </td>
                                                    <td colspan="2">
                                                        :
                                                    </td>
                                                    <td style="text-align: left">
                                                        <asp:RadioButton ID="rbtnLevel1" GroupName="Level" Checked="true" runat="server"
                                                            Text="National " />
                                                        <asp:RadioButton ID="rbtnLevel2" GroupName="Level" runat="server" Text="State" />
                                                        <asp:RadioButton ID="rbtnLevel3" GroupName="Level" runat="server" Text="Zonal" />
                                                        <asp:RadioButton ID="rbtnLevel4" GroupName="Level" runat="server" Text="School" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="col1" align="left">
                                                        <label>
                                                            5. Conducted By <span style="color: Red">*</span>
                                                        </label>
                                                    </td>
                                                    <td colspan="2">
                                                        :
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtConductedby" runat="server" CssClass="jsrequired" Width="400px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="col1" align="left">
                                                        6<label>. Name of the Program <span style="color: Red">*</span>
                                                        </label>
                                                    </td>
                                                    <td colspan="2">
                                                        :
                                                    </td>
                                                    <td style="text-align: left">
                                                        <asp:TextBox ID="txtEvent" CssClass="jsrequired" runat="server" Width="400px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="col1" align="left">
                                                        <label>
                                                            7. Remarks (Winner / Participant)</label>
                                                    </td>
                                                    <td colspan="2">
                                                        :
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtremarks" runat="server" Width="400px" MaxLength="200" TextMode="MultiLine"></asp:TextBox>
                                                        (Max Upto 200 Characters)
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="col1" align="left">
                                                        <label>
                                                            8. Certification Print
                                                        </label>
                                                    </td>
                                                    <td colspan="2">
                                                        :
                                                    </td>
                                                    <td style="text-align: left">
                                                        <asp:RadioButton ID="rbtnPrintYes" GroupName="Print" runat="server" Text="Yes" />
                                                        &nbsp;
                                                        <asp:RadioButton ID="rbtnPrintNo" GroupName="Print" runat="server" Text="No" Checked="True" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="col1" align="left">
                                                        9<label>. Program Start Date <span style="color: Red">*</span>
                                                        </label>
                                                    </td>
                                                    <td colspan="2">
                                                        :
                                                    </td>
                                                    <td style="text-align: left">
                                                        <asp:TextBox ID="txtDate" CssClass="jsrequired dateNL date-picker" runat="server"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="col1" align="left">
                                                        9<label>. Program End Date
                                                        </label>
                                                    </td>
                                                    <td colspan="2">
                                                        :
                                                    </td>
                                                    <td style="text-align: left">
                                                        <asp:TextBox ID="txtEndDate" CssClass="jsrequired dateNL date-picker" runat="server"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="col1" align="left">
                                                        <label>
                                                            10. Name of the Event
                                                        </label>
                                                    </td>
                                                    <td colspan="2">
                                                        :
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtawardtype" runat="server" Width="400px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="col1" align="left">
                                                        11<label>. Position <span style="color: Red">*</span>
                                                        </label>
                                                    </td>
                                                    <td colspan="2">
                                                        :
                                                    </td>
                                                    <td style="text-align: left">
                                                        <asp:DropDownList ID="ddlPosition" CssClass="jsrequired" runat="server">
                                                            <asp:ListItem Selected="True" Value="-1">Select</asp:ListItem>
                                                            <asp:ListItem Value="I">I</asp:ListItem>
                                                            <asp:ListItem Value="II">II</asp:ListItem>
                                                            <asp:ListItem Value="III">III</asp:ListItem>
                                                            <asp:ListItem Value="IV">IV</asp:ListItem>
                                                            <asp:ListItem Value="V">V</asp:ListItem>
                                                            <asp:ListItem Value="VI">VI</asp:ListItem>
                                                            <asp:ListItem Value="VII">VII</asp:ListItem>
                                                            <asp:ListItem Value="VIII">VIII</asp:ListItem>
                                                            <asp:ListItem Value="IX">IX</asp:ListItem>
                                                            <asp:ListItem Value="X">X</asp:ListItem>
                                                            <asp:ListItem Value="Consolation">Consolation</asp:ListItem>
                                                            <asp:ListItem Value="Winner">Winner</asp:ListItem>
                                                            <asp:ListItem Value="Participant">Participant</asp:ListItem>
                                                            <asp:ListItem Value="Best Exhibit">Best Exhibit</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" valign="top" align="center">
                                                        <button id="btnSave" type="button" class="btn-icon btn-orange btn-saving" onclick="Save();">
                                                            <span></span>Save</button>
                                                    </td>
                                                </tr>
                                            </table>
                                            <asp:HiddenField ID="hfStudentID" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
