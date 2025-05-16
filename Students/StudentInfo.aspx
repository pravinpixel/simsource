<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/AdminMaster.master"
    AutoEventWireup="true" CodeFile="StudentInfo.aspx.cs" Inherits="StudentInfo" %>

<%@ MasterType VirtualPath="~/MasterPage/AdminMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="../js/jquery.min.js"></script>
    <%="<script src='" + ResolveUrl("~/js/ASPSnippets_Pager.min.js") + "' type='text/javascript'></script>"%>
    <%="<script src='" + ResolveUrl("~/js/bsn.AutoSuggest_2.1.3.js") + "' type='text/javascript'></script>"%>
    <%="<link href='" + ResolveUrl("~/css/autosuggest_inquisitor.css") + "' rel='stylesheet' type='text/css'/>"%>
    <script type="text/javascript">

        function GetASSGeneralInfo(val) {
            var RegNo = $("[id*=hfRegNo]").val();
            if (RegNo != '') {
                $.ajax({
                    type: "POST",
                    url: "../Students/StudentInfo.aspx/GetASSGeneralInfo",
                    data: '{RegNo:"' + RegNo + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnGetASSGeneralInfoSuccess,
                    failure: function (response) {
                        AlertMessage('info', response.d);
                    },
                    error: function (response) {
                        AlertMessage('info', response.d);
                    }
                });
            }
        }

        function OnGetASSGeneralInfoSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var rel = xml.find("GeneralInfo");
            $.each(rel, function () {
                var breakfast = $(this).find("HasBreakfast").text();
                if (breakfast == "1") {
                    $("[id*=rtbnBreakYes]").attr("checked", true);
                }
                else if (breakfast == "2") {
                    $("[id*=rtbnBreakNo]").attr("checked", true);
                }

                var lunch = $(this).find("HasLunch").text();
                if (lunch == "1") {
                    $("[id*=rtbnLunchYes]").attr("checked", true);
                }
                else if (lunch == "2") {
                    $("[id*=rtbnLunchNo]").attr("checked", true);
                }

                var trans = $(this).find("HasTransport").text();
                if (trans == "1") {
                    $("[id*=rtbnTransYes]").attr("checked", true);
                }
                else if (trans == "2") {
                    $("[id*=rtbnTransNo]").attr("checked", true);
                }

                var birth = $(this).find("HasBirthCert").text();
                if (birth == "1") {
                    $("[id*=rbtnbcYes]").attr("checked", true);
                }
                else if (trans == "2") {
                    $("[id*=rbtnbcNo]").attr("checked", true);
                }

                var hostel = $(this).find("HasHostel").text();
                if (hostel == "1") {
                    $("[id*=rbtnHotelYes]").attr("checked", true);
                }
                else if (hostel == "2") {
                    $("[id*=rbtnHotelNo]").attr("checked", true);
                }
                $("[id*=txtidentify1]").val($(this).find("Identification1").text());
                $("[id*=txtidentify2]").val($(this).find("Identification2").text());

            });
        };



        function GetASSWellnessInfo(val) {
            var RegNo = $("[id*=hfRegNo]").val();
            if (RegNo != '') {
                $.ajax({
                    type: "POST",
                    url: "../Students/StudentInfo.aspx/GetASSWellnessInfo",
                    data: '{RegNo:"' + RegNo + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnGetASSWellnessInfoSuccess,
                    failure: function (response) {
                        AlertMessage('info', response.d);
                    },
                    error: function (response) {
                        AlertMessage('info', response.d);
                    }
                });
            }
        }

        function OnGetASSWellnessInfoSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var rel = xml.find("WellnessInfo");
            $.each(rel, function () {
                var allergy = $(this).find("HasAllergics").text();
                if (allergy == "1") {
                    $("[id*=rbtnAllergicYes]").attr("checked", true);
                }
                else if (allergy == "2") {
                    $("[id*=rbtnAllergicNo]").attr("checked", true);
                }

                if ($(this).find("Attachment").text() != "") {
                    $("[id*=AllergicAttachment]").css("display", "block");
                    $("[id*=AllergicAttachment]").attr("href", "../Students/AllergicAttachment/" + $(this).find("Attachment").text() + "");
                }

                var skin = $(this).find("HasInfection").text();
                if (skin == "1") {
                    $("[id*=rbtnSkinYes]").attr("checked", true);
                }
                else if (skin == "2") {
                    $("[id*=rbtnSkinNo]").attr("checked", true);
                }

                var tetanus = $(this).find("HasTetanus").text();
                if (tetanus == "1") {
                    $("[id*=rbtnTetanusYes]").attr("checked", true);
                }
                else if (tetanus == "2") {
                    $("[id*=rbtnTetanusNo]").attr("checked", true);
                }

                var polio = $(this).find("HasPolio").text();
                if (polio == "1") {
                    $("[id*=rbtnPolioYes]").attr("checked", true);
                }
                else if (polio == "2") {
                    $("[id*=rbtnPolioNo]").attr("checked", true);
                }

                var tb = $(this).find("HasTB").text();
                if (tb == "1") {
                    $("[id*=rbtnTBYes]").attr("checked", true);
                }
                else if (tb == "2") {
                    $("[id*=rbtnTBNo]").attr("checked", true);
                }

                var hepa = $(this).find("HasHepatitis").text();
                if (hepa == "1") {
                    $("[id*=rbtnHepatitisYes]").attr("checked", true);
                }
                else if (hepa == "2") {
                    $("[id*=rbtnHepatitisNo]").attr("checked", true);
                }

                var covid = $(this).find("HasCovid").text();
                if (covid == "1") {
                    $("[id*=rbtnCovidYes]").attr("checked", true);
                }
                else if (covid == "2") {
                    $("[id*=rbtnCovidNo]").attr("checked", true);
                }

                var hpv = $(this).find("HasHPV").text();
                if (hpv == "1") {
                    $("[id*=rbtnHPVYes]").attr("checked", true);
                }
                else if (hpv == "2") {
                    $("[id*=rbtnHPVNo]").attr("checked", true);
                }

                var glass = $(this).find("HasSpecs").text();
                if (glass == "1") {
                    $("[id*=rbtnGlassYes]").attr("checked", true);
                }
                else if (glass == "2") {
                    $("[id*=rbtnGlassNo]").attr("checked", true);
                }

                var lens = $(this).find("HasLens").text();
                if (lens == "1") {
                    $("[id*=rbtnLensYes]").attr("checked", true);
                }
                else if (lens == "2") {
                    $("[id*=rbtnLensNo]").attr("checked", true);
                }

                var hear = $(this).find("HasHearing").text();
                if (hear == "1") {
                    $("[id*=rbtnhearYes]").attr("checked", true);
                }
                else if (hear == "2") {
                    $("[id*=rbtnhearNo]").attr("checked", true);
                }

                var chicken = $(this).find("HasChickenPox").text();
                if (chicken == "1") {
                    $("[id*=rbtnChickenYes]").attr("checked", true);
                }
                else if (chicken == "2") {
                    $("[id*=rbtnChickenNo]").attr("checked", true);
                }

                var rubella = $(this).find("HasRubella").text();
                if (rubella == "1") {
                    $("[id*=rbtnRubellaYes]").attr("checked", true);
                }
                else if (rubella == "2") {
                    $("[id*=rbtnRubellaNo]").attr("checked", true);
                }

                var jaundice = $(this).find("HasJaundice").text();
                if (jaundice == "1") {
                    $("[id*=rbtnJaundiceYes]").attr("checked", true);
                }
                else if (jaundice == "2") {
                    $("[id*=rbtnJaundiceNo]").attr("checked", true);
                }

                var measles = $(this).find("HasMeasles").text();
                if (measles == "1") {
                    $("[id*=rbtnMeaslesYes]").attr("checked", true);
                }
                else if (measles == "2") {
                    $("[id*=rbtnMeaslesNo]").attr("checked", true);
                }

                var mumps = $(this).find("HasMumps").text();
                if (mumps == "1") {
                    $("[id*=rbtnMumpsYes]").attr("checked", true);
                }
                else if (mumps == "2") {
                    $("[id*=rbtnMumpsNo]").attr("checked", true);
                }

                var scarlet = $(this).find("HasScarlet").text();
                if (scarlet == "1") {
                    $("[id*=rbtnScarletYes]").attr("checked", true);
                }
                else if (scarlet == "2") {
                    $("[id*=rbtnScarletNo]").attr("checked", true);
                }

                var cough = $(this).find("HasCough").text();
                if (cough == "1") {
                    $("[id*=rbtnCoughYes]").attr("checked", true);
                }
                else if (cough == "2") {
                    $("[id*=rbtnCoughNo]").attr("checked", true);
                }
                var anorexia = $(this).find("HasAnorexia").text();
                if (anorexia == "1") {
                    $("[id*=chkAnorexia]").attr("checked", true);
                }
                else if (anorexia == "0") {
                    $("[id*=chkAnorexia]").attr("checked", false);
                }

                var arthrititis = $(this).find("HasArthritis").text();
                if (arthrititis == "1") {
                    $("[id*=chkArthritis]").attr("checked", true);
                }
                else if (arthrititis == "0") {
                    $("[id*=chkArthritis]").attr("checked", false);
                }

                var asthma = $(this).find("HasAsthma").text();
                if (asthma == "1") {
                    $("[id*=chkAsthma]").attr("checked", true);
                }
                else if (asthma == "0") {
                    $("[id*=chkAsthma]").attr("checked", false);
                }

                var bone = $(this).find("HasBone").text();
                if (bone == "1") {
                    $("[id*=chkBone]").attr("checked", true);
                }
                else if (bone == "0") {
                    $("[id*=chkBone]").attr("checked", false);
                }

                var cancer = $(this).find("HasCancer").text();
                if (cancer == "1") {
                    $("[id*=chkCancer]").attr("checked", true);
                }
                else if (cancer == "0") {
                    $("[id*=chkCancer]").attr("checked", false);
                }

                var cardio = $(this).find("HasCardiovascular").text();
                if (cardio == "1") {
                    $("[id*=chkCardiovascular]").attr("checked", true);
                }
                else if (cardio == "0") {
                    $("[id*=chkCardiovascular]").attr("checked", false);
                }

                var dia = $(this).find("HasDiabetes").text();
                if (dia == "1") {
                    $("[id*=chkDiabetes]").attr("checked", true);
                }
                else if (dia == "0") {
                    $("[id*=chkDiabetes]").attr("checked", false);
                }
                var eczema = $(this).find("HasEczema").text();
                if (eczema == "1") {
                    $("[id*=chkEczema]").attr("checked", true);
                }
                else if (eczema == "0") {
                    $("[id*=chkEczema]").attr("checked", false);
                }

                var enuresis = $(this).find("HasEnuresis").text();
                if (enuresis == "1") {
                    $("[id*=chkEnuresis]").attr("checked", true);
                }
                else if (enuresis == "0") {
                    $("[id*=chkEnuresis]").attr("checked", false);
                }


                var epilepsy = $(this).find("HasEpilepsy").text();
                if (epilepsy == "1") {
                    $("[id*=chkEpilepsy]").attr("checked", true);
                }
                else if (epilepsy == "0") {
                    $("[id*=chkEpilepsy]").attr("checked", false);
                }

                var genetic = $(this).find("HasGenetic").text();
                if (genetic == "1") {
                    $("[id*=chkGenetic]").attr("checked", true);
                }
                else if (genetic == "0") {
                    $("[id*=chkGenetic]").attr("checked", false);
                }

                var hay = $(this).find("HasHay").text();
                if (hay == "1") {
                    $("[id*=chkHay]").attr("checked", true);
                }
                else if (hay == "0") {
                    $("[id*=chkHay]").attr("checked", false);
                }

                var head = $(this).find("HasHead").text();
                if (head == "1") {
                    $("[id*=chkHead]").attr("checked", true);
                }
                else if (arthrititis == "0") {
                    $("[id*=chkHead]").attr("checked", false);
                }

                var hearing = $(this).find("HasHearingInjury").text();
                if (hearing == "1") {
                    $("[id*=chkHearing]").attr("checked", true);
                }
                else if (hearing == "0") {
                    $("[id*=chkHearing]").attr("checked", false);
                }

                var heart = $(this).find("HasHeart").text();
                if (heart == "1") {
                    $("[id*=chkHeart]").attr("checked", true);
                }
                else if (heart == "0") {
                    $("[id*=chkHeart]").attr("checked", false);
                }

                var hiv = $(this).find("HasHIV").text();
                if (hiv == "1") {
                    $("[id*=chkHIV]").attr("checked", true);
                }
                else if (hiv == "0") {
                    $("[id*=chkHIV]").attr("checked", false);
                }

                var hepatits = $(this).find("HasHepatits").text();
                if (hepatits == "1") {
                    $("[id*=chkHepatitis]").attr("checked", true);
                }
                else if (hepatits == "0") {
                    $("[id*=chkHepatitis]").attr("checked", false);
                }

                var learn = $(this).find("HasLearning").text();
                if (learn == "1") {
                    $("[id*=chkLearning]").attr("checked", true);
                }
                else if (learn == "0") {
                    $("[id*=chkLearning]").attr("checked", false);
                }

                var mens = $(this).find("HasMenstrual").text();
                if (mens == "1") {
                    $("[id*=chkMenstrual]").attr("checked", true);
                }
                else if (mens == "0") {
                    $("[id*=chkMenstrual]").attr("checked", false);
                }

                var migraine = $(this).find("HasMigraine").text();
                if (migraine == "1") {
                    $("[id*=chkMigraine]").attr("checked", true);
                }
                else if (migraine == "0") {
                    $("[id*=chkMigraine]").attr("checked", false);
                }

                var phobia = $(this).find("HasPhobia").text();
                if (phobia == "1") {
                    $("[id*=chkPhobia]").attr("checked", true);
                }
                else if (phobia == "0") {
                    $("[id*=chkPhobia]").attr("checked", false);
                }

                var deform = $(this).find("HasDeformity").text();
                if (deform == "1") {
                    $("[id*=chkDeformity]").attr("checked", true);
                }
                else if (deform == "0") {
                    $("[id*=chkDeformity]").attr("checked", false);
                }

                var physic = $(this).find("HasDisability").text();
                if (physic == "1") {
                    $("[id*=chkPhysical]").attr("checked", true);
                }
                else if (physic == "0") {
                    $("[id*=chkPhysical]").attr("checked", false);
                }

                var pneumo = $(this).find("HasPneumonia").text();
                if (pneumo == "1") {
                    $("[id*=chkPneumonia]").attr("checked", true);
                }
                else if (pneumo == "0") {
                    $("[id*=chkPneumonia]").attr("checked", false);
                }

                var rheumat = $(this).find("HasRheumatic").text();
                if (rheumat == "1") {
                    $("[id*=chkRheumatic]").attr("checked", true);
                }
                else if (rheumat == "0") {
                    $("[id*=chkRheumatic]").attr("checked", false);
                }

                var skins = $(this).find("HasSkin").text();
                if (skins == "1") {
                    $("[id*=chkSkin]").attr("checked", true);
                }
                else if (skins == "0") {
                    $("[id*=chkSkin]").attr("checked", false);
                }

                var stomach = $(this).find("HasStomach").text();
                if (stomach == "1") {
                    $("[id*=chkStomach]").attr("checked", true);
                }
                else if (stomach == "0") {
                    $("[id*=chkStomach]").attr("checked", false);
                }

                var syndrome = $(this).find("HasSyndromes").text();
                if (syndrome == "1") {
                    $("[id*=chkSyndromes]").attr("checked", true);
                }
                else if (syndrome == "0") {
                    $("[id*=chkSyndromes]").attr("checked", false);
                }

                var urinary = $(this).find("HasUrinary").text();
                if (urinary == "1") {
                    $("[id*=chkUrinary]").attr("checked", true);
                }
                else if (urinary == "0") {
                    $("[id*=chkUrinary]").attr("checked", false);
                }

                var anxiety = $(this).find("HasAnxiety").text();
                if (anxiety == "1") {
                    $("[id*=chkAnxiety]").attr("checked", true);
                }
                else if (anxiety == "0") {
                    $("[id*=chkAnxiety]").attr("checked", false);
                }

                var autism = $(this).find("HasAutism").text();
                if (autism == "1") {
                    $("[id*=chkAutism]").attr("checked", true);
                }
                else if (autism == "0") {
                    $("[id*=chkAutism]").attr("checked", false);
                }

                var mood = $(this).find("HasMood").text();
                if (mood == "1") {
                    $("[id*=chkMood]").attr("checked", true);
                }
                else if (mood == "0") {
                    $("[id*=chkMood]").attr("checked", false);
                }


                var speech = $(this).find("HasSpeech").text();
                if (speech == "1") {
                    $("[id*=chkSpeech]").attr("checked", true);
                }
                else if (speech == "0") {
                    $("[id*=chkSpeech]").attr("checked", false);
                }
                $("[id*=txtPrescribed]").val($(this).find("PrescribedMedication").text());
                $("[id*=txtallergies]").val($(this).find("OtherAllergics").text());
                $("[id*=txtMedication]").val($(this).find("MedicationTaken").text());
                $("[id*=txtMedicationPurpose]").val($(this).find("Purpose").text());
                $("[id*=txtPeriod]").val($(this).find("PeriodOfPerscription").text());
                $("[id*=txtOtherlist]").val($(this).find("OtherList").text());
                $("[id*=txtAnyMedication]").val($(this).find("OthersDesc").text());
                $("[id*=txtOperation]").val($(this).find("OperationDesc").text());

            });
        };


        function GetASSSportsInfo(val) {
            var RegNo = $("[id*=hfRegNo]").val();
            if (RegNo != '') {
                $.ajax({
                    type: "POST",
                    url: "../Students/StudentInfo.aspx/GetASSSportsInfo",
                    data: '{RegNo:"' + RegNo + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnGetASSSportsInfoSuccess,
                    failure: function (response) {
                        AlertMessage('info', response.d);
                    },
                    error: function (response) {
                        AlertMessage('info', response.d);
                    }
                });
            }
        }

        function OnGetASSSportsInfoSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var rel = xml.find("SportsInfo");
            $.each(rel, function () {
                var sporttype = $(this).find("Type").text();
                if (sporttype == "1") {
                    $("[id*=rbbadminton]").attr("checked", true);
                }
                else if (sporttype == "2") {
                    $("[id*=rbchess]").attr("checked", true);
                }
                else if (sporttype == "3") {
                    $("[id*=rbtennis]").attr("checked", true);
                }

                var sporttime = $(this).find("Frequency").text();
                if (sporttime == "1") {
                    $("[id*=rbtnfivehours]").attr("checked", true);
                }
                else if (sporttime == "2") {
                    $("[id*=rbtnforenoon]").attr("checked", true);
                }
                else if (sporttime == "3") {
                    $("[id*=rbtnevening]").attr("checked", true);
                }
                else if (sporttime == "4") {
                    $("[id*=rbtnweekend]").attr("checked", true);
                }

                var abledtype = $(this).find("IsSpecial").text();
                if (abledtype == "1") {
                    $("[id*=brntabledYes]").attr("checked", true);
                }
                else if (abledtype == "2") {
                    $("[id*=brntabledNo]").attr("checked", true);
                }

                if ($(this).find("SplAttachment").text() != "") {
                    $("[id*=AbledAttachment]").css("display", "block");
                    $("[id*=AbledAttachment]").attr("href", "../Students/AbledAttachment/" + $(this).find("SplAttachment").text() + "");
                }
                else {
                    $("[id*=AbledAttachment]").css("display", "none");
                }
                if ($(this).find("AwdAttachment").text() != "") {
                    $("[id*=AwardAttachment]").css("display", "block");
                    $("[id*=AwardAttachment]").attr("href", "../Students/AwardAttachment/" + $(this).find("AwdAttachment").text() + "");
                }
                else {
                    $("[id*=AwardAttachment]").css("display", "none");
                }
                if ($(this).find("Attachment").text() != "") {
                    $("[id*=SportAttachment]").css("display", "block");
                    $("[id*=SportAttachment]").attr("href", "../Students/SportAttachment/" + $(this).find("Attachment").text() + "");
                }
                else {
                    $("[id*=SportAttachment]").css("display", "none");
                }
                $("[id*=txtabled]").val($(this).find("Description").text());
                //                FlagFeesCatHeadID = $(this).find("FeesCatHeadID").text();
                //                GetSportsByClass();
                var RegNo = $("[id*=hfRegNo]").val();
                GetSportsFeesInfo(RegNo);


                //$("[id*=ddlSportFees] option[value='" + FlagFeesCatHeadID + "']").attr("selected", "true");
            });
        };

        function DeleteSportFeesInfo(FeesID) {

            if (jConfirm('Are you sure to delete this?', 'Confirm', function (r) {
                if (r) {
                    $.ajax({

                        type: "POST",
                        url: "../Students/StudentInfo.aspx/DeleteSportFeesInfo",
                        data: '{FeesID: ' + FeesID + '}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: OnDeleteSportFeesInfoSuccess,
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
        function OnDeleteSportFeesInfoSuccess(response) {
            var currentPage = $("[id*=currentPage]").text();
            if (response.d == "Deleted") {
                AlertMessage('success', 'Deleted');
                var RegNo = $("[id*=hfRegNo]").val();
                if (RegNo != "") {
                    GetSportsFeesInfo(RegNo);
                }
            }
            else if (response.d == "Delete Failed") {
                AlertMessage('fail', 'Delete');
            }
        };


        function OnGetSportsFeesInfoSuccess(response) {

            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var SportsFees = xml.find("SportsFees");
            var row = $("[id*=dgsportsfees] tr:last-child").clone(true);
            $("[id*=dgsportsfees] tr").not($("[id*=dgsportsfees] tr:first-child")).remove();
            var danchor = ''
            var danchorEnd = '';
            if ($("[id*=hfDeletePrm]").val() == 'false') {
                danchor = "<a>";
                danchorEnd = "</a>";
            }
            else {
                danchor = "<a  href=\"javascript:DeleteSportFeesInfo('";
                danchorEnd = "');\">Delete</a>";
            }

            if (SportsFees.length == 0) {
                $("td", row).eq(0).html("");
                $("td", row).eq(1).html("");
                $("td", row).eq(2).html("No Records Found").attr("align", "center");
                $("td", row).eq(3).html("").removeClass("deleteacc delete-links");
                $("[id*=dgsportsfees]").append(row);
                row = $("[id*=dgsportsfees] tr:last-child").clone(true);

            }
            else {


                $.each(SportsFees, function () {
                    row.addClass("even");
                    var dhref = danchor + $(this).find("FeesID").text() + danchorEnd;
                    $("td", row).eq(0).html($(this).find("ForMonth").text());
                    $("td", row).eq(1).html($(this).find("FeesHeadName").text());
                    $("td", row).eq(2).html($(this).find("Amount").text());
                    // $("td", row).eq(4).html(ehref).addClass("editacc edit-links");
                    $("td", row).eq(3).html(dhref).addClass("deleteacc delete-links");
                    $("[id*=dgsportsfees]").append(row);
                    row = $("[id*=dgsportsfees] tr:last-child").clone(true);

                });

                if ($("[id*=hfDeletePrm]").val() == 'false') {
                    $('.deleteacc').hide();
                }
                else {
                    $('.deleteacc').show();
                }
            }
        }


        function GetSportsFeesInfo(RegNo) {
            if ($("[id*=hfViewPrm]").val() == 'true') {
                $.ajax({
                    type: "POST",
                    url: "../Students/StudentInfo.aspx/GetSportsFeesInfo",
                    data: '{regno: ' + RegNo + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnGetSportsFeesInfoSuccess,
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



        function SaveSportFees() {
            if (($("[id*=hfAddPrm]").val() == 'true') ||
            ($("[id*=hfEditPrm]").val() == 'true')
            ) {
                if ($("[id*=hfRegNo]").val() != '') {
                    if ($('#aspnetForm').valid()) {
                        var Regno = $("[id*=hfRegNo]").val();
                        var ForMonth = $("[id*=ddlMonth]").val();
                        var FeesCatHeadID = $("[id*=ddlSportFees]").val();
                        var parameters = '{"ForMonth": "' + ForMonth + '","FeesCatHeadID": "' + FeesCatHeadID + '","Regno": "' + Regno + '"}';
                        var baseurl = "../Students/StudentInfo.aspx/SaveSportFees";

                        $.ajax({
                            type: "POST",
                            url: baseurl,
                            data: parameters,
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: OnSaveSportFeesSuccess,
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
                    AlertMessage('info', "Please Enter Personal Details");
                    changeAccordion(0);
                }
            }
        }

        function OnSaveSportFeesSuccess(response) {
            if (response.d == "Update Failed") {
                AlertMessage('fail', 'Update');
            }
            else if (response.d == "Updated") {
                AlertMessage('success', 'Updated');
                var RegNo = $("[id*=hfRegNo]").val();
                SaveFeesClear();
                GetSportsFeesInfo(RegNo);
            }

        };


        var FlagFeesCatHeadID;
        // Save General
        function SaveASSSportsDetails() {
            if (($("[id*=hfAddPrm]").val() == 'true') || ($("[id*=hfEditPrm]").val() == 'true')
            ) {
                if ($('#aspnetForm').valid()) {
                    var RegNo = $("[id*=hfRegNo]").val();
                    var sporttype = "";
                    if ($("[id*=rbbadminton]").is(':checked')) {
                        sporttype = "1";
                    }
                    else if ($("[id*=rbchess]").is(':checked')) {
                        sporttype = "2";
                    }
                    else if ($("[id*=rbtennis]").is(':checked')) {
                        sporttype = "3";
                    }

                    var sportstempfile = $('#fusports').val().replace(/C:\\fakepath\\/i, ''); ;
                    var sportsFile = sportstempfile.substring(sportstempfile.lastIndexOf('\\') + 1);

                    var sporttime = "";
                    if ($("[id*=rbtnfivehours]").is(':checked')) {
                        sporttime = "1";
                    }
                    else if ($("[id*=rbtnforenoon]").is(':checked')) {
                        sporttime = "2";
                    }
                    else if ($("[id*=rbtnevening]").is(':checked')) {
                        sporttime = "3";
                    }
                    else if ($("[id*=rbtnweekend]").is(':checked')) {
                        sporttime = "4";
                    }

                    var awardstempfile = $('#fuawards').val().replace(/C:\\fakepath\\/i, ''); ;
                    var awardsFile = awardstempfile.substring(awardstempfile.lastIndexOf('\\') + 1);

                    var abledtype = "";
                    if ($("[id*=brntabledYes]").is(':checked')) {
                        abledtype = "1";
                    }
                    else if ($("[id*=brntabledNo]").is(':checked')) {
                        abledtype = "2";
                    }
                    var abled = $("[id*=txtabled]").val();

                    var abledtempfile = $('#fuabled').val().replace(/C:\\fakepath\\/i, ''); ;
                    var abledFile = abledtempfile.substring(abledtempfile.lastIndexOf('\\') + 1);

                    var sportfees = $("[id*=ddlSportFees]").val();

                    var Academicyear = $("[id*=hfAcademicyear]").val();
                    var parameters = '{"regno": "' + RegNo + '","sporttype": "' + sporttype + '","sporttime": "' + sporttime + '","sportsFile": "' + sportsFile + '","awardsFile": "' + awardsFile + '","abledFile": "' + abledFile + '","abled": "' + abled + '","abledtype": "' + abledtype + '","sportfees": "' + sportfees + '"}';
                    $.ajax({
                        type: "POST",
                        url: "../Students/StudentInfo.aspx/SaveASSSports",
                        data: parameters,
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: OnSaveASSSportsSuccess,
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
                return false;
            }
        }
        // Save On Success
        function OnSaveASSSportsSuccess(response) {
            if (response.d == "Updated") {
                AlertMessage('success', 'Updated');
                var RegNo = $("[id*=hfRegNo]").val();
                if (formdata) {
                    formdata.append("StudenInfoId", RegNo);
                    formdata.append("AbledAttachment", $('#fuabled')[0].files[0]);
                    formdata.append("AwardAttachment", $('#fuawards')[0].files[0]);
                    formdata.append("SportAttachment", $('#fusports')[0].files[0]);
                    if (formdata) {
                        $.ajax({
                            url: "../Students/StudentInfo.aspx",
                            type: "POST",
                            data: formdata,
                            processData: false,
                            contentType: false,
                            success: function (res) {
                            }
                        });
                    }
                }
                SportsDetailsClear();
                GetStudentInfo($("[id*=hfStudentInfoID]").val());
                changeAccordion(18);
            }
            else if (response.d == "Update Failed") {
                AlertMessage('fail', 'Update');
            }
            else if (response.d == "Inserted") {
                AlertMessage('success', 'Updated');
                var RegNo = $("[id*=hfRegNo]").val();
                if (formdata) {
                    formdata.append("StudenInfoId", RegNo);
                    formdata.append("AbledAttachment", $('#fuabled')[0].files[0]);
                    formdata.append("AwardAttachment", $('#fuawards')[0].files[0]);
                    formdata.append("SportAttachment", $('#fusports')[0].files[0]);
                    if (formdata) {
                        $.ajax({
                            url: "../Students/StudentInfo.aspx",
                            type: "POST",
                            data: formdata,
                            processData: false,
                            contentType: false,
                            success: function (res) {
                            }
                        });
                    }
                }
                SportsDetailsClear();
                GetStudentInfo($("[id*=hfStudentInfoID]").val());
                changeAccordion(18);
            }
            else if (response.d == "Insert Failed") {
                AlertMessage('fail', 'Insert');
            }

            GetASSSportsInfo($("[id*=hfRegNo]").val());
        };


        // Save General
        function SaveASSGeneralDetails() {
            if (($("[id*=hfAddPrm]").val() == 'true') || ($("[id*=hfEditPrm]").val() == 'true')
            ) {
                if ($('#aspnetForm').valid()) {
                    var RegNo = $("[id*=hfRegNo]").val();

                    var iden1 = $("[id*=txtidentify1]").val();
                    var iden2 = $("[id*=txtidentify2]").val();

                    var breaks = "";
                    if ($("[id*=rtbnBreakYes]").is(':checked')) {
                        breaks = "1";
                    }
                    else if ($("[id*=rtbnBreakNo]").is(':checked')) {
                        breaks = "2";
                    }

                    var lunch = "";
                    if ($("[id*=rtbnLunchYes]").is(':checked')) {
                        lunch = "1";
                    }
                    else if ($("[id*=rtbnLunchNo]").is(':checked')) {
                        lunch = "2";
                    }

                    var trans = "";
                    if ($("[id*=rtbnTransYes]").is(':checked')) {
                        trans = "1";
                    }
                    else if ($("[id*=rtbnTransNo]").is(':checked')) {
                        trans = "2";
                    }

                    var bc = "";
                    if ($("[id*=rbtnbcYes]").is(':checked')) {
                        bc = "1";
                    }
                    else if ($("[id*=rbtnbcNo]").is(':checked')) {
                        bc = "2";
                    }

                    var hostel = "";
                    if ($("[id*=rbtnHotelYes]").is(':checked')) {
                        hostel = "1";
                    }
                    else if ($("[id*=rbtnHotelNo]").is(':checked')) {
                        hostel = "2";
                    }

                    var Academicyear = $("[id*=hfAcademicyear]").val();
                    var parameters = '{"regno": "' + RegNo + '","hasbreak": "' + breaks + '","hastrans": "' + trans + '","haslunch": "' + lunch + '","hasbirth": "' + bc + '","hashostel": "' + hostel + '","iden1": "' + iden1 + '","iden2": "' + iden2 + '"}';
                    $.ajax({
                        type: "POST",
                        url: "../Students/StudentInfo.aspx/SaveASSGeneral",
                        data: parameters,
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: OnSaveASSSportsSuccess,
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
                return false;
            }
        }
        // Save On Success
        function OnSaveASSGeneralSuccess(response) {
            if (response.d == "Updated") {
                AlertMessage('success', 'Updated');
                GeneralDetailsClear();
                GetStudentInfo($("[id*=hfStudentInfoID]").val());
                changeAccordion(20);
            }
            else if (response.d == "Update Failed") {
                AlertMessage('fail', 'Update');
            }
            else if (response.d == "Inserted") {
                AlertMessage('success', 'Updated');
                GeneralDetailsClear();
                changeAccordion(20);
            }
            else if (response.d == "Insert Failed") {
                AlertMessage('fail', 'Insert');
            }

            GetASSGeneralInfo($("[id*=hfRegNo]").val());
        };

        function SaveASSWellnessDetails() {
            if (($("[id*=hfAddPrm]").val() == 'true') || ($("[id*=hfEditPrm]").val() == 'true')
            ) {
                if ($('#aspnetForm').valid()) {
                    var RegNo = $("[id*=hfRegNo]").val();


                    var allergictempfile = $('#fuAllergic').val().replace(/C:\\fakepath\\/i, ''); ;
                    var allergicFile = allergictempfile.substring(allergictempfile.lastIndexOf('\\') + 1);

                    var allergic = "";
                    if ($("[id*=rbtnAllergicYes]").is(':checked')) {
                        allergic = "1";
                    }
                    else if ($("[id*=rbtnAllergicNo]").is(':checked')) {
                        allergic = "2";
                    }


                    var skin = "";
                    if ($("[id*=rbtnSkinYes]").is(':checked')) {
                        skin = "1";
                    }
                    else if ($("[id*=rbtnSkinNo]").is(':checked')) {
                        skin = "2";
                    }

                    var tetanus = "";
                    if ($("[id*=rbtnTetanusYes]").is(':checked')) {
                        tetanus = "1";
                    }
                    else if ($("[id*=rbtnTetanusNo]").is(':checked')) {
                        tetanus = "2";
                    }

                    var polio = "";
                    if ($("[id*=rbtnPolioYes]").is(':checked')) {
                        polio = "1";
                    }
                    else if ($("[id*=rbtnPolioNo]").is(':checked')) {
                        polio = "2";
                    }

                    var tb = "";
                    if ($("[id*=rbtnTBYes]").is(':checked')) {
                        tb = "1";
                    }
                    else if ($("[id*=rbtnTBNo]").is(':checked')) {
                        tb = "2";
                    }

                    var hepa = "";
                    if ($("[id*=rbtnHepatitisYes]").is(':checked')) {
                        hepa = "1";
                    }
                    else if ($("[id*=rbtnHepatitisNo]").is(':checked')) {
                        hepa = "2";
                    }

                    var covid = "";
                    if ($("[id*=rbtnCovidYes]").is(':checked')) {
                        covid = "1";
                    }
                    else if ($("[id*=rbtnCovidNo]").is(':checked')) {
                        covid = "2";
                    }

                    var hpv = "";
                    if ($("[id*=rbtnHPVYes]").is(':checked')) {
                        hpv = "1";
                    }
                    else if ($("[id*=rbtnHPVNo]").is(':checked')) {
                        hpv = "2";
                    }

                    var glass = "";
                    if ($("[id*=rbtnGlassYes]").is(':checked')) {
                        glass = "1";
                    }
                    else if ($("[id*=rbtnGlassNo]").is(':checked')) {
                        glass = "2";
                    }

                    var lens = "";
                    if ($("[id*=rbtnLensYes]").is(':checked')) {
                        lens = "1";
                    }
                    else if ($("[id*=rbtnLensNo]").is(':checked')) {
                        lens = "2";
                    }

                    var hear = "";
                    if ($("[id*=rbtnhearYes]").is(':checked')) {
                        hear = "1";
                    }
                    else if ($("[id*=rbtnhearNo]").is(':checked')) {
                        hear = "2";
                    }

                    var chicken = "";
                    if ($("[id*=rbtnChickenYes]").is(':checked')) {
                        chicken = "1";
                    }
                    else if ($("[id*=rbtnChickenNo]").is(':checked')) {
                        chicken = "2";
                    }

                    var rubella = "";
                    if ($("[id*=rbtnRubellaYes]").is(':checked')) {
                        rubella = "1";
                    }
                    else if ($("[id*=rbtnRubellaNo]").is(':checked')) {
                        rubella = "2";
                    }

                    var jaundice = "";
                    if ($("[id*=rbtnJaundiceYes]").is(':checked')) {
                        jaundice = "1";
                    }
                    else if ($("[id*=rbtnJaundiceNo]").is(':checked')) {
                        jaundice = "2";
                    }


                    var measles = "";
                    if ($("[id*=rbtnMeaslesYes]").is(':checked')) {
                        measles = "1";
                    }
                    else if ($("[id*=rbtnMeaslesNo]").is(':checked')) {
                        measles = "2";
                    }

                    var mumps = "";
                    if ($("[id*=rbtnMumpsYes]").is(':checked')) {
                        mumps = "1";
                    }
                    else if ($("[id*=rbtnMumpsNo]").is(':checked')) {
                        mumps = "2";
                    }

                    var scarlet = "";
                    if ($("[id*=rbtnScarletYes]").is(':checked')) {
                        scarlet = "1";
                    }
                    else if ($("[id*=rbtnScarletNo]").is(':checked')) {
                        scarlet = "2";
                    }

                    var cough = "";
                    if ($("[id*=rbtnCoughYes]").is(':checked')) {
                        cough = "1";
                    }
                    else if ($("[id*=rbtnCoughNo]").is(':checked')) {
                        cough = "2";
                    }

                    var anorexia = "";
                    if ($("[id*=chkAnorexia]").is(':checked')) {
                        anorexia = "1";
                    }
                    else if (!$("[id*=chkAnorexia]").is(':checked')) {
                        anorexia = "2";
                    }


                    var arthrititis = "";
                    if ($("[id*=chkArthritis]").is(':checked')) {
                        arthrititis = "1";
                    }
                    else if (!$("[id*=chkArthritis]").is(':checked')) {
                        arthrititis = "2";
                    }

                    var asthma = "";
                    if ($("[id*=chkAsthma]").is(':checked')) {
                        asthma = "1";
                    }
                    else if (!$("[id*=chkAsthma]").is(':checked')) {
                        asthma = "0";
                    }

                    var bone = "";
                    if ($("[id*=chkBone]").is(':checked')) {
                        bone = "1";
                    }
                    else if (!$("[id*=chkBone]").is(':checked')) {
                        bone = "0";
                    }

                    var cancer = "";
                    if ($("[id*=chkCancer]").is(':checked')) {
                        cancer = "1";
                    }
                    else if (!$("[id*=chkCancer]").is(':checked')) {
                        cancer = "0";
                    }

                    var cardio = "";
                    if ($("[id*=chkCardiovascular]").is(':checked')) {
                        cardio = "1";
                    }
                    else if (!$("[id*=chkCardiovascular]").is(':checked')) {
                        cardio = "0";
                    }

                    var dia = "";
                    if ($("[id*=chkDiabetes]").is(':checked')) {
                        dia = "1";
                    }
                    else if (!$("[id*=chkDiabetes]").is(':checked')) {
                        dia = "0";
                    }

                    var eczema = "";
                    if ($("[id*=chkEczema]").is(':checked')) {
                        eczema = "1";
                    }
                    else if (!$("[id*=chkEczema]").is(':checked')) {
                        eczema = "0";
                    }


                    var epilepsy = "";
                    if ($("[id*=chkEpilepsy]").is(':checked')) {
                        epilepsy = "1";
                    }
                    else if ($("[id*=chkEpilepsy]").is(':checked')) {
                        epilepsy = "0";
                    }


                    var enuresis = "";
                    if ($("[id*=chkEnuresis]").is(':checked')) {
                        enuresis = "1";
                    }
                    else if ($("[id*=chkEnuresis]").is(':checked')) {
                        enuresis = "0";
                    }

                    var genetic = "";
                    if ($("[id*=chkGenetic]").is(':checked')) {
                        genetic = "1";
                    }
                    else if (!$("[id*=chkGenetic]").is(':checked')) {
                        genetic = "0";
                    }

                    var hay = "";
                    if ($("[id*=chkHay]").is(':checked')) {
                        hay = "1";
                    }
                    else if (!$("[id*=chkHay]").is(':checked')) {
                        hay = "0";
                    }

                    var head = "";
                    if ($("[id*=chkHead]").is(':checked')) {
                        head = "1";
                    }
                    else if ($("[id*=chkHead]").is(':checked')) {
                        head = "0";
                    }

                    var hearing = "";
                    if ($("[id*=chkHearing]").is(':checked')) {
                        hearing = "1";
                    }
                    else if (!$("[id*=chkHearing]").is(':checked')) {
                        hearing = "0";
                    }

                    var heart = "";
                    if ($("[id*=chkHeart]").is(':checked')) {
                        heart = "1";
                    }
                    else if (!$("[id*=chkHeart]").is(':checked')) {
                        heart = "0";
                    }

                    var hepatitis = "";
                    if ($("[id*=chkHepatitis]").is(':checked')) {
                        hepatitis = "1";
                    }
                    else if (!$("[id*=chkHepatitis]").is(':checked')) {
                        hepatitis = "0";
                    }


                    var hiv = "";
                    if ($("[id*=chkHIV]").is(':checked')) {
                        hiv = "1";
                    }
                    else if (!$("[id*=chkHIV]").is(':checked')) {
                        hiv = "0";
                    }


                    var learn = "";
                    if ($("[id*=chkLearning]").is(':checked')) {
                        learn = "1";
                    }
                    else if (!$("[id*=chkLearning]").is(':checked')) {
                        learn = "0";
                    }


                    var mens = "";
                    if ($("[id*=chkMenstrual]").is(':checked')) {
                        mens = "1";
                    }
                    else if (!$("[id*=chkMenstrual]").is(':checked')) {
                        mens = "0";
                    }


                    var migraine = "";
                    if ($("[id*=chkMigraine]").is(':checked')) {
                        migraine = "1";
                    }
                    else if (!$("[id*=chkMigraine]").is(':checked')) {
                        migraine = "0";
                    }


                    var phobia = "";
                    if ($("[id*=chkPhobia]").is(':checked')) {
                        phobia = "1";
                    }
                    else if (!$("[id*=chkPhobia]").is(':checked')) {
                        phobia = "0";
                    }


                    var deform = "";
                    if ($("[id*=chkDeformity]").is(':checked')) {
                        deform = "1";
                    }
                    else if (!$("[id*=chkDeformity]").is(':checked')) {
                        deform = "0";
                    }

                    var physic = "";
                    if ($("[id*=chkPhysical]").is(':checked')) {
                        physic = "1";
                    }
                    else if (!$("[id*=chkPhysical]").is(':checked')) {
                        physic = "0";
                    }

                    var pneumo = "";
                    if ($("[id*=chkPneumonia]").is(':checked')) {
                        pneumo = "1";
                    }
                    else if (!$("[id*=chkPneumonia]").is(':checked')) {
                        pneumo = "0";
                    }

                    var rheumat = "";
                    if ($("[id*=chkRheumatic]").is(':checked')) {
                        rheumat = "1";
                    }
                    else if (!$("[id*=chkRheumatic]").is(':checked')) {
                        rheumat = "0";
                    }


                    var skins = "";
                    if ($("[id*=chkSkin]").is(':checked')) {
                        skins = "1";
                    }
                    else if (!$("[id*=chkSkin]").is(':checked')) {
                        skins = "0";
                    }


                    var stomach = "";
                    if ($("[id*=chkStomach]").is(':checked')) {
                        stomach = "1";
                    }
                    else if (!$("[id*=chkStomach]").is(':checked')) {
                        stomach = "0";
                    }


                    var syndrome = "";
                    if ($("[id*=chkSyndromes]").is(':checked')) {
                        syndrome = "1";
                    }
                    else if (!$("[id*=chkSyndromes]").is(':checked')) {
                        syndrome = "0";
                    }


                    var urinary = "";
                    if ($("[id*=chkUrinary]").is(':checked')) {
                        urinary = "1";
                    }
                    else if (!$("[id*=chkUrinary]").is(':checked')) {
                        urinary = "0";
                    }


                    var anxiety = "";
                    if ($("[id*=chkAnxiety]").is(':checked')) {
                        anxiety = "1";
                    }
                    else if (!$("[id*=chkAnxiety]").is(':checked')) {
                        anxiety = "0";
                    }


                    var autism = "";
                    if ($("[id*=chkAutism]").is(':checked')) {
                        autism = "1";
                    }
                    else if (!$("[id*=chkAutism]").is(':checked')) {
                        autism = "0";
                    }



                    var mood = "";
                    if ($("[id*=chkMood]").is(':checked')) {
                        mood = "1";
                    }
                    else if (!$("[id*=chkMood]").is(':checked')) {
                        mood = "0";
                    }


                    var speech = "";
                    if ($("[id*=chkSpeech]").is(':checked')) {
                        speech = "1";
                    }
                    else if (!$("[id*=chkSpeech]").is(':checked')) {
                        speech = "0";
                    }

                    var prescribed = $("[id*=txtPrescribed]").val();
                    var allergies = $("[id*=txtallergies]").val();
                    var medication = $("[id*=txtMedication]").val();
                    var medicationpurpose = $("[id*=txtMedicationPurpose]").val();
                    var period = $("[id*=txtPeriod]").val();
                    var otherlist = $("[id*=txtOtherlist]").val();
                    var anymedication = $("[id*=txtAnyMedication]").val();
                    var operation = $("[id*=txtOperation]").val();
                    var Academicyear = $("[id*=hfAcademicyear]").val();
                    var desc = "";
                    var parameters = '{"regno": "' + RegNo + '","hasallergic": "' + allergic + '","hasinfection": "' + skin + '","attachment": "' + allergictempfile + '","prescribed": "' + prescribed + '","desc": "' + desc + '","otheraller": "' + allergies + '","medication": "' + medication + '","purpose": "' + medicationpurpose + '","period": "' + period + '","hastetanus": "' + tetanus + '","haspolio": "' + polio + '","hastb": "' + tb + '","hashepatitis": "' + hepa + '","hascovid": "' + covid + '","hashpv": "' + hpv + '","otherdesc": "' + otherlist + '","hasspecs": "' + glass + '","haslens": "' + lens + '","hashearing": "' + hear + '","haschicken": "' + chicken + '","hasrubella": "' + rubella + '","hasjaundice": "' + jaundice + '","hasmeasles": "' + measles + '","hasmumps": "' + mumps + '","hasscarlet": "' + scarlet + '","hascough": "' + cough + '","otherlist": "' + anymedication + '","operation": "' + operation + '","anorexia": "' + anorexia + '","arthitis": "' + arthrititis + '","asthma": "' + asthma + '","hasbone": "' + bone + '","hascancer": "' + cancer + '","hascardio": "' + cardio + '","hasdia": "' + dia + '","eczema": "' + eczema + '","enuresis": "' + enuresis + '","epilepsy": "' + epilepsy + '","genetic": "' + genetic + '","hashay": "' + hay + '","hashead": "' + head + '","hashearinjury": "' + hearing + '","heart": "' + heart + '","hepatitis": "' + hepatitis + '","hashiv": "' + hiv + '","learning": "' + learn + '","hasmensural": "' + mens + '","hasmigraine": "' + migraine + '","hasphobia": "' + phobia + '","hasdeformity": "' + deform + '","hasdisability": "' + physic + '","pneumonia": "' + pneumo + '","hasrheumatic": "' + rheumat + '","hasskin": "' + skins + '","hasstomach": "' + stomach + '","hassyndrome": "' + syndrome + '","hasurinary": "' + urinary + '","hasanxiety": "' + anxiety + '","hasautism": "' + autism + '","hasmood": "' + mood + '","haspseech": "' + speech + '"}';
                    $.ajax({
                        type: "POST",
                        url: "../Students/StudentInfo.aspx/SaveASSWellness",
                        data: parameters,
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: OnSaveASSSportsSuccess,
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
                return false;
            }
        }

        // Save On Success
        function OnSaveASSWellnessSuccess(response) {
            if (response.d == "Updated") {
                AlertMessage('success', 'Updated');
                var RegNo = $("[id*=hfRegNo]").val();
                if (formdata) {
                    formdata.append("StudenInfoId", RegNo);
                    formdata.append("AllergicAttachment", $('#fuAllergic')[0].files[0]);
                    if (formdata) {
                        $.ajax({
                            url: "../Students/StudentInfo.aspx",
                            type: "POST",
                            data: formdata,
                            processData: false,
                            contentType: false,
                            success: function (res) {
                            }
                        });
                    }
                }
                WellnessDetailsClear();
                GetStudentInfo($("[id*=hfStudentInfoID]").val());
                changeAccordion(20);
            }
            else if (response.d == "Update Failed") {
                AlertMessage('fail', 'Update');
            }
            else if (response.d == "Inserted") {
                AlertMessage('success', 'Updated');
                var RegNo = $("[id*=hfRegNo]").val();
                if (formdata) {
                    formdata.append("StudenInfoId", RegNo);
                    formdata.append("AllergicAttachment", $('#fuAllergic')[0].files[0]);
                    if (formdata) {
                        $.ajax({
                            url: "../Students/StudentInfo.aspx",
                            type: "POST",
                            data: formdata,
                            processData: false,
                            contentType: false,
                            success: function (res) {
                            }
                        });
                    }
                }
                WellnessDetailsClear();
                GetStudentInfo($("[id*=hfStudentInfoID]").val());
                changeAccordion(20);
            }
            else if (response.d == "Insert Failed") {
                AlertMessage('fail', 'Insert');
            }

            GetASSWellnessInfo($("[id*=hfRegNo]").val());
        };

        var StudentType = "";
        function showregno() {
            $("[id*=txtSearchRegNo]").val("");
            if ($("[id*=rbtnahss]").is(':checked')) {
                $("[id*=txtSearchRegNo]").removeAttr("disabled");
            }
            else if ($("[id*=rbtnala]").is(':checked')) {
                $("[id*=txtSearchRegNo]").removeAttr("disabled");
            }
            else if ($("[id*=rbtnoutside]").is(':checked')) {
                $("[id*=txtSearchRegNo]").attr("disabled", "disabled");
            }

            PersonalDetailsClear();
            FamilyDetailsClear();
            BroSisDetailsClear();
            MedicalDetailsClear();
            AcademicDetailsClear();
            MedRemDetailsClear();
            AcademicRemarksDetailsClear();
            BusRouteDetailsClear();
            OldSchoolDetailsClear();
            HostelDetailsClear();
            NationalityDetailsClear();
            AttachmentInfoClear();
            ScholarshipDetailsClear();
            SportsDetailsClear();
            ASSWellnessClear();
            GeneralDetailsClear();

        }
        function checkregno() {
            $("[id*=txtSearchRegNo]").val("");
            if ($("[id*=rbtnahss]").is(':checked')) {
                $("[id*=txtSearchRegNo]").removeAttr("disabled");
                StudentType = "ahss";
                $("[id*=trpersonal]").css("display", "contents");
                $("[id*=trfamily]").css("display", "none");
                $("[id*=trbrosis]").css("display", "none");
                $("[id*=trmedical]").css("display", "none");
                $("[id*=trmedrem]").css("display", "none");
            }
            if ($("[id*=rbtnala]").is(':checked')) {
                $("[id*=txtSearchRegNo]").removeAttr("disabled");
                StudentType = "ala";
                $("[id*=trpersonal]").css("display", "contents");
                $("[id*=trfamily]").css("display", "none");
                $("[id*=trbrosis]").css("display", "none");
                $("[id*=trmedical]").css("display", "none");
                $("[id*=trmedrem]").css("display", "none");
            }
            if ($("[id*=rbtnoutside]").is(':checked')) {
                $("[id*=txtSearchRegNo]").attr("disabled", "disabled");
                StudentType = "others";
                $("[id*=trpersonal]").css("display", "contents");
                $("[id*=trfamily]").css("display", "contents");
                $("[id*=trbrosis]").css("display", "contents");
                $("[id*=trmedical]").css("display", "contents");
                $("[id*=trmedrem]").css("display", "contents");


            }
        }
        function GetStudentData(val) {
            var RegNo = "";
            RegNo = $("[id*=txtSearchRegNo]").val();
            if ($("[id*=rbtnahss]").is(':checked')) {
                StudentType = "ahss";
                $("[id*=trpersonal]").css("display", "contents");
                $("[id*=trfamily]").css("display", "none");
                $("[id*=trbrosis]").css("display", "none");
                $("[id*=trmedical]").css("display", "none");
                $("[id*=trmedrem]").css("display", "none");
            }
            if ($("[id*=rbtnala]").is(':checked')) {
                StudentType = "ala";
                $("[id*=trpersonal]").css("display", "contents");
                $("[id*=trfamily]").css("display", "none");
                $("[id*=trbrosis]").css("display", "none");
                $("[id*=trmedical]").css("display", "none");
                $("[id*=trmedrem]").css("display", "none");
            }
            if ($("[id*=rbtnoutside]").is(':checked')) {
                StudentType = "others";
                $("[id*=trpersonal]").css("display", "contents");
                $("[id*=trfamily]").css("display", "contents");
                $("[id*=trbrosis]").css("display", "contents");
                $("[id*=trmedical]").css("display", "contents");
                $("[id*=trmedrem]").css("display", "contents");

            }

            if (RegNo != '') {
                $.ajax({
                    type: "POST",
                    url: "../Students/StudentInfo.aspx/GetStudentData",
                    data: '{RegNo:"' + RegNo + '",StudentType:"' + StudentType + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnGetStudentDataSuccess,
                    failure: function (response) {
                        AlertMessage('info', response.d);
                    },
                    error: function (response) {
                        AlertMessage('info', response.d);
                    }
                });
            }
            else {
                PersonalDetailsClear();
                FamilyDetailsClear();
                BroSisDetailsClear();
                MedicalDetailsClear();
                AcademicDetailsClear();
                MedRemDetailsClear();
                AcademicRemarksDetailsClear();
                BusRouteDetailsClear();
                OldSchoolDetailsClear();
                HostelDetailsClear();
                NationalityDetailsClear();
                AttachmentInfoClear();
                ScholarshipDetailsClear();
                SportsDetailsClear();
                ASSWellnessClear();
                GeneralDetailsClear();
            }
        }


        function OnGetStudentDataSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var StudentInfos = xml.find("StudentInfo");
            if (StudentInfos.length > 0) {
                $("[id*=trpersonal]").css("display", "contents");
                $("[id*=trfamily]").css("display", "contents");
                $("[id*=trbrosis]").css("display", "contents");
                $("[id*=trmedical]").css("display", "contents");
                $("[id*=trmedrem]").css("display", "contents");
            }
            var frelation = xml.find("FRelation");
            var mrelation = xml.find("MRelation");
            var Guardian1 = xml.find("Guardian1");
            var Guardian2 = xml.find("Guardian1");

            row = $("[id*=dgRelationship] tr:last-child").clone(true);
            $("[id*=dgRelationship] tr").not($("[id*=dgRelationship] tr:first-child")).remove();
            var eanchor = ''
            var eanchorEnd = '';
            var danchor = ''
            var danchorEnd = '';
            if ($("[id*=hfEditPrm]").val() == 'false') {
                eanchor = "<a>";
                eanchorEnd = "</a>";
            }
            else {
                eanchor = "<a  href=\"javascript:EditRelationshipInfo('";
                eanchorEnd = "');\">Edit</a>";
            }
            if ($("[id*=hfDeletePrm]").val() == 'false') {
                danchor = "<a>";
                danchorEnd = "</a>";
            }
            else {
                danchor = "<a  href=\"javascript:DeleteRelationshipInfo('";
                danchorEnd = "');\">Delete</a>";
            }

            if (StudentInfos.length == 0) {
                $("[id*=dgRelationship] tr").not($("[id*=dgRelationship] tr:first-child")).remove();
                $("td", row).eq(0).html("");
                $("td", row).eq(1).html("");
                $("td", row).eq(2).html("");
                $("td", row).eq(3).html("No Records Found").attr("align", "center");
                $("td", row).eq(4).html("");
                $("td", row).eq(5).html("");
                $("td", row).eq(6).html("");
                $("td", row).eq(7).html("");
                $("td", row).eq(8).html("");
                $("td", row).eq(9).html("");
                $("td", row).eq(10).html("");
                $("[id*=dgRelationship]").append(row);
                row = $("[id*=dgRelationship] tr:last-child").clone(true);

            }
            else {

                if (frelation.length == 0 && mrelation.length == 0 && Guardian1.length == 0 && Guardian2.length == 0) {
                    $("[id*=dgRelationship] tr").not($("[id*=dgRelationship] tr:first-child")).remove();
                    $("td", row).eq(0).html("");
                    $("td", row).eq(1).html("");
                    $("td", row).eq(2).html("");
                    $("td", row).eq(3).html("No Records Found").attr("align", "center");
                    $("td", row).eq(4).html("");
                    $("td", row).eq(5).html("");
                    $("td", row).eq(6).html("");
                    $("td", row).eq(7).html("");
                    $("td", row).eq(8).html("");
                    $("td", row).eq(9).html("");
                    $("td", row).eq(10).html("");
                    $("[id*=dgRelationship]").append(row);
                    row = $("[id*=dgRelationship] tr:last-child").clone(true);
                }
                $.each(StudentInfos, function () {

                    var ClassID = $(this).find("ClassID").text();
                    $("[id*=ddlClass] option[value='" + ClassID + "']").attr("selected", "true");
                    FlagSectionID = $(this).find("SectionID").text();
                    GetSectionByClass();
                    GetSportsByClass();
                    $("[id*=hfStudentInfoID]").val();
                    $("[id*=hfRegNo]").val($(this).find("RegNo").text());
                    $("[id*=lblApplicationNo]").html($(this).find("ApplicationNo").text());
                    $("[id*=lblRegNo]").html($(this).find("RegNo").text());

                    if ($("[id*=lblApplicationNo]").html() != "") {
                        $("[id*=spnRegno]").css("display", "none");
                        $("[id*=spnAppno]").css("display", "block");
                    } else {
                        $("[id*=spnRegno]").css("display", "block");
                        $("[id*=spnAppno]").css("display", "none");

                    }
                    $("[id*=lblASSRegNo]").html($(this).find("ASSNo").text());
                    $("[id*=lblStudentName]").html($(this).find("StudentName").text());
                    if ($(this).find("SectionID").text() == "") {
                        $("[id*=lblClass]").html($(this).find("Class").text() + " / " + "New")
                    }
                    else {
                        $("[id*=lblClass]").html($(this).find("Class").text() + " / " + $(this).find("Section").text())
                    }


                    $("[id*=txtStudentName]").val($(this).find("StudentName").text());

                    $("[id*=hfRegNo]").val($(this).find("RegNo").text());
                    $("[id*=txtRegNo]").val($(this).find("RegNo").text());
                    $("[id*=txtConcessionReason]").val($(this).find("Reason").text());
                    var Gender = $(this).find("Gender").text();

                    if (Gender == "Male" || Gender == "M") {
                        $("[id*=rbtnMale]").attr("checked", true);
                    }
                    else if (Gender == "Female" || Gender == "F") {
                        $("[id*=rbtnFemale]").attr("checked", true);
                    }
                    $("[id*=txtDOB]").val($(this).find("DOB").text());
                    $("[id*=txtMotherTongue]").val($(this).find("MotherTongue").text());


                    var Religion = $(this).find("ReligionID").text();
                    $("[id*=ddlReligion] option[value='" + Religion + "']").attr("selected", "true");

                    var Community = $(this).find("CommunityID").text();
                    $("[id*=ddlCommunity] option[value='" + Community + "']").attr("selected", "true");

                    var Caste = $(this).find("CasteID").text();
                    $("[id*=ddlCaste] option[value='" + Caste + "']").attr("selected", "true");

                    $("[id*=txtAadhaar]").val($(this).find("AadhaarNo").text());
                    $("[id*=txtFatherAadhaar]").val($(this).find("FatherAadhaarNo").text());
                    $("[id*=txtMotherAadhaar]").val($(this).find("MotherAadhaarNo").text());
                    $("[id*=txtTempAddress]").val($(this).find("TempAddr").text());
                    $("[id*=txtPerAddress]").val($(this).find("PerAddr").text());
                    $("[id*=txtEmail]").val($(this).find("Email").text());
                    $("[id*=txtPhoneNo]").val($(this).find("PhoneNo").text());
                    $("[id*=txtRationCardNo]").val($(this).find("RationCardNo").text());
                    $("[id*=txtSmartCardNo]").val($(this).find("SmartCardNo").text());
                    $("[id*=txtSSLC]").val($(this).find("SSLCNo").text());
                    $("[id*=ddlSSLC]").val($(this).find("SSLCYear").text());
                    $("[id*=txtHSC]").val($(this).find("HSCNo").text());
                    $("[id*=ddlHSC]").val($(this).find("HSCYear").text());
                    $("[id*=txtSUID]").val($(this).find("SUID").text());
                    $("[id*=txtTamilname]").val($(this).find("tamilname").text());

                    var CareTaker = $(this).find("CareTaker").text();

                    if (CareTaker == "Parent") {
                        $("[id*=rbtnParent]").attr("checked", true);
                    }
                    else if (CareTaker == "Guardian") {
                        $("[id*=rbtnGuardian]").attr("checked", true);
                    }
                    var Sports = $(this).find("Sports").text();
                    if (Sports == "true") {
                        $("[id*=rbtnSports]").attr("checked", true);
                    }
                    else {
                        $("[id*=rbtnFine]").attr("checked", true);
                    }

                    var FineArts = $(this).find("FineArts").text();
                    if (FineArts == "true") {
                        $("[id*=rbtnFine]").attr("checked", true);
                    }
                    else {
                        $("[id*=rbtnSports]").attr("checked", true);
                    }

                    $("[id*=txtCurricularRemarks]").val($(this).find("CurricularRemarks").text());

                    var Skills = $(this).find("Skills").text();
                    if (Skills == "true") {
                        $("[id*=rbtnSkillYes]").attr("checked", true);
                    }
                    else {
                        $("[id*=rbtnSkillNo]").attr("checked", true);
                    }

                    $("[id*=txtSkillRemarks]").val($(this).find("SkillRemarks").text());

                    var PhotoFile = $(this).find("PhotoFile").text();
                    if (PhotoFile) {
                        $("[id*=img_prev]").attr('src', "../Students/Photos/" + PhotoFile.toString() + "?rand=" + Math.random()).width(114).height(114)
                    }
                    else {
                        $("[id*=img_prev]").attr('src', "../img/Photo.jpg").width(114).height(114);
                    }

                    $("[id*=ddlBloodGroup]").val($(this).find("BloodGroupID").text());
                    $("[id*=txtDisease]").val($(this).find("DisOrders").text());
                    $("[id*=txtHeight]").val($(this).find("Height").text());
                    $("[id*=txtWeight]").val($(this).find("Weight").text());
                    $("[id*=txtEmergencyPhNo]").val($(this).find("EmerPhNo").text());
                    $("[id*=txtFamilyDocName]").val($(this).find("Doctor").text());
                    $("[id*=txtFamilyDocAdd]").val($(this).find("DocAddr").text());
                    $("[id*=txtFamilyDocPhNo]").val($(this).find("DocPhNo").text());
                    if ($(this).find("IdMarks").text() != "") {
                        var IDnMarks = $(this).find("IdMarks").text().split(":");
                        if (IDnMarks.length > 1) {
                            $("[id*=txtIdentificationMarks1]").val(IDnMarks[0]);
                            $("[id*=txtIdentificationMarks2]").val(IDnMarks[1]);
                        }
                        else {
                            $("[id*=txtIdentificationMarks1]").val(IDnMarks[0]);
                            $("[id*=txtIdentificationMarks2]").val("");
                        }
                    }
                    if ($(this).find("Handicap").text() == "Y") {
                        $("[id*=rbtnPHYes]").attr('checked', true);
                    }
                    else {
                        $("[id*=rbtnNoPH]").attr('checked', true);
                    }
                    showphysical();
                    $("[id*=txtPhysicalHandicapped]").val($(this).find("HandicaptDetails").text());
                    $("[id*=txtAdmissionNo]").val($(this).find("AdmissionNo").text());

                    var AdClassID = $(this).find("AdClassID").text();
                    $("[id*=ddlAdClass] option[value='" + AdClassID + "']").attr("selected", "true");
                    FlagAdSectionID = $(this).find("AdSectionID").text();
                    GetAdSectionByAdClass();

                    $("[id*=txtDOJ]").val($(this).find("DOJ").text());
                    $("[id*=txtDOA]").val($(this).find("DOA").text());

                    var Mode = $(this).find("TransportId").text();
                    $("[id*=ddlModeofTrans] option[value='" + Mode + "']").attr("selected", "true");

                    $("[id*=ddlSchoolMedium]").val($(this).find("mediumID").text());
                    $("[id*=txtFirstlang]").val($(this).find("Firstlang").text());
                    //$("[id*=txtFirstlang]").html($(this).find("Firstlang").text());
                    $("[id*=ddlSeclang]").val($(this).find("Seclang").text());
                    var Scholar = $(this).find("Scholar").text();
                    if (Scholar == "Y") {
                        $("[id*=rbtnScholarYes]").attr("checked", true);
                    }
                    else {
                        $("[id*=rbtnNoScholar]").attr("checked", true);
                    }
                    ShowScholarship();

                    var Concession = $(this).find("Concession").text();

                    if (Concession == "Y") {
                        $("[id*=rbtnConcessYes]").attr("checked", true);
                    }
                    else {
                        $("[id*=rbtnNoConcess]").attr("checked", true);
                    }
                    ShowConcession();


                    var ScholarshipId = $(this).find("ScholarshipId").text();
                    // $("[id*=ddlScholarship] option[value='" + ScholarshipId + "']").attr("selected", "true");

                    $("[id*=hfAcademicyear]").val($(this).find("AcademicYear").text());
                    $("[id*=ddlStatus]").val($(this).find("Active").text());
                    $("[id*=lblStatus]").html($(this).find("Status").text());
                    row.addClass("even");

                    if ($(this).find("FRelation").text() == "Father") {
                        isRelationExist = 1;
                        var ehref = eanchor + $(this).find("StudentID").text() + "','" + $(this).find("FRelation").text() + eanchorEnd;
                        var dhref = danchor + $(this).find("StudentID").text() + "','" + $(this).find("FRelation").text() + danchorEnd;
                        $("td", row).eq(0).html($(this).find("FRelation").text()).attr("valign", "top");
                        $("td", row).eq(1).html($(this).find("FName").text()).attr("valign", "top");
                        $("td", row).eq(2).html($(this).find("FQual").text()).attr("valign", "top");
                        $("td", row).eq(3).html($(this).find("FOccupation").text()).attr("valign", "top");
                        $("td", row).eq(4).html($(this).find("FIncome").text()).attr("valign", "top");
                        $("td", row).eq(5).html("<p style='word-wrap: break-word; width:300px;'>" + $(this).find("FOccAddress").text() + "</p>");
                        $("td", row).eq(6).html($(this).find("FEmail").text()).attr("valign", "top");
                        $("td", row).eq(7).html($(this).find("FatherCell").text()).attr("valign", "top");
                        $("td", row).eq(8).html(ehref).addClass("editacc edit-links").attr("valign", "top");
                        $("td", row).eq(9).html(dhref).addClass("deleteacc delete-links").attr("valign", "top");
                        $("[id*=dgRelationship]").append(row);
                        row = $("[id*=dgRelationship] tr:last-child").clone(true);
                    }

                    if ($(this).find("MRelation").text() == "Mother") {
                        isRelationExist = 1;
                        var ehref = eanchor + $(this).find("StudentID").text() + "','" + $(this).find("MRelation").text() + eanchorEnd;
                        var dhref = danchor + $(this).find("StudentID").text() + "','" + $(this).find("MRelation").text() + danchorEnd;
                        $("td", row).eq(0).html($(this).find("MRelation").text()).attr("valign", "top");
                        $("td", row).eq(1).html($(this).find("MName").text()).attr("valign", "top");
                        $("td", row).eq(2).html($(this).find("MQual").text()).attr("valign", "top");
                        $("td", row).eq(3).html($(this).find("MOccupation").text()).attr("valign", "top");
                        $("td", row).eq(4).html($(this).find("MIncome").text()).attr("valign", "top");
                        $("td", row).eq(5).html("<p style='word-wrap: break-word;'>" + $(this).find("MOccAddress").text() + "</p>");
                        $("td", row).eq(6).html($(this).find("MEmail").text()).attr("valign", "top");
                        $("td", row).eq(7).html($(this).find("MotherCell").text()).attr("valign", "top");
                        $("td", row).eq(8).html(ehref).addClass("editacc edit-links").attr("valign", "top");
                        $("td", row).eq(9).html(dhref).addClass("deleteacc delete-links").attr("valign", "top");
                        $("[id*=dgRelationship]").append(row);
                        row = $("[id*=dgRelationship] tr:last-child").clone(true);
                    }

                    if ($(this).find("Guardian1").text() == "Guardian I") {
                        isRelationExist = 1;
                        var ehref = eanchor + $(this).find("StudentID").text() + "','" + $(this).find("Guardian1").text() + eanchorEnd;
                        var dhref = danchor + $(this).find("StudentID").text() + "','" + $(this).find("Guardian1").text() + danchorEnd;
                        $("td", row).eq(0).html($(this).find("Guardian1").text()).attr("valign", "top");
                        $("td", row).eq(1).html($(this).find("GName1").text()).attr("valign", "top");
                        $("td", row).eq(2).html($(this).find("GQual1").text()).attr("valign", "top");
                        $("td", row).eq(3).html($(this).find("GOcc1").text()).attr("valign", "top");
                        $("td", row).eq(4).html($(this).find("GInc1").text()).attr("valign", "top");
                        $("td", row).eq(5).html("<p style='word-wrap: break-word; width:300px;'>" + $(this).find("GAddr1").text() + "</p>");
                        $("td", row).eq(6).html($(this).find("GEmail1").text()).attr("valign", "top");
                        $("td", row).eq(7).html($(this).find("GPhno1").text()).attr("valign", "top");
                        $("td", row).eq(8).html(ehref).addClass("editacc edit-links").attr("valign", "top");
                        $("td", row).eq(9).html(dhref).addClass("deleteacc delete-links").attr("valign", "top");
                        $("[id*=dgRelationship]").append(row);
                        row = $("[id*=dgRelationship] tr:last-child").clone(true);
                    }

                    if ($(this).find("Guardian2").text() == "Guardian II") {
                        isRelationExist = 1;
                        var ehref = eanchor + $(this).find("StudentID").text() + "','" + $(this).find("Guardian2").text() + eanchorEnd;
                        var dhref = danchor + $(this).find("StudentID").text() + "','" + $(this).find("Guardian2").text() + danchorEnd;
                        $("td", row).eq(0).html($(this).find("Guardian2").text()).attr("valign", "top");
                        $("td", row).eq(1).html($(this).find("GName2").text()).attr("valign", "top");
                        $("td", row).eq(2).html($(this).find("GQual2").text()).attr("valign", "top");
                        $("td", row).eq(3).html($(this).find("GOcc2").text()).attr("valign", "top");
                        $("td", row).eq(4).html($(this).find("GInc2").text()).attr("valign", "top");
                        $("td", row).eq(5).html("<p style='word-wrap: break-word; width:300px;'>" + $(this).find("GAddr2").text() + "</p>");
                        $("td", row).eq(6).html($(this).find("GEmail2").text()).attr("valign", "top");
                        $("td", row).eq(7).html($(this).find("GPhno2").text()).attr("valign", "top");
                        $("td", row).eq(8).html(ehref).addClass("editacc edit-links").attr("valign", "top");
                        $("td", row).eq(9).html(dhref).addClass("deleteacc delete-links").attr("valign", "top");
                        $("[id*=dgRelationship]").append(row);
                        row = $("[id*=dgRelationship] tr:last-child").clone(true);
                    }


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

                });
            }
            var RegNo = $("[id*=hfRegNo]").val();
            if (RegNo != "") {
                GetBroSisInfo(RegNo);
                GetFamilyInfo(RegNo);
                ShowCurricular();
                ShowSkill();
                GetSportsInfo(RegNo);
                //GetFineArtsInfo(RegNo);
                // GetSkillInfo(RegNo);
                GetActivitiesInfo(RegNo);
                GetMedicalRemarkInfo(RegNo);
                GetAcademicRemarkInfo(RegNo);
                GetHostelInfo(RegNo);
                GetBusRouteDetails(0);
                GetStaffChildrenInfo(RegNo);
                GetOldSchoolInfo(RegNo);
                GetConcessionInfo(RegNo);
                GetNationalityInfo(RegNo);
                GetAttachmentInfo(RegNo);
                GetScholarshipInfo(RegNo);
                GetASSSportsInfo(RegNo);
                GetASSGeneralInfo(RegNo);
                GetASSWellnessInfo(RegNo);
            }
            else {
                GetBroSisInfo("-1");
                GetFamilyInfo("-1");
                GetMedicalRemarkInfo("-1");
                ShowCurricular();
                ShowSkill();
                GetSportsInfo("-1");
                //GetFineArtsInfo("-1");
                //GetSkillInfo("-1");
                GetActivitiesInfo("-1");
                GetAcademicRemarkInfo("-1");
                GetHostelInfo("-1");
                GetBusRouteDetails("-1");
                GetStaffChildrenInfo("-1");
                GetOldSchoolInfo("-1");
                GetConcessionInfo("-1");
                GetNationalityInfo("-1");
                GetAttachmentInfo("-1");
                GetScholarshipInfo("-1");
                GetASSSportsInfo("-1");
                GetASSGeneralInfo("-1");
                GetASSWellnessInfo("-1");

            }
        };



        $(document).ready(function () {
            setDatePicker("[id*=txtDOB]");
            setDatePicker("[id*=txtMedRemDate]");
            setDatePicker("[id*=txtDOJ]");
            setDatePicker("[id*=txtDateofHostelAdmn]");
            setDatePicker("[id*=txtDateofBusReg]");
            setDatePicker("[id*=txtAcaRemDate]");
            setDatePicker("[id*=txtTCDate]");
            setDatePicker("[id*=txtTCReceivedDate]");
            setDatePicker("[id*=txtPPDateofIssue]");
            setDatePicker("[id*=txtPPExpDate]");
            setDatePicker("[id*=txtVisaIssuedDate]");
            setDatePicker("[id*=txtVisaExpiryDate]");
            setDatePicker("[id*=txtValidity]");
            setDatePicker("[id*=txtDOA]");
            setDatePicker("[id*=txtCancellationDate]");

            //            if (window.location.hash == "#acc=1") {
            //                window.location.hash = '';
            //                window.location.href = window.location.href.replace('#', '');
            //                setInterval(loadtest, 1000);
            //            }
        });

        //        function loadtest() {
        //            ChangeAccordion(1);
        //        }
    </script>
    <%="<script src='" + ResolveUrl("~/js/ASPSnippets_Pager.min.js") + "' type='text/javascript'></script>"%>
    <script type="text/javascript">

        $(function () {


            if (window.FormData) {
                formdata = new FormData();
            }
            GetModuleMenuID('Fees/AdvanceFees.aspx');
            //        GetStudentInfos Function on page load
            $(".brosis").hide();

            var view = $("[id*=hfViewPrm]").val();
            if (view == 'true')
                var StudentID = $("[id*=hfStudentInfoID]").val();
            if (StudentID != "" && StudentID != "0") {
                GetStudentInfo(StudentID);
                $("[id*=btnAdvanceFees]").css("display", "none");
                $("[id*=spFeesSubmit]").html("Save & Pay Advance Fees");
                $("[id*=spPersonalSubmit]").html("Update");
                $("[id*=ddlStatus]").attr("disabled", false);
            }
            else {
                // GetStudentInfo("0");
                //                GetBroSisInfo("-1");
                //                GetFamilyInfo("-1");
                //                GetMedicalRemarkInfo("-1");
                //                GetAcademicRemarkInfo("-1");
                //                GetHostelInfo("-1");
                //                GetBusRouteDetails("-1");
                //                GetStaffChildrenInfo("-1");
                //                GetOldSchoolInfo("-1");
                //                GetConcessionInfo("-1");
                //                GetNationalityInfo("-1");
                //                GetAttachmentInfo("-1");

                GetSportsInfo("0");
                // GetFineArtsInfo("0");
                // GetSkillInfo("0");
                GetActivitiesInfo("0");
                var StudentInfos = "";

                row = $("[id*=dgRelationship] tr:last-child").clone(true);
                $("[id*=dgRelationship] tr").not($("[id*=dgRelationship] tr:first-child")).remove();
                var eanchor = ''
                var eanchorEnd = '';
                var danchor = ''
                var danchorEnd = '';
                if ($("[id*=hfEditPrm]").val() == 'false') {
                    eanchor = "<a>";
                    eanchorEnd = "</a>";
                }
                else {
                    eanchor = "<a  href=\"javascript:EditRelationshipInfo('";
                    eanchorEnd = "');\">Edit</a>";
                }
                if ($("[id*=hfDeletePrm]").val() == 'false') {
                    danchor = "<a>";
                    danchorEnd = "</a>";
                }
                else {
                    danchor = "<a  href=\"javascript:DeleteRelationshipInfo('";
                    danchorEnd = "');\">Delete</a>";
                }

                if (StudentInfos.length == 0) {
                    $("td", row).eq(0).html("");
                    $("td", row).eq(1).html("");
                    $("td", row).eq(2).html("");
                    $("td", row).eq(3).html("No Records Found").attr("align", "center");
                    $("td", row).eq(4).html("");
                    $("td", row).eq(5).html("");
                    $("td", row).eq(6).html("");
                    $("td", row).eq(7).html("");
                    $("td", row).eq(8).html("");
                    $("td", row).eq(9).html("");
                    // $("td", row).eq(10).html("");
                    $("[id*=dgRelationship]").append(row);
                    row = $("[id*=dgRelationship] tr:last-child").clone(true);

                }


                var BroSis = "";
                var row = $("[id*=dgBroSis] tr:last-child").clone(true);
                $("[id*=dgBroSis] tr").not($("[id*=dgBroSis] tr:first-child")).remove();
                var eanchor = ''
                var eanchorEnd = '';
                var danchor = ''
                var danchorEnd = '';
                if ($("[id*=hfEditPrm]").val() == 'false') {
                    eanchor = "<a>";
                    eanchorEnd = "</a>";
                }
                else {
                    eanchor = "<a  href=\"javascript:EditBroSisInfo('";
                    eanchorEnd = "');\">Edit</a>";
                }
                if ($("[id*=hfDeletePrm]").val() == 'false') {
                    danchor = "<a>";
                    danchorEnd = "</a>";
                }
                else {
                    danchor = "<a  href=\"javascript:DeleteBroSisInfo('";
                    danchorEnd = "');\">Delete</a>";
                }
                $("#chkBroSis").attr("checked", "false");
                showbrosis();
                if (BroSis.length == 0) {
                    $("td", row).eq(0).html("");
                    $("td", row).eq(1).html("");
                    $("td", row).eq(2).html("");
                    $("td", row).eq(3).html("No Records Found").attr("align", "center");
                    $("td", row).eq(4).html("");
                    $("td", row).eq(5).html("");
                    $("td", row).eq(6).html("").removeClass("editacc edit-links");
                    $("td", row).eq(7).html("").removeClass("deleteacc delete-links");
                    $("[id*=dgBroSis]").append(row);
                    row = $("[id*=dgBroSis] tr:last-child").clone(true);

                }
                var staffchild = "";
                var row = $("[id*=dgInstitution] tr:last-child").clone(true);
                $("[id*=dgInstitution] tr").not($("[id*=dgInstitution] tr:first-child")).remove();
                var eanchor = ''
                var eanchorEnd = '';
                var danchor = ''
                var danchorEnd = '';
                if ($("[id*=hfEditPrm]").val() == 'false') {
                    eanchor = "<a>";
                    eanchorEnd = "</a>";
                }
                else {
                    eanchor = "<a  href=\"javascript:EditStaffChildrenInfo('";
                    eanchorEnd = "');\">Edit</a>";
                }
                if ($("[id*=hfDeletePrm]").val() == 'false') {
                    danchor = "<a>";
                    danchorEnd = "</a>";
                }
                else {
                    danchor = "<a  href=\"javascript:DeleteStaffChildrenInfo('";
                    danchorEnd = "');\">Delete</a>";
                }


                if (staffchild.length == 0) {
                    $("td", row).eq(0).html("");
                    $("td", row).eq(1).html("");
                    $("td", row).eq(2).html("No Records Found").attr("align", "center");
                    $("td", row).eq(3).html("").removeClass("editacc edit-links"); ;
                    $("td", row).eq(4).html("").removeClass("deleteacc delete-links"); ;
                    $("td", row).eq(5).html("");
                    $("[id*=dgInstitution]").append(row);
                    row = $("[id*=dgInstitution] tr:last-child").clone(true);

                }

                var MedRem = "";
                var row = $("[id*=dgMedRemarks] tr:last-child").clone(true);
                $("[id*=dgMedRemarks] tr").not($("[id*=dgMedRemarks] tr:first-child")).remove();
                var eanchor = ''
                var eanchorEnd = '';
                var danchor = ''
                var danchorEnd = '';
                if ($("[id*=hfEditPrm]").val() == 'false') {
                    eanchor = "<a>";
                    eanchorEnd = "</a>";
                }
                else {
                    eanchor = "<a  href=\"javascript:EditMedRemarksInfo('";
                    eanchorEnd = "');\">Edit</a>";
                }
                if ($("[id*=hfDeletePrm]").val() == 'false') {
                    danchor = "<a>";
                    danchorEnd = "</a>";
                }
                else {
                    danchor = "<a  href=\"javascript:DeleteMedRemarksInfo('";
                    danchorEnd = "');\">Delete</a>";
                }


                if (MedRem.length == 0) {
                    $("td", row).eq(0).html("");
                    $("td", row).eq(1).html("");
                    $("td", row).eq(2).html("");
                    $("td", row).eq(3).html("No Records Found").attr("align", "center");
                    $("td", row).eq(4).html("");
                    $("td", row).eq(5).html("").removeClass("deleteacc delete-links");
                    $("td", row).eq(6).html("");
                    $("[id*=dgMedRemarks]").append(row);
                    row = $("[id*=dgMedRemarks] tr:last-child").clone(true);

                }


                var MedRem = "";
                var row = $("[id*=dgAcademicRemarks] tr:last-child").clone(true);
                $("[id*=dgAcademicRemarks] tr").not($("[id*=dgAcademicRemarks] tr:first-child")).remove();
                var eanchor = ''
                var eanchorEnd = '';
                var danchor = ''
                var danchorEnd = '';
                if ($("[id*=hfEditPrm]").val() == 'false') {
                    eanchor = "<a>";
                    eanchorEnd = "</a>";
                }
                else {
                    eanchor = "<a  href=\"javascript:EditAcademicRemarksInfo('";
                    eanchorEnd = "');\">Edit</a>";
                }
                if ($("[id*=hfDeletePrm]").val() == 'false') {
                    danchor = "<a>";
                    danchorEnd = "</a>";
                }
                else {
                    danchor = "<a  href=\"javascript:DeleteAcademicRemarksInfo('";
                    danchorEnd = "');\">Delete</a>";
                }


                if (MedRem.length == 0) {
                    $("td", row).eq(0).html("");
                    $("td", row).eq(1).html("");
                    $("td", row).eq(2).html("No Records Found").attr("align", "left");
                    $("td", row).eq(3).html();
                    $("td", row).eq(4).html("").removeClass("deleteacc delete-links"); ;
                    $("[id*=dgAcademicRemarks]").append(row);
                    row = $("[id*=dgAcademicRemarks] tr:last-child").clone(true);

                }
                var BusRoutes = "";
                var row = $("[id*=dgBusRoute] tr:last-child").clone(true);
                $("[id*=dgBusRoute] tr").not($("[id*=dgBusRoute] tr:first-child")).remove();

                var danchor = ''
                var danchorEnd = '';

                if ($("[id*=hfDeletePrm]").val() == 'false') {
                    danchor = "<a>";
                    danchorEnd = "</a>";
                }
                else {
                    danchor = "<a  href=\"javascript:DeleteBusRouteInfo('";
                    danchorEnd = "');\">Delete</a>";
                }

                if (BusRoutes.length == 0) {
                    $("td", row).eq(0).html("");
                    $("td", row).eq(1).html("");
                    $("td", row).eq(2).html("No Records").attr("align", "center");
                    $("td", row).eq(3).html("");
                    $("td", row).eq(4).html("");
                    $("td", row).eq(5).html("");
                    $("td", row).eq(6).html("").removeClass("deleteacc delete-links"); ;
                    $("[id*=dgBusRoute]").append(row);
                    row = $("[id*=dgBusRoute] tr:last-child").clone(true);

                }


                var Scholarships = "";
                var row = $("[id*=dgScholarship] tr:last-child").clone(true);
                $("[id*=dgScholarship] tr").not($("[id*=dgScholarship] tr:first-child")).remove();

                var danchor = ''
                var danchorEnd = '';

                if ($("[id*=hfDeletePrm]").val() == 'false') {
                    danchor = "<a>";
                    danchorEnd = "</a>";
                }
                else {
                    danchor = "<a  href=\"javascript:DeleteScholarshipInfo('";
                    danchorEnd = "');\">Delete</a>";
                }

                if (BusRoutes.length == 0) {
                    $("td", row).eq(0).html("");
                    $("td", row).eq(1).html("");
                    $("td", row).eq(2).html("No Records").attr("align", "center");
                    $("td", row).eq(3).html("").removeClass("deleteacc delete-links"); ;
                    $("[id*=dgScholarship]").append(row);
                    row = $("[id*=dgScholarship] tr:last-child").clone(true);
                }



                var oldschool = "";
                var row = $("[id*=dgOldSchool] tr:last-child").clone(true);
                $("[id*=dgOldSchool] tr").not($("[id*=dgOldSchool] tr:first-child")).remove();
                var eanchor = ''
                var eanchorEnd = '';
                var danchor = ''
                var danchorEnd = '';
                if ($("[id*=hfEditPrm]").val() == 'false') {
                    eanchor = "<a>";
                    eanchorEnd = "</a>";
                }
                else {
                    eanchor = "<a  href=\"javascript:EditOldSchoolInfo('";
                    eanchorEnd = "');\">Edit</a>";
                }
                if ($("[id*=hfDeletePrm]").val() == 'false') {
                    danchor = "<a>";
                    danchorEnd = "</a>";
                }
                else {
                    danchor = "<a  href=\"javascript:DeleteOldSchoolInfo('";
                    danchorEnd = "');\">Delete</a>";
                }


                if (oldschool.length == 0) {
                    $("td", row).eq(0).html("");
                    $("td", row).eq(1).html("");
                    $("td", row).eq(2).html("");
                    $("td", row).eq(3).html("");
                    $("td", row).eq(4).html("No Records Found").attr("align", "left");
                    $("td", row).eq(5).html("");
                    $("td", row).eq(6).html("");
                    $("td", row).eq(7).html("");
                    // $("td", row).eq(8).html("").removeClass("editacc edit-links"); ;
                    $("td", row).eq(8).html("").removeClass("deleteacc delete-links"); ;
                    $("td", row).eq(9).html("");
                    $("[id*=dgOldSchool]").append(row);
                    row = $("[id*=dgOldSchool] tr:last-child").clone(true);

                }

                var attachment = "";
                var row = $("[id*=dgAttachmentDetails] tr:last-child").clone(true);
                $("[id*=dgAttachmentDetails] tr").not($("[id*=dgAttachmentDetails] tr:first-child")).remove();
                var eanchor = ''
                var eanchorEnd = '';
                var danchor = ''
                var danchorEnd = '';
                if ($("[id*=hfEditPrm]").val() == 'false') {
                    eanchor = "<a>";
                    eanchorEnd = "</a>";
                }
                else {
                    eanchor = "<a  href=\"javascript:EditAttachmentInfo('";
                    eanchorEnd = "');\">Edit</a>";
                }
                if ($("[id*=hfDeletePrm]").val() == 'false') {
                    danchor = "<a>";
                    danchorEnd = "</a>";
                }
                else {
                    danchor = "<a  href=\"javascript:DeleteAttachmentInfo('";
                    danchorEnd = "');\">Delete</a>";
                }


                if (attachment.length == 0) {
                    $("td", row).eq(0).html("");
                    $("td", row).eq(1).html("");
                    $("td", row).eq(2).html("No Records Found").attr("align", "center");
                    $("td", row).eq(3).html("");
                    $("td", row).eq(4).html("").removeClass("deleteacc delete-links");
                    $("[id*=dgAttachmentDetails]").append(row);
                    row = $("[id*=dgAttachmentDetails] tr:last-child").clone(true);

                }

                $("[id*=btnAdvanceFees]").css("display", "inline-block");
                $("[id*=spFeesSubmit]").html("Save & Pay Advance Fees");
                $("[id*=spPersonalSubmit]").html("Save");

            }

            var add = $("[id*=hfAddPrm]").val();
            if (add == 'false') {
                $("table.form :input").prop('disabled', true);
            }
            else {
                $("table.form :input").prop('disabled', false);
            }

            // $("[id*=ddlAdSection]").attr("disabled", true);
            //  $("[id*=ddlAdClass]").attr("disabled", true);
            if (StudentID != "") {
                $("[id*=ddlStatus]").attr("disabled", false);
            } else {
                $("[id*=ddlStatus]").attr("disabled", true);
            }
            //            $("[id*=txtFirstlang]").val("English");
            //            $("[id*=txtFirstlang]").html("English");
            //$("[id*=txtDOA]").attr("disabled", true);

            GetSportsByClass();
        });

        function GetSectionByClass() {
            var Class = $("[id*=ddlClass]").val();
            if (Class != "") {

                $.ajax({
                    type: "POST",
                    url: "../Students/StudentInfo.aspx/GetSectionByClassID",
                    data: '{ClassID: ' + Class + '}',
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
        }


        function OnGetSectionByClassSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var cls = xml.find("SectionByClass");
            var select = $("[id*=ddlSection]");
            select.children().remove();
            select.append($("<option>").val('').text('Select'));
            $.each(cls, function () {
                var icls = $(this);
                var SectionID = $(this).find("SectionID").text();
                var SectionName = $(this).find("SectionName").text();
                select.append($("<option>").val(SectionID).text(SectionName));

            });
            //            $("[id*=ddlSection]").attr("disabled", true);
            if (FlagSectionID != -1)
                $("[id*=ddlSection] option[value='" + FlagSectionID + "']").attr("selected", "true");
        };


        function GetSportsByClass() {
            var Class = $("[id*=ddlClass]").val();
            var Status = $("[id*=ddlStatus]").val();
            if (Class != "" && Status != "") {

                $.ajax({
                    type: "POST",
                    url: "../Students/StudentInfo.aspx/BindSportFees",
                    data: '{ClassID: ' + Class + ',"Status": "' + Status + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnGetBindSportFeesSuccess,
                    failure: function (response) {
                        AlertMessage('info', response.d);
                    },
                    error: function (response) {
                        AlertMessage('info', response.d);
                    }
                });
            }
        }


        function OnGetBindSportFeesSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var cls = xml.find("SportFees");
            var select = $("[id*=ddlSportFees]");
            select.children().remove();
            select.append($("<option>").val('').text('Select'));
            $.each(cls, function () {
                var icls = $(this);
                var FeesCatHeadID = $(this).find("FeesCatHeadID").text();
                var FeesHeadName = $(this).find("FeesHeadName").text();
                select.append($("<option>").val(FeesCatHeadID).text(FeesHeadName));
                if (FlagFeesCatHeadID != -1)
                    $("[id*=ddlSportFees] option[value='" + FlagFeesCatHeadID + "']").attr("selected", "true");
            });
        };

        function GetAdSectionByAdClass() {
            var Class = $("[id*=ddlAdClass]").val();
            if (Class != "") {

                $.ajax({
                    type: "POST",
                    url: "../Students/StudentInfo.aspx/GetAdSectionByAdClassID",
                    data: '{ClassID: ' + Class + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnGetAdSectionByAdClassSuccess,
                    failure: function (response) {
                        AlertMessage('info', response.d);
                    },
                    error: function (response) {
                        AlertMessage('info', response.d);
                    }
                });
            }
        }


        function OnGetAdSectionByAdClassSuccess(response) {

            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var cls = xml.find("AdSectionByAdClass");
            var select = $("[id*=ddlAdSection]");
            select.children().remove();
            select.append($("<option>").val('').text('Select'));
            $.each(cls, function () {
                var icls = $(this);
                var SectionID = $(this).find("SectionID").text();
                var SectionName = $(this).find("SectionName").text();
                select.append($("<option>").val(SectionID).text(SectionName));

            });
            //            $("[id*=ddlAdSection]").attr("disabled", true);

            if (FlagAdSectionID != -1)
                $("[id*=ddlAdSection] option[value='" + FlagAdSectionID + "']").attr("selected", "true");
        };



        function GetBroSisSectionByBroSisClass() {
            var Class = $("[id*=ddlBroSisClass]").val();
            if (Class != "") {

                $.ajax({
                    type: "POST",
                    url: "../Students/StudentInfo.aspx/GetSectionByClassID",
                    data: '{ClassID: ' + Class + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnGetBroSisSectionByBroSisClassSuccess,
                    failure: function (response) {
                        AlertMessage('info', response.d);
                    },
                    error: function (response) {
                        AlertMessage('info', response.d);
                    }
                });

            }
        }
        function GetBlockByHostel(ID) {
            $.ajax({
                type: "POST",
                url: "../Students/StudentInfo.aspx/GetBlockByHostelID",
                data: '{HostelID: ' + ID + '}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnGetBlockByHostelIDSuccess,
                failure: function (response) {
                    AlertMessage('info', response.d);
                },
                error: function (response) {
                    AlertMessage('info', response.d);
                }
            });
        }
        function OnGetBlockByHostelIDSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var cls = xml.find("BlockByHostel");
            var select = $("[id*=ddlBlock]");
            select.children().remove();
            select.append($("<option>").val('').text('---Select---'));
            $.each(cls, function () {
                var icls = $(this);
                var BlockID = $(this).find("BlockID").text();
                var BlockName = $(this).find("BlockName").text();
                select.append($("<option>").val(BlockID).text(BlockName));
            });
            if (FlgBlockID != -1)
                $("[id*=ddlBlock] option[value='" + FlgBlockID + "']").attr("selected", "true");
            GetRoomByBlock();
        };
        function GetBusRouteDetails(ID) {
            var RegNo = $("[id*=hfRegNo]").val();
            if (ID == "0") {
                ID = "";
            }
            $.ajax({

                type: "POST",
                url: "../Students/StudentInfo.aspx/GetBusRouteInfo",
                data: '{"routecode": "' + ID + '","regno": "' + RegNo + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnGetBusRouteInfoSuccess,
                failure: function (response) {
                    AlertMessage('info', response.d);
                },
                error: function (response) {
                    AlertMessage('info', response.d);
                }
            });
        }
        function OnGetBusRouteInfoSuccess(response) {
            var iroute = "";
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var BusRoutes = xml.find("BusRoutes");
            var row = $("[id*=dgBusRoute] tr:last-child").clone(true);
            $("[id*=dgBusRoute] tr").not($("[id*=dgBusRoute] tr:first-child")).remove();

            var danchor = ''
            var danchorEnd = '';

            if ($("[id*=hfDeletePrm]").val() == 'false') {
                danchor = "<a>";
                danchorEnd = "</a>";
            }
            else {
                danchor = "<a  href=\"javascript:DeleteBusRouteInfo('";
                danchorEnd = "');\">Delete</a>";
            }

            if (BusRoutes.length == 0) {
                $("td", row).eq(0).html("");
                $("td", row).eq(1).html("");
                $("td", row).eq(2).html("");
                $("td", row).eq(3).html("No Records").attr("align", "left");
                $("td", row).eq(4).html("");
                $("td", row).eq(5).html("");
                $("td", row).eq(6).html("").removeClass("deleteacc delete-links"); ;
                $("[id*=dgBusRoute]").append(row);
                row = $("[id*=dgBusRoute] tr:last-child").clone(true);

            }
            else {
                $.each(BusRoutes, function () {

                    var BusRoute = $(this);
                    var dhref = danchor + $(this).find("BusRouteID").text() + danchorEnd;
                    row.addClass("even");
                    $("td", row).eq(0).html($(this).find("VehicleCode").text());
                    $("td", row).eq(1).html($(this).find("BusRouteName").text());
                    $("td", row).eq(2).html($(this).find("BusRouteCode").text());
                    $("td", row).eq(3).html($(this).find("Timings").text());
                    $("td", row).eq(4).html($(this).find("BusCharge").text());
                    $("td", row).eq(5).html($(this).find("DateofRegistration").text());
                    $("td", row).eq(6).html(dhref).addClass("deleteacc delete-links");
                    iroute = $(this).find("BusRouteID").text();

                    if ($("[id*=hfDeletePrm]").val() == 'false') {
                        $('.deleteacc').hide();
                    }
                    else {
                        $('.deleteacc').show();
                    }
                    $("[id*=ddlRouteCode]").val(iroute);
                    $("[id*=txtDateofBusReg]").val($(this).find("DateofRegistration").text());
                    $("[id*=dgBusRoute] tr:has(td)").remove();
                    $("[id*=dgBusRoute]").append(row);


                });
            }

            if (iroute) {
                $("[id*=rbtnBusYes]").attr("checked", true);
                ShowBus();
            }
            else {
                $("[id*=rbtnBusNo]").attr("checked", true);
            }
            var pager = xml.find("Pager");

            $(".Pager").ASPSnippets_Pager({
                ActiveCssClass: "current",
                PagerCssClass: "pager",
                PageIndex: parseInt(pager.find("PageIndex").text()),
                PageSize: parseInt(pager.find("PageSize").text()),
                RecordCount: parseInt(pager.find("RecordCount").text())
            });
        };

        //        function GetStudentBusRouteDetails(ID) {
        //            var RegNo = $("[id*=hfRegNo]").val();
        //            $.ajax({

        //                type: "POST",
        //                url: "../Students/StudentInfo.aspx/GetStudentBusRouteInfo",
        //                data: '{"regno": "' + RegNo + '"}',
        //                contentType: "application/json; charset=utf-8",
        //                dataType: "json",
        //                success: OnGetStudentBusRouteInfoSuccess,
        //                failure: function (response) {
        //                    AlertMessage('info', response.d);
        //                },
        //                error: function (response) {
        //                    AlertMessage('info', response.d);
        //                }
        //            });
        //        }
        //        function OnGetStudentBusRouteInfoSuccess(response) {
        //            var xmlDoc = $.parseXML(response.d);
        //            var xml = $(xmlDoc);
        //            var BusRoutes = xml.find("StudentBusRoutes");
        //            var row = $("[id*=dgBusRoute] tr:last-child").clone(true);
        //            $("[id*=dgBusRoute] tr").not($("[id*=dgBusRoute] tr:first-child")).remove();
        //            $.each(BusRoutes, function () {
        //                var BusRoute = $(this);
        //                row.addClass("even");
        //                $("td", row).eq(0).html($(this).find("VehicleCode").text());
        //                $("td", row).eq(1).html($(this).find("BusRouteName").text());
        //                $("td", row).eq(2).html($(this).find("BusRouteCode").text());
        //                $("td", row).eq(3).html($(this).find("Timings").text());
        //                $("td", row).eq(4).html($(this).find("BusCharge").text());
        //                $("td", row).eq(5).html($(this).find("DateofRegistration").text());
        //                $("[id*=dgBusRoute]").append(row);
        //                row = $("[id*=dgBusRoute] tr:last-child").clone(true);
        //            });
        //            var pager = xml.find("Pager");

        //            $(".Pager").ASPSnippets_Pager({
        //                ActiveCssClass: "current",
        //                PagerCssClass: "pager",
        //                PageIndex: parseInt(pager.find("PageIndex").text()),
        //                PageSize: parseInt(pager.find("PageSize").text()),
        //                RecordCount: parseInt(pager.find("RecordCount").text())
        //            });
        //        };

        function GetRoomByBlock() {
            var HostelID = $("[id*=ddlHostel]").val();
            var BlockID = $("[id*=ddlBlock]").val();
            $.ajax({
                type: "POST",
                url: "../Students/StudentInfo.aspx/GetRoomByBlock",
                data: '{"hostelid": "' + HostelID + '","blockid": "' + BlockID + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnGetRoomByBlockSuccess,
                failure: function (response) {
                    AlertMessage('info', response.d);
                },
                error: function (response) {
                    AlertMessage('info', response.d);
                }
            });
        }

        function OnGetRoomByBlockSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var cls = xml.find("RoomByBlock");
            var select = $("[id*=ddlRooms]");
            select.children().remove();
            select.append($("<option>").val('').text('---Select---'));
            $.each(cls, function () {
                var icls = $(this);
                var RoomID = $(this).find("RoomID").text();
                var RoomName = $(this).find("RoomName").text();
                select.append($("<option>").val(RoomID).text(RoomName));
            });
            if (FlgRoomID != -1)
                $("[id*=ddlRooms] option[value='" + FlgRoomID + "']").attr("selected", "true");
        };


        function OnGetBroSisSectionByBroSisClassSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var cls = xml.find("SectionByClass");
            var select = $("[id*=ddlBroSisSection]");
            select.children().remove();
            select.append($("<option>").val('').text('---Select---'));
            $.each(cls, function () {
                var icls = $(this);
                var SectionID = $(this).find("SectionID").text();
                var SectionName = $(this).find("SectionName").text();
                select.append($("<option>").val(SectionID).text(SectionName));

            });
            if (BroSisFlagSectionID != -1)
                $("[id*=ddlBroSisSection] option[value='" + BroSisFlagSectionID + "']").attr("selected", "true");
            GetBroSisStudentByBroSisSection();
        };


        function GetBroSisStudentByBroSisSection() {
            var Class = $("[id*=ddlBroSisClass]").val();
            var Section = $("[id*=ddlBroSisSection]").val();
            var Classname = $("[id*=ddlBroSisClass] option[value='" + Class + "']").html();
            var Sectionname = $("[id*=ddlBroSisSection] option[value='" + Section + "']").html();
            if (Sectionname == "---Select---") {
                Sectionname = '';
            }
            $.ajax({
                type: "POST",
                url: "../Students/StudentInfo.aspx/GetStudentBySection",
                data: '{"Class": "' + Classname + '","Section": "' + Sectionname + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnGetBroSisStudentByBroSisSectionSuccess,
                failure: function (response) {
                    AlertMessage('info', response.d);
                },
                error: function (response) {
                    AlertMessage('info', response.d);
                }
            });

        }

        function OnGetBroSisStudentByBroSisSectionSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var cls = xml.find("StudentBySection");
            var select = $("[id*=ddlBroSisStudentName]");
            select.children().remove();
            select.append($("<option>").val('').text('---Select---'));
            $.each(cls, function () {
                var icls = $(this);
                var StudentID = $(this).find("RegNo").text();
                var StudentName = $(this).find("StudentName").text();
                select.append($("<option>").val(StudentID).text(StudentName));

            });
            if (BroSisFlagStudentID != -1)
                $("[id*=ddlBroSisStudentName] option[value='" + BroSisFlagStudentID + "']").attr("selected", "true");
        };



        //GetStudentInfos Function

        function GetStudentInfo(ID) {
            if ($("[id*=hfViewPrm]").val() == 'true') {
                $.ajax({
                    type: "POST",
                    url: "../Students/StudentInfo.aspx/GetStudentInfo",
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

        var row = "";
        var FlagSectionID = -1;
        var FlagAdSectionID = -1;
        var isRelationExist = 0;
        function OnSuccess(response) {

            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var StudentInfos = xml.find("StudentInfo");
            var frelation = xml.find("FRelation");
            var mrelation = xml.find("MRelation");
            var Guardian1 = xml.find("Guardian1");
            var Guardian2 = xml.find("Guardian1");

            row = $("[id*=dgRelationship] tr:last-child").clone(true);
            $("[id*=dgRelationship] tr").not($("[id*=dgRelationship] tr:first-child")).remove();
            var eanchor = ''
            var eanchorEnd = '';
            var danchor = ''
            var danchorEnd = '';
            if ($("[id*=hfEditPrm]").val() == 'false') {
                eanchor = "<a>";
                eanchorEnd = "</a>";
            }
            else {
                eanchor = "<a  href=\"javascript:EditRelationshipInfo('";
                eanchorEnd = "');\">Edit</a>";
            }
            if ($("[id*=hfDeletePrm]").val() == 'false') {
                danchor = "<a>";
                danchorEnd = "</a>";
            }
            else {
                danchor = "<a  href=\"javascript:DeleteRelationshipInfo('";
                danchorEnd = "');\">Delete</a>";
            }

            if (StudentInfos.length == 0) {
                $("[id*=dgRelationship] tr").not($("[id*=dgRelationship] tr:first-child")).remove();
                $("td", row).eq(0).html("");
                $("td", row).eq(1).html("");
                $("td", row).eq(2).html("");
                $("td", row).eq(3).html("No Records Found").attr("align", "center");
                $("td", row).eq(4).html("");
                $("td", row).eq(5).html("");
                $("td", row).eq(6).html("");
                $("td", row).eq(7).html("");
                $("td", row).eq(8).html("");
                $("td", row).eq(9).html("");
                $("td", row).eq(10).html("");
                $("[id*=dgRelationship]").append(row);
                row = $("[id*=dgRelationship] tr:last-child").clone(true);

            }
            else {

                if (frelation.length == 0 && mrelation.length == 0 && Guardian1.length == 0 && Guardian2.length == 0) {
                    $("[id*=dgRelationship] tr").not($("[id*=dgRelationship] tr:first-child")).remove();
                    $("td", row).eq(0).html("");
                    $("td", row).eq(1).html("");
                    $("td", row).eq(2).html("");
                    $("td", row).eq(3).html("No Records Found").attr("align", "center");
                    $("td", row).eq(4).html("");
                    $("td", row).eq(5).html("");
                    $("td", row).eq(6).html("");
                    $("td", row).eq(7).html("");
                    $("td", row).eq(8).html("");
                    $("td", row).eq(9).html("");
                    $("td", row).eq(10).html("");
                    $("[id*=dgRelationship]").append(row);
                    row = $("[id*=dgRelationship] tr:last-child").clone(true);
                }
                $.each(StudentInfos, function () {

                    var SchoolType = $(this).find("SchoolType").text();

                    if (SchoolType == "ala") {
                        $("[id*=rbtnala]").attr("checked", true);
                    }
                    else if (SchoolType == "others") {
                        $("[id*=rbtnoutside]").attr("checked", true);
                    }
                    else if (SchoolType == "ahss") {
                        $("[id*=rbtnahss]").attr("checked", true);
                    }

                    var ClassID = $(this).find("ClassID").text();
                    $("[id*=ddlClass] option[value='" + ClassID + "']").attr("selected", "true");
                    FlagSectionID = $(this).find("SectionID").text();
                    GetSectionByClass();

                    $("[id*=hfStudentInfoID]").val($(this).find("StudentID").text());
                    $("[id*=hfRegNo]").val($(this).find("RegNo").text());
                    $("[id*=lblRegNo]").html($(this).find("RegNo").text());
                    $("[id*=lblASSRegNo]").html($(this).find("ASSNo").text());
                    $("[id*=lblStudentName]").html($(this).find("StudentName").text());
                    if ($(this).find("SectionID").text() == "") {
                        $("[id*=lblClass]").html($(this).find("Class").text() + " / " + "New")
                    }
                    else {
                        $("[id*=lblClass]").html($(this).find("Class").text() + " / " + $(this).find("Section").text())
                    }


                    $("[id*=txtStudentName]").val($(this).find("StudentName").text());


                    $("[id*=txtRegNo]").val($(this).find("RegNo").text());
                    $("[id*=txtConcessionReason]").val($(this).find("Reason").text());
                    var Gender = $(this).find("Gender").text();

                    if (Gender == "Male" || Gender == "M") {
                        $("[id*=rbtnMale]").attr("checked", true);
                    }
                    else if (Gender == "Female" || Gender == "F") {
                        $("[id*=rbtnFemale]").attr("checked", true);
                    }
                    $("[id*=txtDOB]").val($(this).find("DOB").text());
                    $("[id*=txtMotherTongue]").val($(this).find("MotherTongue").text());


                    var Religion = $(this).find("ReligionID").text();
                    $("[id*=ddlReligion] option[value='" + Religion + "']").attr("selected", "true");

                    var Community = $(this).find("CommunityID").text();
                    $("[id*=ddlCommunity] option[value='" + Community + "']").attr("selected", "true");

                    var Caste = $(this).find("CasteID").text();
                    $("[id*=ddlCaste] option[value='" + Caste + "']").attr("selected", "true");

                    $("[id*=txtAadhaar]").val($(this).find("AadhaarNo").text());
                    $("[id*=txtFatherAadhaar]").val($(this).find("FatherAadhaarNo").text());
                    $("[id*=txtMotherAadhaar]").val($(this).find("MotherAadhaarNo").text());
                    $("[id*=txtTempAddress]").val($(this).find("TempAddr").text());
                    $("[id*=txtPerAddress]").val($(this).find("PerAddr").text());
                    $("[id*=txtEmail]").val($(this).find("Email").text());
                    $("[id*=txtPhoneNo]").val($(this).find("PhoneNo").text());
                    $("[id*=txtRationCardNo]").val($(this).find("RationCardNo").text());
                    $("[id*=txtSmartCardNo]").val($(this).find("SmartCardNo").text());
                    $("[id*=txtSSLC]").val($(this).find("SSLCNo").text());
                    $("[id*=ddlSSLC]").val($(this).find("SSLCYear").text());
                    $("[id*=txtHSC]").val($(this).find("HSCNo").text());
                    $("[id*=ddlHSC]").val($(this).find("HSCYear").text());
                    $("[id*=txtSUID]").val($(this).find("SUID").text());
                    $("[id*=txtTamilname]").val($(this).find("tamilname").text());

                    var CareTaker = $(this).find("CareTaker").text();

                    if (CareTaker == "Parent") {
                        $("[id*=rbtnParent]").attr("checked", true);
                    }
                    else if (CareTaker == "Guardian") {
                        $("[id*=rbtnGuardian]").attr("checked", true);
                    }
                    var Sports = $(this).find("Sports").text();
                    if (Sports == "true") {
                        $("[id*=rbtnSports]").attr("checked", true);
                    }
                    else {
                        $("[id*=rbtnFine]").attr("checked", true);
                    }

                    var FineArts = $(this).find("FineArts").text();
                    if (FineArts == "true") {
                        $("[id*=rbtnFine]").attr("checked", true);
                    }
                    else {
                        $("[id*=rbtnSports]").attr("checked", true);
                    }

                    $("[id*=txtCurricularRemarks]").val($(this).find("CurricularRemarks").text());

                    var Skills = $(this).find("Skills").text();
                    if (Skills == "true") {
                        $("[id*=rbtnSkillYes]").attr("checked", true);
                    }
                    else {
                        $("[id*=rbtnSkillNo]").attr("checked", true);
                    }

                    $("[id*=txtSkillRemarks]").val($(this).find("SkillRemarks").text());

                    var PhotoFile = $(this).find("PhotoFile").text();
                    if (PhotoFile) {
                        $("[id*=img_prev]").attr('src', "../Students/Photos/" + PhotoFile.toString() + "?rand=" + Math.random()).width(114).height(114)
                    }
                    else {
                        $("[id*=img_prev]").attr('src', "../img/Photo.jpg").width(114).height(114);
                    }

                    $("[id*=ddlBloodGroup]").val($(this).find("BloodGroupID").text());
                    $("[id*=txtDisease]").val($(this).find("DisOrders").text());
                    $("[id*=txtHeight]").val($(this).find("Height").text());
                    $("[id*=txtWeight]").val($(this).find("Weight").text());
                    $("[id*=txtEmergencyPhNo]").val($(this).find("EmerPhNo").text());
                    $("[id*=txtFamilyDocName]").val($(this).find("Doctor").text());
                    $("[id*=txtFamilyDocAdd]").val($(this).find("DocAddr").text());
                    $("[id*=txtFamilyDocPhNo]").val($(this).find("DocPhNo").text());
                    if ($(this).find("IdMarks").text() != "") {
                        var IDnMarks = $(this).find("IdMarks").text().split(":");
                        if (IDnMarks.length > 1) {
                            $("[id*=txtIdentificationMarks1]").val(IDnMarks[0]);
                            $("[id*=txtIdentificationMarks2]").val(IDnMarks[1]);
                        }
                        else {
                            $("[id*=txtIdentificationMarks1]").val(IDnMarks[0]);
                            $("[id*=txtIdentificationMarks2]").val("");
                        }
                    }
                    if ($(this).find("Handicap").text() == "Y") {
                        $("[id*=rbtnPHYes]").attr('checked', true);
                    }
                    else {
                        $("[id*=rbtnNoPH]").attr('checked', true);
                    }
                    showphysical();
                    $("[id*=txtPhysicalHandicapped]").val($(this).find("HandicaptDetails").text());
                    $("[id*=txtAdmissionNo]").val($(this).find("AdmissionNo").text());

                    var AdClassID = $(this).find("AdClassID").text();
                    $("[id*=ddlAdClass] option[value='" + AdClassID + "']").attr("selected", "true");
                    FlagAdSectionID = $(this).find("AdSectionID").text();
                    GetAdSectionByAdClass();

                    $("[id*=txtDOJ]").val($(this).find("DOJ").text());
                    $("[id*=txtDOA]").val($(this).find("DOA").text());

                    var Mode = $(this).find("TransportId").text();
                    $("[id*=ddlModeofTrans] option[value='" + Mode + "']").attr("selected", "true");

                    $("[id*=ddlSchoolMedium]").val($(this).find("mediumID").text());
                    $("[id*=txtFirstlang]").val($(this).find("Firstlang").text());
                    //$("[id*=txtFirstlang]").html($(this).find("Firstlang").text());
                    $("[id*=ddlSeclang]").val($(this).find("Seclang").text());
                    var Scholar = $(this).find("Scholar").text();
                    if (Scholar == "Y") {
                        $("[id*=rbtnScholarYes]").attr("checked", true);
                    }
                    else {
                        $("[id*=rbtnNoScholar]").attr("checked", true);
                    }
                    ShowScholarship();

                    var Concession = $(this).find("Concession").text();

                    if (Concession == "Y") {
                        $("[id*=rbtnConcessYes]").attr("checked", true);
                    }
                    else {
                        $("[id*=rbtnNoConcess]").attr("checked", true);
                    }
                    ShowConcession();


                    var ScholarshipId = $(this).find("ScholarshipId").text();
                    // $("[id*=ddlScholarship] option[value='" + ScholarshipId + "']").attr("selected", "true");

                    $("[id*=hfAcademicyear]").val($(this).find("AcademicYear").text());
                    $("[id*=ddlStatus]").val($(this).find("Active").text());
                    $("[id*=lblStatus]").html($(this).find("Status").text());
                    GetSportsByClass();
                    row.addClass("even");

                    if ($(this).find("FRelation").text() == "Father") {
                        isRelationExist = 1;
                        var ehref = eanchor + $(this).find("StudentID").text() + "','" + $(this).find("FRelation").text() + eanchorEnd;
                        var dhref = danchor + $(this).find("StudentID").text() + "','" + $(this).find("FRelation").text() + danchorEnd;
                        $("td", row).eq(0).html($(this).find("FRelation").text()).attr("valign", "top");
                        $("td", row).eq(1).html($(this).find("FName").text()).attr("valign", "top");
                        $("td", row).eq(2).html($(this).find("FQual").text()).attr("valign", "top");
                        $("td", row).eq(3).html($(this).find("FOccupation").text()).attr("valign", "top");
                        $("td", row).eq(4).html($(this).find("FIncome").text()).attr("valign", "top");
                        $("td", row).eq(5).html("<p style='word-wrap: break-word; width:300px;'>" + $(this).find("FOccAddress").text() + "</p>");
                        $("td", row).eq(6).html($(this).find("FEmail").text()).attr("valign", "top");
                        $("td", row).eq(7).html($(this).find("FatherCell").text()).attr("valign", "top");
                        $("td", row).eq(8).html(ehref).addClass("editacc edit-links").attr("valign", "top");
                        $("td", row).eq(9).html(dhref).addClass("deleteacc delete-links").attr("valign", "top");
                        $("[id*=dgRelationship]").append(row);
                        row = $("[id*=dgRelationship] tr:last-child").clone(true);
                    }

                    if ($(this).find("MRelation").text() == "Mother") {
                        isRelationExist = 1;
                        var ehref = eanchor + $(this).find("StudentID").text() + "','" + $(this).find("MRelation").text() + eanchorEnd;
                        var dhref = danchor + $(this).find("StudentID").text() + "','" + $(this).find("MRelation").text() + danchorEnd;
                        $("td", row).eq(0).html($(this).find("MRelation").text()).attr("valign", "top");
                        $("td", row).eq(1).html($(this).find("MName").text()).attr("valign", "top");
                        $("td", row).eq(2).html($(this).find("MQual").text()).attr("valign", "top");
                        $("td", row).eq(3).html($(this).find("MOccupation").text()).attr("valign", "top");
                        $("td", row).eq(4).html($(this).find("MIncome").text()).attr("valign", "top");
                        $("td", row).eq(5).html("<p style='word-wrap: break-word;'>" + $(this).find("MOccAddress").text() + "</p>");
                        $("td", row).eq(6).html($(this).find("MEmail").text()).attr("valign", "top");
                        $("td", row).eq(7).html($(this).find("MotherCell").text()).attr("valign", "top");
                        $("td", row).eq(8).html(ehref).addClass("editacc edit-links").attr("valign", "top");
                        $("td", row).eq(9).html(dhref).addClass("deleteacc delete-links").attr("valign", "top");
                        $("[id*=dgRelationship]").append(row);
                        row = $("[id*=dgRelationship] tr:last-child").clone(true);
                    }

                    if ($(this).find("Guardian1").text() == "Guardian I") {
                        isRelationExist = 1;
                        var ehref = eanchor + $(this).find("StudentID").text() + "','" + $(this).find("Guardian1").text() + eanchorEnd;
                        var dhref = danchor + $(this).find("StudentID").text() + "','" + $(this).find("Guardian1").text() + danchorEnd;
                        $("td", row).eq(0).html($(this).find("Guardian1").text()).attr("valign", "top");
                        $("td", row).eq(1).html($(this).find("GName1").text()).attr("valign", "top");
                        $("td", row).eq(2).html($(this).find("GQual1").text()).attr("valign", "top");
                        $("td", row).eq(3).html($(this).find("GOcc1").text()).attr("valign", "top");
                        $("td", row).eq(4).html($(this).find("GInc1").text()).attr("valign", "top");
                        $("td", row).eq(5).html("<p style='word-wrap: break-word; width:300px;'>" + $(this).find("GAddr1").text() + "</p>");
                        $("td", row).eq(6).html($(this).find("GEmail1").text()).attr("valign", "top");
                        $("td", row).eq(7).html($(this).find("GPhno1").text()).attr("valign", "top");
                        $("td", row).eq(8).html(ehref).addClass("editacc edit-links").attr("valign", "top");
                        $("td", row).eq(9).html(dhref).addClass("deleteacc delete-links").attr("valign", "top");
                        $("[id*=dgRelationship]").append(row);
                        row = $("[id*=dgRelationship] tr:last-child").clone(true);
                    }

                    if ($(this).find("Guardian2").text() == "Guardian II") {
                        isRelationExist = 1;
                        var ehref = eanchor + $(this).find("StudentID").text() + "','" + $(this).find("Guardian2").text() + eanchorEnd;
                        var dhref = danchor + $(this).find("StudentID").text() + "','" + $(this).find("Guardian2").text() + danchorEnd;
                        $("td", row).eq(0).html($(this).find("Guardian2").text()).attr("valign", "top");
                        $("td", row).eq(1).html($(this).find("GName2").text()).attr("valign", "top");
                        $("td", row).eq(2).html($(this).find("GQual2").text()).attr("valign", "top");
                        $("td", row).eq(3).html($(this).find("GOcc2").text()).attr("valign", "top");
                        $("td", row).eq(4).html($(this).find("GInc2").text()).attr("valign", "top");
                        $("td", row).eq(5).html("<p style='word-wrap: break-word; width:300px;'>" + $(this).find("GAddr2").text() + "</p>");
                        $("td", row).eq(6).html($(this).find("GEmail2").text()).attr("valign", "top");
                        $("td", row).eq(7).html($(this).find("GPhno2").text()).attr("valign", "top");
                        $("td", row).eq(8).html(ehref).addClass("editacc edit-links").attr("valign", "top");
                        $("td", row).eq(9).html(dhref).addClass("deleteacc delete-links").attr("valign", "top");
                        $("[id*=dgRelationship]").append(row);
                        row = $("[id*=dgRelationship] tr:last-child").clone(true);
                    }


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

                });
            }
            var RegNo = $("[id*=hfRegNo]").val();
            if (RegNo != "") {
                GetBroSisInfo(RegNo);
                GetFamilyInfo(RegNo);
                ShowCurricular();
                ShowSkill();
                GetSportsInfo(RegNo);
                // GetFineArtsInfo(RegNo);
                //  GetSkillInfo(RegNo);
                GetActivitiesInfo(RegNo);
                GetMedicalRemarkInfo(RegNo);
                GetAcademicRemarkInfo(RegNo);
                GetHostelInfo(RegNo);
                GetBusRouteDetails(0);
                GetStaffChildrenInfo(RegNo);
                GetOldSchoolInfo(RegNo);
                GetConcessionInfo(RegNo);
                GetNationalityInfo(RegNo);
                GetAttachmentInfo(RegNo);
                GetScholarshipInfo(RegNo);
                GetASSSportsInfo(RegNo);
                GetASSGeneralInfo(RegNo);
                GetASSWellnessInfo(RegNo);
            }
            else {
                GetBroSisInfo("-1");
                //  GetFamilyInfo("-1");
                GetMedicalRemarkInfo("-1");
                ShowCurricular();
                ShowSkill();
                GetSportsInfo("-1");
                //GetFineArtsInfo("-1");
                // GetSkillInfo("-1");
                GetActivitiesInfo("-1");
                GetAcademicRemarkInfo("-1");
                GetHostelInfo("-1");
                GetBusRouteDetails("-1");
                GetStaffChildrenInfo("-1");
                GetOldSchoolInfo("-1");
                GetConcessionInfo("-1");
                GetNationalityInfo("-1");
                GetAttachmentInfo("-1");
                GetScholarshipInfo("-1");
                GetASSSportsInfo("-1");
                GetASSGeneralInfo("-1");
                GetASSWellnessInfo("-1");

            }
        };

        function GetFamilyInfo(RegNo) {
            if ($("[id*=hfViewPrm]").val() == 'true') {
                var StudentID = $("[id*=hfStudentInfoID]").val();
                if (StudentID == "") {
                    StudentID = "-1";
                }
                var StudentType = "";
                if ($("[id*=rbtnahss]").is(':checked')) {
                    StudentType = "ahss";
                }
                if ($("[id*=rbtnala]").is(':checked')) {
                    StudentType = "ala";
                }
                if ($("[id*=rbtnoutside]").is(':checked')) {
                    StudentType = "others";

                }

                $.ajax({
                    type: "POST",
                    url: "../Students/StudentInfo.aspx/GetFamilyInfo",
                    data: '{RegNo: ' + RegNo + ',"StudentType" : "' + StudentType + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnGetFamilyInfoSuccess,
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



        function OnGetFamilyInfoSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var family = xml.find("Family");
            var relation = xml.find("FRelation");
            row = $("[id*=dgRelationship] tr:last-child").clone(true);
            $("[id*=dgRelationship] tr").not($("[id*=dgRelationship] tr:first-child")).remove();
            var eanchor = ''
            var eanchorEnd = '';
            var danchor = ''
            var danchorEnd = '';
            if ($("[id*=hfEditPrm]").val() == 'false') {
                eanchor = "<a>";
                eanchorEnd = "</a>";
            }
            else {
                eanchor = "<a  href=\"javascript:EditRelationshipInfo('";
                eanchorEnd = "');\">Edit</a>";
            }
            if ($("[id*=hfDeletePrm]").val() == 'false') {
                danchor = "<a>";
                danchorEnd = "</a>";
            }
            else {
                danchor = "<a  href=\"javascript:DeleteRelationshipInfo('";
                danchorEnd = "');\">Delete</a>";
            }
            if (family.length == 0) {
                $("[id*=dgRelationship] tr").not($("[id*=dgRelationship] tr:first-child")).remove();
                $("td", row).eq(0).html("");
                $("td", row).eq(1).html("");
                $("td", row).eq(2).html("");
                $("td", row).eq(3).html("No Records Found").attr("align", "center");
                $("td", row).eq(4).html("");
                $("td", row).eq(5).html("");
                $("td", row).eq(6).html("");
                $("td", row).eq(7).html("");
                $("td", row).eq(8).html("");
                $("td", row).eq(9).html("");
                $("td", row).eq(10).html("");
                $("[id*=dgRelationship]").append(row);
                // row = $("[id*=dgRelationship] tr:last-child").clone(true);

            }
            else {


                $.each(family, function () {

                    if ($(this).find("FRelation").text() == "Father") {
                        isRelationExist = 1;
                        var ehref = eanchor + $(this).find("StudentID").text() + "','" + $(this).find("FRelation").text() + eanchorEnd;
                        var dhref = danchor + $(this).find("StudentID").text() + "','" + $(this).find("FRelation").text() + danchorEnd;
                        $("td", row).eq(0).html($(this).find("FRelation").text()).attr("valign", "top");
                        $("td", row).eq(1).html($(this).find("FName").text()).attr("valign", "top");
                        $("td", row).eq(2).html($(this).find("FQual").text()).attr("valign", "top");
                        $("td", row).eq(3).html($(this).find("FOccupation").text()).attr("valign", "top");
                        $("td", row).eq(4).html($(this).find("FIncome").text()).attr("valign", "top");
                        $("td", row).eq(5).html("<p style='word-wrap: break-word; width:300px;'>" + $(this).find("FOccAddress").text() + "</p>");
                        $("td", row).eq(6).html($(this).find("FEmail").text()).attr("valign", "top");
                        $("td", row).eq(7).html($(this).find("FatherCell").text()).attr("valign", "top");
                        $("td", row).eq(8).html(ehref).addClass("editacc edit-links").attr("valign", "top");
                        $("td", row).eq(9).html(dhref).addClass("deleteacc delete-links").attr("valign", "top");
                        $("[id*=dgRelationship]").append(row);
                        row = $("[id*=dgRelationship] tr:last-child").clone(true);
                    }

                    if ($(this).find("MRelation").text() == "Mother") {
                        isRelationExist = 1;
                        var ehref = eanchor + $(this).find("StudentID").text() + "','" + $(this).find("MRelation").text() + eanchorEnd;
                        var dhref = danchor + $(this).find("StudentID").text() + "','" + $(this).find("MRelation").text() + danchorEnd;
                        $("td", row).eq(0).html($(this).find("MRelation").text()).attr("valign", "top");
                        $("td", row).eq(1).html($(this).find("MName").text()).attr("valign", "top");
                        $("td", row).eq(2).html($(this).find("MQual").text()).attr("valign", "top");
                        $("td", row).eq(3).html($(this).find("MOccupation").text()).attr("valign", "top");
                        $("td", row).eq(4).html($(this).find("MIncome").text()).attr("valign", "top");
                        $("td", row).eq(5).html("<p style='word-wrap: break-word;'>" + $(this).find("MOccAddress").text() + "</p>");
                        $("td", row).eq(6).html($(this).find("MEmail").text()).attr("valign", "top");
                        $("td", row).eq(7).html($(this).find("MotherCell").text()).attr("valign", "top");
                        $("td", row).eq(8).html(ehref).addClass("editacc edit-links").attr("valign", "top");
                        $("td", row).eq(9).html(dhref).addClass("deleteacc delete-links").attr("valign", "top");
                        $("[id*=dgRelationship]").append(row);
                        row = $("[id*=dgRelationship] tr:last-child").clone(true);
                    }

                    if ($(this).find("Guardian1").text() == "Guardian I") {
                        isRelationExist = 1;
                        var ehref = eanchor + $(this).find("StudentID").text() + "','" + $(this).find("Guardian1").text() + eanchorEnd;
                        var dhref = danchor + $(this).find("StudentID").text() + "','" + $(this).find("Guardian1").text() + danchorEnd;
                        $("td", row).eq(0).html($(this).find("Guardian1").text()).attr("valign", "top");
                        $("td", row).eq(1).html($(this).find("GName1").text()).attr("valign", "top");
                        $("td", row).eq(2).html($(this).find("GQual1").text()).attr("valign", "top");
                        $("td", row).eq(3).html($(this).find("GOcc1").text()).attr("valign", "top");
                        $("td", row).eq(4).html($(this).find("GInc1").text()).attr("valign", "top");
                        $("td", row).eq(5).html("<p style='word-wrap: break-word; width:300px;'>" + $(this).find("GAddr1").text() + "</p>");
                        $("td", row).eq(6).html($(this).find("GEmail1").text()).attr("valign", "top");
                        $("td", row).eq(7).html($(this).find("GPhno1").text()).attr("valign", "top");
                        $("td", row).eq(8).html(ehref).addClass("editacc edit-links").attr("valign", "top");
                        $("td", row).eq(9).html(dhref).addClass("deleteacc delete-links").attr("valign", "top");
                        $("[id*=dgRelationship]").append(row);
                        row = $("[id*=dgRelationship] tr:last-child").clone(true);
                    }

                    if ($(this).find("Guardian2").text() == "Guardian II") {
                        isRelationExist = 1;
                        var ehref = eanchor + $(this).find("StudentID").text() + "','" + $(this).find("Guardian2").text() + eanchorEnd;
                        var dhref = danchor + $(this).find("StudentID").text() + "','" + $(this).find("Guardian2").text() + danchorEnd;
                        $("td", row).eq(0).html($(this).find("Guardian2").text()).attr("valign", "top");
                        $("td", row).eq(1).html($(this).find("GName2").text()).attr("valign", "top");
                        $("td", row).eq(2).html($(this).find("GQual2").text()).attr("valign", "top");
                        $("td", row).eq(3).html($(this).find("GOcc2").text()).attr("valign", "top");
                        $("td", row).eq(4).html($(this).find("GInc2").text()).attr("valign", "top");
                        $("td", row).eq(5).html("<p style='word-wrap: break-word; width:300px;'>" + $(this).find("GAddr2").text() + "</p>");
                        $("td", row).eq(6).html($(this).find("GEmail2").text()).attr("valign", "top");
                        $("td", row).eq(7).html($(this).find("GPhno2").text()).attr("valign", "top");
                        $("td", row).eq(8).html(ehref).addClass("editacc edit-links").attr("valign", "top");
                        $("td", row).eq(9).html(dhref).addClass("deleteacc delete-links").attr("valign", "top");
                        $("[id*=dgRelationship]").append(row);
                        row = $("[id*=dgRelationship] tr:last-child").clone(true);
                    }

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

                });
            }
        };




        function GetConcessionInfo(RegNo) {
            if ($("[id*=hfViewPrm]").val() == 'true') {
                var StudentID = $("[id*=hfStudentInfoID]").val();
                if (StudentID == "") {
                    StudentID = "-1";
                }

                $.ajax({
                    type: "POST",
                    url: "../Students/StudentInfo.aspx/GetConcessionInfo",
                    data: '{StudentID: ' + StudentID + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnGetConcessionInfoSuccess,
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
        function OnGetConcessionInfoSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var feescathead = xml.find("ConcessionInfo");

            $.each(feescathead, function () {
                var StudConcessID = $(this).find("StudConcessID").text();
                var ConcessionAmount = $(this).find("ConcessionAmount").text();
                var ConcessType = $(this).find("ConcessType").text();
                var ApprovalStatus = $(this).find("ApprovalStatus").text();
                $(".even").each(function () {
                    if (ConcessType == "F") {
                        var dgStudConcessID = $(this).find('td.StudConcessID').html();
                        if ((dgStudConcessID != null && StudConcessID != null) && (StudConcessID == dgStudConcessID)) {
                            $(this).find('input.ConcessionAmt').val(ConcessionAmount);
                            $(this).find('input.ConcessionAmt').attr("disabled", true);
                            return false;
                        }
                    }
                    else if (ConcessType == "P") {
                        var dgStudConcessID = $(this).find('td.StudConcessID').html();
                        if ((dgStudConcessID != null && StudConcessID != null) && (StudConcessID == dgStudConcessID)) {
                            $(this).find('input.ConcessionAmt').val(ConcessionAmount);
                            $(this).find('input.ConcessionAmt').attr("disabled", false);
                            return false;
                        }
                    }
                });
                if (ApprovalStatus) {
                    $("[id*=lblConcessStatus]").html(ApprovalStatus);
                    if (ApprovalStatus == "Approved") {
                        $("[id*=lblConcessStatus]").addClass("approved");
                    }
                    else if (ApprovalStatus == "Denied") {
                        $("[id*=lblConcessStatus]").addClass("denied");
                    }
                    else if (ApprovalStatus == "Pending") {
                        $("[id*=lblConcessStatus]").addClass("pending");
                    }

                }
                $("[id*=ddlConcession] option[value=" + ConcessType + "]").attr("selected", "true");

                ShowConcession();
            });

        };

        function GetHostelInfo(RegNo) {
            if ($("[id*=hfViewPrm]").val() == 'true') {
                $.ajax({
                    type: "POST",
                    url: "../Students/StudentInfo.aspx/GetHostelInfo",
                    data: '{regno: ' + RegNo + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnGetHostelInfoSuccess,
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
        var FlgBlockID = -1;
        var FlgRoomID = -1;
        function OnGetHostelInfoSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var rel = xml.find("HostelInfo");
            $.each(rel, function () {
                var HostelStatus;
                HostelStatus = $(this).find("HostelStatus").text();
                if (HostelStatus == "Y") {
                    $("[id*=rbtnHostelYes]").attr("checked", true);
                    ShowHostel();
                }
                else {
                    $("[id*=rbtnHostelNo]").attr("checked", true);
                }

                $("[id*=ddlHostel]").val($(this).find("HostelID").text());
                GetBlockByHostel($(this).find("HostelID").text());
                FlgBlockID = $(this).find("BlockID").text();
                FlgRoomID = $(this).find("RoomID").text();
                $("[id*=txtDateofHostelAdmn]").val($(this).find("DateofJoining").text());
            });
        };


        function GetAttachmentInfo(RegNo) {
            if ($("[id*=hfViewPrm]").val() == 'true') {
                $.ajax({
                    type: "POST",
                    url: "../Students/StudentInfo.aspx/GetAttachmentInfo",
                    data: '{regno: ' + RegNo + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnGetAttachmentInfoSuccess,
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


        function OnGetAttachmentInfoSuccess(response) {

            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var attachment = xml.find("Attachment");
            var row = $("[id*=dgAttachmentDetails] tr:last-child").clone(true);
            $("[id*=dgAttachmentDetails] tr").not($("[id*=dgAttachmentDetails] tr:first-child")).remove();
            var eanchor = ''
            var eanchorEnd = '';
            var danchor = ''
            var danchorEnd = '';
            if ($("[id*=hfEditPrm]").val() == 'false') {
                eanchor = "<a>";
                eanchorEnd = "</a>";
            }
            else {
                eanchor = "<a  href=\"javascript:EditAttachmentInfo('";
                eanchorEnd = "');\">Edit</a>";
            }
            if ($("[id*=hfDeletePrm]").val() == 'false') {
                danchor = "<a>";
                danchorEnd = "</a>";
            }
            else {
                danchor = "<a  href=\"javascript:DeleteAttachmentInfo('";
                danchorEnd = "');\">Delete</a>";
            }


            if (attachment.length == 0) {
                $("td", row).eq(0).html("");
                $("td", row).eq(1).html("");
                $("td", row).eq(2).html("No Records Found").attr("align", "center");
                $("td", row).eq(3).html("").removeClass("download-links");
                $("td", row).eq(4).html("").removeClass("deleteacc delete-links");
                $("[id*=dgAttachmentDetails]").append(row);
                row = $("[id*=dgAttachmentDetails] tr:last-child").clone(true);

            }


            else {
                $.each(attachment, function () {
                    row.addClass("even");
                    var ehref = eanchor + $(this).find("StudAttachID").text() + eanchorEnd;
                    var dhref = danchor + $(this).find("StudAttachID").text() + danchorEnd;
                    $("td", row).eq(0).html($(this).find("RowNumber").text());
                    $("td", row).eq(1).html($(this).find("Title").text());
                    $("td", row).eq(2).html($(this).find("Description").text());
                    $("td", row).eq(3).html("<a target='_blank' href=../Students/Attachments/" + $(this).find("FileName").text() + ">" + $(this).find("FileName").text() + "</a>").addClass("download-links");
                    // $("td", row).eq(4).html(ehref).addClass("editacc edit-links");
                    $("td", row).eq(4).html(dhref).addClass("deleteacc delete-links");
                    $("[id*=dgAttachmentDetails]").append(row);
                    row = $("[id*=dgAttachmentDetails] tr:last-child").clone(true);


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



        function GetNationalityInfo(RegNo) {
            if ($("[id*=hfViewPrm]").val() == 'true') {
                $.ajax({
                    type: "POST",
                    url: "../Students/StudentInfo.aspx/GetNationalityInfo",
                    data: '{regno: ' + RegNo + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnGetNationalityInfoSuccess,
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
        function OnGetNationalityInfoSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var rel = xml.find("National");
            $.each(rel, function () {
                var IsNative;
                IsNative = $(this).find("IsNatIndia").text();
                if (IsNative == "Y") {
                    $("[id*=rbtnIndian]").attr("checked", true);
                    $("[id*=rbtnOverseas]").attr("checked", false);
                }
                else {
                    $("[id*=rbtnIndian]").attr("checked", false);
                    $("[id*=rbtnOverseas]").attr("checked", true);
                }
                ShowNationality();
                $("[id*=txtNationality]").val($(this).find("Nationality").text());
                $("[id*=txtPassportNo]").val($(this).find("PassPortNo").text());
                $("[id*=txtPPDateofIssue]").val($(this).find("DateOfIssue").text());
                $("[id*=txtPPExpDate]").val($(this).find("ExpiryDate").text());
                $("[id*=txtVisaNumber]").val($(this).find("VisaNo").text());
                $("[id*=txtVisaIssuedDate]").val($(this).find("VisaIssueDate").text());
                $("[id*=txtVisaExpiryDate]").val($(this).find("VisaExpiryDate").text());
                $("[id*=txtVisaType]").val($(this).find("VisaType").text());
                $("[id*=txtPurpose]").val($(this).find("PurposeOfVisit").text());
                $("[id*=txtNoOfEntry]").val($(this).find("NoOfEntry").text());
                $("[id*=txtValidity]").val($(this).find("Validity").text());
                $("[id*=txtRemark]").val($(this).find("Remarks").text());
            });
        };
        var FlgFeesType = "";
        function GetConcession(FeesType) {

            FlgFeesType = $("[id*=ddlConcession]").val();
            if (FlgFeesType == "F") {
                $(".even").each(function () {
                    var AcutalAmt = $(this).find('.ActualAmount').html();
                    if (AcutalAmt != "" && AcutalAmt != null) {
                        $(this).find('.ConcessionAmt').val(AcutalAmt);
                        $(this).find('input.ConcessionAmt').attr("disabled", true);

                    }
                });

            }
            else {
                $(".even").each(function () {
                    $(this).find('.ConcessionAmt').val("");
                    $(this).find('input.ConcessionAmt').attr("disabled", false);
                });
            }

        }

        function SaveConcessionFees() {
            if ($("[id*=ddlConcession]").val() == "") {
                AlertMessage('info', "Select Concession Type !!! ");
            }
            else {
                var AdmissionNo = $("[id*=ddlSection]").val(); //txtAdmissionNo
                if (AdmissionNo != "0" && AdmissionNo != "") {
                    GetInsertQuery();
                }
                else {
                    AlertMessage('info', "This student not yet admitted, Concession can't applicable !!! ");
                }
            }


        }
        function GetInsertQuery() {
            var RegNo = $("[id*=hfRegNo]").val();
            var StudentInfoID = $("[id*=hfStudentInfoID]").val();
            var Academicyear = $("[id*=hfAcademicyear]").val();

            var parameters = '{"StudentInfoID": "' + StudentInfoID + '"}';
            $.ajax({
                type: "POST",
                url: "../Students/StudentInfo.aspx/GetFeesAmount",
                data: parameters,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnGetFeesAmountSuccess,
                failure: function (response) {
                    AlertMessage('info', response.d);
                },
                error: function (response) {
                    AlertMessage('info', response.d);
                }
            });

        };
        function OnGetFeesAmountSuccess(response) {
            var iCount = 0;
            var sqlstr = "";
            var subQuery = "";
            var MonthName = "";
            var formonth = "";
            var mon = response.d;
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            $(".even").each(function () {
                var dgStudConcessID = $(this).find('td.StudConcessID').html();
                var FeesHeadID = $(this).find('td.FeesHeadID').html();
                var Academicyear = $("[id*=hfAcademicyear]").val();
                var RegNo = $("[id*=hfRegNo]").val();
                var StudentInfoID = $("[id*=hfStudentInfoID]").val();
                var ConcessAmt = $(this).find('input.ConcessionAmt').val();
                var concessFeesType = $("[id*=ddlConcession]").val();
                var UserId = $("[id*=hfUserId]").val();
                if (ConcessAmt == "") {
                    ConcessAmt = "0.00";
                }

                //                if (dgStudConcessID != null && dgStudConcessID != "" && dgStudConcessID != "&nbsp;") {
                //                    if (ConcessAmt != "" && ConcessAmt != null) {
                //                        iCount = iCount + 1;
                //                        subQuery = "update s_studentconcession set [AcademicId]='" + Academicyear + "',[FeesCatHeadId]='" + FeesHeadID + "',[ConcessType]='" + concessFeesType + "',[RegNo]='" + RegNo + "',[ConcessAmt]='" + ConcessAmt + "',[IsActive]=1,[UserId]='" + UserId + "' where StudConcessID='" + dgStudConcessID + "'";
                //                        sqlstr += subQuery;
                //                    }
                //                }
                //                else {
                //                    if (ConcessAmt != "" && ConcessAmt != null) {
                //                        iCount = iCount + 1;
                //                        subQuery = "insert into s_studentconcession ([AcademicId],[FeesCatHeadId],[ConcessType],[RegNo],[ConcessAmt],[IsActive],[UserId]) values('" + Academicyear + "','" + FeesHeadID + "','" + concessFeesType + "','" + RegNo + "','" + ConcessAmt + "','1','" + UserId + "');";
                //                        sqlstr += subQuery;
                //                    }
                //                }

                if (ConcessAmt != "" && ConcessAmt != null) {
                    iCount = iCount + 1;
                    subQuery = "insert into s_studentconcession ([AcademicId],[FeesCatHeadId],[ConcessType],[RegNo],[ConcessAmt],[IsActive],[UserId]) values('" + Academicyear + "','" + FeesHeadID + "','" + concessFeesType + "','" + RegNo + "','" + ConcessAmt + "','0','" + UserId + "');";
                    sqlstr += subQuery;
                }

            });
            if (iCount == 0) {
                AlertMessage('info', 'Enter Any Concession Amount !');
            }
            else {
                var RegNo = $("[id*=hfRegNo]").val();
                var ConcessReason = $("[id*=txtConcessionReason]").val();
                var Concess;
                if ($("[id*=rbtnConcessYes]").is(':checked')) {
                    Concess = "Y";
                }

                else if ($("[id*=rbtnNoConcess]").is(':checked')) {
                    Concess = "N";
                }
                var parameters = '{"query": "' + sqlstr + '","ConcessReason": "' + ConcessReason + '","RegNo": "' + RegNo + '","Concess": "' + Concess + '"}';
                sqlstr = "";
                $.ajax({
                    type: "POST",
                    url: "../Students/StudentInfo.aspx/SaveConcessionFeesDetails",
                    data: parameters,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnSaveConcessionFeesDetailsSuccess,
                    failure: function (response) {
                        AlertMessage('info', response.d);
                    },
                    error: function (response) {
                        AlertMessage('info', response.d);
                    }
                });
            }
        }

        function OnSaveConcessionFeesDetailsSuccess(response) {
            var currentPage = $("[id*=currentPage]").text();
            if (response.d == "Updated") {
                AlertMessage('success', 'Updated');
                var RegNo = $("[id*=hfRegNo]").val();
                var StudentID = $("[id*=hfStudentInfoID]").val();
                GetStudentInfo(StudentID);
                changeAccordion(10);

            }
            else if (response.d == "Update Failed") {
                AlertMessage('fail', 'Update');
            }
            else if (response.d == "Inserted") {
                AlertMessage('success', 'Inserted');
                var RegNo = $("[id*=hfRegNo]").val();
                var StudentID = $("[id*=hfStudentInfoID]").val();
                GetStudentInfo(StudentID);
                changeAccordion(10);
            }
            else if (response.d == "Insert Failed") {
                AlertMessage('fail', 'Insert');
            }
        };

        function GetOldSchoolInfo(RegNo) {
            if ($("[id*=hfViewPrm]").val() == 'true') {
                $.ajax({
                    type: "POST",
                    url: "../Students/StudentInfo.aspx/GetOldSchoolInfo",
                    data: '{regno: ' + RegNo + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnGetOldSchoolInfoSuccess,
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

        function OnGetOldSchoolInfoSuccess(response) {

            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var oldschool = xml.find("OldSchool");
            var row = $("[id*=dgOldSchool] tr:last-child").clone(true);
            $("[id*=dgOldSchool] tr").not($("[id*=dgOldSchool] tr:first-child")).remove();
            var eanchor = ''
            var eanchorEnd = '';
            var danchor = ''
            var danchorEnd = '';
            if ($("[id*=hfEditPrm]").val() == 'false') {
                eanchor = "<a>";
                eanchorEnd = "</a>";
            }
            else {
                eanchor = "<a  href=\"javascript:EditOldSchoolInfo('";
                eanchorEnd = "');\">Edit</a>";
            }
            if ($("[id*=hfDeletePrm]").val() == 'false') {
                danchor = "<a>";
                danchorEnd = "</a>";
            }
            else {
                danchor = "<a  href=\"javascript:DeleteOldSchoolInfo('";
                danchorEnd = "');\">Delete</a>";
            }


            if (oldschool.length == 0) {
                $("td", row).eq(0).html("");
                $("td", row).eq(1).html("");
                $("td", row).eq(2).html("");
                $("td", row).eq(3).html("");
                $("td", row).eq(4).html("");
                $("td", row).eq(5).html("No Records Found").attr("align", "center");
                $("td", row).eq(6).html("");
                $("td", row).eq(7).html("");
                //  $("td", row).eq(8).html("").removeClass("editacc edit-links"); ;
                $("td", row).eq(8).html("").removeClass("deleteacc delete-links"); ;
                $("td", row).eq(9).html("");
                $("[id*=dgOldSchool]").append(row);
                row = $("[id*=dgOldSchool] tr:last-child").clone(true);

            }


            else {
                $.each(oldschool, function () {
                    row.addClass("even");
                    var ehref = eanchor + $(this).find("StudOldSchID").text() + "','" + $(this).find("RegNo").text() + eanchorEnd;
                    var dhref = danchor + $(this).find("StudOldSchID").text() + danchorEnd;
                    $("td", row).eq(0).html($(this).find("RowNumber").text());
                    $("td", row).eq(1).html($(this).find("SchoolName").text());
                    $("td", row).eq(2).html($(this).find("Academicyear").text());
                    $("td", row).eq(3).html($(this).find("StdStudied").text());
                    $("td", row).eq(4).html($(this).find("Firstlanguage").text());
                    $("td", row).eq(5).html($(this).find("Medium").text());
                    $("td", row).eq(6).html($(this).find("TCNo").text());
                    $("td", row).eq(7).html($(this).find("TCDate").text());
                    $("td", row).eq(8).html($(this).find("TCReceivedDate").text());
                    //   $("td", row).eq(8).html(ehref).addClass("editacc edit-links");
                    $("td", row).eq(9).html(dhref).addClass("deleteacc delete-links");
                    $("[id*=dgOldSchool]").append(row);
                    row = $("[id*=dgOldSchool] tr:last-child").clone(true);


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

        function EditOldSchoolInfo(StudOldSchID, RegNo) {

            if ($("[id*=hfEditPrm]").val() == 'true') {
                $("table.form :input").prop('disabled', false);
                $.ajax({
                    type: "POST",
                    url: "../Students/StudentInfo.aspx/EditOldSchoolInfo",
                    data: '{StudOldSchID: ' + StudOldSchID + ',"RegNo": "' + RegNo + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnEditOldSchoolInfoSuccess,
                    failure: function (response) {
                        AlertMessage('info', response.d);
                    },
                    error: function (response) {
                        AlertMessage('info', response.d);
                    }
                });
            }
            else {
                $("table.form :input").prop('disabled', true);
                return false;
            }
        }

        function OnEditOldSchoolInfoSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var rel = xml.find("OldSchool");
            $.each(rel, function () {
                $("[id*=txtSchoolName]").val($(this).find("SchoolName").text());
                $("[id*=ddlFirstLang]").val($(this).find("Firstlanguage").text());
                $("[id*=ddlMedium]").val($(this).find("Medium").text());
                $("[id*=ddlStartAcademicYr]").val($(this).find("StartAcademicyear").text());
                $("[id*=ddlEndAcademicYr]").val($(this).find("EndAcademicyear").text());
                $("[id*=txtStdFrom]").val($(this).find("StdStudied").text());
                $("[id*=txtTCNo]").val($(this).find("TCNo").text());
                $("[id*=txtTCReceivedDate]").val($(this).find("TCReceivedDate").text());
                $("[id*=txtTCDate]").val($(this).find("TCDate").text());
            });
        };

        function DeleteBusRouteInfo(BusRouteId) {
            var RegNo = $("[id*=hfRegNo]").val();
            if (jConfirm('Are you sure to delete this?', 'Confirm', function (r) {
                if (r) {
                    $.ajax({
                        type: "POST",
                        url: "../Students/StudentInfo.aspx/DeleteBusRouteInfo",
                        data: '{RegNo: ' + RegNo + ',BusRouteId: ' + BusRouteId + '}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: OnDeleteBusRouteInfoSuccess,
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
        function OnDeleteBusRouteInfoSuccess(response) {
            var currentPage = $("[id*=currentPage]").text();
            if (response.d == "Deleted") {
                AlertMessage('success', 'Deleted');
                var RegNo = $("[id*=hfRegNo]").val();
                if (RegNo != "") {
                    $("[id*=ddlRouteCode]").val("");
                    $("[id*=txtDateofBusReg]").val("");
                    GetBusRouteDetails(0);

                }
            }
            else if (response.d == "Delete Failed") {
                AlertMessage('fail', 'Delete');
            }
        };


        function DeleteAttachmentInfo(StudAttachID) {

            if (jConfirm('Are you sure to delete this?', 'Confirm', function (r) {
                if (r) {
                    $.ajax({

                        type: "POST",
                        url: "../Students/StudentInfo.aspx/DeleteAttachmentInfo",
                        data: '{StudAttachID: ' + StudAttachID + '}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: OnDeleteAttachmentInfoSuccess,
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
        function OnDeleteAttachmentInfoSuccess(response) {
            var currentPage = $("[id*=currentPage]").text();
            if (response.d == "Deleted") {
                AlertMessage('success', 'Deleted');
                var RegNo = $("[id*=hfRegNo]").val();
                if (RegNo != "") {
                    GetAttachmentInfo(RegNo);
                }
            }
            else if (response.d == "Delete Failed") {
                AlertMessage('fail', 'Delete');
            }
        };


        function DeleteBroSisInfo(StudRelID) {

            if (jConfirm('Are you sure to delete this?', 'Confirm', function (r) {
                if (r) {
                    $.ajax({

                        type: "POST",
                        url: "../Students/StudentInfo.aspx/DeleteBroSisInfo",
                        data: '{StudRelID: ' + StudRelID + '}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: OnDeleteBroSisInfoSuccess,
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
        function OnDeleteBroSisInfoSuccess(response) {
            var currentPage = $("[id*=currentPage]").text();
            if (response.d == "Deleted") {
                AlertMessage('success', 'Deleted');
                var RegNo = $("[id*=hfRegNo]").val();
                if (RegNo != "") {
                    GetBroSisInfo(RegNo);
                }
            }
            else if (response.d == "Delete Failed") {
                AlertMessage('fail', 'Delete');
            }
        };



        function DeleteOldSchoolInfo(StudOldSchID) {

            if (jConfirm('Are you sure to delete this?', 'Confirm', function (r) {
                if (r) {
                    $.ajax({

                        type: "POST",
                        url: "../Students/StudentInfo.aspx/DeleteOldSchoolInfo",
                        data: '{StudOldSchID: ' + StudOldSchID + '}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: OnDeleteOldSchoolInfoSuccess,
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
        function OnDeleteOldSchoolInfoSuccess(response) {
            var currentPage = $("[id*=currentPage]").text();
            if (response.d == "Deleted") {
                AlertMessage('success', 'Deleted');
                var RegNo = $("[id*=hfRegNo]").val();
                if (RegNo != "") {
                    GetOldSchoolInfo(RegNo);
                }
            }
            else if (response.d == "Delete Failed") {
                AlertMessage('fail', 'Delete');
            }
        };
        function GetStaffChildrenInfo(RegNo) {
            if ($("[id*=hfViewPrm]").val() == 'true') {
                $.ajax({
                    type: "POST",
                    url: "../Students/StudentInfo.aspx/GetStaffChildrenInfo",
                    data: '{regno: ' + RegNo + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnGetStaffChildrenInfoSuccess,
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
        function EditStaffChildrenInfo(StudStaffID, Relationship) {

            if ($("[id*=hfEditPrm]").val() == 'true') {
                $("table.form :input").prop('disabled', false);
                $.ajax({
                    type: "POST",
                    url: "../Students/StudentInfo.aspx/EditStaffChildrenInfo",
                    data: '{StudStaffID: ' + StudStaffID + ',"Relationship": "' + Relationship + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnEditStaffChildrenSuccess,
                    failure: function (response) {
                        AlertMessage('info', response.d);
                    },
                    error: function (response) {
                        AlertMessage('info', response.d);
                    }
                });
            }
            else {
                $("table.form :input").prop('disabled', true);
                return false;
            }
        }

        function OnEditStaffChildrenSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var rel = xml.find("StaffChildren");
            $.each(rel, function () {

                $("[id*=ddlStaff1] option[value='" + $(this).find("EmpCode").text() + "']").attr("selected", "true");
                $("[id*=ddlRelationship1] option[value='" + $(this).find("Relationship").text() + "']").attr("selected", "true");



            });
        };
        function chkpriority() {
            if ($("[id*=hfRegNo]").val() != '') {
                var regno = $("[id*=hfRegNo]").val();
                var str = "select isnull(priority,0) as smspriority from s_studentinfo where regno=" + regno;
                $.ajax({
                    type: "POST",
                    url: "../Students/StudentInfo.aspx/chkpriority",
                    data: '{str: "' + str + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        var xmlDoc = $.parseXML(response.d);
                        var xml = $(xmlDoc);
                        var rel = xml.find("priority");
                        $.each(rel, function () {
                            if ($(this).find("smspriority").text() == "0") {
                                AlertMessage('info', "SMS Prioriy is not yet Set, Do You Want to Set For " + $("[id*=dlRelationship]").val() + "? ");
                                $("[id*=dlSMSPriority]").focus();
                            }
                        });
                    }
                });
            }

        }

        function OnGetStaffChildrenInfoSuccess(response) {

            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var staffchild = xml.find("StaffChildren");
            var row = $("[id*=dgInstitution] tr:last-child").clone(true);
            $("[id*=dgInstitution] tr").not($("[id*=dgInstitution] tr:first-child")).remove();
            var eanchor = ''
            var eanchorEnd = '';
            var danchor = ''
            var danchorEnd = '';
            if ($("[id*=hfEditPrm]").val() == 'false') {
                eanchor = "<a>";
                eanchorEnd = "</a>";
            }
            else {
                eanchor = "<a  href=\"javascript:EditStaffChildrenInfo('";
                eanchorEnd = "');\">Edit</a>";
            }
            if ($("[id*=hfDeletePrm]").val() == 'false') {
                danchor = "<a>";
                danchorEnd = "</a>";
            }
            else {
                danchor = "<a  href=\"javascript:DeleteStaffChildrenInfo('";
                danchorEnd = "');\">Delete</a>";
            }


            if (staffchild.length == 0) {
                $("td", row).eq(0).html("");
                $("td", row).eq(1).html("");
                $("td", row).eq(2).html("No Records Found").attr("align", "center");
                $("td", row).eq(3).html("").removeClass("editacc edit-links"); ;
                $("td", row).eq(4).html("").removeClass("deleteacc delete-links"); ;
                $("td", row).eq(5).html("");
                $("[id*=dgInstitution]").append(row);
                row = $("[id*=dgInstitution] tr:last-child").clone(true);

            }

            else {
                $.each(staffchild, function () {
                    row.addClass("even");
                    $("#rbtnInsNo").attr("checked", false);
                    $("#rbtnInsYes").attr("checked", true);
                    ShowInstitution();
                    var ehref = eanchor + $(this).find("StudStaffID").text() + "','" + $(this).find("Relationship").text() + eanchorEnd;
                    var dhref = danchor + $(this).find("StudStaffID").text() + danchorEnd;
                    $("td", row).eq(0).html($(this).find("RowNumber").text());
                    $("td", row).eq(1).html($(this).find("StaffName").text());
                    $("td", row).eq(2).html($(this).find("Relationship").text());
                    $("td", row).eq(3).html(ehref).addClass("editacc edit-links");
                    $("td", row).eq(4).html(dhref).addClass("deleteacc delete-links");
                    $("[id*=dgInstitution]").append(row);
                    row = $("[id*=dgInstitution] tr:last-child").clone(true);


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

        function DeleteStaffChildrenInfo(StudStaffID, Relation) {

            if (jConfirm('Are you sure to delete this?', 'Confirm', function (r) {
                if (r) {
                    $.ajax({

                        type: "POST",
                        url: "../Students/StudentInfo.aspx/DeleteStaffChildrenInfo",
                        data: '{StudStaffID: ' + StudStaffID + ',"Relation": "' + Relation + '"}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: OnDeleteStaffChildrenInfoSuccess,
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
        function OnDeleteStaffChildrenInfoSuccess(response) {
            var currentPage = $("[id*=currentPage]").text();
            if (response.d == "Deleted") {
                AlertMessage('success', 'Deleted');
                var RegNo = $("[id*=hfRegNo]").val();
                if (RegNo != "") {
                    GetStaffChildrenInfo(RegNo);
                }
            }
            else if (response.d == "Delete Failed") {
                AlertMessage('fail', 'Delete');
            }
        };




        function GetMedicalRemarkInfo(RegNo) {
            if ($("[id*=hfViewPrm]").val() == 'true') {
                $.ajax({
                    type: "POST",
                    url: "../Students/StudentInfo.aspx/GetMedicalRemarkInfo",
                    data: '{regno: ' + RegNo + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnGetMedicalRemarkInfoSuccess,
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

        function OnGetMedicalRemarkInfoSuccess(response) {

            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var MedRem = xml.find("MedicalRemark");
            var row = $("[id*=dgMedRemarks] tr:last-child").clone(true);
            $("[id*=dgMedRemarks] tr").not($("[id*=dgMedRemarks] tr:first-child")).remove();
            var eanchor = ''
            var eanchorEnd = '';
            var danchor = ''
            var danchorEnd = '';
            if ($("[id*=hfEditPrm]").val() == 'false') {
                eanchor = "<a>";
                eanchorEnd = "</a>";
            }
            else {
                eanchor = "<a  href=\"javascript:EditMedRemarksInfo('";
                eanchorEnd = "');\">Edit</a>";
            }
            if ($("[id*=hfDeletePrm]").val() == 'false') {
                danchor = "<a>";
                danchorEnd = "</a>";
            }
            else {
                danchor = "<a  href=\"javascript:DeleteMedRemarksInfo('";
                danchorEnd = "');\">Delete</a>";
            }


            if (MedRem.length == 0) {
                $("td", row).eq(0).html("");
                $("td", row).eq(1).html("");
                $("td", row).eq(2).html("");
                $("td", row).eq(3).html("No Records Found").attr("align", "center");
                $("td", row).eq(4).html("").removeClass("download-links");
                $("td", row).eq(5).html("").removeClass("deleteacc delete-links");
                $("td", row).eq(6).html("");
                $("[id*=dgMedRemarks]").append(row);
                row = $("[id*=dgMedRemarks] tr:last-child").clone(true);

            }
            else {

                $.each(MedRem, function () {
                    row.addClass("even");
                    var ehref = eanchor + $(this).find("MedRemarkID").text() + eanchorEnd;
                    var dhref = danchor + $(this).find("MedRemarkID").text() + danchorEnd;
                    $("td", row).eq(0).html($(this).find("RowNumber").text());
                    $("td", row).eq(1).html($(this).find("RegNo").text());
                    $("td", row).eq(2).html($(this).find("RemarkDate").text());
                    $("td", row).eq(3).html($(this).find("Description").text());
                    $("td", row).eq(4).html("<a target='_blank' href=../Students/MedicalRemarks/" + $(this).find("FileName").text() + ">" + $(this).find("FileName").text() + "</a>").addClass("download-links");
                    // $("td", row).eq(6).html(ehref).addClass("editacc edit-links");
                    $("td", row).eq(5).html(dhref).addClass("deleteacc delete-links");
                    $("[id*=dgMedRemarks]").append(row);
                    row = $("[id*=dgMedRemarks] tr:last-child").clone(true);


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

        function DeleteMedRemarksInfo(MedRemarkId) {
            if (jConfirm('Are you sure to delete this?', 'Confirm', function (r) {
                if (r) {
                    $.ajax({

                        type: "POST",
                        url: "../Students/StudentInfo.aspx/DeleteMedicalRemarkInfo",
                        data: '{MedRemarkId: ' + MedRemarkId + '}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: OnDeleteMedicalRemarkSuccess,
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
        function OnDeleteMedicalRemarkSuccess(response) {
            var currentPage = $("[id*=currentPage]").text();
            if (response.d == "Deleted") {
                AlertMessage('success', 'Deleted');
                var RegNo = $("[id*=hfRegNo]").val();
                if (RegNo != "") {
                    GetMedicalRemarkInfo(RegNo);
                }
            }
            else if (response.d == "Delete Failed") {
                AlertMessage('fail', 'Delete');
            }
        };




        function GetAcademicRemarkInfo(RegNo) {
            if ($("[id*=hfViewPrm]").val() == 'true') {
                $.ajax({
                    type: "POST",
                    url: "../Students/StudentInfo.aspx/GetAcademicRemarkInfo",
                    data: '{regno: ' + RegNo + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnGetAcademicRemarkInfoSuccess,
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

        function OnGetAcademicRemarkInfoSuccess(response) {

            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var MedRem = xml.find("AcademicRemark");
            var row = $("[id*=dgAcademicRemarks] tr:last-child").clone(true);
            $("[id*=dgAcademicRemarks] tr").not($("[id*=dgAcademicRemarks] tr:first-child")).remove();
            var eanchor = ''
            var eanchorEnd = '';
            var danchor = ''
            var danchorEnd = '';
            if ($("[id*=hfEditPrm]").val() == 'false') {
                eanchor = "<a>";
                eanchorEnd = "</a>";
            }
            else {
                eanchor = "<a  href=\"javascript:EditAcademicRemarksInfo('";
                eanchorEnd = "');\">Edit</a>";
            }
            if ($("[id*=hfDeletePrm]").val() == 'false') {
                danchor = "<a>";
                danchorEnd = "</a>";
            }
            else {
                danchor = "<a  href=\"javascript:DeleteAcademicRemarksInfo('";
                danchorEnd = "');\">Delete</a>";
            }


            if (MedRem.length == 0) {
                $("td", row).eq(0).html("");
                $("td", row).eq(1).html("");
                $("td", row).eq(2).html("No Records Found").attr("align", "left");
                $("td", row).eq(3).html();
                $("td", row).eq(4).html("").removeClass("deleteacc delete-links"); ;
                $("[id*=dgAcademicRemarks]").append(row);
                row = $("[id*=dgAcademicRemarks] tr:last-child").clone(true);

            }

            else {
                $.each(MedRem, function () {
                    row.addClass("even");
                    var ehref = eanchor + $(this).find("RemarkID").text() + eanchorEnd;
                    var dhref = danchor + $(this).find("RemarkID").text() + danchorEnd;
                    $("td", row).eq(0).html($(this).find("RowNumber").text());
                    $("td", row).eq(1).html($(this).find("RegNo").text());
                    $("td", row).eq(2).html($(this).find("RemarkDate").text());
                    $("td", row).eq(3).html($(this).find("Remarks").text());
                    // $("td", row).eq(6).html(ehref).addClass("editacc edit-links");
                    $("td", row).eq(4).html(dhref).addClass("deleteacc delete-links");
                    $("[id*=dgAcademicRemarks]").append(row);
                    row = $("[id*=dgAcademicRemarks] tr:last-child").clone(true);


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

        function DeleteAcademicRemarksInfo(RemarkId) {
            if (jConfirm('Are you sure to delete this?', 'Confirm', function (r) {
                if (r) {
                    $.ajax({

                        type: "POST",
                        url: "../Students/StudentInfo.aspx/DeleteAcademicRemarkInfo",
                        data: '{RemarkId: ' + RemarkId + '}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: OnDeleteAcademicRemarkSuccess,
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
        function OnDeleteAcademicRemarkSuccess(response) {
            var currentPage = $("[id*=currentPage]").text();
            if (response.d == "Deleted") {
                AlertMessage('success', 'Deleted');
                var RegNo = $("[id*=hfRegNo]").val();
                if (RegNo != "") {
                    GetAcademicRemarkInfo(RegNo);
                }
            }
            else if (response.d == "Delete Failed") {
                AlertMessage('fail', 'Delete');
            }
        };



        function GetBroSisInfo(RegNo) {
            if ($("[id*=hfViewPrm]").val() == 'true') {
                $.ajax({
                    type: "POST",
                    url: "../Students/StudentInfo.aspx/GetBroSisInfo",
                    data: '{regno: ' + RegNo + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnGetBroSisInfoSuccess,
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

        function OnGetBroSisInfoSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var BroSis = xml.find("BroSis");
            var row = $("[id*=dgBroSis] tr:last-child").clone(true);
            $("[id*=dgBroSis] tr").not($("[id*=dgBroSis] tr:first-child")).remove();
            var eanchor = ''
            var eanchorEnd = '';
            var danchor = ''
            var danchorEnd = '';
            if ($("[id*=hfEditPrm]").val() == 'false') {
                eanchor = "<a>";
                eanchorEnd = "</a>";
            }
            else {
                eanchor = "<a  href=\"javascript:EditBroSisInfo('";
                eanchorEnd = "');\">Edit</a>";
            }
            if ($("[id*=hfDeletePrm]").val() == 'false') {
                danchor = "<a>";
                danchorEnd = "</a>";
            }
            else {
                danchor = "<a  href=\"javascript:DeleteBroSisInfo('";
                danchorEnd = "');\">Delete</a>";
            }
            $("#chkBroSis").attr("checked", "false");
            showbrosis();
            if (BroSis.length == 0) {
                $("td", row).eq(0).html("");
                $("td", row).eq(1).html("");
                $("td", row).eq(2).html("");
                $("td", row).eq(3).html("No Records Found").attr("align", "center");
                $("td", row).eq(4).html("");
                $("td", row).eq(5).html("");
                $("td", row).eq(6).html("").removeClass("editacc edit-links");
                $("td", row).eq(7).html("").removeClass("deleteacc delete-links"); ;
                $("[id*=dgBroSis]").append(row);
                row = $("[id*=dgBroSis] tr:last-child").clone(true);

            }
            else {
                $("#chkBroSis").attr("checked", "true");
                showbrosis();
                $.each(BroSis, function () {
                    row.addClass("even");
                    var ehref = eanchor + $(this).find("RegNo").text() + "','" + $(this).find("StudRelID").text() + eanchorEnd;
                    var dhref = danchor + $(this).find("StudRelID").text() + danchorEnd;
                    $("td", row).eq(0).html($(this).find("RowNumber").text());
                    $("td", row).eq(1).html($(this).find("RegNo").text());
                    $("td", row).eq(2).html($(this).find("Relation").text());
                    $("td", row).eq(3).html($(this).find("StudentName").text());
                    $("td", row).eq(4).html($(this).find("Class").text());
                    $("td", row).eq(5).html($(this).find("Section").text());
                    $("td", row).eq(6).html(ehref).addClass("editacc edit-links");
                    $("td", row).eq(7).html(dhref).addClass("deleteacc delete-links");
                    $("[id*=dgBroSis]").append(row);
                    row = $("[id*=dgBroSis] tr:last-child").clone(true);


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

        function EditBroSisInfo(ID, relationId) {
            if (ID == "" || ID == null) {
                ID = "0";
            }
            if ($("[id*=hfEditPrm]").val() == 'true') {
                $("table.form :input").prop('disabled', false);
                $.ajax({

                    type: "POST",
                    url: "../Students/StudentInfo.aspx/EditBroSisInfo",
                    data: '{regno: ' + ID + ',"relationId": "' + relationId + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnEditBroSisSuccess,
                    failure: function (response) {
                        AlertMessage('info', response.d);
                    },
                    error: function (response) {
                        AlertMessage('info', response.d);
                    }
                });
            }
            else {
                $("table.form :input").prop('disabled', true);
                return false;
            }
        }
        var BroSisFlagSectionID = -1;
        var BroSisFlagStudentID = -1;
        function OnEditBroSisSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var rel = xml.find("EditBroSis");
            $.each(rel, function () {
                var ClassID = $(this).find("ClassID").text();
                $("[id*=ddlBroSisClass] option[value='" + ClassID + "']").attr("selected", "true");
                BroSisFlagSectionID = $(this).find("SectionID").text();
                GetBroSisSectionByBroSisClass();
                var StudentRelationID = $(this).find("StudentRelationID").text();
                BroSisFlagStudentID = StudentRelationID;


                var Relation = $(this).find("Relation").text();
                $("[id*=ddlBroSisRelation] option[value='" + Relation.toUpperCase() + "']").attr("selected", "true");

            });
        };

        function DeleteRelationshipInfo(ID, type) {
            if ($("[id*=hfEditPrm]").val() == 'true') {
                $("table.form :input").prop('disabled', false);
                $.ajax({

                    type: "POST",
                    url: "../Students/StudentInfo.aspx/DeleteRelationshipInfo",
                    data: '{studentid: ' + ID + ',"type": "' + type + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnDeleteRelationshipSuccess,
                    failure: function (response) {
                        AlertMessage('info', response.d);
                    },
                    error: function (response) {
                        AlertMessage('info', response.d);
                    }
                });
            }
            else {
                $("table.form :input").prop('disabled', true);
                return false;
            }
        }

        function OnDeleteRelationshipSuccess(response) {
            var currentPage = $("[id*=currentPage]").text();
            if (response.d == "Deleted") {
                AlertMessage('success', 'Deleted');
                var StudentID = $("[id*=hfStudentInfoID]").val();
                GetStudentInfo(StudentID);

            }
            else if (response.d == "Delete Failed") {
                AlertMessage('fail', 'Delete');
            }
        };

        function EditRelationshipInfo(ID, type) {
            if ($("[id*=hfEditPrm]").val() == 'true') {
                $("table.form :input").prop('disabled', false);
                $.ajax({

                    type: "POST",
                    url: "../Students/StudentInfo.aspx/EditRelationshipInfo",
                    data: '{studentid: ' + ID + ',"type": "' + type + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnEditRelationshipSuccess,
                    failure: function (response) {
                        AlertMessage('info', response.d);
                    },
                    error: function (response) {
                        AlertMessage('info', response.d);
                    }
                });
            }
            else {
                $("table.form :input").prop('disabled', true);
                return false;
            }
        }

        function OnEditRelationshipSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var rel = xml.find("EditRelationship");
            $.each(rel, function () {
                if ($(this).find("Relation").text() == "Father") {
                    $("[id*=ddlRelationship] option[value='" + $(this).find("Relation").text() + "']").attr("selected", "true");
                    $("[id*=ddlSMSPriority] option[value='" + $(this).find("Priority").text() + "']").attr("selected", "true");
                }
                else if ($(this).find("Relation").text() == "Mother") {
                    $("[id*=ddlRelationship] option[value='" + $(this).find("Relation").text() + "']").attr("selected", "true");
                    $("[id*=ddlSMSPriority] option[value='" + $(this).find("Priority").text() + "']").attr("selected", "true");
                }
                else {
                    $("[id*=ddlRelationship] option[value='" + $(this).find("Relation").text() + "']").attr("selected", "true");
                    $("[id*=ddlSMSPriority] option[value='" + $(this).find("Priority").text() + "']").attr("selected", "true");
                }
                $("[id*=txtName]").val($(this).find("Name").text());
                $("[id*=txtOccupation]").val($(this).find("Occupation").text());
                $("[id*=txtIncome]").val($(this).find("Income").text());
                $("[id*=txtOccAddress]").val($(this).find("OccAddress").text());
                $("[id*=txtQualification]").val($(this).find("Qual").text());
                $("[id*=txtRelMobile]").val($(this).find("Cell").text());
                $("[id*=txtRelEmail]").val($(this).find("RelEmail").text());

            });
        };


        function SaveandPayAdvanceFees() {
            if (($("[id*=hfAddPrm]").val() == 'true') || ($("[id*=hfEditPrm]").val() == 'true')
            ) {
                if ($('#aspnetForm').valid()) {
                    $("[id*=btnAdvanceFees]").attr("disabled", "true");
                    var StudentInfoID = $("[id*=hfStudentInfoID]").val();
                    var StudentName = $("[id*=txtStudentName]").val();
                    var Gender;
                    if ($("[id*=rbtnMale]").is(':checked')) {
                        Gender = "M";
                    }

                    else if ($("[id*=rbtnFemale]").is(':checked')) {
                        Gender = "F";
                    }
                    var Class = $("[id*=ddlClass]").val();
                    var Classname = $("[id*=ddlClass] option[value='" + Class + "']").html();

                    var Section = $("[id*=ddlSection]").val();
                    var Sectionname = $("[id*=ddlSection] option[value='" + Section + "']").html();

                    var DOB = $("[id*=txtDOB]").val();
                    var DOJ = $("[id*=txtDOJ]").val();
                    var MotherTongue = $("[id*=txtMotherTongue]").val();
                    var Religion = $("[id*=ddlReligion]").val();
                    var Community = $("[id*=ddlCommunity]").val();
                    var Caste = $("[id*=ddlCaste]").val();
                    var Aadhaar = $("[id*=txtAadhaar]").val();
                    var FatherAadhaar = $("[id*=txtFatherAadhaar]").val();
                    var MotherAadhaar = $("[id*=txtMotherAadhaar]").val();
                    var TempAddress = $("[id*=txtTempAddress]").val();
                    var PerAddress = $("[id*=txtPerAddress]").val();
                    var Email = $("[id*=txtEmail]").val();
                    var PhoneNo = $("[id*=txtPhoneNo]").val();
                    var RationCard = $("[id*=txtRationCardNo]").val();
                    var SmartCard = $("[id*=txtSmartCardNo]").val();
                    var tempfile = $('#FuPhoto').val().replace(/C:\\fakepath\\/i, ''); ;
                    var PhotoFile = tempfile.substring(tempfile.lastIndexOf('\\') + 1);
                    var PhotoPath = $('#FuPhoto').val().replace(/C:\\fakepath\\/i, ''); ;
                    var SSLCNo = $("[id*=txtSSLC]").val();
                    var SSLCYear = $("[id*=ddlSSLC]").val();
                    var HSCNo = $("[id*=txtHSC]").val();
                    var HSCYear = $("[id*=ddlHSC]").val();
                    var SUID = $("[id*=txtSUID]").val();
                    var Tamilname = $("[id*=txtTamilname]").val();

                    if (Section == "New") {
                        Section = "";
                    }
                    var Academicyear = $("[id*=hfAcademicyear]").val();
                    var parameters = '{"id": "' + StudentInfoID + '","studentname": "' + StudentName + '","classname": "' + Classname + '","classid": "' + Class + '","sectionname": "' + Section + '","gender": "' + Gender + '","dob": "' + DOB + '","doj": "' + DOJ + '","religion": "' + Religion + '","mtongue": "' + MotherTongue + '","community": "' + Community + '","caste": "' + Caste + '","aadhaar": "' + Aadhaar + '","fatheraadhaar": "' + FatherAadhaar + '","motheraadhaar": "' + MotherAadhaar + '","tempaddress": "' + TempAddress + '","peraddress": "' + PerAddress + '","email": "' + Email + '","phoneno": "' + PhoneNo + '","smartcard": "' + SmartCard + '","rationcard": "' + RationCard + '","photopath": "' + PhotoPath + '","photofile": "' + PhotoFile + '","sslcno": "' + SSLCNo + '","sslcyear": "' + SSLCYear + '","hscno": "' + HSCNo + '","hscyear": "' + HSCYear + '","suid": "' + SUID + '","tamilname": "' + Tamilname + '","academicyear": "' + Academicyear + '","academicyear": "' + Academicyear + '"}';
                    $.ajax({
                        type: "POST",
                        url: "../Students/StudentInfo.aspx/SaveandPayAdvanceFees",
                        data: parameters,
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: OnSaveandPayAdvanceFeesSuccess,
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
                return false;
            }
        }

        // Save On Success
        function OnSaveandPayAdvanceFeesSuccess(response) {
            var currentPage = $("[id*=currentPage]").text();
            if (response.d) {
                AlertMessage('success', 'Inserted');
                $("[id*=hfRegNo]").val(response.d);
                var RegNo = $("[id*=hfRegNo]").val();
                var url = "../Fees/AdvanceFees.aspx?menuId=" + $("[id*=hfAdvMenuId]").val() + "&activeIndex=" + $("[id*=hdnIndex]").val() + "&moduleId=" + $("[id*=hfAdvModuleID]").val() + "&RegNo=" + RegNo + "";
                $(location).attr('href', url)
            }
            else if (response.d == "Insert Failed") {
                AlertMessage('fail', 'Insert');
            }


        };



        // Save StudentInfo
        function SavePersonalDetails() {
            if (($("[id*=hfAddPrm]").val() == 'true') || ($("[id*=hfEditPrm]").val() == 'true')
            ) {
                if ($('#aspnetForm').valid()) {
                    var StudentInfoID = $("[id*=hfStudentInfoID]").val();
                    var StudentName = $("[id*=txtStudentName]").val();
                    var Regno = $("[id*=txtSearchRegNo]").val();
                    var StudentType = "";
                    if ($("[id*=rbtnahss]").is(':checked')) {
                        StudentType = "ahss";
                    }
                    if ($("[id*=rbtnala]").is(':checked')) {
                        StudentType = "ala";
                    }
                    if ($("[id*=rbtnoutside]").is(':checked')) {
                        StudentType = "others";

                    }
                    var Gender;
                    if ($("[id*=rbtnMale]").is(':checked')) {
                        Gender = "M";
                    }

                    else if ($("[id*=rbtnFemale]").is(':checked')) {
                        Gender = "F";
                    }
                    var Class = $("[id*=ddlClass]").val();
                    var Classname = $("[id*=ddlClass] option[value='" + Class + "']").html();

                    var Section = $("[id*=ddlSection]").val();
                    var Sectionname = $("[id*=ddlSection] option[value='" + Section + "']").html();

                    var DOB = $("[id*=txtDOB]").val();
                    var DOJ = $("[id*=txtDOJ]").val();
                    var MotherTongue = $("[id*=txtMotherTongue]").val();
                    var Religion = $("[id*=ddlReligion]").val();
                    var Community = $("[id*=ddlCommunity]").val();
                    var Caste = $("[id*=ddlCaste]").val();
                    var Aadhaar = $("[id*=txtAadhaar]").val();
                    var FatherAadhaar = $("[id*=txtFatherAadhaar]").val();
                    var MotherAadhaar = $("[id*=txtMotherAadhaar]").val();
                    var TempAddress = $("[id*=txtTempAddress]").val();
                    var PerAddress = $("[id*=txtPerAddress]").val();
                    var Email = $("[id*=txtEmail]").val();
                    var PhoneNo = $("[id*=txtPhoneNo]").val();
                    var RationCard = $("[id*=txtRationCardNo]").val();
                    var SmartCard = $("[id*=txtSmartCardNo]").val();
                    var tempfile = $('#FuPhoto').val().replace(/C:\\fakepath\\/i, ''); ;
                    var PhotoFile = tempfile.substring(tempfile.lastIndexOf('\\') + 1);
                    var PhotoPath = $('#FuPhoto').val().replace(/C:\\fakepath\\/i, ''); ;
                    var sstatus = $("[id*=ddlStatus]").val();
                    var SSLCNo = $("[id*=txtSSLC]").val();
                    var SSLCYear = $("[id*=ddlSSLC]").val();
                    var HSCNo = $("[id*=txtHSC]").val();
                    var HSCYear = $("[id*=ddlHSC]").val();
                    var SUID = $("[id*=txtSUID]").val();
                    var Tamilname = $("[id*=txtTamilname]").val();

                    if (Section == "New") {
                        Section = "";
                    }
                    if (sstatus == "---Select---") {
                        sstatus = "";
                    }

                    var Academicyear = $("[id*=hfAcademicyear]").val();
                    var parameters = '{"id": "' + StudentInfoID + '","SearchRegno": "' + Regno + '","studenttype": "' + StudentType + '","studentname": "' + StudentName + '","classname": "' + Classname + '","classid": "' + Class + '","sectionname": "' + Section + '","gender": "' + Gender + '","dob": "' + DOB + '","doj": "' + DOJ + '","religion": "' + Religion + '","mtongue": "' + MotherTongue + '","community": "' + Community + '","caste": "' + Caste + '","aadhaar": "' + Aadhaar + '","fatheraadhaar": "' + FatherAadhaar + '","motheraadhaar": "' + MotherAadhaar + '","tempaddress": "' + TempAddress + '","peraddress": "' + PerAddress + '","email": "' + Email + '","phoneno": "' + PhoneNo + '","smartcard": "' + SmartCard + '","rationcard": "' + RationCard + '","photopath": "' + PhotoPath + '","photofile": "' + PhotoFile + '","sslcno": "' + SSLCNo + '","sslcyear": "' + SSLCYear + '","hscno": "' + HSCNo + '","hscyear": "' + HSCYear + '","suid": "' + SUID + '","tamilname": "' + Tamilname + '","academicyear": "' + Academicyear + '","sstatus": "' + sstatus + '","userid": "' + $("[id*=hfuserid]").val() + '"}';
                    $.ajax({
                        type: "POST",
                        url: "../Students/StudentInfo.aspx/SaveStudentInfo",
                        data: parameters,
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: OnSavePersonalDetailsSuccess,
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
                return false;
            }
        }

        // Save On Success
        function OnSavePersonalDetailsSuccess(response) {
            var currentPage = $("[id*=currentPage]").text();
            if (response.d == "Updated") {

                AlertMessage('success', 'Updated');
                var RegNo = $("[id*=hfRegNo]").val();
                if (formdata) {
                    formdata.append("StudenInfoId", RegNo);
                    if (formdata) {
                        $.ajax({
                            url: "../Students/StudentInfo.aspx",
                            type: "POST",
                            data: formdata,
                            processData: false,
                            contentType: false,
                            success: function (res) {
                            }
                        });
                    }
                }
                PersonalDetailsClear();
                GetStudentInfo($("[id*=hfStudentInfoID]").val());
                changeAccordion(1);
            }
            else if (response.d == "Update Failed") {
                AlertMessage('fail', 'Update');
            }
            else if (response.d) {
                var strRegNo = response.d.toString().split(",");
                AlertMessage('success', 'Inserted');
                $("[id*=hfRegNo]").val(strRegNo[0]);
                $("[id*=hfStudentInfoID]").val(strRegNo[1]);
                $("[id*=hfASSNo]").val(strRegNo[2]);
                var RegNo = $("[id*=hfRegNo]").val();

                if (formdata) {
                    formdata.append("StudenInfoId", RegNo);
                    if (formdata) {
                        $.ajax({
                            url: "../Students/StudentInfo.aspx",
                            type: "POST",
                            data: formdata,
                            processData: false,
                            contentType: false,
                            success: function (res) {
                            }
                        });
                    }
                }
                PersonalDetailsClear();
                GetStudentInfo($("[id*=hfStudentInfoID]").val());
                changeAccordion(1);
            }
            else if (response.d == "Insert Failed") {
                AlertMessage('fail', 'Insert');
            }

            GetStudentData($("[id*=hfRegNo]").val());
        };

        function SaveFamilyDetails() {

            if (($("[id*=hfAddPrm]").val() == 'true') ||
            ($("[id*=hfEditPrm]").val() == 'true')
            ) {
                //#aspnetForm
                if ($("[id*=hfRegNo]").val() != '') {

                    if ($('#aspnetForm').valid()) {
                        $("[id*=btnRelationshipSubmit]").attr("disabled", "true");
                        var StudentInfoID = $("[id*=hfStudentInfoID]").val();
                        var RegNo = $("[id*=hfRegNo]").val();
                        var Relationship = $("[id*=ddlRelationship]").val();
                        var RelName = $("[id*=txtName]").val();
                        var RelQualification = $("[id*=txtQualification]").val();
                        var RelIncome = $("[id*=txtIncome]").val();
                        var RelOccupation = $("[id*=txtOccupation]").val();
                        var RelEmail = $("[id*=txtRelEmail]").val();
                        var RelMobile = $("[id*=txtRelMobile]").val();
                        var OccAddress = $("[id*=txtOccAddress]").val();
                        var SMSPriority = $("[id*=ddlSMSPriority]").val();
                        var Caretaker;
                        if ($("[id*=rbtnParent]").is(':checked')) {
                            Caretaker = "Parent";
                        }

                        else if ($("[id*=rbtnGaurdian]").is(':checked')) {
                            Caretaker = "Guardian";
                        }
                        if (Relationship == "Father" || Relationship == "Mother" || Relationship == "Guardian I" || Relationship == "Guardian II") {

                            var parameters = '{"id": "' + RegNo + '","relationship": "' + Relationship + '","name": "' + RelName + '","qual": "' + RelQualification + '","inc": "' + RelIncome + '","occ": "' + RelOccupation + '","email": "' + RelEmail + '","cell": "' + RelMobile + '","addr": "' + OccAddress + '","priority": "' + SMSPriority + '","caretaker": "' + Caretaker + '"}';
                            var baseurl = "../Students/StudentInfo.aspx/SaveFamilyInfo";
                        }
                        // else {
                        //  var parameters = '{"id": "' + RegNo + '","gname": "' + RelName + '","gaddr": "' + OccAddress + '","gphno": "' + RelMobile + '","priority": "' + SMSPriority + '","qual": "' + RelQualification + '","inc": "' + RelIncome + '","occ": "' + RelOccupation + '","email": "' + RelEmail + '"}';
                        //  var baseurl = "../Students/StudentInfo.aspx/SaveGuardianInfo";
                        //  }
                        $.ajax({
                            type: "POST",
                            url: baseurl,
                            data: parameters,
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: OnSaveFamilyDetailsSuccess,
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
                    AlertMessage('info', "Please Enter Personal Details");
                    changeAccordion(0);
                }
            }
        }

        function GetModuleID(path) {
            $.ajax({
                type: "POST",
                url: "../Students/StudentInfo.aspx/GetModuleId",
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
                var url = "../Students/StudentInfo.aspx?menuId=" + $("[id*=hdnMenuIndex]").val() + "&activeIndex=" + $("[id*=hdnIndex]").val() + "&moduleId=" + $("[id*=hfModuleID]").val() + "&StudentID=" + $("[id*=hfStudentInfoID]").val() + "";
                //  window.location.href += "#acc=1";
                location.reload();
                // location.reload();
                //$(location).attr('href', url)
            });
        }
        // Save On Success
        function OnSaveFamilyDetailsSuccess(response) {
            var currentPage = $("[id*=currentPage]").text();
            if (response.d == "Updated") {

                AlertMessage('success', 'Updated');
                var StudentID = $("[id*=hfStudentInfoID]").val();
                FamilyDetailsClear();
                GetStudentInfo(StudentID);
                //$("#chkBroSis").attr("checked", "false");
                // showbrosis();
                // GetModuleID('Students/StudentInfo.aspx');
            }
            else if (response.d == "Update Failed") {
                AlertMessage('fail', 'Update');
            }
            else if (response.d) {
                AlertMessage('success', 'Inserted');
                var StudentID = $("[id*=hfStudentInfoID]").val();
                FamilyDetailsClear();
                GetStudentInfo(StudentID);
                // $("#chkBroSis").attr("checked", "false");
                // showbrosis();
                // GetModuleID('Students/StudentInfo.aspx');
            }
            else if (response.d == "Insert Failed") {
                AlertMessage('fail', 'Insert');
            }


        };



        function SaveBroSisDetails() {
            if (($("[id*=hfAddPrm]").val() == 'true') ||
            ($("[id*=hfEditPrm]").val() == 'true')
            ) {
                if ($("[id*=hfRegNo]").val() != '') {
                    if ($('#aspnetForm').valid()) {
                        $("[id*=btnBroSisAdd]").attr("disabled", "true");
                        var StudentInfoID = $("[id*=hfStudentInfoID]").val();
                        var RegNo = $("[id*=hfRegNo]").val();
                        var Class = $("[id*=ddlBroSisClass]").val();
                        var Section = $("[id*=ddlBroSisSection]").val();
                        var RelationId = $("[id*=ddlBroSisStudentName]").val();
                        var Relation = $("[id*=ddlBroSisRelation]").val();

                        var parameters = '{"id": "' + RegNo + '","relationid": "' + RelationId + '","relation": "' + Relation + '"}';
                        var baseurl = "../Students/StudentInfo.aspx/SaveBroSisInfo";

                        $.ajax({
                            type: "POST",
                            url: baseurl,
                            data: parameters,
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: OnSaveBroSisDetailsSuccess,
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
                    AlertMessage('info', "Please Enter Personal Details");
                    changeAccordion(0);
                }
            }
        }
        // Save On Success
        function OnSaveBroSisDetailsSuccess(response) {
            var currentPage = $("[id*=currentPage]").text();
            if (response.d == "Updated") {
                AlertMessage('success', 'Updated');
                var RegNo = $("[id*=hfRegNo]").val();
                var StudentID = $("[id*=hfStudentInfoID]").val();
                BroSisDetailsClear();
                GetStudentInfo(StudentID);
                // changeAccordion(3);


            }
            else if (response.d == "Update Failed") {
                AlertMessage('fail', 'Update');
            }
            else if (response.d == "Inserted") {
                AlertMessage('success', 'Inserted');
                var RegNo = $("[id*=hfRegNo]").val();
                var StudentID = $("[id*=hfStudentInfoID]").val();
                BroSisDetailsClear();
                GetStudentInfo(StudentID);
                //changeAccordion(3);
            }
            else if (response.d == "Insert Failed") {
                AlertMessage('fail', 'Insert');
            }

        };


        function SaveMedicalDetails() {
            if (($("[id*=hfAddPrm]").val() == 'true') ||
            ($("[id*=hfEditPrm]").val() == 'true')
            ) {
                if ($("[id*=hfRegNo]").val() != '') {
                    if ($('#aspnetForm').valid()) {
                        $("[id*=btnMedicalSave]").attr("disabled", "true");
                        var StudentInfoID = $("[id*=hfStudentInfoID]").val();
                        var RegNo = $("[id*=hfRegNo]").val();
                        var BloodGroup = $("[id*=ddlBloodGroup]").val();
                        var Disease = $("[id*=txtDisease]").val();
                        var Height = $("[id*=txtHeight]").val();
                        var Weight = $("[id*=txtWeight]").val();
                        var EmergencyPhNo = $("[id*=txtEmergencyPhNo]").val();
                        var FamilyDocName = $("[id*=txtFamilyDocName]").val();
                        var FamilyDocAdd = $("[id*=txtFamilyDocAdd]").val();
                        var FamilyDocPhNo = $("[id*=txtFamilyDocPhNo]").val();
                        var IdentificationMarks = $("[id*=txtIdentificationMarks1]").val() + ":" + $("[id*=txtIdentificationMarks2]").val();
                        var Physical;
                        if ($("[id*=rbtnPHYes]").is(':checked')) {
                            Physical = "Y";
                        }

                        else if ($("[id*=rbtnNoPH]").is(':checked')) {
                            Physical = "N";
                        }
                        var PhysicalHandicapped = $("[id*=txtPhysicalHandicapped]").val();

                        var parameters = '{"id": "' + RegNo + '","bloodgroup": "' + BloodGroup + '","disease": "' + Disease + '","height": "' + Height + '","weight": "' + Weight + '","emergencyphno": "' + EmergencyPhNo + '","familydocname": "' + FamilyDocName + '","familydocadd": "' + FamilyDocAdd + '","familydocphno": "' + FamilyDocPhNo + '","identificationmarks": "' + IdentificationMarks + '","physical": "' + Physical + '","physicalhandicapped": "' + PhysicalHandicapped + '"}';
                        var baseurl = "../Students/StudentInfo.aspx/SaveMedicalInfo";

                        $.ajax({
                            type: "POST",
                            url: baseurl,
                            data: parameters,
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: OnSaveMedicalDetailsSuccess,
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
                    AlertMessage('info', "Please Enter Personal Details");
                    changeAccordion(0);
                }
            }
        }

        function OnSaveMedicalDetailsSuccess(response) {
            var currentPage = $("[id*=currentPage]").text();
            if (response.d == "Updated") {
                AlertMessage('success', 'Updated');
                var RegNo = $("[id*=hfRegNo]").val();
                var StudentID = $("[id*=hfStudentInfoID]").val();
                MedicalDetailsClear();
                GetStudentInfo(StudentID);
                changeAccordion(4);


            }
            else if (response.d == "Update Failed") {
                AlertMessage('fail', 'Update');
            }
            else if (response.d == "Inserted") {
                AlertMessage('success', 'Inserted');
                var RegNo = $("[id*=hfRegNo]").val();
                var StudentID = $("[id*=hfStudentInfoID]").val();
                MedicalDetailsClear();
                GetStudentInfo(StudentID);
                changeAccordion(4);
            }
            else if (response.d == "Insert Failed") {
                AlertMessage('fail', 'Insert');
            }

        };

        function SaveMedRemDetails() {
            if (($("[id*=hfAddPrm]").val() == 'true') ||
            ($("[id*=hfEditPrm]").val() == 'true')
            ) {
                if ($("[id*=hfRegNo]").val() != '') {
                    if ($('#aspnetForm').valid()) {
                        $("[id*=btnMedRemSave]").attr("disabled", "true");
                        var StudentInfoID = $("[id*=hfStudentInfoID]").val();
                        var RegNo = $("[id*=hfRegNo]").val();
                        var MedRemDate = $("[id*=txtMedRemDate]").val();
                        var MedRemReason = $("[id*=txtMedRemReason]").val();
                        var filename = $("[id*=fuMedRem]").val().replace(/C:\\fakepath\\/i, '');
                        var Academicyear = $("[id*=hfAcademicyear]").val();
                        var parameters = '{"id": "' + RegNo + '","academicid": "' + Academicyear + '","remarkdate": "' + MedRemDate + '","description": "' + MedRemReason + '","filename": "' + filename + '"}';
                        var baseurl = "../Students/StudentInfo.aspx/SaveMedicalRemarkInfo";

                        $.ajax({
                            type: "POST",
                            url: baseurl,
                            data: parameters,
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: OnSaveMedicalRemarkDetailsSuccess,
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
                    AlertMessage('info', "Please Enter Personal Details");
                    changeAccordion(0);
                }
            }
        }

        function OnSaveMedicalRemarkDetailsSuccess(response) {
            var currentPage = $("[id*=currentPage]").text();
            if (response.d) {
                AlertMessage('success', 'Updated');
                var RegNo = $("[id*=hfRegNo]").val();
                var StudentID = $("[id*=hfStudentInfoID]").val();
                var MedRemDate = $("[id*=txtMedRemDate]").val();
                var MaxId = response.d;
                formdata.append("StudenInfoId", StudentID);
                formdata.append("MedRemDate", MedRemDate);
                formdata.append("MaxId", MaxId);
                if (formdata) {
                    $.ajax({
                        url: "../Students/StudentInfo.aspx",
                        type: "POST",
                        data: formdata,
                        processData: false,
                        contentType: false,
                        success: function (res) {
                        }
                    });
                }
                MedicalDetailsClear();
                GetStudentInfo(StudentID);
                // changeAccordion(5);


            }
            else if (response.d == "Update Failed") {
                AlertMessage('fail', 'Update');
            }
            else if (response.d == "Inserted") {
                AlertMessage('success', 'Inserted');
                var RegNo = $("[id*=hfRegNo]").val();
                var StudentID = $("[id*=hfStudentInfoID]").val();
                var MedRemDate = $("[id*=txtMedRemDate]").val();
                var MaxId = response.d;
                formdata.append("StudenInfoId", StudentID);
                formdata.append("MedRemDate", MedRemDate);
                formdata.append("MaxId", MaxId);
                if (formdata) {
                    $.ajax({
                        url: "../Students/StudentInfo.aspx",
                        type: "POST",
                        data: formdata,
                        processData: false,
                        contentType: false,
                        success: function (res) {
                        }
                    });
                }
                MedicalDetailsClear();
                GetStudentInfo(StudentID);
                // changeAccordion(5);
            }
            else if (response.d == "Insert Failed") {
                AlertMessage('fail', 'Insert');
            }

        };



        function SaveAcademicDetails() {
            if (($("[id*=hfAddPrm]").val() == 'true') ||
            ($("[id*=hfEditPrm]").val() == 'true')
            ) {
                if ($("[id*=hfRegNo]").val() != '') {
                    if ($('#aspnetForm').valid()) {
                        $("[id*=btnAcademicDetailsSubmit]").attr("disabled", "true");
                        var StudentInfoID = $("[id*=hfStudentInfoID]").val();
                        var RegNo = $("[id*=hfRegNo]").val();
                        var AdmissionNo = $("[id*=txtAdmissionNo]").val();

                        var Class = $("[id*=ddlAdClass]").val();
                        var Classname = $("[id*=ddlAdClass] option[value='" + Class + "']").html();

                        var Section = $("[id*=ddlAdSection]").val();
                        var Sectionname = $("[id*=ddlAdSection] option[value='" + Section + "']").html();


                        var DOA = $("[id*=txtDOA]").val();
                        var Mode = $("[id*=ddlModeofTrans]").val();
                        var ModeofTrans = $("[id*=ddlModeofTrans] option[value='" + Mode + "']").html();

                        var Medium = $("[id*=ddlSchoolMedium]").val();
                        var Firstlang = $("[id*=txtFirstlang]").val();
                        var Seclang = $("[id*=ddlSeclang]").val();
                        //                        var Scholar;
                        //                        if ($("[id*=rbtnScholarYes]").is(':checked')) {
                        //                            Scholar = "Y";
                        //                        }

                        //                        else if ($("[id*=rbtnNoScholar]").is(':checked')) {
                        //                            Scholar = "N";
                        //                        }
                        //                        var Scholarship = $("[id*=ddlScholarship]").val();
                        var Academicyear = $("[id*=hfAcademicyear]").val();
                        if (Sectionname == "New") {
                            Sectionname = "";
                        }
                        if (Classname == "---Select---") {
                            Classname = "";
                        }

                        var emp1 = $("[id*=ddlStaff1]").val();
                        var emp2 = $("[id*=ddlStaff2]").val();
                        var relation1 = $("[id*=ddlRelationship1]").val();
                        var relation2 = $("[id*=ddlRelationship2]").val();
                        var sstatus = $("[id*=ddlStatus]").val();
                        var parameters = '{"id": "' + RegNo + '","admissionno": "' + AdmissionNo + '","adclassname": "' + Class + '","adsectionname": "' + Section + '","doa": "' + DOA + '","modeoftrans": "' + Mode + '","medium": "' + Medium + '","firstlang": "' + Firstlang + '","seclang": "' + Seclang + '","academicid": "' + Academicyear + '","emp1": "' + emp1 + '","emp2": "' + emp2 + '","relation1": "' + relation1 + '","relation2": "' + relation2 + '","sstatus": "' + sstatus + '"}';
                        var baseurl = "../Students/StudentInfo.aspx/SaveAcademicInfo";

                        $.ajax({
                            type: "POST",
                            url: baseurl,
                            data: parameters,
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: OnSaveAcademicDetailsSuccess,
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
                    AlertMessage('info', "Please Enter Personal Details");
                    changeAccordion(0);
                }
            }
        }

        function OnSaveAcademicDetailsSuccess(response) {
            var currentPage = $("[id*=currentPage]").text();
            if (response.d == "Updated") {
                AlertMessage('success', 'Updated');
                var RegNo = $("[id*=hfRegNo]").val();
                var StudentID = $("[id*=hfStudentInfoID]").val();
                AcademicDetailsClear();
                GetStudentInfo(StudentID);
                changeAccordion(6);


            }
            else if (response.d == "Update Failed") {
                AlertMessage('fail', 'Update');
            }
            else if (response.d == "Inserted") {
                AlertMessage('success', 'Inserted');
                var RegNo = $("[id*=hfRegNo]").val();
                var StudentID = $("[id*=hfStudentInfoID]").val();
                AcademicDetailsClear();
                GetStudentInfo(StudentID);
                changeAccordion(6);
            }
            else if (response.d == "Insert Failed") {
                AlertMessage('fail', 'Insert');
            }

        };

        function SaveScholarshipDetails() {
            if (($("[id*=hfAddPrm]").val() == 'true') ||
            ($("[id*=hfEditPrm]").val() == 'true')
            ) {
                if ($("[id*=hfRegNo]").val() != '') {
                    if ($('#aspnetForm').valid()) {
                        $("[id*=btnScholarshipSubmit]").attr("disabled", "true");
                        var StudentInfoID = $("[id*=hfStudentInfoID]").val();
                        var RegNo = $("[id*=hfRegNo]").val();

                        var Scholar;
                        if ($("[id*=rbtnScholarYes]").is(':checked')) {
                            Scholar = "Y";
                        }

                        else if ($("[id*=rbtnNoScholar]").is(':checked')) {
                            Scholar = "N";
                        }
                        var Scholarship = $("[id*=ddlScholarship]").val();
                        var Academicyear = $("[id*=hfAcademicyear]").val();

                        var parameters = '{"id": "' + RegNo + '","academicid": "' + Academicyear + '","scholar": "' + Scholar + '","scholarship": "' + Scholarship + '"}';
                        var baseurl = "../Students/StudentInfo.aspx/SaveScholarshipInfo";

                        $.ajax({
                            type: "POST",
                            url: baseurl,
                            data: parameters,
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: OnSaveScholarshipDetailsSuccess,
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
                    AlertMessage('info', "Please Enter Personal Details");
                    changeAccordion(0);
                }
            }
        }

        function OnSaveScholarshipDetailsSuccess(response) {
            if (response.d == "Updated") {
                var RegNo = $("[id*=hfRegNo]").val();
                GetScholarshipInfo(RegNo);
            }
            else {
                alert(response.d);
            }
        }

        function SaveAcademicRemarkDetails() {
            if (($("[id*=hfAddPrm]").val() == 'true') ||
            ($("[id*=hfEditPrm]").val() == 'true')
            ) {
                if ($("[id*=hfRegNo]").val() != '') {
                    if ($('#aspnetForm').valid()) {
                        $("[id*=btnAAcademicRemarks]").attr("disabled", "true");
                        var StudentInfoID = $("[id*=hfStudentInfoID]").val();
                        var RegNo = $("[id*=hfRegNo]").val();
                        var RemDate = $("[id*=txtAcaRemDate]").val();
                        var RemReason = $("[id*=txtAcaRemarks]").val();
                        var Academicyear = $("[id*=hfAcademicyear]").val();
                        var parameters = '{"id": "' + RegNo + '","academicid": "' + Academicyear + '","remarkdate": "' + RemDate + '","remarks": "' + RemReason + '"}';
                        var baseurl = "../Students/StudentInfo.aspx/SaveAcademicRemarkInfo";

                        $.ajax({
                            type: "POST",
                            url: baseurl,
                            data: parameters,
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: OnSaveAcademicRemarkDetailsSuccess,
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
                    AlertMessage('info', "Please Enter Personal Details");
                    changeAccordion(0);
                }
            }
        }

        function OnSaveAcademicRemarkDetailsSuccess(response) {
            var currentPage = $("[id*=currentPage]").text();
            if (response.d == "Updated") {
                AlertMessage('success', 'Updated');
                var RegNo = $("[id*=hfRegNo]").val();
                var StudentID = $("[id*=hfStudentInfoID]").val();
                AcademicRemarksDetailsClear();
                GetStudentInfo(StudentID);
                // changeAccordion(7);


            }
            else if (response.d == "Update Failed") {
                AlertMessage('fail', 'Update');
            }
            else if (response.d == "Inserted") {
                AlertMessage('success', 'Inserted');
                var RegNo = $("[id*=hfRegNo]").val();
                var StudentID = $("[id*=hfStudentInfoID]").val();
                AcademicRemarksDetailsClear();
                GetStudentInfo(StudentID);
                // changeAccordion(7);
            }
            else if (response.d == "Insert Failed") {
                AlertMessage('fail', 'Insert');
            }

        };


        function SaveBusRouteDetails() {
            if (($("[id*=hfAddPrm]").val() == 'true') ||
            ($("[id*=hfEditPrm]").val() == 'true')
            ) {
                if ($("[id*=hfRegNo]").val() != '') {
                    if ($('#aspnetForm').valid()) {
                        $("[id*=btnBusRouteSubmit]").attr("disabled", "true");
                        var StudentInfoID = $("[id*=hfStudentInfoID]").val();
                        var RegNo = $("[id*=hfRegNo]").val();
                        var BusFacility;
                        if ($("[id*=rbtnBusYes]").is(':checked')) {
                            BusFacility = "Y";
                        }

                        else if ($("[id*=rbtnBusNo]").is(':checked')) {
                            BusFacility = "N";
                        }
                        var RouteCode = $("[id*=ddlRouteCode]").val();
                        var RegDate = $("[id*=txtDateofBusReg]").val();
                        var Academicyear = $("[id*=hfAcademicyear]").val();
                        var parameters = '{"id": "' + RegNo + '","academicid": "' + Academicyear + '","routeid": "' + RouteCode + '","Busfacility": "' + BusFacility + '","regdate": "' + RegDate + '","status": "' + BusFacility + '"}';
                        var baseurl = "../Students/StudentInfo.aspx/SaveBusRouteInfo";

                        $.ajax({
                            type: "POST",
                            url: baseurl,
                            data: parameters,
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: OnSaveBusRouteDetailsSuccess,
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
                    AlertMessage('info', "Please Enter Personal Details");
                    changeAccordion(0);
                }
            }
        }

        function OnSaveBusRouteDetailsSuccess(response) {
            var currentPage = $("[id*=currentPage]").text();
            if (response.d == "Updated") {
                AlertMessage('success', 'Updated');
                var RegNo = $("[id*=hfRegNo]").val();
                var StudentID = $("[id*=hfStudentInfoID]").val();
                BusRouteDetailsClear();
                GetStudentInfo(StudentID);
                changeAccordion(10);

            }
            else if (response.d == "Update Failed") {
                AlertMessage('fail', 'Update');
            }
            else if (response.d == "Inserted") {
                AlertMessage('success', 'Inserted');
                var RegNo = $("[id*=hfRegNo]").val();
                BusRouteDetailsClear();
                var StudentID = $("[id*=hfStudentInfoID]").val();
                GetStudentInfo(StudentID);
                changeAccordion(10);

            }
            else if (response.d == "Insert Failed") {
                AlertMessage('fail', 'Insert');
            }
            else {
                AlertMessage('info', response.d);
                $("[id*=btnBusRouteSubmit]").attr("disabled", "false");
            }

        };



        function SaveHostelDetails() {
            if (($("[id*=hfAddPrm]").val() == 'true') ||
            ($("[id*=hfEditPrm]").val() == 'true')
            ) {
                if ($("[id*=hfRegNo]").val() != '') {
                    if ($('#aspnetForm').valid()) {
                        $("[id*=btnHostelSubmit]").attr("disabled", "true");
                        var StudentInfoID = $("[id*=hfStudentInfoID]").val();
                        var RegNo = $("[id*=hfRegNo]").val();
                        var Hostel;
                        if ($("[id*=rbtnHostelYes]").is(':checked')) {
                            Hostel = "Y";
                        }

                        else if ($("[id*=rbtnHostelNo]").is(':checked')) {
                            Hostel = "N";
                        }
                        var hostelid = $("[id*=ddlHostel]").val();
                        var blockid = $("[id*=ddlBlock]").val();
                        var roomid = $("[id*=ddlRooms]").val();
                        var RegDate = $("[id*=txtDateofHostelAdmn]").val();
                        var Academicyear = $("[id*=hfAcademicyear]").val();
                        var parameters = '{"id": "' + RegNo + '","academicid": "' + Academicyear + '","hostelid": "' + hostelid + '","blockid": "' + blockid + '","roomid": "' + roomid + '","regdate": "' + RegDate + '","status": "' + Hostel + '"}';
                        var baseurl = "../Students/StudentInfo.aspx/SaveHostelInfo";

                        $.ajax({
                            type: "POST",
                            url: baseurl,
                            data: parameters,
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: OnSaveHostelInfoSuccess,
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
                    AlertMessage('info', "Please Enter Personal Details");
                    changeAccordion(0);
                }
            }
        }

        function OnSaveHostelInfoSuccess(response) {
            var currentPage = $("[id*=currentPage]").text();
            if (response.d == "Updated") {
                AlertMessage('success', 'Updated');
                var RegNo = $("[id*=hfRegNo]").val();
                var StudentID = $("[id*=hfStudentInfoID]").val();
                HostelDetailsClear();
                GetStudentInfo(StudentID);
                changeAccordion(9);

            }
            else if (response.d == "Update Failed") {
                AlertMessage('fail', 'Update');
            }
            else if (response.d == "Inserted") {
                AlertMessage('success', 'Inserted');
                var RegNo = $("[id*=hfRegNo]").val();
                var StudentID = $("[id*=hfStudentInfoID]").val();
                HostelDetailsClear();
                GetStudentInfo(StudentID);
                changeAccordion(9);
            }
            else if (response.d == "Insert Failed") {
                AlertMessage('fail', 'Insert');
            }

        };


        function SaveOldSchoolDetails() {
            if (($("[id*=hfAddPrm]").val() == 'true') ||
            ($("[id*=hfEditPrm]").val() == 'true')
            ) {
                if ($("[id*=hfRegNo]").val() != '') {
                    if ($('#aspnetForm').valid()) {
                        $("[id*=btnTCSave]").attr("disabled", "true");
                        var StudentInfoID = $("[id*=hfStudentInfoID]").val();
                        var RegNo = $("[id*=hfRegNo]").val();
                        var SchoolName = $("[id*=txtSchoolName]").val();
                        var StartAcademicYr = $("[id*=ddlStartAcademicYr]").val();
                        var EndAcademicYr = $("[id*=ddlEndAcademicYr]").val();
                        var StdFrom = $("[id*=txtStdFrom]").val();
                        var FirstLang = $("[id*=ddlFirstLang]").val();
                        var Medium = $("[id*=ddlMedium]").val();
                        var TCNo = $("[id*=txtTCNo]").val();
                        var TCDate = $("[id*=txtTCDate]").val();
                        var TCReceivedDate = $("[id*=txtTCReceivedDate]").val();
                        var Academicyear = $("[id*=hfAcademicyear]").val();
                        var parameters = '{"ID": "' + RegNo + '","SchoolName": "' + SchoolName + '","StartAcademicYr": "' + StartAcademicYr + '","EndAcademicYr": "' + EndAcademicYr + '","StdFrom": "' + StdFrom + '","FirstLang": "' + FirstLang + '","iMedium": "' + Medium + '","TCNo": "' + TCNo + '","TCDate": "' + TCDate + '","TCReceivedDate": "' + TCReceivedDate + '"}';
                        var baseurl = "../Students/StudentInfo.aspx/SaveOldSchoolInfo";

                        $.ajax({
                            type: "POST",
                            url: baseurl,
                            data: parameters,
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: OnSaveOldSchoolInfoSuccess,
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
                    AlertMessage('info', "Please Enter Personal Details");
                    changeAccordion(0);
                }
            }
        }

        function OnSaveOldSchoolInfoSuccess(response) {
            var currentPage = $("[id*=currentPage]").text();
            if (response.d == "Updated") {
                AlertMessage('success', 'Updated');
                var RegNo = $("[id*=hfRegNo]").val();
                var StudentID = $("[id*=hfStudentInfoID]").val();
                OldSchoolDetailsClear();
                GetStudentInfo(StudentID);
                //  changeAccordion(11);

            }
            else if (response.d == "Update Failed") {
                AlertMessage('fail', 'Update');
            }
            else if (response.d == "Inserted") {
                AlertMessage('success', 'Inserted');
                var RegNo = $("[id*=hfRegNo]").val();
                var StudentID = $("[id*=hfStudentInfoID]").val();
                OldSchoolDetailsClear();
                GetStudentInfo(StudentID);
                // changeAccordion(11);
            }
            else if (response.d == "Insert Failed") {
                AlertMessage('fail', 'Insert');
            }

        };

        function SaveNationalityDetails() {
            if (($("[id*=hfAddPrm]").val() == 'true') ||
            ($("[id*=hfEditPrm]").val() == 'true')
            ) {
                if ($("[id*=hfRegNo]").val() != '') {
                    if ($('#aspnetForm').valid()) {
                        $("[id*=btnNationalitySave]").attr("disabled", "true");
                        var StudentInfoID = $("[id*=hfStudentInfoID]").val();
                        var RegNo = $("[id*=hfRegNo]").val();
                        var IsNative;
                        var Nationality;
                        if ($("[id*=rbtnIndian]").is(':checked')) {
                            IsNative = "Y";
                            Nationality = "Indian";
                        }
                        else if ($("[id*=rbtnOverseas]").is(':checked')) {
                            IsNative = "N";
                            Nationality = $("[id*=txtNationality]").val();
                        }

                        var PassportNo = $("[id*=txtPassportNo]").val();
                        var PPDateofIssue = $("[id*=txtPPDateofIssue]").val();
                        var VisaNumber = $("[id*=txtVisaNumber]").val();
                        var PPExpDate = $("[id*=txtPPExpDate]").val();
                        var VisaType = $("[id*=txtVisaType]").val();
                        var VisaIssuedDate = $("[id*=txtVisaIssuedDate]").val();
                        var VisaExpiryDate = $("[id*=txtVisaExpiryDate]").val();
                        var NoOfEntry = $("[id*=txtNoOfEntry]").val();
                        var Validity = $("[id*=txtValidity]").val();
                        var Purpose = $("[id*=txtPurpose]").val();
                        var Remark = $("[id*=txtRemark]").val();
                        var Academicyear = $("[id*=hfAcademicyear]").val();
                        var parameters = '{"ID": "' + RegNo + '","IsNative": "' + IsNative + '","Nationality": "' + Nationality + '","PassportNo": "' + PassportNo + '","PPDateofIssue": "' + PPDateofIssue + '","VisaNumber": "' + VisaNumber + '","PPExpDate": "' + PPExpDate + '","VisaType": "' + VisaType + '","VisaIssuedDate": "' + VisaIssuedDate + '","VisaExpiryDate": "' + VisaExpiryDate + '","NoOfEntry": "' + NoOfEntry + '","Validity": "' + Validity + '","Purpose": "' + Purpose + '","Remark": "' + Remark + '"}';
                        var baseurl = "../Students/StudentInfo.aspx/SaveNationalityInfo";

                        $.ajax({
                            type: "POST",
                            url: baseurl,
                            data: parameters,
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: OnSaveNationalityInfoSuccess,
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
                    AlertMessage('info', "Please Enter Personal Details");
                    changeAccordion(0);
                }
            }
        }

        function OnSaveNationalityInfoSuccess(response) {
            var currentPage = $("[id*=currentPage]").text();
            if (response.d == "Updated") {
                AlertMessage('success', 'Updated');
                var RegNo = $("[id*=hfRegNo]").val();
                var StudentID = $("[id*=hfStudentInfoID]").val();
                NationalityDetailsClear();
                GetStudentInfo(StudentID);
                changeAccordion(13);

            }
            else if (response.d == "Update Failed") {
                AlertMessage('fail', 'Update');
            }
            else if (response.d == "Inserted") {
                AlertMessage('success', 'Inserted');
                var RegNo = $("[id*=hfRegNo]").val();
                var StudentID = $("[id*=hfStudentInfoID]").val();
                NationalityDetailsClear();
                GetStudentInfo(StudentID);
                changeAccordion(13);
            }
            else if (response.d == "Insert Failed") {
                AlertMessage('fail', 'Insert');
            }

        };



        function SaveAttachmentDetails() {
            if (($("[id*=hfAddPrm]").val() == 'true') ||
            ($("[id*=hfEditPrm]").val() == 'true')
            ) {
                if ($("[id*=hfRegNo]").val() != '') {
                    if ($('#aspnetForm').valid()) {
                        $("[id*=btnAttachmentSave]").attr("disabled", "true");

                        var StudentInfoID = $("[id*=hfStudentInfoID]").val();
                        var RegNo = $("[id*=hfRegNo]").val();
                        var Title = $("[id*=txtAttTitle]").val();
                        var Description = $("[id*=txtAttDescription]").val();
                        var Filename = $("[id*=AttFile1]").val().replace(/C:\\fakepath\\/i, '');
                        var Academicyear = $("[id*=hfAcademicyear]").val();
                        var parameters = '{"id": "' + RegNo + '","Title": "' + Title + '","Description": "' + Description + '","Filename": "' + Filename + '"}';
                        var baseurl = "../Students/StudentInfo.aspx/SaveAttachmentInfo";

                        $.ajax({
                            type: "POST",
                            url: baseurl,
                            data: parameters,
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: OnSaveAttachmentInfoSuccess,
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
                    AlertMessage('info', "Please Enter Personal Details");
                    changeAccordion(0);
                }
            }
        }

        function OnSaveAttachmentInfoSuccess(response) {
            var currentPage = $("[id*=currentPage]").text();
            if (response.d) {
                AlertMessage('success', 'Updated');
                var RegNo = $("[id*=hfRegNo]").val();
                var StudentID = $("[id*=hfStudentInfoID]").val();
                var MaxId = response.d;
                formdata.append("StudenInfoId", StudentID);
                formdata.append("MaxId", MaxId);
                if (formdata) {
                    $.ajax({
                        url: "../Students/StudentInfo.aspx",
                        type: "POST",
                        data: formdata,
                        processData: false,
                        contentType: false,
                        success: function (res) {
                        }
                    });
                }
                AttachmentInfoClear();
                GetStudentInfo(StudentID);
                //  changeAccordion(12);


            }
            else if (response.d == "Update Failed") {
                AlertMessage('fail', 'Update');
            }
            else if (response.d == "Inserted") {
                AlertMessage('success', 'Inserted');
                var RegNo = $("[id*=hfRegNo]").val();
                var StudentID = $("[id*=hfStudentInfoID]").val();
                var MaxId = response.d;
                formdata.append("StudenInfoId", StudentID);
                formdata.append("MaxId", MaxId);
                if (formdata) {
                    $.ajax({
                        url: "../Students/StudentInfo.aspx",
                        type: "POST",
                        data: formdata,
                        processData: false,
                        contentType: false,
                        success: function (res) {
                        }
                    });
                }
                AttachmentInfoClear();
                GetStudentInfo(StudentID);
                //  changeAccordion(12);
            }
            else if (response.d == "Insert Failed") {
                AlertMessage('fail', 'Insert');
            }

        };

        function SportsDetailsClear() {
            $('#aspnetForm').validate().resetForm();

            $("[id*=fusports]").val("");
            $("[id*=fuawards]").val("");
            $("[id*=fuabled]").val("");
            $("[id*=txtabled]").val("");
            $("[id*=rbbadminton]").attr("checked", true);
            $("[id*=rbchess]").attr("checked", false);
            $("[id*=rbtennis]").attr("checked", false);
            $("[id*=rbtnfivehours]").attr("checked", true);
            $("[id*=rbtnforenoon]").attr("checked", false);
            $("[id*=rbtnevening]").attr("checked", false);
            $("[id*=rbtnweekend]").attr("checked", false);
        }
        function ASSWellnessClear() {
            $('#aspnetForm').validate().resetForm();
            $("[id*=rbtnAllergicYes").attr("checked", false);
            $("[id*=rbtnAllergicNo").attr("checked", false);
            $("[id*=fuAllergic").attr("checked", false);
            $("[id*=rbtnSkinYes").attr("checked", false);
            $("[id*=rbtnSkinNo").attr("checked", false);
            $("[id*=txtPrescribed").val("");
            $("[id*=txtallergies").val("");
            $("[id*=txtMedication").val("");
            $("[id*=txtMedicationPurpose").val("");
            $("[id*=txtPeriod").val("");
            $("[id*=rbtnTetanusYes").attr("checked", false);
            $("[id*=rbtnTetanusNo").attr("checked", false);
            $("[id*=rbtnPolioYes").attr("checked", false);
            $("[id*=rbtnPolioNo").attr("checked", false);
            $("[id*=rbtnTBYes").attr("checked", false);
            $("[id*=rbtnTBNo").attr("checked", false);
            $("[id*=rbtnHepatitisYes").attr("checked", false);
            $("[id*=rbtnHepatitisNo").attr("checked", false);
            $("[id*=rbtnCovidYes").attr("checked", false);
            $("[id*=rbtnCovidNo").attr("checked", false);
            $("[id*=rbtnHPVYes").attr("checked", false);
            $("[id*=rbtnHPVNo").attr("checked", false);
            $("[id*=txtOtherlist").val("");
            $("[id*=rbtnGlassYes").attr("checked", false);
            $("[id*=rbtnGlassNo").attr("checked", false);
            $("[id*=rbtnLensYes").attr("checked", false);
            $("[id*=rbtnLensNo").attr("checked", false);
            $("[id*=rbtnhearYes").attr("checked", false);
            $("[id*=rbtnhearNo").attr("checked", false);
            $("[id*=rbtnChickenYes").attr("checked", false);
            $("[id*=rbtnChickenNo").attr("checked", false);
            $("[id*=rbtnRubellaYes").attr("checked", false);
            $("[id*=rbtnRubellaNo").attr("checked", false);
            $("[id*=rbtnJaundiceYes").attr("checked", false);
            $("[id*=rbtnJaundiceNo").attr("checked", false);
            $("[id*=rbtnMeaslesYes").attr("checked", false);
            $("[id*=rbtnMeaslesNo").attr("checked", false);
            $("[id*=rbtnMumpsYes").attr("checked", false);
            $("[id*=rbtnMumpsNo").attr("checked", false);
            $("[id*=rbtnScarletYes").attr("checked", false);
            $("[id*=rbtnScarletNo").attr("checked", false);
            $("[id*=txtOperation").val("");
            $("[id*=rbtnCoughYes").attr("checked", false);
            $("[id*=rbtnCoughNo").attr("checked", false);
            $("[id*=txtAnyMedication").val("");
            $("[id*=chkAnorexia").attr("checked", false);
            $("[id*=chkArthritis").attr("checked", false);
            $("[id*=chkAsthma").attr("checked", false);
            $("[id*=chkBone").attr("checked", false);
            $("[id*=chkCancer").attr("checked", false);
            $("[id*=chkCardiovascular").attr("checked", false);
            $("[id*=chkDiabetes").attr("checked", false);
            $("[id*=chkEczema").attr("checked", false);
            $("[id*=chkEnuresis").attr("checked", false);
            $("[id*=chkEpilepsy").attr("checked", false);
            $("[id*=chkGenetic").attr("checked", false);
            $("[id*=chkHay").attr("checked", false);
            $("[id*=chkHead").attr("checked", false);
            $("[id*=chkHearing").attr("checked", false);
            $("[id*=chkHeart").attr("checked", false);
            $("[id*=chkHepatitis").attr("checked", false);
            $("[id*=chkHIV").attr("checked", false);
            $("[id*=chkLearning").attr("checked", false);
            $("[id*=chkMenstrual").attr("checked", false);
            $("[id*=chkMigraine").attr("checked", false);
            $("[id*=chkPhobia").attr("checked", false);
            $("[id*=chkDeformity").attr("checked", false);
            $("[id*=chkPhysical").attr("checked", false);
            $("[id*=chkPneumonia").attr("checked", false);
            $("[id*=chkRheumatic").attr("checked", false);
            $("[id*=chkSkin").attr("checked", false);
            $("[id*=chkStomach").attr("checked", false);
            $("[id*=chkSyndromes").attr("checked", false);
            $("[id*=chkUrinary").attr("checked", false);
            $("[id*=chkAnxiety").attr("checked", false);
            $("[id*=chkAutism").attr("checked", false);
            $("[id*=chkMood").attr("checked", false);
            $("[id*=chkSpeech").attr("checked", false);
        }
        function GeneralDetailsClear() {
            $('#aspnetForm').validate().resetForm();

            $("[id*=txtidentify1]").val("");
            $("[id*=txtidentify2]").val("");
            $("[id*=rtbnBreakYes]").attr("checked", true);
            $("[id*=rtbnBreakNo]").attr("checked", false);
            $("[id*=rtbnLunchYes]").attr("checked", true);
            $("[id*=rtbnLunchNo]").attr("checked", false);
            $("[id*=rtbnTransYes]").attr("checked", true);
            $("[id*=rtbnTransNo]").attr("checked", false);
            $("[id*=rbtnbcYes]").attr("checked", true);
            $("[id*=rbtnbcNo]").attr("checked", false);
            $("[id*=rbtnHotelYes]").attr("checked", true);
            $("[id*=rbtnHotelNo]").attr("checked", false);
        }


        function PersonalDetailsClear() {

            $('#img_prev').attr('src', "../img/photo.jpg");
            $("[id*=txtStudentName]").val("");
            $("[id*=txtDOB]").val("");
            $("[id*=txtMotherTongue]").val("");
            $("[id*=ddlClass]").val("");
            $("[id*=ddlSection]").val("");
            $("[id*=ddlReligion]").val("");
            $("[id*=ddlCommunity]").val("");
            $("[id*=ddlCaste]").val("");
            $("[id*=txtAadhaar]").val("");
            $("[id*=txtFatherAadhaar]").val("");
            $("[id*=txtMotherAadhaar]").val("");
            $("[id*=txtTempAddress]").val("");
            $("[id*=txtPerAddress]").val("");
            $("[id*=txtEmail]").val("");
            $("[id*=txtPhoneNo]").val("");
            $("[id*=txtHSC]").val("");
            $("[id*=txtSSLC]").val("");
            $("[id*=ddlSSLC]").val("");
            $("[id*=ddlHSC]").val("");
            $("[id*=txtSUID]").val("");
            $("[id*=txtTamilname]").val("");

            $("[id*=FuPhoto]").val("");
            $("[id*=btnAdvanceFees]").attr("disabled", "false");

            $("[id*=spPersonalSubmit]").html("Save");
            if ($("[id*=hfAddPrm]").val() == 'false') {
                $("table.form :input").prop('disabled', true);
            }
            else
                $("table.form :input").prop('disabled', false);
            $('#aspnetForm').validate().resetForm();
        }
        function FamilyDetailsClear() {
            $('#aspnetForm').validate().resetForm();
            $("[id*=ddlRelationship]").val("");
            $("[id*=txtName]").val("");
            $("[id*=txtQualification]").val("");
            $("[id*=txtIncome]").val("");
            $("[id*=txtRelEmail]").val("");
            $("[id*=txtOccupation]").val("");
            $("[id*=txtRelMobile]").val("");
            $("[id*=txtOccAddress]").val("");
            $("[id*=ddlSMSPriority]").val("");
            $("[id*=btnRelationshipSubmit]").attr("disabled", "false");
            var StudentInfos = "";

            row = $("[id*=dgRelationship] tr:last-child").clone(true);
            $("[id*=dgRelationship] tr").not($("[id*=dgRelationship] tr:first-child")).remove();
            var eanchor = ''
            var eanchorEnd = '';
            var danchor = ''
            var danchorEnd = '';
            if ($("[id*=hfEditPrm]").val() == 'false') {
                eanchor = "<a>";
                eanchorEnd = "</a>";
            }
            else {
                eanchor = "<a  href=\"javascript:EditRelationshipInfo('";
                eanchorEnd = "');\">Edit</a>";
            }
            if ($("[id*=hfDeletePrm]").val() == 'false') {
                danchor = "<a>";
                danchorEnd = "</a>";
            }
            else {
                danchor = "<a  href=\"javascript:DeleteRelationshipInfo('";
                danchorEnd = "');\">Delete</a>";
            }

            if (StudentInfos.length == 0) {
                $("td", row).eq(0).html("");
                $("td", row).eq(1).html("");
                $("td", row).eq(2).html("");
                $("td", row).eq(3).html("No Records Found").attr("align", "center");
                $("td", row).eq(4).html("");
                $("td", row).eq(5).html("");
                $("td", row).eq(6).html("");
                $("td", row).eq(7).html("");
                $("td", row).eq(8).html("");
                $("td", row).eq(9).html("");
                // $("td", row).eq(10).html("");
                $("[id*=dgRelationship]").append(row);
                row = $("[id*=dgRelationship] tr:last-child").clone(true);

            }

        }

        function BroSisDetailsClear() {
            $('#aspnetForm').validate().resetForm();
            $("[id*=ddlBroSisClass]").val("");
            $("[id*=ddlBroSisSection]").val("");
            $("[id*=ddlBroSisStudentName]").val("");
            $("[id*=ddlBroSisRelation]").val("");
            $("[id*=btnBroSisAdd]").attr("disabled", "false");
            if ($("[id*=hfAddPrm]").val() == 'false') {
                $("table.form :input").prop('disabled', true);
            }
            else
                $("table.form :input").prop('disabled', false);
        };
        function MedicalDetailsClear() {
            $('#aspnetForm').validate().resetForm();
            $("[id*=ddlBloodGroup]").val("");
            $("[id*=txtDisease]").val("");
            $("[id*=txtHeight]").val("");
            $("[id*=txtWeight]").val("");
            $("[id*=txtEmergencyPhNo]").val("");
            $("[id*=txtFamilyDocName]").val("");
            $("[id*=txtFamilyDocAdd]").val("");
            $("[id*=txtFamilyDocPhNo]").val("");
            $("[id*=txtIdentificationMarks1]").val("");
            $("[id*=txtIdentificationMarks2]").val("");
            $("[id*=txtPhysicalHandicapped]").val("");
            $("[id*=txtPhysicalHandicapped]").val("");
            $("[id*=txtMedRemDate]").val("");
            $("[id*=txtMedRemReason]").val("");
            $("[id*=btnMedicalSave]").attr("disabled", "false");
            $("[id*=btnMedRemSave]").attr("disabled", "false");
            if ($("[id*=hfAddPrm]").val() == 'false') {
                $("table.form :input").prop('disabled', true);
            }
            else
                $("table.form :input").prop('disabled', false);
        };

        function AcademicDetailsClear() {
            $('#aspnetForm').validate().resetForm();
            $("[id*=txtAdmissionNo]").val("");
            $("[id*=ddlAdClass]").val("");
            $("[id*=ddlAdSection]").val("");
            $("[id*=txtDOJ]").val("");
            $("[id*=txtDOA]").val("");
            $("[id*=txtRegNo]").val("");
            $("[id*=ddlModeofTrans]").val("");
            $("[id*=ddlSchoolMedium]").val("");
            $("[id*=txtFirstlang]").val("");
            $("[id*=ddlSeclang]").val("");
            $("[id*=ddlStaff1]").val("");
            $("[id*=ddlStaff2]").val("");
            $("[id*=ddlRelationship1]").val("");
            $("[id*=ddlRelationship2]").val("");
            $("[id*=btnAcademicDetailsSubmit]").attr("disabled", "false");
            if ($("[id*=hfAddPrm]").val() == 'false') {
                $("table.form :input").prop('disabled', true);
            }
            else
                $("table.form :input").prop('disabled', false);
        };

        function MedRemDetailsClear() {
            $('#aspnetForm').validate().resetForm();
            $("[id*=txtMedRemDate]").val("");
            $("[id*=txtMedRemReason]").val("");
            $("[id*=fuMedRem]").val("");
            $("[id*=btnMedRemSave]").attr("disabled", "false");
            if ($("[id*=hfAddPrm]").val() == 'false') {
                $("table.form :input").prop('disabled', true);
            }
            else
                $("table.form :input").prop('disabled', false);
        };

        function AcademicRemarksDetailsClear() {
            $('#aspnetForm').validate().resetForm();
            $("[id*=txtAcaRemDate]").val("");
            $("[id*=txtAcaRemarks]").val("");
            $("[id*=btnAAcademicRemarks]").attr("disabled", "false");
            if ($("[id*=hfAddPrm]").val() == 'false') {
                $("table.form :input").prop('disabled', true);
            }
            else
                $("table.form :input").prop('disabled', false);
        };

        function BusRouteDetailsClear() {
            $('#aspnetForm').validate().resetForm();
            $("[id*=ddlRouteCode]").val("");
            $("[id*=txtDateofBusReg]").val("");
            $("[id*=btnBusRouteSubmit]").attr("disabled", "false");
            if ($("[id*=hfAddPrm]").val() == 'false') {
                $("table.form :input").prop('disabled', true);
            }
            else
                $("table.form :input").prop('disabled', false);
        };
        function OldSchoolDetailsClear() {
            $('#aspnetForm').validate().resetForm();
            $("[id*=txtSchoolName]").val("");
            $("[id*=ddlStartAcademicYr]").val("");
            $("[id*=ddlEndAcademicYr]").val("");
            $("[id*=txtStdFrom]").val("");
            $("[id*=ddlFirstLang]").val("");
            $("[id*=ddlMedium]").val("");
            $("[id*=txtTCNo]").val("");
            $("[id*=txtTCDate]").val("");
            $("[id*=txtTCReceivedDate]").val("");
            $("[id*=btnTCSave]").attr("disabled", "false");
            if ($("[id*=hfAddPrm]").val() == 'false') {
                $("table.form :input").prop('disabled', true);
            }
            else
                $("table.form :input").prop('disabled', false);
        };
        function HostelDetailsClear() {
            $('#aspnetForm').validate().resetForm();
            $("[id*=ddlHostel]").val("");
            $("[id*=ddlBlock]").val("");
            $("[id*=ddlRooms]").val("");
            $("[id*=txtDateofHostelAdmn]").val("");
            $("[id*=rbtnHostelNo]").attr("checked", true);
            ShowHostel();
            $("[id*=btnHostelSubmit]").attr("disabled", "false");
            if ($("[id*=hfAddPrm]").val() == 'false') {
                $("table.form :input").prop('disabled', true);
            }
            else
                $("table.form :input").prop('disabled', false);
        };

        function NationalityDetailsClear() {
            $('#aspnetForm').validate().resetForm();
            $("[id*=txtNationality]").val("");
            $("[id*=txtPassportNo]").val("");
            $("[id*=txtPPDateofIssue]").val("");
            $("[id*=txtVisaNumber]").val("");
            $("[id*=txtPPExpDate]").val("");
            $("[id*=txtVisaType]").val("");
            $("[id*=txtVisaIssuedDate]").val("");
            $("[id*=txtVisaExpiryDate]").val("");
            $("[id*=txtNoOfEntry]").val("");
            $("[id*=txtValidity]").val("");
            $("[id*=txtPurpose]").val("");
            $("[id*=txtRemark]").val("");
            $("[id*=btnNationalitySave]").attr("disabled", "false");
            if ($("[id*=hfAddPrm]").val() == 'false') {
                $("table.form :input").prop('disabled', true);
            }
            else
                $("table.form :input").prop('disabled', false);
        };

        function SaveFeesClear() {
            $('#aspnetForm').validate().resetForm();
            $("[id*=ddlMonth]").val("");
            $("[id*=ddlSportFees]").val("");
            if ($("[id*=hfAddPrm]").val() == 'false') {
                $("table.form :input").prop('disabled', true);
            }
            else
                $("table.form :input").prop('disabled', false);
        };

        function AttachmentInfoClear() {
            $('#aspnetForm').validate().resetForm();
            $("[id*=txtAttTitle]").val("");
            $("[id*=txtAttDescription]").val("");
            $("[id*=AttFile1]").val("");
            $("[id*=btnAttachmentSave]").attr("disabled", "false");
            if ($("[id*=hfAddPrm]").val() == 'false') {
                $("table.form :input").prop('disabled', true);
            }
            else
                $("table.form :input").prop('disabled', false);
        };



        function GetScholarshipInfo(ID) {
            var RegNo = $("[id*=hfRegNo]").val();
            if (ID == "0") {
                ID = "";
            }
            $.ajax({

                type: "POST",
                url: "../Students/StudentInfo.aspx/GetScholarshipInfo",
                data: '{"regno": "' + RegNo + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnGetScholarshipInfoSuccess,
                failure: function (response) {
                    AlertMessage('info', response.d);
                },
                error: function (response) {
                    AlertMessage('info', response.d);
                }
            });
        }

        function OnGetScholarshipInfoSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var Scholarships = xml.find("Scholarships");
            var row = $("[id*=dgScholarship] tr:last-child").clone(true);
            $("[id*=dgScholarship] tr").not($("[id*=dgScholarship] tr:first-child")).remove();
            var eanchor = ''
            var eanchorEnd = '';
            var danchor = ''
            var danchorEnd = '';
            if ($("[id*=hfEditPrm]").val() == 'false') {
                eanchor = "<a>";
                eanchorEnd = "</a>";
            }
            else {
                eanchor = "<a  href=\"javascript:EditScholarship('";
                eanchorEnd = "');\">Edit</a>";
            }
            if ($("[id*=hfDeletePrm]").val() == 'false') {
                danchor = "<a>";
                danchorEnd = "</a>";
            }
            else {
                danchor = "<a  href=\"javascript:DeleteScholarship('";
                danchorEnd = "');\">Delete</a>";
            }
            // $("#chkBroSis").attr("checked", "true");        
            // ShowScholarship();
            if (Scholarships.length == 0) {
                $("td", row).eq(0).html("");
                $("td", row).eq(1).html("");
                $("td", row).eq(2).html("No Records Found").attr("align", "center");
                $("td", row).eq(3).html("").removeClass("editacc edit-links");
                $("td", row).eq(4).html("").removeClass("deleteacc delete-links"); ;
                $("[id*=dgScholarship]").append(row);
                row = $("[id*=dgScholarship] tr:last-child").clone(true);

            }
            else {
                // $("#chkBroSis").attr("checked", "true");
                //ShowScholarship();
                $.each(Scholarships, function () {
                    row.addClass("even");
                    var ehref = eanchor + $(this).find("RegNo").text() + "','" + $(this).find("StudScholId").text() + eanchorEnd;
                    var dhref = danchor + $(this).find("StudScholId").text() + danchorEnd;
                    $("td", row).eq(0).html($(this).find("SNO").text());
                    $("td", row).eq(1).html($(this).find("ScholarshipId").text());
                    $("td", row).eq(2).html($(this).find("ScholarshipName").text());
                    $("td", row).eq(3).html(ehref).addClass("editacc edit-links");
                    $("td", row).eq(4).html(dhref).addClass("deleteacc delete-links");
                    $("[id*=dgScholarship]").append(row);
                    row = $("[id*=dgScholarship] tr:last-child").clone(true);


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



        function ScholarshipDetailsClear() {
            $('#aspnetForm').validate().resetForm();
            $("[id*=ddlScholarship]").val("");
            $("[id*=btnScholarshipSubmit]").attr("disabled", "false");
            if ($("[id*=hfAddPrm]").val() == 'false') {
                $("table.form :input").prop('disabled', true);
            }
            else
                $("table.form :input").prop('disabled', false);
        }


        function DeleteScholarship(StudScholID) {

            if (jConfirm('Are you sure to delete this?', 'Confirm', function (r) {
                if (r) {
                    $.ajax({

                        type: "POST",
                        url: "../Students/StudentInfo.aspx/DeleteScholarshipInfo",
                        data: '{StudScholID: ' + StudScholID + '}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: OnDeleteScholarshipInfoSuccess,
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

        function OnDeleteScholarshipInfoSuccess(response) {
            var currentPage = $("[id*=currentPage]").text();
            if (response.d == "Deleted") {
                AlertMessage('success', 'Deleted');
                var RegNo = $("[id*=hfRegNo]").val();
                if (RegNo != "") {
                    GetScholarshipInfo(RegNo);
                }
            }
            else if (response.d == "Delete Failed") {
                AlertMessage('fail', 'Delete');
            }
        };


        function GetSportsInfo(ID) {
            var RegNo = $("[id*=hfRegNo]").val();
            if (ID == "0") {
                ID = "";
                RegNo = "0";
            }
            if (RegNo != "") {
                $.ajax({

                    type: "POST",
                    url: "../Students/StudentInfo.aspx/GetSportsInfo",
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
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var sports = xml.find("Sports");
            var row = $("[id*=dgSports] tr:last-child").clone(true);
            $("[id*=dgSports] tr").not($("[id*=dgSports] tr:first-child")).remove();
            if (sports.length == 0) {
                $("td", row).eq(0).html("No Records Found").attr("align", "left");
                $("td", row).eq(1).html("").removeClass("editacc edit-links").removeClass("deleteacc delete-links");
                $("[id*=dgSports]").append(row);
                row = $("[id*=dgSports] tr:last-child").clone(true);

            }
            else {
                $.each(sports, function () {

                    row.addClass("even");
                    $("td", row).eq(0).html($(this).find("SportName").text());
                    var recstatus = "";
                    $("td", row).eq(1).html('').removeClass("editacc edit-links").removeClass("deleteacc delete-links");
                    if ($(this).find("StudSportId").text() != null && $(this).find("StudSportId").text() != "") {
                        recstatus = "Update";
                        ApporvalStatus = '<a href="javascript:void(0)" onclick="ManageSports(\'' + $(this).find("RegNo").text() + '\',\'' + $(this).find("SportId").text() + '\',\'' + recstatus + '\');" ><span class="tcsend">Delete</span> </a>';
                        $("td", row).eq(1).html(ApporvalStatus).addClass("deleteacc delete-links");
                    }
                    else {
                        recstatus = "Add";
                        ApporvalStatus = '<a href="javascript:void(0)" onclick="ManageSports(\'' + $(this).find("RegNo").text() + '\',\'' + $(this).find("SportId").text() + '\',\'' + recstatus + '\');" ><span class="tcsend">Add</span> </a>';
                        $("td", row).eq(1).html(ApporvalStatus).addClass("editacc edit-links");
                    }
                    $("[id*=dgSports]").append(row);
                    row = $("[id*=dgSports] tr:last-child").clone(true);


                });

                if ($("[id*=hfEditPrm]").val() == 'false') {
                    $('.editacc').hide();
                }
                else {
                    $('.editacc').show();
                }
            }
        }

        function ManageSports(RegNo, SportId, Status) {

            $.ajax({
                type: "POST",
                url: "../Students/StudentInfo.aspx/ManageSports",
                data: '{"regno": "' + RegNo + '","sportid" : "' + SportId + '","status" : "' + Status + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    GetSportsInfo(RegNo);
                },
                failure: function (response) {
                    AlertMessage('info', response.d);
                },
                error: function (response) {
                    AlertMessage('info', response.d);
                }
            });
        }
        function SaveCurricularDetails() {
            if (($("[id*=hfAddPrm]").val() == 'true') || ($("[id*=hfEditPrm]").val() == 'true')) {
                if ($("[id*=hfRegNo]").val() != '') {
                    var RegNo = $("[id*=hfRegNo]").val();
                    if (document.getElementById('rbtnSports').checked == true) {
                        var Curi = "Sports";
                    }
                    else if (document.getElementById('rbtnFine').checked == true) {
                        var Curi = "FineArts";
                    }
                    $.ajax({
                        type: "POST",
                        url: "../Students/StudentInfo.aspx/SaveCurricularDetails",
                        data: '{"regno": "' + RegNo + '","type": "' + Curi + '","curricularremarks" : "' + $("[id*=txtCurricularRemarks]").val() + '"}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            if (response.d == "Success") {
                                AlertMessage('success', "Updated");
                                GetStudentInfo(RegNo);
                                changeAccordion(7);
                            }
                            else {
                                AlertMessage('info', "Select any data for " + Curi + "");
                            }

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
                    AlertMessage('info', "Please Enter Personal Details");
                    changeAccordion(0);
                }
            }

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
                    url: "../Students/StudentInfo.aspx/GetFineArtsInfo",
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
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var finearts = xml.find("FineArts");
            var row = $("[id*=dgFineArts] tr:last-child").clone(true);
            $("[id*=dgFineArts] tr").not($("[id*=dgFineArts] tr:first-child")).remove();
            var recstatus = "";
            if (finearts.length == 0) {
                $("td", row).eq(0).html("No Records Found").attr("align", "left");
                $("td", row).eq(1).html("").removeClass("editacc edit-links");
                $("[id*=dgFineArts]").append(row);
                row = $("[id*=dgFineArts] tr:last-child").clone(true);

            }
            else {

                $.each(finearts, function () {
                    row.addClass("even");
                    $("td", row).eq(0).html($(this).find("FineArtName").text());
                    $("td", row).eq(1).html('').removeClass("editacc edit-links").removeClass("deleteacc delete-links");
                    if ($(this).find("StudFineArtId").text() != null && $(this).find("StudFineArtId").text() != "") {
                        recstatus = "Update";
                        ApporvalStatus = '<a href="javascript:void(0)" onclick="ManageFineArts(\'' + $(this).find("RegNo").text() + '\',\'' + $(this).find("FineArtId").text() + '\',\'' + recstatus + '\');" ><span class="tcsend">Delete</span> </a>';
                        $("td", row).eq(1).html(ApporvalStatus).addClass("deleteacc delete-links");
                    }
                    else {
                        recstatus = "Add";
                        ApporvalStatus = '<a href="javascript:void(0)" onclick="ManageFineArts(\'' + $(this).find("RegNo").text() + '\',\'' + $(this).find("FineArtId").text() + '\',\'' + recstatus + '\');" ><span class="tcsend">Add</span> </a>';
                        $("td", row).eq(1).html(ApporvalStatus).addClass("editacc edit-links");
                    }
                    $("td", row).eq(1).html(ApporvalStatus);
                    $("[id*=dgFineArts]").append(row);
                    row = $("[id*=dgFineArts] tr:last-child").clone(true);

                });

                if ($("[id*=hfEditPrm]").val() == 'false') {
                    $('.editacc').hide();
                }
                else {
                    $('.editacc').show();
                }
            }
        }

        function ManageFineArts(RegNo, FineArtsID, Status) {
            $.ajax({
                type: "POST",
                url: "../Students/StudentInfo.aspx/ManageFineArts",
                data: '{"regno": "' + RegNo + '","fineartsid" : "' + FineArtsID + '","status" : "' + Status + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    GetFineArtsInfo(RegNo);
                },
                failure: function (response) {
                    AlertMessage('info', response.d);
                },
                error: function (response) {
                    AlertMessage('info', response.d);
                }
            });
        }

        function GetActivitiesInfo(ID) {
            var RegNo = $("[id*=hfRegNo]").val();
            if (ID == "0") {
                ID = "";
                RegNo = "0";
            }
            if (RegNo != "") {
                $.ajax({

                    type: "POST",
                    url: "../Students/StudentInfo.aspx/GetActivitiesInfo",
                    data: '{regno: ' + RegNo + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnGetActivitiesInfoSuccess,
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
        function OnGetActivitiesInfoSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var acti = xml.find("Activities");
            var row = $("[id*=dgActivities] tr:last-child").clone(true);
            $("[id*=dgActivities] tr").not($("[id*=dgActivities] tr:first-child")).remove();
            var recstatus = "";
            if (acti.length == 0) {
                $("td", row).eq(1).html("");
                $("td", row).eq(0).html("No Records Found").attr("align", "left");
                $("td", row).eq(1).html("").removeClass("editacc edit-links");
                $("[id*=dgActivities]").append(row);
                row = $("[id*=dgActivities] tr:last-child").clone(true);

            }
            else {

                $.each(acti, function () {
                    row.addClass("even");
                    $("td", row).eq(0).html($(this).find("ActName").text());
                    $("td", row).eq(1).html('').removeClass("editacc edit-links").removeClass("deleteacc delete-links");
                    if ($(this).find("StudActId").text() != null && $(this).find("StudActId").text() != "") {
                        recstatus = "Update";
                        ApporvalStatus = '<a href="javascript:void(0)" onclick="ManageActivities(\'' + $(this).find("RegNo").text() + '\',\'' + $(this).find("ActId").text() + '\',\'' + recstatus + '\');" ><span class="tcsend">Remove from Payment</span> </a>';
                        $("td", row).eq(1).html(ApporvalStatus).addClass("deleteacc delete-links");
                    }
                    else {
                        recstatus = "Add";
                        ApporvalStatus = '<a href="javascript:void(0)" onclick="ManageActivities(\'' + $(this).find("RegNo").text() + '\',\'' + $(this).find("ActId").text() + '\',\'' + recstatus + '\');" ><span class="tcsend">Add to Payment</span> </a>';
                        $("td", row).eq(1).html(ApporvalStatus).addClass("editacc edit-links");
                    }
                    $("td", row).eq(1).html(ApporvalStatus);
                    $("[id*=dgActivities]").append(row);
                    row = $("[id*=dgActivities] tr:last-child").clone(true);

                });

                if ($("[id*=hfEditPrm]").val() == 'false') {
                    $('.editacc').hide();
                }
                else {
                    $('.editacc').show();
                }
            }
        }


        function ManageActivities(RegNo, ActID, Status) {
            var Remarks = $("[id*=txtActivityRemarks]").val();
            $.ajax({
                type: "POST",
                url: "../Students/StudentInfo.aspx/ManageActivities",
                data: '{"regno": "' + RegNo + '","ActID" : "' + ActID + '","Remarks" : "' + Remarks + '","status" : "' + Status + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    GetActivitiesInfo(RegNo);
                },
                failure: function (response) {
                    AlertMessage('info', response.d);
                },
                error: function (response) {
                    AlertMessage('info', response.d);
                }
            });
        }


        function GetSkillInfo(ID) {
            var RegNo = $("[id*=hfRegNo]").val();
            if (ID == "0") {
                ID = "";
                RegNo = "0";
            }
            if (RegNo != "") {
                $.ajax({

                    type: "POST",
                    url: "../Students/StudentInfo.aspx/GetSkillInfo",
                    data: '{regno: ' + RegNo + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnGetSkillInfoSuccess,
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
        function OnGetSkillInfoSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var finearts = xml.find("Skills");
            var row = $("[id*=dgSkills] tr:last-child").clone(true);
            $("[id*=dgSkills] tr").not($("[id*=dgSkills] tr:first-child")).remove();
            var recstatus = "";
            if (finearts.length == 0) {
                $("td", row).eq(0).html("No Records Found").attr("align", "left");
                $("td", row).eq(1).html("").removeClass("editacc edit-links");
                $("[id*=dgSkills]").append(row);
                row = $("[id*=dgSkills] tr:last-child").clone(true);

            }
            else {

                $.each(finearts, function () {
                    row.addClass("even");
                    $("td", row).eq(0).html($(this).find("SkillName").text());
                    $("td", row).eq(1).html('').removeClass("editacc edit-links").removeClass("deleteacc delete-links");
                    if ($(this).find("StudSkillId").text() != null && $(this).find("StudSkillId").text() != "") {
                        recstatus = "Update";
                        ApporvalStatus = '<a href="javascript:void(0)" onclick="ManageSkills(\'' + $(this).find("RegNo").text() + '\',\'' + $(this).find("SkillId").text() + '\',\'' + recstatus + '\');" ><span class="tcsend">Delete</span> </a>';
                        $("td", row).eq(1).html(ApporvalStatus).addClass("deleteacc delete-links");
                    }
                    else {
                        recstatus = "Add";
                        ApporvalStatus = '<a href="javascript:void(0)" onclick="ManageSkills(\'' + $(this).find("RegNo").text() + '\',\'' + $(this).find("SkillId").text() + '\',\'' + recstatus + '\');" ><span class="tcsend">Add</span> </a>';
                        $("td", row).eq(1).html(ApporvalStatus).addClass("editacc edit-links");
                    }
                    $("td", row).eq(1).html(ApporvalStatus);
                    $("[id*=dgSkills]").append(row);
                    row = $("[id*=dgSkills] tr:last-child").clone(true);

                });

                if ($("[id*=hfEditPrm]").val() == 'false') {
                    $('.editacc').hide();
                }
                else {
                    $('.editacc').show();
                }
            }
        }

        function ManageSkills(RegNo, SkillID, Status) {
            $.ajax({
                type: "POST",
                url: "../Students/StudentInfo.aspx/ManageSkills",
                data: '{"regno": "' + RegNo + '","SkillID" : "' + SkillID + '","status" : "' + Status + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    GetSkillInfo(RegNo);
                },
                failure: function (response) {
                    AlertMessage('info', response.d);
                },
                error: function (response) {
                    AlertMessage('info', response.d);
                }
            });
        }


        var Skill = "";
        function SaveSkillDetails() {
            if (($("[id*=hfAddPrm]").val() == 'true') || ($("[id*=hfEditPrm]").val() == 'true')) {
                if ($("[id*=hfRegNo]").val() != '') {
                    var RegNo = $("[id*=hfRegNo]").val();
                    if (document.getElementById('rbtnSkillYes').checked == true) {
                        Skill = "1";
                    }
                    else if (document.getElementById('rbtnSkillNo').checked == true) {
                        skill = "0";
                    }
                    $.ajax({
                        type: "POST",
                        url: "../Students/StudentInfo.aspx/SaveSkillDetails",
                        data: '{"regno": "' + RegNo + '","Skill": "' + Skill + '","SkillRemarks" : "' + $("[id*=txtSkillRemarks]").val() + '"}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            if (response.d == "Success") {
                                AlertMessage('success', "Updated");
                                GetStudentInfo(RegNo);
                                changeAccordion(8);
                            }
                            else {
                                AlertMessage('info', "Select any data for Skills");
                            }

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
                    AlertMessage('info', "Please Enter Personal Details");
                    changeAccordion(0);
                }
            }

        }

    </script>
    <script type="text/javascript">

        function showbrosis() {
            if (document.getElementById('chkBroSis').checked == true) {
                $(".brosis").slideDown("slow");
            }
            if (document.getElementById('chkBroSis').checked == false) {
                $(".brosis").slideUp("slow");
            }
        }
        function ShowNationality() {
            if (document.getElementById('rbtnOverseas').checked == true) {
                $("#dvNationality").slideDown("slow");
            }
            if (document.getElementById('rbtnIndian').checked == true) {
                $("#dvNationality").slideUp("slow");
            }
        }
        function showphysical() {
            if (document.getElementById('rbtnPHYes').checked == true) {
                $("#dvPhy").slideDown("slow");
            }
            if (document.getElementById('rbtnNoPH').checked == true) {
                $("#dvPhy").slideUp("slow");
            }
        }
        function ShowScholarship() {
            if (document.getElementById('rbtnScholarYes').checked == true) {
                $("#dvScholar").slideDown("slow");
            }
            if (document.getElementById('rbtnNoScholar').checked == true) {
                $("#dvScholar").slideUp("slow");
            }
        }
        function ShowConcession() {
            if (document.getElementById('rbtnConcessYes').checked == true) {
                $("#dvConcession").slideDown("slow");
            }
            if (document.getElementById('rbtnNoConcess').checked == true) {
                $("#dvConcession").slideUp("slow");
            }
        }
        function ShowConcessionTab() {
            $("#dvConcession").slideDown("slow");
        }
        function ShowHostel() {
            if (document.getElementById('rbtnHostelYes').checked == true) {
                $("#dvHostel").slideDown("slow");
            }
            if (document.getElementById('rbtnHostelNo').checked == true) {
                $("#dvHostel").slideUp("slow");
            }
        }
        function ShowSkill() {
            if (document.getElementById('rbtnSkillYes').checked == true) {
                $("#dvSkills").slideDown("slow");
            }
            if (document.getElementById('rbtnSkillNo').checked == true) {
                $("#dvSkills").slideUp("slow");
            }
        }
        function ShowCurricular() {
            if (document.getElementById('rbtnSports').checked == true) {
                $("#dvSports").css("display", "block");
                $("#dvFineArts").css("display", "none");
            }
            if (document.getElementById('rbtnFine').checked == true) {
                $("#dvFineArts").css("display", "block");
                $("#dvSports").css("display", "none");
            }
        }
        function ShowBus() {
            if (document.getElementById('rbtnBusYes').checked == true) {
                $("#dvBus").slideDown("slow");
            }
            if (document.getElementById('rbtnBusNo').checked == true) {
                $("#dvBus").slideUp("slow");
            }
        }
        function ShowInstitution() {
            if (document.getElementById('rbtnInsYes').checked == true) {
                $("#dvInstitution").slideDown("slow");
            }
            if (document.getElementById('rbtnInsNo').checked == true) {
                $("#dvInstitution").slideUp("slow");
            }
        } 
    </script>
    <script type="text/javascript">
        function CheckAll() {
            if ($("[id*=chkContact]").is(':checked')) {
                $("[id*=txtPerAddress]").val($("[id*=txtTempAddress]").val());
                $("[id*=txtPerAddress]").attr("disabled", true);
            }
            else {
                $("[id*=txtPerAddress]").attr("disabled", false);
                $("[id*=txtPerAddress]").val('');
            }
        }
    </script>
    <script type="text/javascript">
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
                    formdata.append("StudentImage", input.files[0]);
                }
            }
        }
        function readMedRemURL(input) {

            if (window.FormData) {
                formdata = new FormData();
            }
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.readAsDataURL(input.files[0]);
                if (formdata) {
                    formdata.append("MedicalRemarks", input.files[0]);
                }
            }
        }
        function readAttFileURL(input) {

            if (window.FormData) {
                formdata = new FormData();
            }
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.readAsDataURL(input.files[0]);
                if (formdata) {
                    formdata.append("Attachment", input.files[0]);
                }
            }
        }

        function readSportFileURL(input) {

            if (window.FormData) {
                formdata = new FormData();
            }
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.readAsDataURL(input.files[0]);
                if (formdata) {
                    formdata.append("SportAttachment", input.files[0]);
                }
            }
        }

        function readAwardsFileURL(input) {

            if (window.FormData) {
                formdata = new FormData();
            }
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.readAsDataURL(input.files[0]);
                if (formdata) {
                    formdata.append("AwardAttachment", input.files[0]);
                }
            }
        }
        function readAbledFileURL(input) {

            if (window.FormData) {
                formdata = new FormData();
            }
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.readAsDataURL(input.files[0]);
                if (formdata) {
                    formdata.append("AbledAttachment", input.files[0]);
                }
            }
        }

        function readAllergicFileURL(input) {

            if (window.FormData) {
                formdata = new FormData();
            }
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.readAsDataURL(input.files[0]);
                if (formdata) {
                    formdata.append("AllergicAttachment", input.files[0]);
                }
            }
        }



        function changeAccordion(value) {
            $(".john-accord").accordion({
                "header": "a.menuitem",
                "collapsible": true,
                "active": parseInt(value),
                "autoHeight": false

            });
        }

    </script>
    <script type="text/javascript">
        function GetModuleMenuID(path) {
            $.ajax({
                type: "POST",
                url: "../Students/Studentinfo.aspx/GetModuleMenuId",
                data: '{"path": "' + path + '","UserId":"' + $("[id*=hfUserId]").val() + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnModuleMenuIDSuccess,
                failure: function (response) {
                    AlertMessage('info', response.d);
                },
                error: function (response) {
                    AlertMessage('info', response.d);
                }
            });

        }
        function OnModuleMenuIDSuccess(response) {

            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var modmenu = xml.find("ModuleMenu");
            $("[id*=hfAdvMenuId]").val(modmenu.find("menuid").text());
            $("[id*=hfAdvModuleID]").val(modmenu.find("modulemenuid").text());
            //        alert($("[id*=hfAdvMenuId]").val());
            //        alert($("[id*=hfAdvModuleID]").val());
        }


    </script>
    <style type="text/css">
        article, aside, figure, footer, header, hgroup, menu, nav, section
        {
            display: block;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="head2" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="grid_10">
        <div class="box round first fullpage">
            <h2>
                <span style="color: rgb(227, 227, 227); font-family: system-ui, sans-serif; font-size: 12px;
                    font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal;
                    font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px;
                    text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px;
                    white-space: normal; background-color: rgb(40, 40, 40); text-decoration-thickness: initial;
                    text-decoration-style: initial; text-decoration-color: initial; display: inline !important;
                    float: none;"></span>Student Information
                <div id="jSuccess-info">
                    <table>
                        <tr>
                            <td style="width: 250px; float: left">
                                <span id="spnAppno">Application No :<asp:Label ID="lblApplicationNo" runat="server"></asp:Label></span>
                            </td>
                            <td style="width: 250px; float: left">
                                <span id="Span1">ASOS Reg. No :<asp:Label ID="lblASSRegNo" runat="server"></asp:Label></span>
                            </td>
                            <td style="width: 250px; float: left">
                                <span id="spnRegno">Registration No :<asp:Label ID="lblRegNo" runat="server"></asp:Label></span>
                            </td>
                            <td style="width: 250px; float: left">
                                Student Name :
                                <asp:Label ID="lblStudentName" runat="server"></asp:Label>
                            </td>
                            <td style="width: 250px; float: left">
                                Class & Section :
                                <asp:Label ID="lblClass" runat="server"></asp:Label>
                            </td>
                            <td style="width: 250px; float: left">
                                Present Status :
                                <asp:Label ID="lblStatus" runat="server"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
            </h2>
            <div class="clear">
            </div>
            <div class="block john-accord content-wrapper4">
                <ul class="section menu">
                    <li><a style="border-width: 1px; border-style: dotted; border-color: #CCCCCC;" class="menuitem">
                        Personal Details</a>
                        <ul class="johnmenu">
                            <li>
                                <div style="border-bottom-style: none; border-bottom-width: 0px;" id="dvPersonal"
                                    class="frm-block">
                                    <table class="form" width="100%">
                                        <tr>
                                            <td align="center" colspan="4">
                                                <div style="float: left; width: 120px; right: 60px; margin-top: 5px;">
                                                    <img id="img_prev" src="../img/photo.jpg" class='zoom' alt="Profile Photo" width="114"
                                                        height="114" />
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="20%" class="col1">
                                                <span style="color: Red">*</span>
                                                <label>
                                                    Student Enroll From</label>
                                            </td>
                                            <td width="26%" class="col2">
                                                <label>
                                                    <input type="radio" checked="checked" id="rbtnahss" onchange="showregno();" class="studenttype"
                                                        name="studenttype" value="AHSS" />AHSS &nbsp;
                                                    <input type="radio" id="rbtnala" class="studenttype" onchange="showregno();" name="studenttype"
                                                        value="ALA" />ALA &nbsp;
                                                    <input type="radio" id="rbtnoutside" class="studenttype" onchange="showregno();"
                                                        name="studenttype" value="OTHERS" />OTHERS &nbsp;</label>
                                            </td>
                                            <td width="14%" class="col2">
                                                <span class="col1">
                                                    <label>
                                                        Search By Student Regno</label>
                                                </span>
                                            </td>
                                            <td class="col2">
                                                <asp:TextBox ID="txtSearchRegNo" onkeydown="GetStudentData(this.value);" onblur="GetStudentData(this.value);"
                                                    runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="20%" class="col1">
                                                <span style="color: Red">*</span>
                                                <label>
                                                    Student Name :</label>
                                            </td>
                                            <td width="26%" class="col2">
                                                <asp:TextBox ID="txtStudentName" CssClass="jsrequired" runat="server"></asp:TextBox>
                                            </td>
                                            <td width="14%" class="col2">
                                                <span class="col1">
                                                    <label>
                                                        Sex :</label>
                                                </span>
                                            </td>
                                            <td class="col2">
                                                <label>
                                                    <input type="radio" name="rb1" id="rbtnMale" value="Male" checked="checked" />Male</label>
                                                <label>
                                                    <input type="radio" name="rb1" id="rbtnFemale" value="Female" />Female</label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="9%">
                                                <span style="color: Red">*</span>
                                                <label>
                                                    Class :</label>
                                            </td>
                                            <td width="18%">
                                                <asp:DropDownList ID="ddlClass" CssClass="jsrequired" runat="server" AppendDataBoundItems="True"
                                                    onchange="GetSectionByClass(); GetSportsByClass();">
                                                    <asp:ListItem Selected="True" Value="">---Select---</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td width="11%">
                                                <label>
                                                    Section :</label>
                                            </td>
                                            <td width="20%">
                                                <asp:DropDownList ID="ddlSection" runat="server" AppendDataBoundItems="True">
                                                    <asp:ListItem Selected="True" Value="">Select</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label>
                                                    <span style="color: Red">*</span> Date of Birth :</label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtDOB" CssClass="jsrequired dateNL date-picker" runat="server"></asp:TextBox>
                                            </td>
                                            <td>
                                                <label>
                                                    Mother Tongue :
                                                </label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtMotherTongue" CssClass="" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label>
                                                    Religion :</label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlReligion" CssClass="" runat="server" AppendDataBoundItems="True">
                                                    <asp:ListItem Selected="True" Value="">---Select---</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <label>
                                                    Community :</label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlCommunity" CssClass="" runat="server" AppendDataBoundItems="True">
                                                    <asp:ListItem Selected="True" Value="">---Select---</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label>
                                                    Caste :</label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlCaste" CssClass="" runat="server" AppendDataBoundItems="True">
                                                    <asp:ListItem Selected="True" Value="">---Select---</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <label>
                                                    Aadhaar card :</label>
                                            </td>
                                            <td>
                                                <label for="textarea">
                                                </label>
                                                <asp:TextBox ID="txtAadhaar" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                          <tr>
                                            <td>
                                                <label>
                                                    Father Aadhaar card :</label>
                                            </td>
                                            <td>
                                                <label for="textarea">
                                                </label>
                                                <asp:TextBox ID="txtFatherAadhaar" runat="server"></asp:TextBox>
                                            </td>
                                            <td>
                                                <label>
                                                    Mother Aadhaar card :</label>
                                            </td>
                                            <td>
                                                <label for="textarea">
                                                </label>
                                                <asp:TextBox ID="txtMotherAadhaar" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label>
                                                    Temporary Address :</label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtTempAddress" TextMode="MultiLine" Rows="5" Columns="30" onchange="CheckAll();"
                                                    runat="server" OnTextChanged="txtTempAddress_TextChanged"></asp:TextBox>
                                            </td>
                                            <td>
                                                <label>
                                                    Permanent Address :</label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtPerAddress" TextMode="MultiLine" Rows="5" Columns="30" runat="server"></asp:TextBox>
                                                <br />
                                                <label>
                                                    <input type="checkbox" name="chkContact" id="chkContact" value="contact" onchange="CheckAll();"
                                                        checked="checked" />
                                                    Same as Temporary Address</label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label>
                                                    Email :</label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtEmail" CssClass="email" runat="server"></asp:TextBox>
                                            </td>
                                            <td>
                                                <label>
                                                    <span style="color: Red">*</span> Phone No :</label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtPhoneNo" CssClass="jsrequired" Text="" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label>
                                                    Upload Image :</label>
                                            </td>
                                            <td>
                                                <input type='file' id="FuPhoto" onchange="readURL(this);" />
                                            </td>
                                            <td>
                                                <span style="color: Red">*</span>
                                                <label>
                                                    Date of Join:</label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtDOJ" CssClass="jsrequired dateNL date-picker" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label>
                                                    Smart Card No :</label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtSmartCardNo" runat="server"></asp:TextBox>
                                            </td>
                                            <td>
                                                <label>
                                                    Ration Card No :</label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtRationCardNo" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label>
                                                    SSLC certificate No. :</label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtSSLC" runat="server"></asp:TextBox>
                                            </td>
                                            <td>
                                                <label>
                                                    Year of Passing :</label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlSSLC" runat="server">
                                                    <asp:ListItem Value="">Select</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label>
                                                    HSC certificate No. :</label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtHSC" runat="server"></asp:TextBox>
                                            </td>
                                            <td>
                                                <label>
                                                    Year of Passing :</label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlHSC" runat="server">
                                                    <asp:ListItem Value="">Select</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label>
                                                    Student Unique No. :</label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtSUID" runat="server"></asp:TextBox>
                                            </td>
                                            <td>
                                                <label>
                                                    Student Name in Tamil :</label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtTamilname" CssClass="text_tam" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr id="trpersonal">
                                            <td colspan="4" align="center">
                                                <table border="0" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td>
                                                            <asp:HiddenField ID="hfStudentInfoID" runat="server" />
                                                            <asp:HiddenField ID="hfAcademicyear" runat="server" />
                                                            <asp:HiddenField ID="hfRegNo" runat="server" />
                                                            <asp:HiddenField ID="hfASSNo" runat="server" />
                                                            <asp:HiddenField ID="hfModuleID" runat="server" />
                                                            <asp:HiddenField ID="hfUserId" runat="server" />
                                                        </td>
                                                        <td>
                                                            <button id="btnPersonalSubmit" type="button" class="btn-icon btn-orange btn-saving"
                                                                onclick="SavePersonalDetails();">
                                                                <span></span>
                                                                <div id="spPersonalSubmit">
                                                                    Save</div>
                                                            </button>
                                                            &nbsp;
                                                        </td>
                                                        <td>
                                                            <button id="btnPersonalCancel" type="button" class="btn-icon btn-navy btn-cancel1"
                                                                runat="server" onclick="return PersonalDetailsClear();">
                                                                <span></span>Cancel</button>&nbsp;
                                                        </td>
                                                        <td style="padding-top: 0px; display: none;">
                                                            &nbsp;
                                                            <button id="btnAdvanceFees" type="button" class="btn-icon btn-orange btn-saving"
                                                                onclick="SaveandPayAdvanceFees();">
                                                                <span></span>
                                                                <div id="spFeesSubmit">
                                                                    Save & Pay Advance Fees</div>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </li>
                        </ul>
                    </li>
                    <li><a style="border-width: 1px; border-style: dotted; border-color: #CCCCCC;" class="menuitem">
                        Parents / Guardian Details</a>
                        <ul class="johnmenu">
                            <li>
                                <div id="dvFamily" style="border-bottom-style: none; border-bottom-width: 0px;" class="frm-block">
                                    <table class="form" width="100%">
                                        <tr>
                                            <td width="20%" class="col1">
                                                <label>
                                                    <span style="color: Red">*</span> Relationship :</label>
                                            </td>
                                            <td width="28%" class="col2">
                                                <asp:DropDownList ID="ddlRelationship" CssClass="jsrequired" runat="server" onchange="chkpriority();"
                                                    AppendDataBoundItems="True">
                                                    <asp:ListItem Selected="True" Value="">---Select---</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td width="20%" class="col1">
                                                <label>
                                                    <span style="color: Red">*</span> Name :</label>
                                            </td>
                                            <td width="28%" class="col2">
                                                <asp:TextBox ID="txtName" CssClass="jsrequired" Text="" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="19%" class="col2">
                                                <span class="col1">
                                                    <label>
                                                        Qualification :</label>
                                                </span>
                                            </td>
                                            <td width="33%" class="col2">
                                                <asp:TextBox ID="txtQualification" runat="server"></asp:TextBox>
                                            </td>
                                            <td>
                                                <label>
                                                    Annual Income :</label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtIncome" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label>
                                                    Occupation :
                                                </label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtOccupation" runat="server"></asp:TextBox>
                                            </td>
                                            <td>
                                                <label>
                                                    Email :</label>
                                            </td>
                                            <td>
                                                <span class="col2">
                                                    <asp:TextBox ID="txtRelEmail" CssClass="email" runat="server"></asp:TextBox>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label>
                                                    <span style="color: Red">*</span> Mobile :</label>
                                            </td>
                                            <td>
                                                <span class="col2">
                                                    <asp:TextBox ID="txtRelMobile" CssClass="jsrequired numbersonly" runat="server"></asp:TextBox>
                                                </span>
                                            </td>
                                            <td>
                                                <label>
                                                    Occupational Address:</label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtOccAddress" TextMode="MultiLine" Rows="5" Columns="30" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label>
                                                    <span style="color: Red">*</span> SMS Priority :</label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlSMSPriority" CssClass="" runat="server" AppendDataBoundItems="True">
                                                    <asp:ListItem Selected="True" Value="">---Select---</asp:ListItem>
                                                    <asp:ListItem Value="1">Father</asp:ListItem>
                                                    <asp:ListItem Value="2">Mother</asp:ListItem>
                                                    <asp:ListItem Value="3">Guardian I</asp:ListItem>
                                                    <asp:ListItem Value="4">Guardian II</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <label>
                                                    Care Taker :</label>
                                            </td>
                                            <td>
                                                <span class="col2">
                                                    <input type="radio" id="rbtnParent" value="Parent" name="rbtnCare" checked="checked" />
                                                    Parent
                                                    <input type="radio" id="rbtnGaurdian" value="Gaurdian" name="rbtnCare" />
                                                    Gaurdian</span>
                                            </td>
                                        </tr>
                                        <tr id="trfamily">
                                            <td colspan="4" align="center">
                                                <button id="btnRelationshipSubmit" type="button" class="btn-icon btn-navy btn-update"
                                                    onclick="SaveFamilyDetails();">
                                                    <span></span>Update</button>
                                                <button id="btnRelationshipCancel" type="button" class="btn-icon btn-navy btn-cancel1"
                                                    runat="server" onclick="return FamilyDetailsClear();">
                                                    <span></span>Cancel</button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4">
                                                <div class="block">
                                                    <table width="100%">
                                                        <tr valign="top">
                                                            <td valign="top">
                                                                <asp:GridView ID="dgRelationship" runat="server" Width="100%" AutoGenerateColumns="False"
                                                                    AllowPaging="True" ShowFooter="True" HorizontalAlign="Center" RowStyle-CssClass="even"
                                                                    AlternatingRowStyle-CssClass="odd" EnableModelValidation="True" CssClass="display">
                                                                    <Columns>
                                                                        <asp:BoundField DataField="Relationship" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                            HeaderText="Relationship" SortExpression="Relationship">
                                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="Name" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                            HeaderText="Name" SortExpression="Name">
                                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="Qualification" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                            HeaderText="Qualification" SortExpression="Qualification">
                                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="Occupation" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                            HeaderText="Occupation" SortExpression="Occupation">
                                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="Income" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                            HeaderText="Income" SortExpression="Income">
                                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="Address" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                            HeaderText="Address" SortExpression="Address">
                                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="Email" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                            HeaderText="Email" SortExpression="Email">
                                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="Mobile" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                            HeaderText="Mobile" SortExpression="Mobile">
                                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                                                            HeaderStyle-CssClass="sorting_mod editacc">
                                                                            <HeaderTemplate>
                                                                                Edit</HeaderTemplate>
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandArgument='<%# Eval("StudentId") %>'
                                                                                    CommandName="Edit" CausesValidation="false" CssClass="links"></asp:LinkButton>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                                                            HeaderStyle-CssClass="sorting_mod deleteacc">
                                                                            <HeaderTemplate>
                                                                                Delete</HeaderTemplate>
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="lnkDelete" runat="server" Text="Delete" CommandArgument='<%# Eval("StudentId") %>'
                                                                                    CommandName="Delete" CausesValidation="false" CssClass="links"></asp:LinkButton>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                </asp:GridView>
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
                            </li>
                        </ul>
                    </li>
                    <li><a style="border-width: 1px; border-style: dotted; border-color: #CCCCCC;" class="menuitem">
                        Brother / Sister Details</a>
                        <ul class="johnmenu">
                            <li>
                                <div id="Div5" style="border-bottom-style: none; border-bottom-width: 0px;" class="frm-block">
                                    <table class="form" width="100%">
                                        <tr>
                                            <td colspan="4">
                                                <table width="100%" class="form">
                                                    <tr>
                                                        <td>
                                                            <label>
                                                                Is Brothers/Sisters Studying In Same Institution Address :</label>&nbsp;&nbsp;
                                                            <input type="checkbox" id="chkBroSis" onclick="javascript:showbrosis();" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <div class="brosis" id="dvBroSis" style="position: relative; width: 100%">
                                                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                                    <tr>
                                                                        <td width="21%">
                                                                            <label>
                                                                                Class</label>
                                                                        </td>
                                                                        <td width="21%">
                                                                            <label>
                                                                                Section</label>
                                                                        </td>
                                                                        <td width="20%">
                                                                            <label>
                                                                                Student</label>
                                                                        </td>
                                                                        <td>
                                                                            <label>
                                                                                Relationship</label>
                                                                        </td>
                                                                        <td>
                                                                            &nbsp;
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddlBroSisClass" CssClass="jsrequired" runat="server" AppendDataBoundItems="True"
                                                                                onchange="GetBroSisSectionByBroSisClass();">
                                                                                <asp:ListItem Selected="True" Value="">---Select---</asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddlBroSisSection" CssClass="" runat="server" AppendDataBoundItems="True"
                                                                                onchange="GetBroSisStudentByBroSisSection();">
                                                                                <asp:ListItem Selected="True" Value="">---Select---</asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddlBroSisStudentName" CssClass="jsrequired" runat="server"
                                                                                AppendDataBoundItems="True">
                                                                                <asp:ListItem Selected="True" Value="">---Select---</asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td width="16%">
                                                                            <asp:DropDownList ID="ddlBroSisRelation" CssClass="jsrequired" runat="server" AppendDataBoundItems="True">
                                                                                <asp:ListItem Selected="True" Value="">---Select---</asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td id="trbrosis" width="22%" align="left">
                                                                            <button id="btnBroSisAdd" type="button" class="btn-icon btn-navy btn-update" onclick="SaveBroSisDetails();">
                                                                                <span></span>Update</button>&nbsp;
                                                                            <button id="btnBroSisCancel" type="button" class="btn-icon btn-navy btn-cancel1"
                                                                                runat="server" onclick="return BroSisDetailsClear();">
                                                                                <span></span>Cancel</button>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="5">
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4">
                                                <div class="block">
                                                    <table width="100%">
                                                        <tr valign="top">
                                                            <td valign="top">
                                                                <asp:GridView ID="dgBroSis" runat="server" Width="100%" AutoGenerateColumns="False"
                                                                    AllowPaging="True" ShowFooter="True" HorizontalAlign="Center" RowStyle-CssClass="even"
                                                                    AlternatingRowStyle-CssClass="odd" EnableModelValidation="True" CssClass="display">
                                                                    <Columns>
                                                                        <asp:BoundField DataField="SlNo" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                            HeaderText="Sl. No." SortExpression="SlNo">
                                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="RegNo" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                            HeaderText="RegNo" SortExpression="RegNo">
                                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="Relation" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                            HeaderText="Relationship" SortExpression="Relation">
                                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="Name" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                            HeaderText="Name" SortExpression="Name">
                                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="Class" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                            HeaderText="Class" SortExpression="Class">
                                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="Section" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                            HeaderText="Section" SortExpression="Section">
                                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                                                            HeaderStyle-CssClass="sorting_mod editacc">
                                                                            <HeaderTemplate>
                                                                                Edit</HeaderTemplate>
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandArgument='<%# Eval("StudRelID") %>'
                                                                                    CommandName="Edit" CausesValidation="false" CssClass="links"></asp:LinkButton>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                                                            HeaderStyle-CssClass="sorting_mod deleteacc">
                                                                            <HeaderTemplate>
                                                                                Delete</HeaderTemplate>
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="lnkDelete" runat="server" Text="Delete" CommandArgument='<%# Eval("StudRelID") %>'
                                                                                    CommandName="Delete" CausesValidation="false" CssClass="links"></asp:LinkButton>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                </asp:GridView>
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
                            </li>
                        </ul>
                    </li>
                    <li><a style="border-width: 1px; border-style: dotted; border-color: #CCCCCC;" class="menuitem">
                        Medical Details</a>
                        <ul class="johnmenu">
                            <li>
                                <div id="dvMedical" style="border-bottom-style: none; border-bottom-width: 0px;"
                                    class="frm-block">
                                    <table class="form" width="100%">
                                        <tr>
                                            <td width="20%" class="col1">
                                                <span style="color: Red">*</span>
                                                <label>
                                                    Blood Group:</label>
                                            </td>
                                            <td width="28%" class="col2">
                                                <asp:DropDownList ID="ddlBloodGroup" CssClass="jsrequired" runat="server" AppendDataBoundItems="True">
                                                    <asp:ListItem Selected="True" Value="">---Select---</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td width="19%" class="col2">
                                                <label>
                                                    Disease /Allergy:</label>
                                            </td>
                                            <td width="33%" class="col2">
                                                <asp:TextBox ID="txtDisease" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label>
                                                    Height (cm):</label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtHeight" runat="server"></asp:TextBox>
                                            </td>
                                            <td>
                                                <label>
                                                    Weight (Kg):
                                                </label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtWeight" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label>
                                                    Emergency Phone No
                                                </label>
                                            </td>
                                            <td>
                                                <span class="col2">
                                                    <asp:TextBox ID="txtEmergencyPhNo" runat="server"></asp:TextBox>
                                                </span>
                                            </td>
                                            <td>
                                                <label>
                                                    Family Doctor Name:</label>
                                            </td>
                                            <td>
                                                <span class="col2">
                                                    <asp:TextBox ID="txtFamilyDocName" runat="server"></asp:TextBox>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label>
                                                    Address:</label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtFamilyDocAdd" TextMode="MultiLine" runat="server"></asp:TextBox>
                                            </td>
                                            <td>
                                                <label>
                                                    Doctor Phone No:</label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtFamilyDocPhNo" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label>
                                                    Identification Marks:</label>
                                            </td>
                                            <td>
                                                1.
                                                <asp:TextBox ID="txtIdentificationMarks1" CssClass="idn-marks" runat="server"></asp:TextBox>
                                            </td>
                                            <td>
                                                <label>
                                                    Physically Handicapped</label>
                                            </td>
                                            <td>
                                                <span class="col2">
                                                    <input type="radio" id="rbtnNoPH" name="rbPhysical" onclick="javascript:showphysical();"
                                                        checked="checked" />
                                                    No
                                                    <input type="radio" id="rbtnPHYes" name="rbPhysical" onclick="javascript:showphysical();" />
                                                    Yes</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td>
                                                2.
                                                <asp:TextBox ID="txtIdentificationMarks2" CssClass="idn-marks" runat="server"></asp:TextBox>
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td>
                                                <div id="dvPhy" style="display: none;">
                                                    <asp:TextBox ID="txtPhysicalHandicapped" runat="server"></asp:TextBox>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr id="trmedical">
                                            <td colspan="4" align="center">
                                                <button id="btnMedicalSave" type="button" class="btn-icon btn-navy btn-update" onclick="SaveMedicalDetails();">
                                                    <span></span>Update</button>&nbsp;
                                                <button id="btnMedicalCancel" type="button" class="btn-icon btn-navy btn-cancel1"
                                                    runat="server" onclick="return MedicalDetailsClear();">
                                                    <span></span>Cancel</button>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </li>
                        </ul>
                    </li>
                    <li><a style="border-width: 1px; border-style: dotted; border-color: #CCCCCC;" class="menuitem">
                        Medical Remarks Details</a>
                        <ul class="johnmenu">
                            <li>
                                <div id="Div3" style="border-bottom-style: none; border-bottom-width: 0px;" class="frm-block">
                                    <table class="form" width="100%">
                                        <tr>
                                            <td colspan="4">
                                                <table class="form">
                                                    <tr>
                                                        <td class="col1 formsubheading">
                                                            Medical Record Remarks :
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <div id="dvMedicalRecord" style="position: relative; width: 100%">
                                                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                                    <tr>
                                                                        <td width="21%">
                                                                            <label>
                                                                                Date</label>
                                                                        </td>
                                                                        <td width="21%">
                                                                            <label>
                                                                                Reason</label>
                                                                        </td>
                                                                        <td width="21%">
                                                                            <label>
                                                                                Upload Attachment</label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:TextBox ID="txtMedRemDate" CssClass="dateNL date-picker" runat="server"></asp:TextBox>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtMedRemReason" runat="server"></asp:TextBox>
                                                                        </td>
                                                                        <td>
                                                                            <input type='file' id="fuMedRem" onchange="readMedRemURL(this);" />&nbsp;&nbsp;&nbsp;&nbsp;
                                                                        </td>
                                                                        <td id="trmedrem">
                                                                            <button id="btnMedRemSave" type="button" class="btn-icon btn-navy btn-update" onclick="SaveMedRemDetails();">
                                                                                <span></span>Update</button>&nbsp;
                                                                            <button id="btnMedRemCancel" type="button" class="btn-icon btn-navy btn-cancel1"
                                                                                runat="server" onclick="return MedRemDetailsClear();">
                                                                                <span></span>Cancel</button>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="5">
                                                                            <div class="block">
                                                                                <table width="100%">
                                                                                    <tr valign="top">
                                                                                        <td valign="top">
                                                                                            <asp:GridView ID="dgMedRemarks" runat="server" Width="100%" AutoGenerateColumns="False"
                                                                                                AllowPaging="True" ShowFooter="True" HorizontalAlign="Center" RowStyle-CssClass="even"
                                                                                                AlternatingRowStyle-CssClass="odd" EnableModelValidation="True" CssClass="display">
                                                                                                <Columns>
                                                                                                    <asp:BoundField DataField="SlNo" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                                                        HeaderText="Sl. No." SortExpression="SlNo">
                                                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                                                    </asp:BoundField>
                                                                                                    <asp:BoundField DataField="RegNo" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                                                        HeaderText="RegNo" SortExpression="RegNo">
                                                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                                                    </asp:BoundField>
                                                                                                    <asp:BoundField DataField="RemarkDate" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                                                        HeaderText="Remark Date" SortExpression="RemarkDate">
                                                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                                                    </asp:BoundField>
                                                                                                    <asp:BoundField DataField="Description" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                                                        HeaderText="Description" SortExpression="Description">
                                                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                                                    </asp:BoundField>
                                                                                                    <asp:BoundField DataField="FileName" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                                                        HeaderText="FileName" SortExpression="FileName">
                                                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                                                    </asp:BoundField>
                                                                                                    <asp:TemplateField Visible="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                                                                                        HeaderStyle-CssClass="sorting_mod editacc">
                                                                                                        <HeaderTemplate>
                                                                                                            Edit</HeaderTemplate>
                                                                                                        <ItemTemplate>
                                                                                                            <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandArgument='<%# Eval("MedRemarkID") %>'
                                                                                                                CommandName="Edit" CausesValidation="false" CssClass="links"></asp:LinkButton>
                                                                                                        </ItemTemplate>
                                                                                                    </asp:TemplateField>
                                                                                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                                                                                        HeaderStyle-CssClass="sorting_mod deleteacc">
                                                                                                        <HeaderTemplate>
                                                                                                            Delete</HeaderTemplate>
                                                                                                        <ItemTemplate>
                                                                                                            <asp:LinkButton ID="lnkDelete" runat="server" Text="Delete" CommandArgument='<%# Eval("MedRemarkID") %>'
                                                                                                                CommandName="Delete" CausesValidation="false" CssClass="links"></asp:LinkButton>
                                                                                                        </ItemTemplate>
                                                                                                    </asp:TemplateField>
                                                                                                </Columns>
                                                                                            </asp:GridView>
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
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </li>
                        </ul>
                    </li>
                    <li><a style="border-width: 1px; border-style: dotted; border-color: #CCCCCC;" class="menuitem">
                        Academic Details</a>
                        <ul class="johnmenu">
                            <li>
                                <div id="dvAcademic" style="border-bottom-style: none; border-bottom-width: 0px;"
                                    class="frm-block">
                                    <table class="form" width="100%">
                                        <tr>
                                            <td width="22%" class="col1">
                                                <label>
                                                    Register No:</label>
                                            </td>
                                            <td width="27%" class="col2">
                                                <asp:TextBox ID="txtRegNo" ReadOnly="true" runat="server"></asp:TextBox>
                                            </td>
                                            <td width="22%" class="col2">
                                                <label>
                                                    Admission No:</label>
                                            </td>
                                            <td width="29%" class="col2">
                                                <asp:TextBox ID="txtAdmissionNo" ReadOnly="true" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label>
                                                    Admitted Class</label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlAdClass" CssClass="" runat="server" AppendDataBoundItems="True"
                                                    onchange="GetAdSectionByAdClass(this.value);">
                                                    <asp:ListItem Selected="True" Value="">---Select---</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <label>
                                                    Admitted Section</label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlAdSection" CssClass="" runat="server" AppendDataBoundItems="True">
                                                    <asp:ListItem Selected="True" Value="">New</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="22%" class="col2">
                                                <label>
                                                    Date of Admission:</label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtDOA" CssClass="dateNL date-picker" Enabled="false" runat="server"></asp:TextBox>
                                            </td>
                                            <td width="29%" class="col2">
                                                <label>
                                                    Mode of Transport:</label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlModeofTrans" runat="server" AppendDataBoundItems="True">
                                                    <asp:ListItem Selected="True" Value="">---Select---</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="22%" class="col1">
                                                <label>
                                                    Medium:</label>
                                            </td>
                                            <td width="27%" class="col2">
                                                <asp:DropDownList ID="ddlSchoolMedium" CssClass="jsrequired" runat="server" AppendDataBoundItems="True">
                                                </asp:DropDownList>
                                            </td>
                                            <td width="22%" class="col2">
                                                <label>
                                                    First Language:</label>
                                            </td>
                                            <td width="29%" class="col2">
                                                <asp:DropDownList ID="txtFirstlang" CssClass="" runat="server" AppendDataBoundItems="True">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label>
                                                    Second language :</label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlSeclang" CssClass="" runat="server" AppendDataBoundItems="True">
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <label>
                                                    Present Status:</label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlStatus" CssClass="jsrequired" runat="server">
                                                    <asp:ListItem Selected="True" Value="">---Select---</asp:ListItem>
                                                    <asp:ListItem Value="N">New</asp:ListItem>
                                                    <asp:ListItem Value="C">Current</asp:ListItem>
                                                    <asp:ListItem Value="O">Old</asp:ListItem>
                                                    <asp:ListItem Value="D">Discontinued</asp:ListItem>
                                                    <asp:ListItem Value="F">Temproray</asp:ListItem>
                                                    <asp:ListItem Value="E">Cancelled</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label>
                                                    If Parents Working in this Institution:</label>
                                            </td>
                                            <td>
                                                <span class="col2">
                                                    <input type="radio" name="bb1" id="rbtnInsNo" value="No" checked="checked" onclick="javascript:ShowInstitution();" />No
                                                    <input type="radio" name="bb1" id="rbtnInsYes" value="Yes" onclick="javascript:ShowInstitution();" />Yes</span>
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td width="43%">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4">
                                                <div id="dvInstitution" style="display: none;">
                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                        <tr>
                                                            <td width="48%">
                                                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                                    <tr>
                                                                        <td width="22%">
                                                                            <label>
                                                                                Emp Id/Name:</label>
                                                                        </td>
                                                                        <td width="27%">
                                                                            <asp:DropDownList ID="ddlStaff1" runat="server" AppendDataBoundItems="True">
                                                                                <asp:ListItem Selected="True" Value="">---Select---</asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td width="25%" align="center">
                                                                            <label>
                                                                                Relationship:</label>
                                                                        </td>
                                                                        <td width="27%">
                                                                            <asp:DropDownList ID="ddlRelationship1" runat="server" AppendDataBoundItems="True">
                                                                                <asp:ListItem Selected="True" Value="">---Select---</asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="22%">
                                                                            <label>
                                                                                Emp Id/Name:</label>
                                                                        </td>
                                                                        <td width="27%">
                                                                            <asp:DropDownList ID="ddlStaff2" runat="server" AppendDataBoundItems="True">
                                                                                <asp:ListItem Selected="True" Value="">---Select---</asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td width="25%" align="center">
                                                                            <label>
                                                                                Relationship:</label>
                                                                        </td>
                                                                        <td width="27%">
                                                                            <asp:DropDownList ID="ddlRelationship2" runat="server" AppendDataBoundItems="True">
                                                                                <asp:ListItem Selected="True" Value="">---Select---</asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                            <td width="2%">
                                                                &nbsp;
                                                            </td>
                                                            <td valign="top">
                                                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <label>
                                                                                Parent/Guardian Details</label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:GridView ID="dgInstitution" runat="server" Width="100%" AutoGenerateColumns="False"
                                                                                AllowPaging="True" ShowFooter="True" HorizontalAlign="Center" RowStyle-CssClass="even"
                                                                                AlternatingRowStyle-CssClass="odd" EnableModelValidation="True" CssClass="display">
                                                                                <Columns>
                                                                                    <asp:BoundField DataField="SlNo" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                                        HeaderText="SlNo" SortExpression="SlNo">
                                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="StaffName" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                                        HeaderText="StaffName" SortExpression="StaffName">
                                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="Relationship" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                                        HeaderText="Relationship" SortExpression="Relationship">
                                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                                    </asp:BoundField>
                                                                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                                                                        HeaderStyle-CssClass="sorting_mod editacc">
                                                                                        <HeaderTemplate>
                                                                                            Edit</HeaderTemplate>
                                                                                        <ItemTemplate>
                                                                                            <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandArgument='<%# Eval("StudStaffID") %>'
                                                                                                CommandName="Edit" CausesValidation="false" CssClass="links"></asp:LinkButton>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                                                                        HeaderStyle-CssClass="sorting_mod deleteacc">
                                                                                        <HeaderTemplate>
                                                                                            Delete</HeaderTemplate>
                                                                                        <ItemTemplate>
                                                                                            <asp:LinkButton ID="lnkDelete" runat="server" Text="Delete" CommandArgument='<%# Eval("StudStaffID") %>'
                                                                                                CommandName="Delete" CausesValidation="false" CssClass="links"></asp:LinkButton>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                </Columns>
                                                                            </asp:GridView>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <div class="Pager">
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="40">
                                                &nbsp;
                                            </td>
                                            <td id="tracademic" colspan="3">
                                                <button id="btnAcademicDetailsSubmit" type="button" class="btn-icon btn-navy btn-update"
                                                    onclick="SaveAcademicDetails();">
                                                    <span></span>
                                                    <div id="spAcaSubmit">
                                                        Update</div>
                                                </button>
                                                <button id="btnAcademicDetailsCancel" type="button" class="btn-icon btn-navy btn-cancel1"
                                                    runat="server" onclick="return AcademicDetailsClear();">
                                                    <span></span>Cancel</button>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </li>
                        </ul>
                    </li>
                    <li><a style="display: none; border-width: 1px; border-style: dotted; border-color: #CCCCCC;"
                        class="menuitem">Co-curricular activities during school hours</a>
                        <ul class="johnmenu">
                            <li>
                                <div id="dvCurricular" style="border-bottom-style: none; border-bottom-width: 0px;"
                                    class="frm-block">
                                    <table class="form" width="100%">
                                        <tr>
                                            <td width="22%" class="col1">
                                                <label>
                                                    Select any one option
                                                </label>
                                            </td>
                                            <td class="col2">
                                                <input type="radio" name="cbtnCurricular" id="rbtnSports" value="Sports" onclick="javascript:ShowCurricular();" />Sports
                                                <input type="radio" name="cbtnCurricular" id="rbtnFine" value="Fine Arts" onclick="javascript:ShowCurricular();" />Fine
                                                Arts
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label>
                                                    Remarks</label>
                                            </td>
                                            <td valign="top">
                                                <asp:TextBox ID="txtCurricularRemarks" TextMode="MultiLine" Rows="3" Columns="30"
                                                    runat="server"></asp:TextBox>
                                                &nbsp;
                                                <button id="btnCuri" type="button" runat="server" class="btn-icon btn-navy btn-update"
                                                    onclick="SaveCurricularDetails();">
                                                    <span></span>
                                                    <div id="dpCurricular">
                                                        Save</div>
                                                </button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <div id="dvSports" style="display: none; float: left; width: 100%">
                                                    <asp:GridView ID="dgSports" runat="server" Width="100%" AutoGenerateColumns="False"
                                                        ShowFooter="True" HorizontalAlign="Center" RowStyle-CssClass="even" AlternatingRowStyle-CssClass="odd"
                                                        EnableModelValidation="True" CssClass="display">
                                                        <Columns>
                                                            <asp:BoundField DataField="SportName" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                HeaderText="Sports Name" SortExpression="SportName">
                                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                            </asp:BoundField>
                                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                                                HeaderStyle-CssClass="sorting_mod editacc">
                                                                <HeaderTemplate>
                                                                    Option</HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lnkEdit" runat="server" Text="Option" CommandArgument='<%# Eval("StudSportId") %>'
                                                                        CommandName="Edit" CausesValidation="false" CssClass="links"></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                                <div id="dvFineArts" style="display: none; float: left; width: 100%">
                                                    <asp:GridView ID="dgFineArts" runat="server" Width="100%" AutoGenerateColumns="False"
                                                        AllowPaging="True" ShowFooter="True" HorizontalAlign="Center" RowStyle-CssClass="even"
                                                        AlternatingRowStyle-CssClass="odd" EnableModelValidation="True" CssClass="display">
                                                        <Columns>
                                                            <asp:BoundField DataField="FineArtName" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                HeaderText="Fine Arts Name" SortExpression="FineArtName">
                                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                            </asp:BoundField>
                                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                                                HeaderStyle-CssClass="sorting_mod editacc">
                                                                <HeaderTemplate>
                                                                    Option</HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lnkEdit" runat="server" Text="Option" CommandArgument='<%# Eval("StudFineArtId") %>'
                                                                        CommandName="Edit" CausesValidation="false" CssClass="links"></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </li>
                        </ul>
                    </li>
                    <li><a style="display: none; border-width: 1px; border-style: dotted; border-color: #CCCCCC;"
                        class="menuitem">Skill based education</a>
                        <ul class="johnmenu">
                            <li>
                                <div id="dvSkill" style="border-bottom-style: none; border-bottom-width: 0px;" class="frm-block">
                                    <table class="form" width="100%">
                                        <tr>
                                            <td width="22%" class="col1">
                                                <label>
                                                    Select any one option
                                                </label>
                                            </td>
                                            <td class="col2">
                                                <input type="radio" name="cbtnSkills" id="rbtnSkillYes" value="Yes" onclick="javascript:ShowSkill();" />Yes
                                                <input type="radio" name="cbtnSkills" id="rbtnSkillNo" value="No" onclick="javascript:ShowSkill();" />No
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label>
                                                    Remarks</label>
                                            </td>
                                            <td valign="top">
                                                <asp:TextBox ID="txtSkillRemarks" TextMode="MultiLine" Rows="3" Columns="30" runat="server"></asp:TextBox>
                                                &nbsp;
                                                <button id="btnSkillSubmit" type="button" runat="server" class="btn-icon btn-navy btn-update"
                                                    onclick="SaveSkillDetails();">
                                                    <span></span>
                                                    <div id="dpSkill">
                                                        Save</div>
                                                </button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4">
                                                <div id="dvSkills" style="display: none; float: left; width: 100%">
                                                    <asp:GridView ID="dgSkills" runat="server" Width="100%" AutoGenerateColumns="False"
                                                        ShowFooter="True" HorizontalAlign="Center" RowStyle-CssClass="even" AlternatingRowStyle-CssClass="odd"
                                                        EnableModelValidation="True" CssClass="display">
                                                        <Columns>
                                                            <asp:BoundField DataField="SKillName" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                HeaderText="Skill Name" SortExpression="SKillName">
                                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                            </asp:BoundField>
                                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                                                HeaderStyle-CssClass="sorting_mod editacc">
                                                                <HeaderTemplate>
                                                                    Option</HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lnkEdit" runat="server" Text="Option" CommandArgument='<%# Eval("StudSkillId") %>'
                                                                        CommandName="Edit" CausesValidation="false" CssClass="links"></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </li>
                        </ul>
                    </li>
                    <li><a style="display: none; border-width: 1px; border-style: dotted; border-color: #CCCCCC;"
                        class="menuitem">Evening Special sports and Fine Arts classes</a>
                        <ul class="johnmenu">
                            <li>
                                <div id="dvActivites" style="border-bottom-style: none; border-bottom-width: 0px;"
                                    class="frm-block">
                                    <table class="form" width="100%">
                                        <tr>
                                            <td>
                                                <label>
                                                    Remarks</label>
                                            </td>
                                            <td valign="top">
                                                <asp:TextBox ID="txtActivityRemarks" TextMode="MultiLine" Rows="3" Columns="30" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4">
                                                <div class="" id="dvAct">
                                                    <asp:GridView ID="dgActivities" runat="server" Width="100%" AutoGenerateColumns="False"
                                                        ShowFooter="True" HorizontalAlign="Center" RowStyle-CssClass="even" AlternatingRowStyle-CssClass="odd"
                                                        EnableModelValidation="True" CssClass="display">
                                                        <Columns>
                                                            <asp:BoundField DataField="ActName" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                HeaderText="Activities Name" SortExpression="ActName">
                                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                            </asp:BoundField>
                                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                                                HeaderStyle-CssClass="sorting_mod editacc">
                                                                <HeaderTemplate>
                                                                    Option</HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lnkActEdit" runat="server" Text="Option" CommandArgument='<%# Eval("StudActId") %>'
                                                                        CommandName="Edit" CausesValidation="false" CssClass="links"></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </li>
                        </ul>
                    </li>
                    <li><a style="display: none; border-width: 1px; border-style: dotted; border-color: #CCCCCC;"
                        class="menuitem">Scholarship Details</a>
                        <ul class="johnmenu">
                            <li>
                                <div id="dvscholarshipDetails" style="border-bottom-style: none; border-bottom-width: 0px;"
                                    class="frm-block">
                                    <table class="form" width="100%">
                                        <tr>
                                            <td width="22%" class="col1">
                                                <label>
                                                    Is Student Eligible For scholarship</label>
                                            </td>
                                            <td>
                                                <input type="radio" name="sch1" id="rbtnNoScholar" value="No" checked="checked" onclick="javascript:ShowScholarship();" />No
                                                <input type="radio" name="sch1" id="rbtnScholarYes" value="Yes" onclick="javascript:ShowScholarship();" />Yes
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4">
                                                <div id="dvScholar" style="display: none;">
                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                        <tr>
                                                            <td width="48%">
                                                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                                    <tr>
                                                                        <td width="45%">
                                                                            <label>
                                                                                Scholarship Name :</label>
                                                                        </td>
                                                                        <td width="55%">
                                                                            <asp:DropDownList ID="ddlScholarship" CssClass="jsrequired" runat="server" AppendDataBoundItems="True">
                                                                                <asp:ListItem Selected="True" Value="">---Select---</asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                            <td>
                                                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <label>
                                                                                Scholarship Details</label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:GridView ID="dgScholarship" runat="server" Width="100%" AutoGenerateColumns="False"
                                                                                AllowPaging="True" ShowFooter="True" HorizontalAlign="Center" RowStyle-CssClass="even"
                                                                                AlternatingRowStyle-CssClass="odd" EnableModelValidation="True" CssClass="display">
                                                                                <Columns>
                                                                                    <asp:BoundField DataField="SNO" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                                        HeaderText="SlNo" SortExpression="SNO">
                                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="ScholarshipId" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                                        HeaderText="ScholarshipId" SortExpression="ScholarshipId">
                                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="ScholarshipName" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                                        HeaderText="ScholarshipName" SortExpression="ScholarshipName">
                                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                                    </asp:BoundField>
                                                                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                                                                        HeaderStyle-CssClass="sorting_mod editacc">
                                                                                        <HeaderTemplate>
                                                                                            Edit</HeaderTemplate>
                                                                                        <ItemTemplate>
                                                                                            <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandArgument='<%# Eval("StudScholId") %>'
                                                                                                CommandName="Edit" CausesValidation="false" CssClass="links"></asp:LinkButton>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                                                                        HeaderStyle-CssClass="sorting_mod deleteacc">
                                                                                        <HeaderTemplate>
                                                                                            Delete</HeaderTemplate>
                                                                                        <ItemTemplate>
                                                                                            <asp:LinkButton ID="lnkDelete" runat="server" Text="Delete" CommandArgument='<%# Eval("StudScholId") %>'
                                                                                                CommandName="Delete" CausesValidation="false" CssClass="links"></asp:LinkButton>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                </Columns>
                                                                            </asp:GridView>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <div class="Pager">
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td align="left">
                                                <button id="btnScholarshipSubmit" type="button" runat="server" class="btn-icon btn-navy btn-update"
                                                    onclick="SaveScholarshipDetails();">
                                                    <span></span>
                                                    <div id="Div9">
                                                        Update</div>
                                                </button>
                                                <button id="btnScholarshipCancel" type="button" class="btn-icon btn-navy btn-cancel1"
                                                    runat="server" onclick="return ScholarshipDetailsClear();">
                                                    <span></span>Cancel</button>
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </li>
                        </ul>
                    </li>
                    <li><a style="display: none; border-width: 1px; border-style: dotted; border-color: #CCCCCC;"
                        class="menuitem">Academic Remarks Details</a>
                        <ul class="johnmenu">
                            <li>
                                <div id="Div4" style="border-bottom-style: none; border-bottom-width: 0px;" class="frm-block">
                                    <table class="form" width="100%">
                                        <tr>
                                            <td colspan="4">
                                                <table class="form">
                                                    <tr>
                                                        <td class="col1 formsubheading">
                                                            <label>
                                                                Academic Remarks :</label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <div id="dvAcaRemarks" style="position: relative; width: 100%">
                                                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                                    <tr>
                                                                        <td width="21%">
                                                                            <label>
                                                                                Date</label>
                                                                        </td>
                                                                        <td width="21%">
                                                                            <label>
                                                                                Remarks</label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:TextBox ID="txtAcaRemDate" CssClass="dateNL date-picker" runat="server"></asp:TextBox>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtAcaRemarks" runat="server"></asp:TextBox>
                                                                        </td>
                                                                        <td>
                                                                            <button id="btnAAcademicRemarks" type="button" class="btn-icon btn-navy btn-update"
                                                                                onclick="SaveAcademicRemarkDetails();">
                                                                                <span></span>Update</button>&nbsp;
                                                                            <button id="btnAcademicRemCancel" type="button" class="btn-icon btn-navy btn-cancel1"
                                                                                runat="server" onclick="return AcademicRemDetailsClear();">
                                                                                <span></span>Cancel</button>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="5">
                                                                            <div class="block">
                                                                                <table width="100%">
                                                                                    <tr valign="top">
                                                                                        <td valign="top">
                                                                                            <asp:GridView ID="dgAcademicRemarks" runat="server" Width="100%" AutoGenerateColumns="False"
                                                                                                AllowPaging="True" ShowFooter="True" HorizontalAlign="Center" RowStyle-CssClass="even"
                                                                                                AlternatingRowStyle-CssClass="odd" EnableModelValidation="True" CssClass="display">
                                                                                                <Columns>
                                                                                                    <asp:BoundField DataField="SlNo" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                                                        HeaderText="Sl. No." SortExpression="SlNo">
                                                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                                                    </asp:BoundField>
                                                                                                    <asp:BoundField DataField="RegNo" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                                                        HeaderText="RegNo" SortExpression="RegNo">
                                                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                                                    </asp:BoundField>
                                                                                                    <asp:BoundField DataField="RemarkDate" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                                                        HeaderText="RemarkDate" SortExpression="RemarkDate">
                                                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                                                    </asp:BoundField>
                                                                                                    <asp:BoundField DataField="Remarks" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                                                        HeaderText="Remarks" SortExpression="Remarks">
                                                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                                                    </asp:BoundField>
                                                                                                    <asp:TemplateField Visible="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                                                                                        HeaderStyle-CssClass="sorting_mod editacc">
                                                                                                        <HeaderTemplate>
                                                                                                            Edit</HeaderTemplate>
                                                                                                        <ItemTemplate>
                                                                                                            <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandArgument='<%# Eval("RemarkID") %>'
                                                                                                                CommandName="Edit" CausesValidation="false" CssClass="links"></asp:LinkButton>
                                                                                                        </ItemTemplate>
                                                                                                    </asp:TemplateField>
                                                                                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                                                                                        HeaderStyle-CssClass="sorting_mod deleteacc">
                                                                                                        <HeaderTemplate>
                                                                                                            Delete</HeaderTemplate>
                                                                                                        <ItemTemplate>
                                                                                                            <asp:LinkButton ID="lnkDelete" runat="server" Text="Delete" CommandArgument='<%# Eval("RemarkID") %>'
                                                                                                                CommandName="Delete" CausesValidation="false" CssClass="links"></asp:LinkButton>
                                                                                                        </ItemTemplate>
                                                                                                    </asp:TemplateField>
                                                                                                </Columns>
                                                                                            </asp:GridView>
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
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </li>
                        </ul>
                    </li>
                    <li><a style="display: none; border-width: 1px; border-style: dotted; border-color: #CCCCCC;"
                        class="menuitem">Hostel Details</a>
                        <ul class="johnmenu">
                            <li>
                                <div id="dvHostelDetails" style="border-bottom-style: none; border-bottom-width: 0px;"
                                    class="frm-block">
                                    <table class="form" width="100%">
                                        <tr>
                                            <td width="22%" class="col1">
                                                <label>
                                                    Is Hostel Students
                                                </label>
                                            </td>
                                            <td class="col2">
                                                <input type="radio" name="hb1" id="rbtnHostelNo" value="No" checked="checked" onclick="javascript:ShowHostel();" />No
                                                <input type="radio" name="hb1" id="rbtnHostelYes" value="Yes" onclick="javascript:ShowHostel();" />Yes
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4">
                                                <div id="dvHostel" style="display: none;">
                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                        <tr>
                                                            <td width="48%">
                                                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                                    <tr>
                                                                        <td width="45%">
                                                                            <label>
                                                                                Hotel Name</label>
                                                                        </td>
                                                                        <td width="55%">
                                                                            <asp:DropDownList ID="ddlHostel" CssClass="jsrequired" runat="server" AppendDataBoundItems="True"
                                                                                onchange="GetBlockByHostel(this.value);">
                                                                                <asp:ListItem Selected="True" Value="">---Select---</asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <label>
                                                                                Block Name</label>
                                                                        </td>
                                                                        <td width="55%">
                                                                            <asp:DropDownList ID="ddlBlock" CssClass="jsrequired" runat="server" onchange="javascript:GetRoomByBlock();"
                                                                                AppendDataBoundItems="True">
                                                                                <asp:ListItem Selected="True" Value="">---Select---</asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <label>
                                                                                Room No</label>
                                                                        </td>
                                                                        <td width="55%">
                                                                            <asp:DropDownList ID="ddlRooms" CssClass="jsrequired" runat="server" AppendDataBoundItems="True">
                                                                                <asp:ListItem Selected="True" Value="">---Select---</asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="45%">
                                                                            <label>
                                                                                Date of Admission</label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtDateofHostelAdmn" CssClass="dateNL date-picker" runat="server"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                            <td width="52%" style="padding: 10px;">
                                                                <div class="block">
                                                                    <table width="100%">
                                                                        <tr valign="top">
                                                                            <td valign="top">
                                                                                <asp:GridView ID="dgHostel" runat="server" AutoGenerateColumns="false" Width="100%"
                                                                                    AllowPaging="True" ShowFooter="True" HorizontalAlign="Center" RowStyle-CssClass="even"
                                                                                    AlternatingRowStyle-CssClass="even" EnableModelValidation="True" CssClass="display" />
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
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td align="left">
                                                <button id="btnHostelSubmit" type="button" runat="server" class="btn-icon btn-navy btn-update"
                                                    onclick="SaveHostelDetails();">
                                                    <span></span>
                                                    <div id="Div2">
                                                        Update</div>
                                                </button>
                                                <button id="btnHostelCancel" type="button" class="btn-icon btn-navy btn-cancel1"
                                                    runat="server" onclick="return HostelDetailsClear();">
                                                    <span></span>Cancel</button>
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </li>
                        </ul>
                    </li>
                    <li><a style="display: none; border-width: 1px; border-style: dotted; border-color: #CCCCCC;"
                        class="menuitem">Bus Details</a>
                        <ul class="johnmenu">
                            <li>
                                <div id="dvBusDetails" style="border-bottom-style: none; border-bottom-width: 0px;"
                                    class="frm-block">
                                    <table class="form" width="100%">
                                        <tr>
                                            <td width="22%" class="col1">
                                                <label>
                                                    Is Bus Students</label>
                                            </td>
                                            <td>
                                                <input type="radio" name="bb1" id="rbtnBusNo" value="No" checked="checked" onclick="javascript:ShowBus();" />No
                                                <input type="radio" name="bb1" id="rbtnBusYes" value="Yes" onclick="javascript:ShowBus();" />Yes
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4">
                                                <div id="dvBus" style="display: none;">
                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                        <tr>
                                                            <td width="48%">
                                                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                                    <tr>
                                                                        <td width="45%">
                                                                            <label>
                                                                                Boarding Point :</label>
                                                                        </td>
                                                                        <td width="55%">
                                                                            <asp:DropDownList ID="ddlRouteCode" CssClass="jsrequired" runat="server" onchange="javascript:GetBusRouteDetails(this.value);"
                                                                                AppendDataBoundItems="True">
                                                                                <asp:ListItem Selected="True" Value="">---Select---</asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <label>
                                                                                Date of Registration</label>
                                                                        </td>
                                                                        <td width="55%">
                                                                            <asp:TextBox ID="txtDateofBusReg" CssClass="jsrequired dateNL date-picker" runat="server"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                            <td>
                                                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <label>
                                                                                Bus Route Details</label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:GridView ID="dgBusRoute" runat="server" Width="100%" AutoGenerateColumns="False"
                                                                                AllowPaging="True" ShowFooter="True" HorizontalAlign="Center" RowStyle-CssClass="even"
                                                                                AlternatingRowStyle-CssClass="odd" EnableModelValidation="True" CssClass="display">
                                                                                <Columns>
                                                                                    <asp:BoundField DataField="VehicleCode" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                                        HeaderText="VehicleCode" SortExpression="VehicleName">
                                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="BusRouteName" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                                        HeaderText="BusRouteName" SortExpression="BusRouteName">
                                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="BusRouteCode" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                                        HeaderText="BusRouteCode" SortExpression="BusRouteCode">
                                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="Timings" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                                        HeaderText="Timings" SortExpression="Timings">
                                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="BusCharge" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                                        HeaderText="BusCharge" SortExpression="BusCharge">
                                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="DateofRegistration" HeaderStyle-CssClass="sorting_mod"
                                                                                        ItemStyle-HorizontalAlign="Center" HeaderText="DateofRegistration" SortExpression="DateofRegistration">
                                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                                    </asp:BoundField>
                                                                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                                                                        HeaderStyle-CssClass="sorting_mod deleteacc">
                                                                                        <HeaderTemplate>
                                                                                            Delete</HeaderTemplate>
                                                                                        <ItemTemplate>
                                                                                            <asp:LinkButton ID="lnkDelete" runat="server" Text="Delete" CommandArgument='<%# Eval("BusRouteID")%>'
                                                                                                CommandName="Delete" CausesValidation="false" CssClass="links"></asp:LinkButton>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                </Columns>
                                                                            </asp:GridView>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <div class="Pager">
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td align="left">
                                                <button id="btnBusRouteSubmit" type="button" runat="server" class="btn-icon btn-navy btn-update"
                                                    onclick="SaveBusRouteDetails();">
                                                    <span></span>
                                                    <div id="Div1">
                                                        Update</div>
                                                </button>
                                                <button id="btnBusRouteCancel" type="button" class="btn-icon btn-navy btn-cancel1"
                                                    runat="server" onclick="return BusRouteDetailsClear();">
                                                    <span></span>Cancel</button>
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </li>
                        </ul>
                    </li>
                    <li><a style="display: none; border-width: 1px; border-style: dotted; border-color: #CCCCCC;"
                        class="menuitem">Concession Details</a>
                        <ul class="johnmenu">
                            <li>
                                <asp:UpdatePanel ID="ups" runat="server">
                                    <ContentTemplate>
                                        <div id="dvConcessionDetails" style="border-bottom-style: none; border-bottom-width: 0px;"
                                            class="frm-block">
                                            <table class="form" width="100%">
                                                <tr>
                                                    <td width="22%" class="col1">
                                                        <label>
                                                            Is Student Eligible For Concession</label>
                                                    </td>
                                                    <td>
                                                        <label for="textarea2">
                                                        </label>
                                                        <span class="col2">
                                                            <input type="radio" name="Concess" id="rbtnNoConcess" value="No" checked="checked"
                                                                onclick="javascript:ShowConcession();" />No
                                                            <input type="radio" name="Concess" id="rbtnConcessYes" value="Yes" onclick="javascript:ShowConcession();" />Yes</span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4">
                                                        <div class="" id="dvConcession" style="display: none;">
                                                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                                <tr valign="top">
                                                                    <td>
                                                                        <label>
                                                                            Academic Year Belong To :</label>
                                                                    </td>
                                                                    <td colspan="5">
                                                                        <asp:RadioButtonList ID="rdlAdvanceFees" AutoPostBack="true" RepeatDirection="Horizontal"
                                                                            runat="server" OnSelectedIndexChanged="rdlAdvanceFees_SelectedIndexChanged">
                                                                        </asp:RadioButtonList>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td width="12%">
                                                                        <label>
                                                                            Concession Type:</label>
                                                                    </td>
                                                                    <td width="30%">
                                                                        <asp:DropDownList ID="ddlConcession" CssClass="jsrequired" runat="server" onchange="javascript:GetConcession(this.value);">
                                                                            <asp:ListItem Selected="True" Value="">---Select---</asp:ListItem>
                                                                            <asp:ListItem Selected="False" Value="F">Full</asp:ListItem>
                                                                            <asp:ListItem Selected="False" Value="P">Partial</asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td width="12%">
                                                                        <label>
                                                                            Concession Reason:</label>
                                                                    </td>
                                                                    <td width="30%">
                                                                        <asp:TextBox ID="txtConcessionReason" Style="width: 250px;" runat="server"></asp:TextBox>
                                                                    </td>
                                                                    <td width="12%">
                                                                        <label>
                                                                            Concession Status:</label>
                                                                    </td>
                                                                    <td width="30%">
                                                                        <asp:Label ID="lblConcessStatus" runat="server"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="6">
                                                                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" Width="100%"
                                                                            AllowPaging="false" ShowFooter="True" HorizontalAlign="Center" RowStyle-CssClass="even"
                                                                            AlternatingRowStyle-CssClass="even" EnableModelValidation="True" CssClass="display"
                                                                            PageSize="50" />
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
                                                <tr>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td align="left">
                                                        <button id="btnConcessionSubmit" type="button" runat="server" class="btn-icon btn-navy btn-update"
                                                            onclick="SaveConcessionFees();">
                                                            <span></span>
                                                            <div id="spSubmit">
                                                                Update</div>
                                                        </button>
                                                        <button id="btnConcessionCancel" type="button" class="btn-icon btn-navy btn-cancel1"
                                                            runat="server" onclick="return ConcessionCancel();">
                                                            <span></span>Cancel</button>
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="rdlAdvanceFees" EventName="SelectedIndexChanged" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </li>
                        </ul>
                    </li>
                    <li><a style="display: none; border-width: 1px; border-style: dotted; border-color: #CCCCCC;"
                        class="menuitem">Old School Details</a>
                        <ul class="johnmenu">
                            <li>
                                <div class="frm-block">
                                    <table class="form">
                                        <tr>
                                            <td colspan="4">
                                                <div class="">
                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                        <tr>
                                                            <td width="100%" height="10" colspan="5">
                                                                <table class="form">
                                                                    <tr>
                                                                        <td colspan="4">
                                                                            <div class="">
                                                                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                                                    <tr>
                                                                                        <td>
                                                                                            <label>
                                                                                                Name of the School:</label>
                                                                                        </td>
                                                                                        <td>
                                                                                            <label>
                                                                                                Academic year</label>
                                                                                        </td>
                                                                                        <td>
                                                                                            <label>
                                                                                                Standard Studied</label>
                                                                                        </td>
                                                                                        <td>
                                                                                            <label>
                                                                                                1st Language</label>
                                                                                        </td>
                                                                                        <td>
                                                                                            &nbsp;
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <asp:TextBox ID="txtSchoolName" runat="server" CssClass="jsrequired"></asp:TextBox>
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:DropDownList ID="ddlStartAcademicYr" CssClass="jsrequired" runat="server" Width="75px"
                                                                                                AppendDataBoundItems="True">
                                                                                                <asp:ListItem Selected="True" Value="">Select</asp:ListItem>
                                                                                            </asp:DropDownList>
                                                                                            <asp:DropDownList ID="ddlEndAcademicYr" CssClass="jsrequired" Width="75px" runat="server"
                                                                                                AppendDataBoundItems="True">
                                                                                                <asp:ListItem Selected="True" Value="">Select</asp:ListItem>
                                                                                            </asp:DropDownList>
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:TextBox ID="txtStdFrom" runat="server" CssClass="jsrequired"></asp:TextBox>
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:DropDownList ID="ddlFirstLang" CssClass="jsrequired" runat="server" AppendDataBoundItems="True">
                                                                                                <asp:ListItem Selected="True" Value="">---Select---</asp:ListItem>
                                                                                            </asp:DropDownList>
                                                                                        </td>
                                                                                        <td>
                                                                                            &nbsp;
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <label>
                                                                                                Medium</label>
                                                                                        </td>
                                                                                        <td>
                                                                                            <label>
                                                                                                TC No</label>
                                                                                        </td>
                                                                                        <td>
                                                                                            <label>
                                                                                                TC Date</label>
                                                                                        </td>
                                                                                        <td>
                                                                                            <label>
                                                                                                TC Received Date</label>
                                                                                        </td>
                                                                                        <td>
                                                                                            &nbsp;
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <asp:DropDownList ID="ddlMedium" CssClass="jsrequired" runat="server" AppendDataBoundItems="True">
                                                                                                <asp:ListItem Selected="True" Value="">---Select---</asp:ListItem>
                                                                                            </asp:DropDownList>
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:TextBox ID="txtTCNo" runat="server" CssClass="jsrequired"></asp:TextBox>
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:TextBox ID="txtTCDate" runat="server" CssClass="jsrequired dateNL date-picker"></asp:TextBox>
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:TextBox ID="txtTCReceivedDate" runat="server" CssClass="jsrequired dateNL date-picker"></asp:TextBox>
                                                                                        </td>
                                                                                        <td>
                                                                                            <button id="btnTCSave" type="button" runat="server" class="btn-icon btn-navy btn-update"
                                                                                                onclick="SaveOldSchoolDetails();">
                                                                                                <span></span>
                                                                                                <div id="Div6">
                                                                                                    Update</div>
                                                                                            </button>
                                                                                            <button id="btnTCCancel" type="button" class="btn-icon btn-navy btn-cancel1" runat="server"
                                                                                                onclick="return TCCancel();">
                                                                                                <span></span>Cancel</button>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td height="10" colspan="5">
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="5">
                                                                <div class="block">
                                                                    <asp:GridView ID="dgOldSchool" runat="server" Width="100%" AutoGenerateColumns="False"
                                                                        AllowPaging="True" ShowFooter="True" HorizontalAlign="Center" RowStyle-CssClass="even"
                                                                        AlternatingRowStyle-CssClass="odd" EnableModelValidation="True" CssClass="display">
                                                                        <Columns>
                                                                            <asp:BoundField DataField="SlNo" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                                HeaderText="Sl.No." SortExpression="SlNo">
                                                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="SchoolName" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                                HeaderText="School Name" SortExpression="SchoolName">
                                                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="Academicyear" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                                HeaderText="Academic Year" SortExpression="Academicyear">
                                                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="StdStudied" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                                HeaderText="Std Studied" SortExpression="StdStudied">
                                                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="Firstlang" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                                HeaderText="Ist Language" SortExpression="Firstlang">
                                                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="Medium" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                                HeaderText="Medium" SortExpression="Medium">
                                                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="TCNo" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                                HeaderText="TC No" SortExpression="TCNo">
                                                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="TCDate" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                                HeaderText="TC Date" SortExpression="TCDate">
                                                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="TCReceivedDate" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                                HeaderText="TC Received Date" SortExpression="TCReceivedDate">
                                                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                            </asp:BoundField>
                                                                            <asp:TemplateField Visible="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                                                                HeaderStyle-CssClass="sorting_mod editacc">
                                                                                <HeaderTemplate>
                                                                                    Edit</HeaderTemplate>
                                                                                <ItemTemplate>
                                                                                    <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandArgument='<%# Eval("StudOldSchID") %>'
                                                                                        CommandName="Edit" CausesValidation="false" CssClass="links"></asp:LinkButton>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                                                                HeaderStyle-CssClass="sorting_mod deleteacc">
                                                                                <HeaderTemplate>
                                                                                    Delete</HeaderTemplate>
                                                                                <ItemTemplate>
                                                                                    <asp:LinkButton ID="lnkDelete" runat="server" Text="Delete" CommandArgument='<%# Eval("StudOldSchID")%>'
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
                                                                <br />
                                                                <br />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </li>
                        </ul>
                    </li>
                    <li><a style="border-width: 1px; border-style: dotted; border-color: #CCCCCC;" class="menuitem">
                        Nationality Details</a>
                        <ul class="johnmenu">
                            <li>
                                <div class="frm-block">
                                    <table class="form">
                                        <tr>
                                            <td width="20%" class="col1">
                                                <label>
                                                    Citizenship</label>
                                            </td>
                                            <td class="col2">
                                                <input type="radio" name="Nb1" id="rbtnIndian" value="Indian" checked="checked" onclick="javascript:ShowNationality();" />Indian
                                                <input type="radio" name="Nb1" id="rbtnOverseas" value="Overseas" onclick="javascript:ShowNationality();" />Overseas
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4">
                                                <div id="dvNationality" style="display: none;">
                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                        <tr>
                                                            <td width="19%" class="col2">
                                                                <label>
                                                                    Nationality</label>
                                                            </td>
                                                            <td width="33%" class="col2">
                                                                <asp:TextBox ID="txtNationality" runat="server"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <label>
                                                                    Passport Number</label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtPassportNo" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <label>
                                                                    Date of Issue
                                                                </label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtPPDateofIssue" CssClass="jsrequired dateNL date-picker" runat="server"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <label>
                                                                    Visa Number</label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtVisaNumber" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <label>
                                                                    Expiry Date</label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtPPExpDate" CssClass="jsrequired dateNL date-picker" runat="server"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <label>
                                                                    Visa Type</label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtVisaType" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <label>
                                                                    Visa Issue Date</label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtVisaIssuedDate" CssClass="jsrequired dateNL date-picker" runat="server"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <label>
                                                                    Visa Expiry Date</label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtVisaExpiryDate" CssClass="jsrequired dateNL date-picker" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <label>
                                                                    No of Entry</label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtNoOfEntry" runat="server"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <label>
                                                                    Validity</label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtValidity" CssClass="jsrequired dateNL date-picker" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <label>
                                                                    Purpose of Visit</label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtPurpose" TextMode="MultiLine" runat="server"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <label>
                                                                    Remark</label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtRemark" TextMode="MultiLine" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="40">
                                                &nbsp;
                                            </td>
                                            <td colspan="4">
                                                <button id="btnNationalitySave" type="button" class="btn-icon btn-navy btn-update"
                                                    onclick="SaveNationalityDetails();">
                                                    <span></span>
                                                    <div id="Div7">
                                                        Update</div>
                                                </button>
                                                <button id="btnNationalityCancel" type="button" class="btn-icon btn-navy btn-cancel1"
                                                    onclick="return NationalityDetailsClear();">
                                                    <span></span>Cancel</button>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </li>
                        </ul>
                    </li>
                    <li><a style="border-width: 1px; border-style: dotted; border-color: #CCCCCC;" class="menuitem">
                        Attachment Details</a>
                        <ul class="johnmenu">
                            <li>
                                <div class="frm-block">
                                    <table class="form">
                                        <tr>
                                            <td class="col1 formsubheading">
                                                <label>
                                                    Attachments :</label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div id="Div8" style="position: relative; width: 100%">
                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                        <tr>
                                                            <td width="21%">
                                                                <label>
                                                                    Title</label>
                                                            </td>
                                                            <td width="21%">
                                                                <label>
                                                                    Description</label>
                                                            </td>
                                                            <td width="21%">
                                                                <label>
                                                                    Upload Attachment</label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <input name="txtAttTitle" type="text" id="txtAttTitle" />
                                                            </td>
                                                            <td>
                                                                <input name="txtAttDescription" type="text" id="txtAttDescription" />
                                                            </td>
                                                            <td>
                                                                <input type='file' id="AttFile1" onchange="readAttFileURL(this);" />&nbsp;&nbsp;&nbsp;&nbsp;
                                                            </td>
                                                            <td>
                                                                <button id="btnAttachmentSave" type="button" class="btn-icon btn-navy btn-update"
                                                                    onclick="SaveAttachmentDetails();">
                                                                    <span></span>Update</button>&nbsp;
                                                                <button id="btnAttachementCancel" type="button" class="btn-icon btn-navy btn-cancel1"
                                                                    onclick="return AttachmentInfoClear();">
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
                                                                                    <asp:GridView ID="dgAttachmentDetails" runat="server" Width="100%" AutoGenerateColumns="False"
                                                                                        AllowPaging="True" ShowFooter="True" HorizontalAlign="Center" RowStyle-CssClass="even"
                                                                                        AlternatingRowStyle-CssClass="odd" EnableModelValidation="True" CssClass="display">
                                                                                        <Columns>
                                                                                            <asp:BoundField DataField="SlNo" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                                                HeaderText="Sl. No." SortExpression="SlNo">
                                                                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="Title" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                                                HeaderText="Title" SortExpression="Title">
                                                                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="Description" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                                                HeaderText="Description" SortExpression="Description">
                                                                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="FileName" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                                                HeaderText="FileName" SortExpression="FileName">
                                                                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                                            </asp:BoundField>
                                                                                            <asp:TemplateField Visible="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                                                                                HeaderStyle-CssClass="sorting_mod editacc">
                                                                                                <HeaderTemplate>
                                                                                                    Edit</HeaderTemplate>
                                                                                                <ItemTemplate>
                                                                                                    <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandArgument='<%# Eval("StudAttachID") %>'
                                                                                                        CommandName="Edit" CausesValidation="false" CssClass="links"></asp:LinkButton>
                                                                                                </ItemTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                                                                                HeaderStyle-CssClass="sorting_mod deleteacc">
                                                                                                <HeaderTemplate>
                                                                                                    Delete</HeaderTemplate>
                                                                                                <ItemTemplate>
                                                                                                    <asp:LinkButton ID="lnkDelete" runat="server" Text="Delete" CommandArgument='<%# Eval("StudAttachID") %>'
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
                            </li>
                        </ul>
                    </li>
                    <li><a style="border-width: 1px; border-style: dotted; border-color: #CCCCCC;" class="menuitem">
                        Sports Information</a>
                        <ul class="johnmenu">
                            <li>
                                <div class="frm-block">
                                    <table class="form" width="100%">
                                        <tbody>
                                            <tr>
                                                <td width="20%" class="col1">
                                                    <span style="color: Red">*</span>
                                                    <label>
                                                        Sports Requested</label>
                                                </td>
                                                <td width="26%" class="col2">
                                                    <label>
                                                        <input type="radio" id="rbbadminton" checked="checked" class="sportstype" name="sportstype"
                                                            value="1" />Badminton &nbsp;
                                                        <input type="radio" id="rbchess" class="studenttype" name="sportstype" value="2" />Chess
                                                        &nbsp;
                                                        <input type="radio" id="rbtennis" class="studenttype" name="sportstype" value="3" />Table
                                                        Tennis&nbsp;</label>
                                                </td>
                                                <td width="20%" class="col1">
                                                    <label>
                                                        Participation in Interschool / District / State / National Level Competition<br>
                                                        <small style="font-weight: 100">(Please Attach Document)</small> :</label>
                                                </td>
                                                <td width="26%" class="col2">
                                                    <input type="file" id="fusports" onchange="readSportFileURL(this);" />
                                                    <a target='_blank' id="SportAttachment">Download</a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="20%" class="col1" valign="top">
                                                    <span style="color: Red">*</span>
                                                    <label>
                                                        Sports Requested Timing</label>
                                                </td>
                                                <td width="26%" class="col2">
                                                    <label>
                                                        <input type="radio" id="rbtnfivehours" class="sportsrequested" name="sportsrequested"
                                                            value="fivehours" />5 Hours per day (Monday to Saturday)<br>
                                                        <small style="font-weight: 100;">(Applicable only for Students preferring to Study in
                                                            Amalorpavam Lourds Academy)</small> &nbsp;<br />
                                                        <br />
                                                        <input type="radio" id="rbtnforenoon" class="sportsrequested" name="sportsrequested"
                                                            value="Forenoon" />Forenoon Class (6.00 am to 7.30 am) (Monday to Friday) &nbsp;<br />
                                                        <br />
                                                        <input type="radio" id="rbtnevening" class="sportsrequested" name="sportsrequested"
                                                            value="Evening" />Evening Class (6.30 pm to 8.00 pm) (Monday to Friday) &nbsp;<br />
                                                        <br />
                                                        <input type="radio" id="rbtnweekend" class="sportsrequested" name="sportsrequested"
                                                            value="Weekend" />Weekend Class (Saturday: 6.30 pm to 8.30 pm & Sunday: 7.30
                                                        am to 10.30 am)<br />
                                                        <br />
                                                    </label>
                                                </td>
                                                <td width="20%" class="col1">
                                                    <label>
                                                        Awards Received<br>
                                                        <small style="font-weight: 100">(Please Attach Document)</small> :</label>
                                                </td>
                                                <td width="26%" class="col2">
                                                    <input type="file" id="fuawards" onchange="readAwardsFileURL(this);" />
                                                    <a target='_blank' id="AwardAttachment">Download</a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="20%" class="col1" valign="top">
                                                    <label>
                                                        Is your child Specially abled?</label>
                                                </td>
                                                <td class="col2">
                                                    <input type="radio" name="Nb1" id="brntabledYes" value="Yes" />Yes
                                                    <input type="radio" name="Nb1" id="brntabledNo" value="No" checked="checked" />No<br>
                                                    <br>
                                                    <label>
                                                        kindly describe and provide relevant supporting documents:<br>
                                                        <small style="font-weight: 100">(Please Attach Document)</small> :</label><br>
                                                    <textarea name="txtabled" rows="5" cols="30" id="txtabled"></textarea><br>
                                                    <input type="file" id="fuabled" onchange="readAbledFileURL(this);" />
                                                    <a target='_blank' id="AbledAttachment">Download</a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="20%" class="col1">
                                                    &nbsp;
                                                </td>
                                                <td class="col2">
                                                    &nbsp;
                                                </td>
                                                <td width="20%" class="col1">
                                                    <button id="btnSportSaveDetails" type="button" class="btn-icon btn-orange btn-saving"
                                                        onclick="SaveASSSportsDetails();">
                                                        <span></span>
                                                        <div id="dvASSSports">
                                                            Save</div>
                                                    </button>
                                                    &nbsp;
                                                    <button id="btnSportClearDetails" type="button" class="btn-icon btn-navy btn-cancel1"
                                                        runat="server" onclick="return SportsDetailsClear();">
                                                        <span></span>Cancel</button>&nbsp;
                                                </td>
                                                <td class="col2">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="col1 formsubheading" width="20%" valign="top">
                                                    <label>
                                                        Select to Map the Sports Fees
                                                    </label>
                                                </td>
                                                <td width="20%" class="col1" valign="top">
                                                </td>
                                                <td width="20%" class="col1" valign="top">
                                                    &nbsp;
                                                </td>
                                                <td width="20%" class="col1" valign="top">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4">
                                                    <div id="dvsportsfees" style="position: relative; width: 100%">
                                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                            <tr>
                                                                <td width="21%">
                                                                    <label>
                                                                        Fees Month</label>
                                                                </td>
                                                                <td width="21%">
                                                                    <label>
                                                                        Sports Fees</label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlMonth" Width="350px" runat="server" AppendDataBoundItems="True">
                                                                        <asp:ListItem Selected="True" Value="">---Select---</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlSportFees" Width="350px" runat="server" AppendDataBoundItems="True">
                                                                        <asp:ListItem Selected="True" Value="">---Select---</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td>
                                                                    <button id="brnSportFeesSave" type="button" class="btn-icon btn-navy btn-update"
                                                                        onclick="SaveSportFees();">
                                                                        <span></span>Add</button>&nbsp;
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="4">
                                                                    <div class="block">
                                                                        <table width="100%">
                                                                            <tr valign="top">
                                                                                <td valign="top">
                                                                                    <div>
                                                                                        <asp:GridView ID="dgsportsfees" runat="server" Width="100%" AutoGenerateColumns="False"
                                                                                            AllowPaging="True" ShowFooter="True" HorizontalAlign="Center" RowStyle-CssClass="even"
                                                                                            AlternatingRowStyle-CssClass="odd" EnableModelValidation="True" CssClass="display">
                                                                                            <Columns>
                                                                                                <asp:BoundField DataField="ForMonth" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                                                    HeaderText="ForMonth" SortExpression="ForMonth">
                                                                                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                                                </asp:BoundField>
                                                                                                <asp:BoundField DataField="FeesHeadName" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                                                    HeaderText="FeesHeadName" SortExpression="FeesHeadName">
                                                                                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                                                </asp:BoundField>
                                                                                                <asp:BoundField DataField="Amount" HeaderStyle-CssClass="sorting_mod" ItemStyle-HorizontalAlign="Center"
                                                                                                    HeaderText="Amount" SortExpression="Amount">
                                                                                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                                                </asp:BoundField>
                                                                                                <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                                                                                    HeaderStyle-CssClass="sorting_mod deleteacc">
                                                                                                    <HeaderTemplate>
                                                                                                        Delete</HeaderTemplate>
                                                                                                    <ItemTemplate>
                                                                                                        <asp:LinkButton ID="lnkDelete" runat="server" Text="Delete" CommandArgument='<%# Eval("FeesID") %>'
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
                                                                                    <div class="sportfeesPager">
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
                                        </tbody>
                                    </table>
                                </div>
                            </li>
                        </ul>
                    </li>
                    <li><a style="border-width: 1px; border-style: dotted; border-color: #CCCCCC;" class="menuitem">
                        General Information </a>
                        <ul class="johnmenu">
                            <li>
                                <div class="frm-block">
                                    <table class="form" width="100%">
                                        <tbody>
                                            <tr>
                                                <td width="20%" class="col1">
                                                    <span style="color: Red">*</span>
                                                    <label>
                                                        Does your Child require:
                                                        <br />
                                                        School Breakfast
                                                    </label>
                                                </td>
                                                <td width="26%" class="col2">
                                                    <label>
                                                        <input type="radio" id="rtbnBreakYes" class="breakfast" name="breakfast" value="Yes" />Yes
                                                        &nbsp;
                                                        <input type="radio" id="rtbnBreakNo" class="breakfast" name="breakfast" value="No" />No
                                                        &nbsp;
                                                    </label>
                                                </td>
                                                <td width="20%" class="col1">
                                                    <span style="color: Red">*</span>
                                                    <label>
                                                        Does your Child require:<br />
                                                        School Lunch
                                                    </label>
                                                </td>
                                                <td width="26%" class="col2">
                                                    <label>
                                                        <input type="radio" id="rtbnLunchYes" class="lunch" name="lunch" value="Yes" />Yes
                                                        &nbsp;
                                                        <input type="radio" id="rtbnLunchNo" class="lunch" name="lunch" value="No" />No
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="20%" class="col1">
                                                    <span style="color: Red">*</span>
                                                    <label>
                                                        Does your Child require:<br />
                                                        Transportation
                                                    </label>
                                                </td>
                                                <td width="26%" class="col2">
                                                    <label>
                                                        <input type="radio" id="rtbnTransYes" class="transport" name="transport" value="Yes" />Yes
                                                        &nbsp;
                                                        <input type="radio" id="rtbnTransNo" class="transport" name="transport" value="No" />No
                                                        &nbsp;
                                                    </label>
                                                </td>
                                                <td width="20%" class="col1">
                                                    <span style="color: Red">*</span>
                                                    <label>
                                                        Whether original Birth Certificate<br />
                                                        is attached
                                                    </label>
                                                </td>
                                                <td width="26%" class="col2">
                                                    <label>
                                                        <input type="radio" id="rbtnbcYes" class="birthcert" name="birthcert" value="Yes" />Yes
                                                        &nbsp;
                                                        <input type="radio" id="rbtnbcNo" class="birthcert" name="birthcert" value="No" />No
                                                        &nbsp;
                                                    </label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label>
                                                        Identification Marks:</label>
                                                </td>
                                                <td>
                                                    1.
                                                    <input name="txtidentify1" type="text" id="txtidentify1" class="idn-marks" />
                                                </td>
                                                <td>
                                                    <label>
                                                        Do you need hostel facility
                                                        <br />
                                                        <small style="font-weight: 100;">(Applicable only for Students preferring to Study in
                                                            Amalorpavam Lourds Academy) </small>
                                                    </label>
                                                </td>
                                                <td>
                                                    <span class="col2">
                                                        <label>
                                                            <input type="radio" id="rbtnHotelYes" name="rbtnHotel" /></label>
                                                        No
                                                        <label>
                                                            <input type="radio" id="rbtnHotelNo" name="rbtnHotel" />
                                                        </label>
                                                        Yes</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td>
                                                    2.
                                                    <input name="txtidentify2" type="text" id="txtidentify2" class="idn-marks" />
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="20%" class="col1">
                                                    &nbsp;
                                                </td>
                                                <td class="col2">
                                                    &nbsp;
                                                </td>
                                                <td width="20%" class="col1">
                                                    <button id="btnGeneralSaveDetails" type="button" class="btn-icon btn-orange btn-saving"
                                                        onclick="SaveASSGeneralDetails();">
                                                        <span></span>
                                                        <div id="dvGeneral">
                                                            Save</div>
                                                    </button>
                                                    <button id="btnGeneralClear" type="button" class="btn-icon btn-navy btn-cancel1"
                                                        runat="server" onclick="return GeneralDetailsClear();">
                                                        <span></span>Cancel</button>&nbsp;
                                                </td>
                                                <td class="col2">
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </li>
                        </ul>
                    </li>
                    <li><a style="border-width: 1px; border-style: dotted; border-color: #CCCCCC;" class="menuitem">
                        Wellness Information</a>
                        <ul class="johnmenu">
                            <li>
                                <div class="frm-block">
                                    <table class="form" width="100%">
                                        <tbody>
                                            <tr>
                                                <td colspan="4" class="formsubheading">
                                                    <label style="font-size: 14px; letter-spacing: 1px;">
                                                        Allergies / Infections - Please mention the detail below</label>
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="20%" class="col1" valign="top">
                                                    <label>
                                                        Allergic to Particular Medicine</label>
                                                </td>
                                                <td class="col2" valign="top">
                                                    <input type="radio" name="Allergic" id="rbtnAllergicYes" value="Indian" />Yes
                                                    <input type="radio" name="Allergic" id="rbtnAllergicNo" checked="checked" value="Overseas" />No<br />
                                                    <br>
                                                    <label>
                                                        kindly attach the details:</small> :</label><br>
                                                    <input type="file" id="fuAllergic" onchange="readAllergicFileURL(this);" />
                                                    <a target='_blank' id="AllergicAttachment">Download</a>
                                                </td>
                                                <td width="20%" class="col1" valign="top">
                                                    <label>
                                                        Skin Infections, if any:</label>
                                                </td>
                                                <td class="col2">
                                                    <input type="radio" name="skin" id="rbtnSkinYes" value="skin" />Yes
                                                    <input type="radio" name="skin" id="rbtnSkinNo" value="skin" />No<br />
                                                    <br>
                                                    <label>
                                                        Prescribed Medication, if any:<br>
                                                        <small style="font-weight: 100">Please indicate the details/cause of such infection
                                                            as below:</small>
                                                    </label>
                                                    <br>
                                                    <textarea name="txtPrescribed" rows="5" cols="30" id="txtPrescribed"></textarea>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="20%" class="col1" valign="top">
                                                    <label>
                                                        Any other allergies/infections - list below:</label><br />
                                                    <textarea name="txtallergies" rows="5" cols="30" id="txtallergies"></textarea>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="10">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" class="formsubheading">
                                                    <label style="font-size: 14px; letter-spacing: 1px;">
                                                        Medication-please indicate below if your child is at present taking any regular
                                                        medication</label>
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="20%" class="col1" valign="top">
                                                    <label>
                                                        Medication being Taken</label><br>
                                                    <textarea name="txtMedication" rows="5" cols="30" id="txtMedication"></textarea>
                                                </td>
                                                <td width="20%" class="col1" valign="top">
                                                    <label>
                                                        Purpose</label><br />
                                                    <textarea name="txtMedicationPurpose" rows="5" cols="30" id="txtMedicationPurpose"></textarea>
                                                </td>
                                                <td width="20%" class="col1" valign="top">
                                                    <label>
                                                        Period of Prescription</label><br>
                                                    <textarea name="txtPeriod" rows="5" cols="30" id="txtPeriod"></textarea>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="10">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" class="formsubheading">
                                                    <label style="font-size: 14px; letter-spacing: 1px;">
                                                        Please complete vaccination record of the student as follows:</label>
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" class="heading">
                                                    <label style="font-size: 14px; letter-spacing: 1px;">
                                                        Vaccinations:</label>
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="20%" class="col1" valign="top">
                                                    <label>
                                                        Tetanus</label>
                                                </td>
                                                <td class="col2" valign="top">
                                                    <input type="radio" name="Tetanus" id="rbtnTetanusYes" value="Yes" />Completed
                                                    <input type="radio" name="Tetanus" id="rbtnTetanusNo" checked="checked" value="No" />Not
                                                    Completed Completed<br />
                                                    <br />
                                                </td>
                                                <td width="20%" class="col1" valign="top">
                                                    <label>
                                                        Polio</label>
                                                </td>
                                                <td class="col2" valign="top">
                                                    <input type="radio" name="Polio" id="rbtnPolioYes" value="Yes" checked="checked" />Completed
                                                    <input type="radio" name="Polio" id="rbtnPolioNo" value="No" />Not Completed<br />
                                                    <br />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="20%" class="col1" valign="top">
                                                    <label>
                                                        TB</label>
                                                </td>
                                                <td class="col2" valign="top">
                                                    <input type="radio" name="TB" id="rbtnTBYes" value="Yes" checked="checked" />Completed
                                                    <input type="radio" name="TB" id="rbtnTBNo" value="No" />Not Completed<br />
                                                    <br />
                                                </td>
                                                <td width="20%" class="col1" valign="top">
                                                    <label>
                                                        Hepatitis B
                                                    </label>
                                                </td>
                                                <td class="col2" valign="top">
                                                    <input type="radio" name="Hepatitis" id="rbtnHepatitisYes" value="Yes" checked="checked" />Completed
                                                    <input type="radio" name="Hepatitis" id="rbtnHepatitisNo" value="No" />Not Completed<br />
                                                    <br />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="20%" class="col1" valign="top">
                                                    <label>
                                                        Covid-19</label>
                                                </td>
                                                <td class="col2" valign="top">
                                                    <input type="radio" name="Covid" id="rbtnCovidYes" value="Yes" checked="checked" />Completed
                                                    <input type="radio" name="Covid" id="rbtnCovidNo" value="No" />Not Completed<br />
                                                    <br />
                                                </td>
                                                <td width="20%" class="col1" valign="top">
                                                    <label>
                                                        HPV 11-14 Year old Girls
                                                    </label>
                                                </td>
                                                <td class="col2" valign="top">
                                                    <input type="radio" name="HPV" id="rbtnHPVYes" value="Yes" checked="checked" />Completed
                                                    <input type="radio" name="HPV" id="rbtnHPVNo" value="Yes" />Not Completed<br />
                                                    <br />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="20%" class="col1" valign="top">
                                                    <label>
                                                        Any other, please list below</label><br />
                                                    <textarea name="txtOtherlist" rows="5" cols="30" id="txtOtherlist"></textarea>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="10">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" class="formsubheading">
                                                    <label style="font-size: 14px; letter-spacing: 1px;">
                                                        Sight and Hearing Details</label>
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" class="heading">
                                                    <label style="font-size: 14px; letter-spacing: 1px;">
                                                        Particulars</label>
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="20%" class="col1" valign="top">
                                                    <label>
                                                        Does your Child wear Glasses?</label>
                                                    <input type="radio" name="Glass" id="rbtnGlassYes" value="Yes" checked="checked" />Yes
                                                    <input type="radio" name="Glass" id="rbtnGlassNo" value="No" />No<br />
                                                    <br />
                                                </td>
                                                <td width="22%" class="" valign="top">
                                                    <label>
                                                        Does your Child wear Contact Lenses?</label>
                                                    <input type="radio" name="Lenses" id="rbtnLensYes" value="Yes" checked="checked" />Yes
                                                    <input type="radio" name="Lenses" id="rbtnLensNo" value="No" />No<br />
                                                    <br />
                                                </td>
                                                <td width="20%" class="col1" valign="top">
                                                    <label>
                                                        Does your Child use any hearing aid?</label>
                                                    <input type="radio" name="hearing" id="rbtnhearYes" value="Yes" checked="checked" />Yes
                                                    <input type="radio" name="hearing" id="rbtnhearNo" value="No" />No<br />
                                                    <br />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" class="heading">
                                                    <label style="font-size: 14px; letter-spacing: 1px;">
                                                        Illness</label>
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="20%" class="col1" valign="top">
                                                    <label>
                                                        Chicken Pox</label>
                                                    <input type="radio" name="Chicken" id="rbtnChickenYes" value="Yes" checked="checked" />Yes
                                                    <input type="radio" name="Chicken" id="rbtnChickenNo" value="No" />No<br />
                                                    <br />
                                                </td>
                                                <td width="22%" class="" valign="top">
                                                    <label>
                                                        German Measles (Rubella) Glandular fever</label>
                                                    <input type="radio" name="Rubella" id="rbtnRubellaYes" value="Yes" checked="checked" />Yes
                                                    <input type="radio" name="Rubella" id="rbtnRubellaNo" value="No" />No<br />
                                                    <br />
                                                </td>
                                                <td width="20%" class="col1" valign="top">
                                                    <label>
                                                        Jaundice</label>
                                                    <input type="radio" name="Jaundice" id="rbtnJaundiceYes" value="Yes" checked="checked" />Yes
                                                    <input type="radio" name="Jaundice" id="rbtnJaundiceNo" value="No" />No<br />
                                                    <br />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="20%" class="col1" valign="top">
                                                    <label>
                                                        Measles</label>
                                                    <input type="radio" name="Measles" id="rbtnMeaslesYes" value="Yes" checked="checked" />Yes
                                                    <input type="radio" name="Measles" id="rbtnMeaslesNo" value="No" />No<br />
                                                    <br />
                                                </td>
                                                <td width="22%" class="" valign="top">
                                                    <label>
                                                        Mumps</label>
                                                    <input type="radio" name="Mumps" id="rbtnMumpsYes" value="Yes" checked="checked" />Yes
                                                    <input type="radio" name="Mumps" id="rbtnMumpsNo" value="No" />No<br />
                                                    <br />
                                                </td>
                                                <td width="20%" class="col1" valign="top">
                                                    <label>
                                                        Scarlet Fever</label>
                                                    <input type="radio" name="Scarlet" id="rbtnScarletYes" value="Yes" checked="checked" />Yes
                                                    <input type="radio" name="Scarlet" id="rbtnScarletNo" value="No" />No<br />
                                                    <br />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="20%" class="col1" valign="top">
                                                    <label>
                                                        Whooping Cough</label>
                                                    <input type="radio" name="Cough" id="rbtnCoughYes" value="Yes" checked="checked" />Yes
                                                    <input type="radio" name="Cough" id="rbtnCoughNo" value="No" />No<br />
                                                    <br />
                                                </td>
                                                <td width="22%" class="" valign="top">
                                                    <label>
                                                        Any other-list below</label>
                                                    <br />
                                                    <textarea name="txtAnyMedication" rows="5" cols="30" id="txtAnyMedication"></textarea>
                                                </td>
                                                <td width="22%" class="" valign="top">
                                                    <label>
                                                        Operation/Surgeries Undergone till date</label>
                                                    <br />
                                                    <textarea name="txtOperation" rows="5" cols="30" id="txtOperation"></textarea>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" class="heading">
                                                    <label style="font-size: 14px; letter-spacing: 1px;">
                                                        Other Illness if any (Please Tick)</label>
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="22%" class="" valign="top">
                                                    <input type="checkbox" id="chkAnorexia" />
                                                    <label>
                                                        Anorexia/ Bulimia/ any other eating disorder</label>&nbsp;&nbsp;
                                                </td>
                                                <td width="22%" class="" valign="top">
                                                    <input type="checkbox" id="chkArthritis" />
                                                    <label>
                                                        Arthritis</label>&nbsp;&nbsp;
                                                </td>
                                                <td width="22%" class="" valign="top">
                                                    <input type="checkbox" id="chkAsthma" />
                                                    <label>
                                                        Asthma</label>&nbsp;&nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="22%" class="" valign="top">
                                                    <input type="checkbox" id="chkBone" />
                                                    <label>
                                                        Bone or Joint Diseases</label>&nbsp;&nbsp;
                                                </td>
                                                <td width="22%" class="" valign="top">
                                                    <input type="checkbox" id="chkCancer" />
                                                    <label>
                                                        Cancer</label>&nbsp;&nbsp;
                                                </td>
                                                <td width="22%" class="" valign="top">
                                                    <input type="checkbox" id="chkCardiovascular" />
                                                    <label>
                                                        Cardiovascular</label>&nbsp;&nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="22%" class="" valign="top">
                                                    <input type="checkbox" id="chkDiabetes" />
                                                    <label>
                                                        Diabetes</label>&nbsp;&nbsp;
                                                </td>
                                                <td width="22%" class="" valign="top">
                                                    <input type="checkbox" id="chkEczema" />
                                                    <label>
                                                        Eczema</label>&nbsp;&nbsp;
                                                </td>
                                                <td width="22%" class="" valign="top">
                                                    <input type="checkbox" id="chkEnuresis" />
                                                    <label>
                                                        Enuresis (Bed Wetting)</label>&nbsp;&nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="22%" class="" valign="top">
                                                    <input type="checkbox" id="chkEpilepsy" />
                                                    <label>
                                                        Epilepsy / Seizures</label>&nbsp;&nbsp;
                                                </td>
                                                <td width="22%" class="" valign="top">
                                                    <input type="checkbox" id="chkGenetic" />
                                                    <label>
                                                        Genetic Disorder</label>&nbsp;&nbsp;
                                                </td>
                                                <td width="22%" class="" valign="top">
                                                    <input type="checkbox" id="chkHay" />
                                                    <label>
                                                        Hay Fever</label>&nbsp;&nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="22%" class="" valign="top">
                                                    <input type="checkbox" id="chkHead" />
                                                    <label>
                                                        Head Injury</label>&nbsp;&nbsp;
                                                </td>
                                                <td width="22%" class="" valign="top">
                                                    <input type="checkbox" id="chkHearing" />
                                                    <label>
                                                        Hearing Difficulties</label>&nbsp;&nbsp;
                                                </td>
                                                <td width="22%" class="" valign="top">
                                                    <input type="checkbox" id="chkHeart" />
                                                    <label>
                                                        Heart Disease (Congenital)</label>&nbsp;&nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="22%" class="" valign="top">
                                                    <input type="checkbox" id="chkHepatitis" />
                                                    <label>
                                                        Hepatitis</label>&nbsp;&nbsp;
                                                </td>
                                                <td width="22%" class="" valign="top">
                                                    <input type="checkbox" id="chkHIV" />
                                                    <label>
                                                        HIV/AIDS
                                                    </label>
                                                    &nbsp;&nbsp;
                                                </td>
                                                <td width="22%" class="" valign="top">
                                                    <input type="checkbox" id="chkLearning" />
                                                    <label>
                                                        Learning Difficulties</label>&nbsp;&nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="22%" class="" valign="top">
                                                    <input type="checkbox" id="chkMenstrual" />
                                                    <label>
                                                        Menstrual Disorder</label>&nbsp;&nbsp;
                                                </td>
                                                <td width="22%" class="" valign="top">
                                                    <input type="checkbox" id="chkMigraine" />
                                                    <label>
                                                        Migraine</label>&nbsp;&nbsp;
                                                </td>
                                                <td width="22%" class="" valign="top">
                                                    <input type="checkbox" id="chkPhobia" />
                                                    <label>
                                                        Phobia</label>&nbsp;&nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="22%" class="" valign="top">
                                                    <input type="checkbox" id="chkDeformity" />
                                                    <label>
                                                        Physical Deformity</label>&nbsp;&nbsp;
                                                </td>
                                                <td width="22%" class="" valign="top">
                                                    <input type="checkbox" id="chkPhysical" />
                                                    <label>
                                                        Physical Disability</label>&nbsp;&nbsp;
                                                </td>
                                                <td width="22%" class="" valign="top">
                                                    <input type="checkbox" id="chkPneumonia" />
                                                    <label>
                                                        Pneumonia</label>&nbsp;&nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="22%" class="" valign="top">
                                                    <input type="checkbox" id="chkRheumatic" />
                                                    <label>
                                                        Rheumatic Fever</label>&nbsp;&nbsp;
                                                </td>
                                                <td width="22%" class="" valign="top">
                                                    <input type="checkbox" id="chkSkin" />
                                                    <label>
                                                        Skin Diseases</label>&nbsp;&nbsp;
                                                </td>
                                                <td width="22%" class="" valign="top">
                                                    <input type="checkbox" id="chkStomach">
                                                    <label>
                                                        Stomach Ulcer</label>&nbsp;&nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="22%" class="" valign="top">
                                                    <input type="checkbox" id="chkSyndromes" />
                                                    <label>
                                                        Syndromes</label>&nbsp;&nbsp;
                                                </td>
                                                <td width="22%" class="" valign="top">
                                                    <input type="checkbox" id="chkUrinary" />
                                                    <label>
                                                        Urinary tract Infection
                                                    </label>
                                                    &nbsp;&nbsp;
                                                </td>
                                                <td width="22%" class="" valign="top">
                                                    <input type="checkbox" id="chkAnxiety" />
                                                    <label>
                                                        Anxiety</label>&nbsp;&nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="22%" class="" valign="top">
                                                    <input type="checkbox" id="chkAutism" />
                                                    <label>
                                                        Autism Disorder</label>&nbsp;&nbsp;
                                                </td>
                                                <td width="22%" class="" valign="top">
                                                    <input type="checkbox" id="chkMood" />
                                                    <label>
                                                        Mood Swings</label>&nbsp;&nbsp;
                                                </td>
                                                <td width="22%" class="" valign="top">
                                                    <input type="checkbox" id="chkSpeech" />
                                                    <label>
                                                        Speech Difficulties</label>&nbsp;&nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="20%" class="col1">
                                                    &nbsp;
                                                </td>
                                                <td class="col2">
                                                    &nbsp;
                                                </td>
                                                <td width="20%" class="col1">
                                                    <button id="btnWellnessSave" type="button" class="btn-icon btn-orange btn-saving"
                                                        onclick="SaveASSWellnessDetails();">
                                                        <span></span>
                                                        <div id="Div10">
                                                            Save</div>
                                                    </button>
                                                    <button id="btnWellnessClear" type="button" class="btn-icon btn-navy btn-cancel1"
                                                        runat="server" onclick="return ASSWellnessClear();">
                                                        <span></span>Cancel</button>&nbsp;
                                                </td>
                                                <td class="col2">
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hfAdvModuleID" runat="server" />
    <asp:HiddenField ID="hfAdvMenuId" runat="server" />
    <asp:HiddenField ID="hfConcession" runat="server" />
</asp:Content>
