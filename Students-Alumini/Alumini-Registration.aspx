<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/AdminMaster.master"
    AutoEventWireup="true" CodeFile="Alumini-Registration.aspx.cs" Inherits="Students_Alumini_Alumini_Registration" %>

<%@ MasterType VirtualPath="~/MasterPage/AdminMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="../js/jquery.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            setDatePicker("[id*=txtDOB]");
        });
        $(function () {
            if (window.FormData) {
                formdata = new FormData();
            }

            if ($("[id*=hfAlumniID]").val() != '') {
                  var AlumniID = $("[id*=hfAlumniID]").val();
                  GetAluminiInfo(AlumniID);
            };
            });

         function GetAluminiInfo(ID) {
            if ($("[id*=hfViewPrm]").val() == 'true') {
                $.ajax({
                    type: "POST",
                 url: "../Students-Alumini/Alumini-Registration.aspx/GetAluminiInfo",
                 data: '{alumniID: ' + ID + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnAlumniSuccess,
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

        function OnAlumniSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var rel = xml.find("AluminiInfo");
            $.each(rel, function () {
                var status;
                status = $(this).find("status").text();
                if (status == "1") {
                    $("[id*=rbtnActive]").attr("checked", true);
                }
                else {
                    $("[id*=rbtnInActive]").attr("checked", true);
                }
                $("[id*=hfAlumniID]").val($(this).find("alumniID").text());
                $("[id*=txtName]").val($(this).find("StudentName").text());
                $("[id*=ddlClassfrom]").val($(this).find("class_from").text());
                $("[id*=ddlClassTo]").val($(this).find("class_to").text());
                $("[id*=ddlBatch]").val($(this).find("batch").text());
                $("[id*=txtDOB]").val($(this).find("dob").text());
                $("[id*=txtFather]").val($(this).find("fothrname").text());
                $("[id*=txtMother]").val($(this).find("mothrname").text());
                $("[id*=ddlStatus]").val($(this).find("m_status").text());
                $("[id*=txtReligion]").val($(this).find("religion").text());
                $("[id*=txtAddress]").val($(this).find("address").text());
                $("[id*=txtLandline]").val($(this).find("contactno").text());
                $("[id*=txtMobile]").val($(this).find("mobile").text());
                $("[id*=txtEMail]").val($(this).find("emailid").text());
                $("[id*=txtEName]").val($(this).find("ename").text());
                $("[id*=txtEAddress]").val($(this).find("eaddress").text());
                $("[id*=txtEDesignation]").val($(this).find("designation").text());
                var PhotoFile = $(this).find("photoupload").text();
                if (PhotoFile) {
                    $("[id*=img_prev]").attr('src', "../Students-Alumini/Uploads/ProfilePhotos/" + PhotoFile.toString() + "?rand=" + Math.random()).width(114).height(114)
                }
                else {
                    $("[id*=img_prev]").attr('src', "../img/Photo.jpg").width(114).height(114);
                }
                var aluminiID = $("[id*=hfAlumniID]").val();
                if (aluminiID != "") {
                    GetGraduationInfo(aluminiID);
                }
            });
        };

       


        var formdata;
        function readURL(input) {
            if (window.FormData) {
                formdata = new FormData();
            }

            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    $('#img_prev').attr('src', e.target.result).width(114).height(114);

                };
                reader.readAsDataURL(input.files[0]);
                if (formdata) {
                    formdata.append("AluminiImage", input.files[0]);
                }
            }
        }


        function SaveAlumini() {
            if ($('#aspnetForm').valid()) {
             var Stat;
                    if ($("[id*=rbtnActive]").is(':checked')) {
                        Stat = "1";
                    }

                    else if ($("[id*=rbtnInActive]").is(':checked')) {
                        Stat = "0";
                    }

                    var tempfile = $('#FuPhoto').val().replace(/C:\\fakepath\\/i, ''); ;
                    var PhotoFile = tempfile.substring(tempfile.lastIndexOf('\\') + 1);
                    var PhotoPath = $('#FuPhoto').val().replace(/C:\\fakepath\\/i, ''); ;

                    var parameters = '{"aluminiid": "' + $("[id*=hfAlumniID]").val() + '","name": "' + $("[id*=txtName]").val() + '","classfrom": "' + $("[id*=ddlClassfrom]").val() + '","classto": "' + $("[id*=ddlClassTo]").val() + '","batch": "' + $("[id*=ddlBatch]").val() + '","dob": "' + $("[id*=txtDOB]").val() + '","father": "' + $("[id*=txtFather]").val() + '","mother": "' + $("[id*=txtMother]").val() + '","maritalstatus": "' + $("[id*=ddlStatus]").val() + '","religion": "' + $("[id*=txtReligion]").val() + '","address": "' + $("[id*=txtAddress]").val() + '","landline": "' + $("[id*=txtLandline]").val() + '","mobile": "' + $("[id*=txtMobile]").val() + '","email": "' + $("[id*=txtEMail]").val() + '","ename": "' + $("[id*=txtEName]").val() + '","eaddress": "' + $("[id*=txtEAddress]").val() + '","edesignation": "' + $("[id*=txtEDesignation]").val() + '","photopath": "' + PhotoPath + '","photofile": "' + PhotoFile + '","Status": "' + Stat + '"}';
                $.ajax({
                    type: "POST",
                    url: "../Students-Alumini/Alumini-Registration.aspx/SaveAlumini",
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
            
            if (response.d == "Update Failed") {
                AlertMessage('fail', 'Update');
            }
            else if (response.d) {
                var aluminiID = response.d.toString();
                AlertMessage('success', 'Inserted');
                $("[id*=hfAlumniID]").val(aluminiID);
                if (formdata) {
                    formdata.append("aluminiID", aluminiID);
                    if (formdata) {
                        $.ajax({
                            url: "../Students-Alumini/Alumini-Registration.aspx",
                            type: "POST",
                            data: formdata,
                            processData: false,
                            contentType: false,
                            success: function (res) {
                            }
                        });
                    }
                }
                Cancel();
                GetAluminiInfo(aluminiID);
            }
            else if (response.d == "Insert Failed") {
                AlertMessage('fail', 'Insert');
            }


        };

        function SaveGraduationDetails() {
            if ($("[id*=hfAlumniID]").val() != '') {
                if ($('#aspnetForm').valid()) {
                  
                    var parameters = '{"AluminiID": "' + $("[id*=hfAlumniID]").val() + '","Course": "' + $("[id*=txtCourse]").val() + '","Board": "' + $("[id*=txtBoard]").val() + '","YOC": "' + $("[id*=ddlYOC]").val() + '"}';
                    $.ajax({
                        type: "POST",
                        url: "../Students-Alumini/Alumini-Registration.aspx/SaveGraduationdetails",
                        data: parameters,
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: OnSaveGraduationdetailSuccess,
                        failure: function (response) {
                            AlertMessage('info', response.d);
                        },
                        error: function (response) {
                            AlertMessage('info', response.d);
                        }
                    });
                }
            }
            else {
                AlertMessage('info', "Please enter Alumini details first");
            }
        }
        function OnSaveGraduationdetailSuccess(response) {
            if (response.d != '') {
                AlertMessage('success', "Updated");
                GraduationInfoClear();
                GetGraduationInfo( $("[id*=hfAlumniID]").val());
            }
            else {
                AlertMessage('fail', "Update");
            }
        }

        function GetGraduationInfo(ID) {
            if ($("[id*=hfViewPrm]").val() == 'true') {
                $.ajax({
                    type: "POST",
                    url: "../Students-Alumini/Alumini-Registration.aspx/GetGraduationInfo",
                    data: '{alumniID: ' + ID + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnGraduationSuccess,
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

        function OnGraduationSuccess(response) {

            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var MedRem = xml.find("GraduationInfo");
            var row = $("[id*=dgGraduation] tr:last-child").clone(true);
            $("[id*=dgGraduation] tr").not($("[id*=dgGraduation] tr:first-child")).remove();
            var eanchor = ''
            var eanchorEnd = '';
            var danchor = ''
            var danchorEnd = '';
           
            if ($("[id*=hfDeletePrm]").val() == 'false') {
                danchor = "<a>";
                danchorEnd = "</a>";
            }
            else {
                danchor = "<a  href=\"javascript:DeleteGraduationInfo('";
                danchorEnd = "');\">Delete</a>";
            }


            if (MedRem.length == 0) {
                $("td", row).eq(0).html("");
                $("td", row).eq(1).html("");
                $("td", row).eq(2).html("No Records Found").attr("align", "center");
                $("td", row).eq(3).html("").removeClass("deleteacc delete-links"); ;
                $("[id*=dgGraduation]").append(row);
                row = $("[id*=dgGraduation] tr:last-child").clone(true);

            }
            else {
                $.each(MedRem, function () {
                    row.addClass("even");
                    var ehref = eanchor + $(this).find("id").text() + eanchorEnd;
                    var dhref = danchor + $(this).find("id").text() + danchorEnd;
                    $("td", row).eq(0).html($(this).find("course").text());
                    $("td", row).eq(1).html($(this).find("board").text());
                    $("td", row).eq(2).html($(this).find("yoc").text());
                    $("td", row).eq(3).html(dhref).addClass("deleteacc delete-links");
                    $("[id*=dgGraduation]").append(row);
                    row = $("[id*=dgGraduation] tr:last-child").clone(true);


                });

                if ($("[id*=hfEditPrm]").val() == 'false') {
                    $('.editacc').hide();
                }
                else {
                    $('.editacc').show();
                }
                if ($("[id*=hfDeletePrm]").val() == 'false') {
                    $('.deleteacc').hide();
                }
                else {
                    $('.deleteacc').show();
                }
                var pager = xml.find("Pager");

                $(".Pager").ASPSnippets_Pager({
                    ActiveCssClass: "current",
                    PagerCssClass: "pager",
                    PageIndex: parseInt(pager.find("PageIndex").text()),
                    PageSize: parseInt(pager.find("PageSize").text()),
                    RecordCount: parseInt(pager.find("RecordCount").text())

                });

            }

        }

        function DeleteGraduationInfo(ID) {
            $("[id*=hfGradID]").val(ID);
            if ($("[id*=hfGradID]").val() != '') {
                if (jConfirm('Are you sure to delete this?', 'Confirm', function (r) {
                    if (r) {
                        $.ajax({
                            type: "POST",
                            url: "../Students-Alumini/Alumini-Registration.aspx/DeleteGraduationdetails",
                            data: '{"id": "' + $("[id*=hfGradID]").val() + '"}',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: OnDelGraduationSuccess,
                            failure: function (response) {
                                AlertMessage('info', response.d);
                            },
                            error: function (response) {
                                AlertMessage('info', response.d);
                            }

                        });
                    }

                })) {
                }

            }
        }

         
        function OnDelGraduationSuccess(response) {
            if (response.d == 'Delete Fail') {
                AlertMessage('fail', "Delete");
                GraduationInfoClear();
            }
            else {
                AlertMessage('success', 'Deleted');
                GetAluminiInfo($("[id*=hfAlumniID]").val());
            }
        }

        function GraduationInfoClear() {
            $("[id*=txtCourse]").val('');
            $("[id*=txtBoard]").val('');
            $("[id*=ddlYOC]").val('');
            $("[id*=hfGradID]").val('');
            $('#aspnetForm').validate().resetForm();
        }

        function Cancel() {
            $("[id*=txtName]").val('');
            $("[id*=ddlClassfrom]").val('');
            $("[id*=ddlClassTo]").val('');
            $("[id*=ddlBatch]").val('');
            $("[id*=txtDOB]").val('');
            $("[id*=txtFather]").val('');
            $("[id*=txtMother]").val('');
            $("[id*=ddlStatus]").val('');
            $("[id*=txtReligion]").val('');
            $("[id*=txtAddress]").val('');
            $("[id*=txtLandline]").val('');
            $("[id*=txtMobile]").val('');
            $("[id*=txtEMail]").val('');
            $("[id*=txtEName]").val('');
            $("[id*=txtEaddress]").val('');
            $("[id*=txtEDesignation]").val('');
            $("[id*=hfAlumniID]").val('');
            $('#aspnetForm').validate().resetForm();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head2" runat="Server">
    <style type="text/css">
        .jsrequired
        {
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="grid_10">
        <div class="box round first">
            <h2>
                Manage Alumini Registration
            </h2>
            <div class="clear">
            </div>
            <div class="block content-wrapper2">
                <table width="100%">
                    <tr valign="top">
                        <td valign="top">
                            <table class="form">
                                <tr>
                                    <td class="col1" colspan="4">
                                        &nbsp;
                                        <img id="img_prev" src="../img/photo.jpg" class='zoom' alt="Profile Photo" width="114"
                                            height="114" />
                                    </td>
                                    <td rowspan="4">
                                        <div class="block">
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="col1">
                                        <span class="col1"><span style="color: Red">*</span>
                                            <label>
                                                Name</label>
                                    </td>
                                    <td class="col2">
                                        <asp:TextBox ID="txtName" CssClass="jsrequired" runat="server"></asp:TextBox>
                                    </td>
                                    <td class="col2">
                                        <span class="col1"><span style="color: Red">*</span>
                                            <label>
                                                Class & Section</label>
                                    </td>
                                    <td class="col2">
                                        <asp:DropDownList ID="ddlClassfrom" runat="server">
                                            <asp:ListItem Value="L.K.G">L.K.G </asp:ListItem>
                                            <asp:ListItem Value="U.K.G">U.K.G </asp:ListItem>
                                            <asp:ListItem Value="I Std">I Std </asp:ListItem>
                                            <asp:ListItem Value="II Std">II Std </asp:ListItem>
                                            <asp:ListItem Value="III Std">III Std </asp:ListItem>
                                            <asp:ListItem Value="IV Std">IV Std </asp:ListItem>
                                            <asp:ListItem Value="V Std">V Std </asp:ListItem>
                                            <asp:ListItem Value="VI Std">VI Std </asp:ListItem>
                                            <asp:ListItem Value="VII Std">VII Std </asp:ListItem>
                                            <asp:ListItem Value="VIII Std">VIII Std </asp:ListItem>
                                            <asp:ListItem Value="IX Std">IX Std </asp:ListItem>
                                            <asp:ListItem Value="X Std">X Std </asp:ListItem>
                                            <asp:ListItem Value="XI Std">XI Std </asp:ListItem>
                                            <asp:ListItem Value="XII Std">XII Std </asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:DropDownList ID="ddlClassTo" runat="server">
                                            <asp:ListItem Value="L.K.G">L.K.G </asp:ListItem>
                                            <asp:ListItem Value="U.K.G">U.K.G </asp:ListItem>
                                            <asp:ListItem Value="I Std">I Std </asp:ListItem>
                                            <asp:ListItem Value="II Std">II Std </asp:ListItem>
                                            <asp:ListItem Value="III Std">III Std </asp:ListItem>
                                            <asp:ListItem Value="IV Std">IV Std </asp:ListItem>
                                            <asp:ListItem Value="V Std">V Std </asp:ListItem>
                                            <asp:ListItem Value="VI Std">VI Std </asp:ListItem>
                                            <asp:ListItem Value="VII Std">VII Std </asp:ListItem>
                                            <asp:ListItem Value="VIII Std">VIII Std </asp:ListItem>
                                            <asp:ListItem Value="IX Std">IX Std </asp:ListItem>
                                            <asp:ListItem Value="X Std">X Std </asp:ListItem>
                                            <asp:ListItem Value="XI Std">XI Std </asp:ListItem>
                                            <asp:ListItem Value="XII Std">XII Std </asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="col1">
                                        <span class="col1"><span style="color: Red">*</span>
                                            <label>
                                                Batch</label>
                                    </td>
                                    <td class="col2">
                                        <asp:DropDownList ID="ddlBatch" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td class="col2">
                                        <span class="col1"><span style="color: Red">*</span>
                                            <label>
                                                DOB</label> &nbsp;
                                    </td>
                                    <td class="col2">
                                        <asp:TextBox ID="txtDOB" CssClass="jsrequired dateNL date-picker" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="col1">
                                        <span class="col1"><span style="color: Red">*</span>
                                            <label>
                                                Father Name</label>
                                    </td>
                                    <td class="col2">
                                        <asp:TextBox ID="txtFather" CssClass="jsrequired" runat="server"></asp:TextBox>
                                    </td>
                                    <td class="col2">
                                        <span class="col1"><span style="color: Red">*</span>
                                            <label>
                                                Mother Name</label>
                                    </td>
                                    <td class="col2">
                                        <asp:TextBox ID="txtMother" CssClass="jsrequired" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="col1">
                                        <span class="col1"><span style="color: Red">*</span>
                                            <label>
                                                Marital Status</label>
                                    </td>
                                    <td class="col2">
                                            <asp:DropDownList ID="ddlStatus" runat="server">
                                                <asp:ListItem Value="Single">Single</asp:ListItem>
                                                <asp:ListItem Value="Married">Married</asp:ListItem>
                                            </asp:DropDownList>
                                    </td>
                                    <td class="col2">
                                        <span class="col1"><span style="color: Red">*</span>
                                            <label>
                                                Religion</label>
                                    </td>
                                    <td class="col2">
                                        <asp:TextBox ID="txtReligion" CssClass="jsrequired" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="col1">
                                        <span class="col1"><span style="color: Red">*</span>
                                            <label>
                                                Residential address with Pincode</label>
                                    </td>
                                    <td class="col2">
                                        <asp:TextBox ID="txtAddress" CssClass="jsrequired" runat="server" 
                                            TextMode="MultiLine"></asp:TextBox>
                                    </td>
                                    <td class="col2">
                                        <label>
                                            Landline No.</label>
                                    </td>
                                    <td class="col2">
                                        &nbsp;<asp:TextBox ID="txtLandline" CssClass="jsrequired" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="col1">
                                        <span class="col1"><span style="color: Red">*</span>
                                            <label>
                                                E-Mail Id</label>
                                    </td>
                                    <td class="col2">
                                        <asp:TextBox ID="txtEMail" CssClass="jsrequired" runat="server"></asp:TextBox>
                                    </td>
                                    <td class="col2">
                                        <span class="col1"><span style="color: Red">*</span>
                                            <label>
                                                Mobile No.</label>
                                    </td>
                                    <td class="col2">
                                        <asp:TextBox ID="txtMobile" CssClass="jsrequired" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="col1">
                                        <span class="col1"><span style="color: Red">*</span>
                                            <label>
                                                Employer Name</label>
                                    </td>
                                    <td class="col2">
                                        <asp:TextBox ID="txtEName" CssClass="jsrequired" runat="server"></asp:TextBox>
                                    </td>
                                    <td class="col1">
                                        <span class="col1"><span style="color: Red">*</span>
                                            <label>
                                                Employer Address</label>
                                    </td>
                                    <td class="col2">
                                        <asp:TextBox ID="txtEAddress" CssClass="jsrequired" runat="server" 
                                            TextMode="MultiLine"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="col1">
                                        <span class="col1"><span style="color: Red">*</span>
                                            <label>
                                                Designation</label>
                                    </td>
                                    <td class="col2">
                                        <asp:TextBox ID="txtEDesignation" CssClass="jsrequired" runat="server"></asp:TextBox>
                                    </td>
                                    <td class="col1">
                                    </td>
                                    <td class="col2">
                                                <label>
                                                    <input type="radio" name="rb1" id="rbtnActive" value="1" 
                                                    disabled="disabled" />Approve</label>
                                                <label>
                                                    <input type="radio" name="rb1" id="rbtnInActive" value="0" 
                                                    checked="checked" disabled="disabled" />Suspend</label>
                                            </td>
                                </tr>
                                <tr>
                                    <td class="col1">
                                        &nbsp;<label>Upload Image :</label>
                                    </td>
                                    <td class="col2">
                                        <input type='file' id="FuPhoto" onchange="readURL(this);" />
                                    </td>
                                    <td class="col2">
                                        &nbsp;
                                    </td>
                                    <td class="col2">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td class="col1">
                                        &nbsp;
                                        <asp:HiddenField ID="hfAlumniID" runat="server" />
                                        <asp:HiddenField ID="hdnUserId" runat="server" />
                                        <asp:HiddenField ID="hfGradID" runat="server" />
                                    </td>
                                    <td>
                                        <button id="btnSubmit" type="button" class="btn-icon btn-orange btn-saving" onclick="SaveAlumini();">
                                            <span></span>
                                            <div id="spSubmit">
                                                Save</div>
                                        </button>
                                        <button id="btnCancel" type="button" class="btn-icon btn-navy btn-cancel1" runat="server"
                                            onclick="return Cancel();">
                                            <span></span>Cancel</button>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <table class="form">
                    <tr>
                        <td class="col1 formsubheading">
                            <label>
                                Graduation details :</label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div id="Div8" style="position: relative; width: 100%">
                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td width="21%">
                                            <label>
                                                N</label>ame of the course
                                        </td>
                                        <td width="21%">
                                            <label>
                                                Name of the board/ university</label>
                                        </td>
                                        <td width="21%">
                                            <label>
                                                Year of completion</label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <input name="txtCoursename" type="text" id="txtCourse" />
                                        </td>
                                        <td>
                                            <input name="txtBoard" type="text" id="txtBoard" />
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlYOC" runat="server">
                                                <asp:ListItem Selected="True" Value="">----Select---</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <button id="btnGraduationSave" type="button" class="btn-icon btn-navy btn-update"
                                                onclick="SaveGraduationDetails();">
                                                <span></span>Add to List</button>&nbsp;
                                            <button id="btnGraduationCancel" type="button" class="btn-icon btn-navy btn-cancel1"
                                                onclick="return GraduationInfoClear();">
                                                <span></span>Cancel</button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="5">
                                            <div class="block">
                                                <table width="100%">
                                                    <tr valign="top">
                                                        <td valign="top">
                                                            <div>
                                                                <asp:GridView ID="dgGraduation" runat="server" Width="75%" AutoGenerateColumns="False"
                                                                    AllowPaging="True" ShowFooter="True" HorizontalAlign="Center" RowStyle-CssClass="even"
                                                                    AlternatingRowStyle-CssClass="odd" EnableModelValidation="True" CssClass="display"
                                                                    EmptyDataText="No Records Found">
                                                                    <Columns>
                                                                        <asp:BoundField DataField="Course" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                            HeaderText="Course Name" SortExpression="Course Name">
                                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="board_univ" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                            HeaderText="Board / University" SortExpression="board_univ">
                                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="year_of_complete" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                            HeaderText="Year of Completion" SortExpression="year_of_complete">
                                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                                                            HeaderStyle-CssClass="sorting_mod deleteacc">
                                                                            <HeaderTemplate>
                                                                                Delete</HeaderTemplate>
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="lnkDelete" runat="server" Text="Delete" CommandArgument='<%# Eval("id") %>'
                                                                                    CommandName="Delete" CausesValidation="false" CssClass="links"></asp:LinkButton>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                </asp:GridView>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <div class="Pager">
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
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
