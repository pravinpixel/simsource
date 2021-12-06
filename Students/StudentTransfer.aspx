<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/AdminMaster.master"
    AutoEventWireup="true" CodeFile="StudentTransfer.aspx.cs" Inherits="StudentTransfer" %>

<%@ MasterType VirtualPath="~/MasterPage/AdminMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="../js/jquery.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head2" runat="Server">
    <%="<script src='" + ResolveUrl("~/js/jquery.printElement.js") + "' type='text/javascript'></script>"%>
    <%="<link href='" + ResolveUrl("~/css/performance-print.css") + "' rel='stylesheet' type='text/css'  media='print' />"%>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function ApplyPromotion() {
            if (jConfirm('Are you confirm to trasnfer these students to the selected class & section?', 'Confirm', function (r) {
                if (r) {
                    var ClassID = $("[id*=ddlClass]").val();
                    var SectionID = $("[id*=ddlSection]").val();
                    var NxtClassID = $("[id*=ddlNxtClass]").val();
                    var NxtSectionID = $("[id*=ddlNxtSection]").val();
                    if (ClassID != "" && SectionID != "") {

                        $(".even").each(function () {
                            var regno = $(this).find('td.regno').html();
                            var status = $(this).find("option:selected").text();

                            var parameters = '{"NxtClassID": "' + NxtClassID + '","NxtSectionID": "' + NxtSectionID + '","ClassID": "' + ClassID + '","SectionID": "' + SectionID + '","RegNo": "' + regno + '","Status": "' + status + '"}';
                            $.ajax({
                                type: "POST",
                                url: "../Students/StudentTransfer.aspx/UpdatePromotion",
                                data: parameters,
                                contentType: "application/json; charset=utf-8",
                                beforeSend: loadingfun,
                                dataType: "json",
                                failure: function (response) {
                                    AlertMessage('info', response.d);
                                },
                                error: function (response) {
                                    AlertMessage('info', response.d);
                                }
                            });
                        });
                    }
                    alertwindow();
                }

            })) {
            }

        }



        function alertwindow() {
            AlertMessage('success', 'Updated');
            $("#loading").html('');
            $(".IDprint").html('');
        }
        function loadingfun() {

            var str = '<div style="background: url(../img/overly.png) repeat; width: 100%;  height: 100%; position: fixed;text-align:center; top: 0; left: 0; z-index: 10000;">';
            str += '<center><img src="../img/loading.gif"/></center>';
            str += '</div>';
            $("#loading").html(str);

        }
        function GetSectionByClass(ID) {
            $.ajax({
                type: "POST",
                url: "../Students/StudentTransfer.aspx/GetSectionByClassID",
                data: '{ClassID: ' + ID + '}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnGetSectionByClassSuccess,
                failure: function (response) {
                    AlertMessage('info', response.d);
                },
                error: function (response) {
                    AlertMessage('info', response.d);
                }
            });
        }
        function OnGetSectionByClassSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var cls = xml.find("SectionByClass");
            var select = $("[id*=ddlSection]");
            select.children().remove();
            select.append($("<option>").val('').text('---Select---'));
            $.each(cls, function () {
                var icls = $(this);
                var SectionID = $(this).find("SectionID").text();
                var SectionName = $(this).find("SectionName").text();
                select.append($("<option>").val(SectionID).text(SectionName));


            });
        };



        function print() {

            $(".IDprint").printElement(
            {
                leaveOpen: false,
                printBodyOptions:
            {
                styleToAdd: 'padding:5px 20px 0px 20px;margin:5px 15px 0px 20px;color:#000;font-family:Arial, Helvetica, sans-serif; font-size:5px; text-align: left; !important;'

            }
            , overrideElementCSS: [
                    '../css/layout.css',
                    { href: '../css/performance-print.css', media: 'print'}]
            });
        }



        function GetList(pageIndex) {
            var classid = $("[id*=ddlClass]").val();
            var sectionid = $("[id*=ddlSection]").val();
            if (sectionid == 'null') {
                sectionid = "";
            }
            $.ajax({
                type: "POST",
                url: "../Students/StudentTransfer.aspx/GetStudentList",
                data: '{"classId":"' + classid + '","sectionId":"' + sectionid + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnGetStudentListSuccess,
                failure: function (response) {
                    AlertMessage('info', response.d);
                },
                error: function (response) {
                    AlertMessage('info', response.d);
                }
            });

        }
        function OnGetStudentListSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var sList = xml.find("StudentList");
            var row = $("[id*=dgStudentList] tr:last-child").clone(true);
            $("[id*=dgStudentList] tr").not($("[id*=dgStudentList] tr:first-child")).remove();
            if (sList.length > 0) {

                $.each(sList, function () {
                    row.addClass("even");
                    var chkAdd = null;
                    chkAdd = "<input name=\"chkAdd\" value=\"" + $(this).find("RegNo").text() + "\" id=\"" + $(this).find("RegNo").text() + "\" type=\"checkbox\">";
                    $("td", row).eq(0).html(chkAdd).css("width", "60px");
                    $("td", row).eq(1).html($(this).find("RegNo").text()).addClass("RegNo");
                    $("td", row).eq(2).html($(this).find("StudentName").text()).addClass("StudentName");
                    $("[id*=dgStudentList]").append(row);
                    row = $("[id*=dgStudentList] tr:last-child").clone(true);
                });
            }
            else {
                row.addClass("even");
                $("td", row).eq(0).html("").css("width", "60px");
                $("td", row).eq(1).html("No Records Found").removeClass("RegNo");
                $("td", row).eq(2).html("").removeClass("StudentName");
                $("[id*=dgStudentList]").append(row);
                row = $("[id*=dgStudentList] tr:last-child").clone(true);
            }
        };


        function CheckAll(id) {
            $("[id*=dgStudentList]").find("input[name*='" + id + "']:checkbox").each(function () {
                if ($("[id*=" + id + "]").is(':checked')) {
                    $(this).attr('checked', true);
                }
                else {
                    $(this).attr('checked', false);
                }
            });
        }

    </script>
    <style type="text/css">
        .modal
        {
            position: fixed;
            top: 0;
            left: 0;
            background-color: black;
            z-index: 99;
            opacity: 0.8;
            filter: alpha(opacity=80);
            -moz-opacity: 0.8;
            min-height: 100%;
            width: 100%;
        }
        .loading
        {
            font-family: Arial;
            font-size: 10pt;
            border: 5px solid #67CFF5;
            width: 200px;
            height: 100px;
            display: none;
            position: fixed;
            background-color: White;
            z-index: 999;
        }
    </style>
    <asp:HiddenField ID="hdnUserName" runat="server" />
    <asp:HiddenField ID="hfUserId" runat="server" />
    <div id="loading">
    </div>
    <div class="grid_10">
        <div class="box round first fullpage">
            <h2>
                Student Transfer</h2>
            <div class="clear">
            </div>
            <div align="center" class="block john-accord content-wrapper2">
                <table class="form" width="100%">
                    <tr valign="top">
                        <td valign="top">
                            <div id="dvExamNoAssigner" style="float: left; margin: 0 auto; width: 780px;" runat="server">
                                <asp:UpdatePanel ID="ups" runat="server">
                                    <ContentTemplate>
                                        <table class="form" cellpadding="0" cellspacing="0">
                                            <tr align="left">
                                                <td>
                                                    <label>
                                                        Class :</label>&nbsp;
                                                    <asp:DropDownList ID="ddlClass" CssClass="jsrequired" runat="server" AppendDataBoundItems="True"
                                                        AutoPostBack="true" OnSelectedIndexChanged="ddlClass_SelectedIndexChanged">
                                                        <asp:ListItem Selected="True" Value="">-----Select-----</asp:ListItem>
                                                    </asp:DropDownList>
                                                    &nbsp;
                                                    <label>
                                                        Section :</label>&nbsp;
                                                    <asp:DropDownList ID="ddlSection" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlSection_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                    &nbsp;
                                                    <button id="btnSearch" type="button" class="btn-icon btn-navy btn-search" onclick="GetList(1);">
                                                        <span></span>
                                                        <div id="spFeesSubmit">
                                                            Search</div>
                                                    </button>
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="ddlClass" EventName="SelectedIndexChanged" />
                                        <asp:AsyncPostBackTrigger ControlID="ddlSection" EventName="SelectedIndexChanged" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:GridView ID="dgStudentList" runat="server" Width="100%" AutoGenerateColumns="False"
                                ShowFooter="True" HorizontalAlign="Center" RowStyle-CssClass="even" AlternatingRowStyle-CssClass="odd"
                                EnableModelValidation="True" CssClass="display">
                                <Columns>
                                    <asp:TemplateField HeaderText="CheckAll" HeaderStyle-CssClass="sorting_mod">
                                        <HeaderTemplate>
                                            <input id="chkAdd" type="checkbox" onchange="CheckAll(this.id);" />Select
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox Width="50" ID="chkAddSelect" runat="server" AutoPostBack="false" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="RegNo" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                        HeaderText="RegNo" SortExpression="RegNo">
                                        <ItemStyle HorizontalAlign="Center" CssClass="RegNo"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="StudentName" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                        HeaderText="StudentName" SortExpression="StudentName">
                                        <ItemStyle HorizontalAlign="Center" CssClass="StudentName"></ItemStyle>
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="Pager" id="GetListPager">
                            </div>
                        </td>
                    </tr>
                </table>
                 <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                <table width="100%" class="form">
                    <asp:HiddenField ID="hfModuleID" runat="server" />
                    <tr>
                        <td>
                            <div class="IDprint">
                                <div id="dvCard" style="overflow: auto; width: 100%" runat="server">
                                </div>
                                <asp:PlaceHolder ID="promocontent" runat="server"></asp:PlaceHolder>
                                <asp:HiddenField ID="hfClassID" runat="server" />
                                <asp:HiddenField ID="hfAcademicID" runat="server" />
                                <asp:HiddenField ID="hfSectionID" runat="server" />
                            </div>
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <pre style="border: thin solid #FF0000; background-color: #FFFFCC; font-family: Verdana;
                                font-weight: bold; font-size: 12px;"> For your Verification &amp; Confirmation before proceeding Transfer...
 1. Please check the list once again before proceeding to Transfer.
 2. Once the applied for the students in the selected class and section, can&#39;t be roll back.
 3. Once the applied for the students in the selected class and section, can&#39;t be viewed in any other reports until the change of academic year.</pre>
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <label>
                                Select the class to Transfer</label>&nbsp;
                            <asp:DropDownList ID="ddlNxtClass" CssClass="jsrequired" AppendDataBoundItems="True"
                                onchange="GetSectionByClass(this.value);" runat="server" AutoPostBack="True"
                                OnSelectedIndexChanged="ddlNxtClass_SelectedIndexChanged">
                            </asp:DropDownList>
                            &nbsp; &nbsp;
                            <label>
                                Select the section to Transfer</label>&nbsp;
                            <asp:DropDownList ID="ddlNxtSection" CssClass="jsrequired" runat="server" OnSelectedIndexChanged="ddlNxtSection_SelectedIndexChanged">
                                <asp:ListItem Selected="True" Value="">Select</asp:ListItem>
                            </asp:DropDownList>
                            &nbsp;
                            <button id="btnSubmit" type="button" runat="server" class="btn-generate-list button-generatelist"
                                onclick="ApplyPromotion();">
                                <span></span>
                                <div id="spSubmit">
                                    Transfer Students</div>
                            </button>
                        </td>
                    </tr>
                </table>
                 </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="ddlNxtClass" EventName="SelectedIndexChanged" />
                                        <asp:AsyncPostBackTrigger ControlID="ddlNxtSection" EventName="SelectedIndexChanged" />
                                    </Triggers>
                                </asp:UpdatePanel>
            </div>
        </div>
    </div>
</asp:Content>
