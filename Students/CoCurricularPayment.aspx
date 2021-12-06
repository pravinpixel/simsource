<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/AdminMaster.master" AutoEventWireup="true" CodeFile="CoCurricularPayment.aspx.cs" Inherits="Students_CoCurricularPayment" %>

<%@ MasterType VirtualPath="~/MasterPage/AdminMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script type="text/javascript" src="../js/jquery.min.js"></script>

<script type="text/javascript">
    $(function () {
        var StudentID = $("[id*=hfStudentInfoID]").val();
        if (StudentID != "" && StudentID != "0") {
            GetStudentInfo(StudentID);
        }

    });

    //GetStudentInfos Function
    function GetStudentInfo(ID) {
        if ($("[id*=hfViewPrm]").val() == 'true') {
            $.ajax({
                type: "POST",
                url: "../Students/CoCurricularPayment.aspx/GetStudentInfo",
                data: '{studentid: ' + ID + '}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
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


    function OnSuccess(response) {
        var xmlDoc = $.parseXML(response.d);
        var xml = $(xmlDoc);
        var StudentInfos = xml.find("StudentInfo");
        $.each(StudentInfos, function () {
            $("[id*=hfStudentInfoID]").val($(this).find("StudentID").text());
            $("[id*=hfRegNo]").val($(this).find("RegNo").text());
            $("[id*=lblRegNo]").html($(this).find("RegNo").text());
            $("[id*=lblStudentName]").html($(this).find("StudentName").text());
            $("[id*=lblStatus]").html($(this).find("Status").text());

            if ($(this).find("SectionID").text() == "") {
                $("[id*=lblClass]").html($(this).find("Class").text() + " / " + "New")
            }
            else {
                $("[id*=lblClass]").html($(this).find("Class").text() + " / " + $(this).find("Section").text())
            }
        });

        //GetSportsInfo("-1");
        //GetFineArtsInfo("-1");
    }


    function GetSportsInfo(ID) {
        var RegNo = $("[id*=hfRegNo]").val();
        if (ID == "0") {
            ID = "";
            RegNo = "0";
        }
        if (RegNo != "") {
            $.ajax({

                type: "POST",
                url: "../Students/CoCurricularPayment.aspx/GetSportsInfo",
                data: '{regno: ' + RegNo + '}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnGetSportsInfoSuccess,
                failure: function (response) {
                    AlertMessage('info', response.d);
                },
                error: function (response) {
                    AlertMessage('info', response.d);
                }
            });
        }
    }

    var ApporvalStatus;
    function OnGetSportsInfoSuccess(response) {
    }

    function GetFineArtsInfo(ID) {
        var RegNo = $("[id*=hfRegNo]").val();
        if (ID == "0") {
            ID = "";
            RegNo = "0";
        }
        if (RegNo != "") {
            $.ajax({
                type: "POST",
                url: "../Students/CoCurricularPayment.aspx/GetFineArtsInfo",
                data: '{regno: ' + RegNo + '}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnGetFineArtsInfoSuccess,
                failure: function (response) {
                    AlertMessage('info', response.d);
                },
                error: function (response) {
                    AlertMessage('info', response.d);
                }
            });
        }
    }

    var ApporvalStatus = "";
    function OnGetFineArtsInfoSuccess(response) {
        
    }

    function select_month(month_name) {

        if (month_name != '') {
            loadingfun();

            var RegNo = $("[id*=hfRegNo]").val();
            var cocurricular_type = $("[id*=hdnChkcocurricular]").val();

            $.ajax({
                type: "POST",
                url: "../Students/CoCurricularPayment.aspx/get_cocurricular_paymentDetails",
                data: '{"RegNo": "' + RegNo + '","month_name": "' + month_name + '","cocurricular_type": "' + cocurricular_type + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnGetPaymentDetailsSuccess,
                failure: function (response) {
                    alert(response.d);
                },
                error: function (response) {
                    alert(response.d);
                }
            });

        }

    }

    function OnGetPaymentDetailsSuccess(response) {
        $("#result_list_html").html(response.d.toString());

        unloadingfun();
    }

    function payment_status_change(payment_status, month_name, activity_id, payment_id) {

        if (payment_status != '') {
            loadingfun();

            var RegNo = $("[id*=hfRegNo]").val();
            $.ajax({
                type: "POST",
                url: "../Students/CoCurricularPayment.aspx/save_cocurricular_paymentDetails",
                data: '{"payment_id": "' + payment_id + '", "RegNo": "' + RegNo + '", "month_name": "' + month_name + '","activity_id": "' + activity_id + '", "payment_status": "' + payment_status + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    alert("success");
                    unloadingfun();
                },
                failure: function (response) {
                    alert(response.d);
                    unloadingfun();
                },
                error: function (response) {
                    alert(response.d);
                    unloadingfun();
                }
            });


        }        
    }


    function loadingfun() {

        var str = '<div style="background: url(../img/overly.png) repeat; width: 100%;  height: 100%; position: fixed;text-align:center; top: 0; left: 0; z-index: 10000;">';
        str += '<center><img src="../img/loading.gif"/></center>';
        str += '</div>';
        $("#loading").html(str);
    }

    function unloadingfun() {
        $("#loading").html('');
    }


</script>


<style type="text/css">
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

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="head2" runat="Server">
 
 </asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

<asp:HiddenField ID="hfStudentInfoID" runat="server" />
<asp:HiddenField ID="hfAcademicyear" runat="server" />
<asp:HiddenField ID="hfRegNo" runat="server" />
<asp:HiddenField ID="hfModuleID" runat="server" />
<asp:HiddenField ID="hfUserId" runat="server" />
<asp:HiddenField ID="hdnChkcocurricular" runat="server" />

<div id="loading">
</div>

    <div class="grid_10">
        <div class="box round first fullpage">
            <h2>
                Student Information
                <div id="jSuccess-info">
                    Registration No :
                    <asp:Label ID="lblRegNo" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Student
                    Name :
                    <asp:Label ID="lblStudentName" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Class
                    & Section :
                    <asp:Label ID="lblClass" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Present
                    Status :
                    <asp:Label ID="lblStatus" runat="server"></asp:Label></div>
            </h2>
            <div class="clear">
            </div>

             <h2>
                Co-Curricular Information :  <asp:Label ID="lblCocurriculardet" runat="server" Text="Sports / FineArts"></asp:Label>                
            </h2>

            <div class="block john-accord content-wrapper4">
              
              <table class="form" width="100%">
                            <tr>
                                <td>
                                    <div id="dvSalaryEntry">
                                        <table width="100%">
                                            <tr>
                                                <td height="30" width="20%">
                                                   &nbsp;
                                                </td>
                                                <td height="40" width="20%">
                                                     <label>
                                                        For Month :</label>
                                                    <asp:DropDownList ID="ddlMonth" runat="server" AutoPostBack="False" CssClass="jsrequired" onchange="select_month(this.value)">
                                                        <asp:ListItem Value="">-----Select-----</asp:ListItem>
                                                    </asp:DropDownList>
                                                    &nbsp;


                                                   <!-- <button id="btnSearch" class="btn-icon btn-navy btn-search" onclick="GetList();" type="button">
                                                        Search
                                                    </button>-->

                                                </td>
                                                <td height="40" width="25%">
                                                  &nbsp;
                                                </td>
                                            </tr>
                                           
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </table>
            
            <div style="clear:both;">&nbsp;</div>
                <div class="block1">
                     <table id="tbl_results" class="display" style="width:100%; border-collapse:collapse;" cellspacing="1" cellpadding="1" border="1" >
                            <thead>
                                <tr>
                                    <th class="sorting_mod" width="20%">Activity</th>
                                    <th class="sorting_mod" width="10%">Payment Status</th>
                                    <!--<th class="sorting_mod" width="80%">Remarks</th>-->
                                </tr>
                            </thead>
                            <tbody id="result_list_html">                                          
                                <tr class="even">
                                    <td colspan="2">No-Data</td>                                
                                </tr>          
                            </tbody>
                     </table>
                </div>
            </div>


           
        </div>
    </div>
</asp:Content>


