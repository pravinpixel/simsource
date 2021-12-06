<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/AdminMaster.master"
    EnableEventValidation="false" AutoEventWireup="true" CodeFile="TransferCertificate.aspx.cs"
    Inherits="Students_TransferCertificate" %>

<%@ MasterType VirtualPath="~/MasterPage/AdminMaster.master" %>
<asp:Content ID="Content3" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">

        function GetModuleMenuID(path) {
            $.ajax({
                type: "POST",
                url: "../Students/TransferCertificate.aspx/GetModuleMenuId",
                data: '{"path": "' + path + '","UserId":"' + $("[id*=hdnUserId]").val() + '"}',
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
            var modmenu = xml.find("ModuleMenu");
            $("[id*=hfAcdMenuId]").val(modmenu.find("menuid").text());
            $("[id*=hfAcdModuleID]").val(modmenu.find("modulemenuid").text());
            var url = "../Students/TCSearch.aspx?menuId=" + $("[id*=hdnMenuIndex]").val() + "&activeIndex=" + $("[id*=hdnIndex]").val() + "&moduleId=" + $("[id*=hfModuleID]").val() + "&StudentID=" + $("[id*=hdnRegNo]").val() + "";
            $(location).attr('href', url)
        }
        function SendForApporval(regNo) {

            $.ajax({
                type: "POST",
                url: "../Students/TransferCertificate.aspx/SendForApporval",
                data: '{"RegNo": "' + regNo + '","AcademicId":"' + $('[id*=hdnAcademicYearId]').val() + '","userId":"' + $('#<%= hdnUserId.ClientID %>').val() + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d == "1")
                        GetModuleMenuID('Students/TCSearch.aspx');
                    else
                        AlertMessage('fail', "Failed");

                },
                failure: function (response) {
                    AlertMessage('info', response.d);
                },
                error: function (response) {
                    AlertMessage('info', response.d);
                }
            });

        }

        function SaveTCDetails(isPrintTc) {
            if ($("[id*=hfAddPrm]").val() == 'true') {
                if ($('#aspnetForm').valid()) {
                    var parameters = '{"isPrint":"' + isPrintTc + '","regNo": "' + $("[id*=hdnRegNo]").val() + '","academicId": "' + $("[id*=hfAcademicYear]").val() + '","userId": "' + $("[id*=hfuserid]").val() + '","leaveOfStudy": "' + $("[id*=txtSTD]").val() + '","promotionText": "' + $("[id*=txtPromotion]").val() + '","medicalCheckup": "' + $("[id*=sltMedicalInspection]").val() + '","lastDate": "' + $("[id*=txtTCStudLateDate]").val() + '","conduct": "' + $("[id*=ddlConduct]").val() + '","applicationDate": "' + $("[id*=txtTCAppDate]").val() + '","tcDate": "' + $("[id*=txtTCDate]").val() + '","courseofStudy": "' + $("[id*=txtTCCoures]").val() + '","printtc":"1"}';
                    $.ajax({
                        type: "POST",
                        url: "../Students/TransferCertificate.aspx/SaveTCDetails",
                        data: parameters,
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            if (response.d == 'fail') {
                                AlertMessage('fail', 'TC Generate');
                            }

                            else if (response.d == 'false') {
                                AlertMessage('success', 'TC Generated');
                            }

                            else if (response.d == 'true') {
                                AlertMessage('success', 'TC Generated');
                                print();
                            }

                        },
                        failure: function (response) {
                            AlertMessage('info', response.d);
                        },
                        error: function (response) {
                            AlertMessage('info', response.d);
                        }
                    });
                    SendForApporval($("[id*=hdnRegNo]").val());
                }
            }
        }

    </script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="head2" runat="Server">
    <style type="text/css">
        @media print
        {
            .bord-bott
            {
                border-bottom: 1px solid;
            }
        }
        
        @media screen
        {
            .bord-bott
            {
                border-bottom: 1px solid;
            }
        }
        
        .alignright
        {
            text-align: right;
        }
        .alignleft
        {
            text-align: left;
        }
        .aligncenter
        {
            text-align: center;
        }
        
        .logotxt
        {
            font-family: "Myriad Pro" , "Trebuchet MS" , Arial;
            text-align: left;
            vertical-align: top !important;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            setDatePicker("[id*=txtTCStudLateDate]");
            setDatePicker("[id*=txtTCAppDate]");
            setDatePicker("[id*=txtTCDate]");

        });


    </script>
    <%="<link href='" + ResolveUrl("~/css/tc.css") + "' rel='stylesheet' type='text/css'  media='screen' />"%>
    <%="<link href='" + ResolveUrl("~/css/TCprint.css") + "' rel='stylesheet' type='text/css'  media='print, handheld' />"%>
    <%="<script src='" + ResolveUrl("~/js/jquery.printElement.js") + "' type='text/javascript'></script>"%>
    <script type="text/javascript">
        function print() {
            $(".formtc").printElement(
            {
                leaveOpen: false,
                printBodyOptions:
            {
                styleToAdd: 'padding:5px 20px 0px 20px;margin:5px 25px 0px 20px;color:#000 !important;'
            }
            ,
                overrideElementCSS: [

        '../css/tc.css',

        { href: '../css/TCprint.css', media: 'print'}]

            });

        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:HiddenField ID="hdnRegNo" runat="server" />
    <asp:HiddenField ID="hdnUserId" runat="server" />
    <asp:HiddenField ID="hdnAcademicYearId" runat="server" />
    <div class="grid_10">
        <div class="box round first">
            <h2>
                TRANSFER CERTIFICATE</h2>
            <div align="right">
                <button id="Button2" type="button" class="btn-icon btn-orange btn-saving" onclick="SaveTCDetails('false')">
                    <span></span>Save TC & Send For Approval</button></div>
            <table style="float: right">
                <tr>
                    <td align="center">
                    </td>
                    <td>
                        <button id="Button3" type="button" class="btn-icon btn-orange btn-saving" style="display: none;"
                            onclick="SaveTCDetails('true')">
                            <span></span>Save & PrintTC</button>
                    </td>
                </tr>
            </table>
            <div class="tc-block content-wrapper2">
                <table class="formtc">
                    <tr>
                        <td align="center" class="tctext">
                            <%--<img src="../images/login-school-logo.png" class="schoolLogo" alt="" />--%>
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 50px;">
                        </td>
                    </tr>
                    <tr>
                        <td align="center" valign="bottom" style="padding-top: 0px;">
                            <table width="98%" border="0" cellspacing="0" cellpadding="0" class="tcbg">
                                <tr>
                                    <td width="33%" align="left" valign="middle" class="ser-no">
                                        <br />
                                        Serial No :
                                        <%= _SerialNo%><br />
                                        Admission No :
                                        <%= _AdminNo%><br />
                                        Student UID :
                                        <%= _Studentuid%>
                                    </td>
                                    <td width="33%">
                                    </td>
                                    <%--  <td width="33%" align="center" valign="middle" class="tctext">
                                        TRANSFER CERTIFICATE
                                    </td>--%>
                                    <td width="33%" align="right" valign="middle" class="tc-photo">
                                        <img src="Photos/<%= _Regno%>.jpg" class="studPhoto" alt="" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="">
                            <table width="100%" cellpadding="5" cellspacing="0" class="formtctxt">
                                <tr>
                                    <td width="3%" height="40" valign="top" class="">
                                        1.
                                    </td>
                                    <td width="45%" valign="top" class="">
                                        <span class="alignleft">a). Name of the School
                                            <br />
                                            b). Name of the Educational District / Revenue District </span>
                                    </td>
                                    <td width="3%" valign="top" class="">
                                        :
                                    </td>
                                    <td width="45%" valign="top" class="tc-txt-upper">
                                        <b>
                                            <%= _SchoolName %>
                                            <br />
                                            <span class="aligncenter">
                                                <%= _SchoolDist%>
                                            </span></b>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="40" class="tdHeight35">
                                        2.
                                    </td>
                                    <td>
                                        <span class="alignleft">Name of the pupil (in Block letters) </span>
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td class="tc-txt-upper">
                                        <asp:TextBox ID="txtStudentName" Style="font-weight: bold" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="40" class="tdHeight35">
                                        3.
                                    </td>
                                    <td>
                                        <span class="alignleft">Name of the Father and Mother of the pupil </span>
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td class="tc-txt-upper">
                                        <asp:TextBox ID="txtParentName" Style="font-weight: bold" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="40" class="tdHeight35">
                                        4.
                                    </td>
                                    <td>
                                        <span class="alignleft">Nationality and Religion </span>
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td class="tc-txt-upper">
                                        <asp:TextBox ID="txtNationality" Style="font-weight: bold" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="40" valign="top" class="tdHeight35">
                                        5.
                                    </td>
                                    <td valign="top">
                                        <span class="alignleft">Community Whether he / she belongs to
                                            <br />
                                            SC / ST / BC / MBC / OC/ OBC/ FC </span>
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td class="tc-txt-upper">
                                        <asp:TextBox ID="txtCommunity" Style="font-weight: bold" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="40" class="tdHeight35">
                                        6.
                                    </td>
                                    <td>
                                        <span class="alignleft">Sex</span>
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td class="tc-txt-upper">
                                        <asp:TextBox ID="txtSex" Style="font-weight: bold" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="40" valign="top" class="tdHeight35">
                                        7.
                                    </td>
                                    <td valign="top">
                                        Date of Birth as entered in the Admission
                                        <br />
                                        Register in figures and words
                                    </td>
                                    <td valign="top">
                                        :
                                    </td>
                                    <td valign="top" class="tc-txt-upper">
                                        <asp:TextBox ID="txtDOB" TextMode="MultiLine" Width="400" Height="30" Style="font-weight: bold"
                                            runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="40" class="tdHeight35">
                                        8.
                                    </td>
                                    <td valign="top">
                                        <span class="alignleft">Personal Marks of Identification </span>
                                    </td>
                                    <td valign="top">
                                        :
                                    </td>
                                    <td valign="top" class="tc-txt-upper">
                                        <asp:TextBox ID="txtIdMarks" TextMode="MultiLine" Width="400" Height="30" Style="font-weight: bold"
                                            runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="40" class="tdHeight35">
                                        9
                                    </td>
                                    <td>
                                        <span class="alignleft">Date of Admission and Standard in which admitted </span>
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td class="tc-txt-upper">
                                        <asp:TextBox ID="txtDOA" TextMode="MultiLine" Width="400" Height="30" Style="font-weight: bold"
                                            runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="40" valign="top" class="tdHeight35">
                                        10.
                                    </td>
                                    <td valign="top">
                                        <span class="alignleft">Standard in which the pupil was studying at the time of leaving
                                            <br />
                                            (in words)</span>
                                    </td>
                                    <td valign="top">
                                        :
                                    </td>
                                    <td valign="top" class="tc-txt-upper">
                                        <asp:TextBox ID="txtSTD" Style="font-weight: bold" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="40" class="tdHeight35">
                                        11.
                                    </td>
                                    <td>
                                        <span class="alignleft">Whether qualified for promotion to higher standard </span>
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td class="tc-txt-upper">
                                        <asp:TextBox ID="txtPromotion" Style="font-weight: bold" CssClass="jsrequired" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="40" valign="top" class="tdHeight35">
                                        12.
                                    </td>
                                    <td valign="top">
                                        <span class="alignleft">Whether the pupil was in receipt of any scholarship ?<br />
                                            (Nature of the scholarship to be specified) </span>
                                    </td>
                                    <td valign="top">
                                        :
                                    </td>
                                    <td valign="top" class="tc-txt-upper">
                                        <asp:TextBox ID="txtScholer" CssClass="jsrequired" Style="font-weight: bold" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="40" valign="top" class="tdHeight35">
                                        13.
                                    </td>
                                    <td valign="top">
                                        <span class="alignleft">Whether the pupil has undergone Medical inspection during
                                            <br />
                                            the last academic year </span>
                                    </td>
                                    <td valign="top">
                                        :
                                    </td>
                                    <td valign="top" class="tc-txt-upper">
                                        <select id="sltMedicalInspection" runat="server">
                                            <option value="True">Yes</option>
                                            <option value="False">No</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="40" class="tdHeight35">
                                        14.
                                    </td>
                                    <td>
                                        <span class="alignleft">Date on which the pupil actually left the school </span>
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td class="tc-txt-upper">
                                        <input id="txtTCStudLateDate" runat="server" class="jsrequired" name="txtTCStudLateDate"
                                            type="text" />
                                    </td>
                                </tr>
                                <tr>
                                    <td height="40" class="tdHeight35" style="vertical-align: top; padding-top: 9px;">
                                        15.
                                    </td>
                                    <td style="vertical-align: top; padding-top: 9px;">
                                        <span class="alignleft">The pupil’s conduct and character </span>
                                    </td>
                                    <td style="vertical-align: top; padding-top: 9px;">
                                        :
                                    </td>
                                    <td class="tc-txt-upper">
                                        <asp:DropDownList ID="ddlConduct" runat="server" AppendDataBoundItems="True">
                                            <asp:ListItem Selected="True" Value="">Select</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="40" class="tdHeight35" style="vertical-align: top; padding-top: 9px;">
                                        16.
                                    </td>
                                    <td valign="top" style="vertical-align: top; padding-top: 9px;">
                                        <span class="alignleft">Date on which application for Transfer Certificate was made
                                            on behalf of the pupil by the parent or guardian </span>
                                    </td>
                                    <td valign="top" style="vertical-align: top; padding-top: 9px;">
                                        :
                                    </td>
                                    <td valign="top" class="tc-txt-upper">
                                        <input id="txtTCAppDate" class="jsrequired" runat="server" name="txtTCAppDate" type="text" />
                                    </td>
                                </tr>
                                <tr>
                                    <td height="40" class="tdHeight35" style="vertical-align: top; padding-top: 9px;">
                                        17.
                                    </td>
                                    <td style="vertical-align: top; padding-top: 9px;">
                                        <span class="alignleft">Date of&nbsp; Transfer Certificate </span>
                                    </td>
                                    <td style="vertical-align: top; padding-top: 9px;">
                                        :
                                    </td>
                                    <td class="tc-txt-upper">
                                        <input id="txtTCDate" runat="server" class="jsrequired" name="txtTCDate" type="text" />
                                    </td>
                                </tr>
                                <tr>
                                    <td height="40" class="tdHeight35" style="vertical-align: top; padding-top: 9px;">
                                        18.
                                    </td>
                                    <td style="vertical-align: top; padding-top: 9px;">
                                        <span class="alignleft">Course of Study </span>
                                    </td>
                                    <td style="vertical-align: top; padding-top: 9px;">
                                        :
                                    </td>
                                    <td class="tc-txt-upper">
                                        <input id="txtTCCoures" runat="server" name="txtTCCoures" type="text" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td style="vertical-align: top; padding-top: 9px;">
                            <div id="OldSchool" runat="server">
                                <table border="0" class="bord-bott course" cellspacing="0" cellpadding="5" width="95%"
                                    style="text-align: center;">
                                    <tbody>
                                        <tr>
                                            <td width="20%" valign="middle" class="cours-brd-tl">
                                                <p>
                                                    <strong>Name of the School</strong></p>
                                            </td>
                                            <td width="20%" valign="middle" class="cours-brd-tl">
                                                <p>
                                                    <strong>Academic Year (s)</strong></p>
                                            </td>
                                            <td width="20%" valign="middle" class="cours-brd-tl">
                                                <p>
                                                    <strong>Standard (s) studied</strong></p>
                                            </td>
                                            <td width="20%" valign="middle" class="cours-brd-tl">
                                                <p>
                                                    <strong>First Language</strong></p>
                                            </td>
                                            <td width="20%" valign="middle" class="cours-brd-tlr">
                                                <p>
                                                    <strong>Medium of Instruction</strong></p>
                                            </td>
                                        </tr>
                                        <%= _StudCourceHistory %>
                                    </tbody>
                                    <!--       <tr>
            <td width="20%" class="cours-brd-tl"><p>St. Patrick Mat H Sec School</p></td>
            <td width="20%" class="cours-brd-tl"><p>2005-2006 to 2008-09</p></td>
            <td width="20%" class="cours-brd-tl"><p>10002</p></td>
            <td width="20%" class="cours-brd-tl"><p>Tamil</p></td>
            <td width="20%" class="cours-brd-tlr"><p>English</p></td>
          </tr>
          <tr>
            <td width="20%" class="cours-brd-tlb"><p>St. Johns Mat H Sec     School</p></td>
            <td width="20%" class="cours-brd-tlb"><p>2009-2010 to 2010-11</p></td>
            <td width="20%" class="cours-brd-tlb"><p>10002</p></td>
            <td width="20%" class="cours-brd-tlb"><p>Tamil</p></td>
            <td width="20%" class="cours-brd-tlrb"><p>English</p></td>
          </tr>         -->
                                </table>
                            </div>
                        </td>
                    </tr>
                    <%-- <tr>
                        <td style="vertical-align: top; padding-top: 9px;" class="style1">
                            <strong><span class="alignleft">Signature of the Principle with date and school seal
                            </span></strong>
                        </td>
                    </tr>--%>
                    <tr>
                        <td style="vertical-align: top;" class="signature">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td style="vertical-align: top; padding-top: 9px;">
                            <span class="aligncenter">Note: </span>
                        </td>
                    </tr>
                    <tr>
                        <td style="vertical-align: top; padding-top: 9px;">
                            <span class="alignleft">1. Erasures and unauthenticated or fraudulent alteration will
                                lead to its cancellation</span><br />
                            <span class="alignleft">2. Should be signed in ink by the Head of the Institution, who
                                will be held responsible for the correctness of the entries</span>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" style="padding-top: 20px;">
                            <span class="decleartion"><strong>Declaration by the Parent or Guardian </strong>
                            </span>
                            <br />
                            <span class="aligncenter">I here by declare that the particulars recorded against items
                                2 to 7 are correct and that no change will be demanded by me in future. </span>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="vertical-align: top; padding-top: 9px;">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td class="signparent" align="left">
                            <strong>Signature of the Parent / Guardian </strong>
                        </td>
                    </tr>
                    <tr>
                        <td height="50" style="vertical-align: top; padding-top: 9px;">
                            &nbsp;
                            <asp:HiddenField ID="hfAcdModuleID" runat="server" />
                            <asp:HiddenField ID="hfAcdMenuId" runat="server" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
