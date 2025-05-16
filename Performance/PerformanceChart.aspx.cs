using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Configuration;
using System.IO;
using Microsoft.Reporting.WebForms;
using System.Drawing.Printing;
using System.Drawing.Imaging;
using System.Text;


public partial class Performance_PerformanceChart : System.Web.UI.Page
{
    Utilities utl = null;
    Utilities utl1 = null;
    Utilities utl2 = null;

    PrintDocument printDoc = new PrintDocument();
    public static int Userid = 0;
    public static int AcademicID = 0;
    public static string UserName = string.Empty;
    private static int PageSize = 10;
    string sqlstr = "";
    string sqlstr1 = "";

    string strClass = "";
    string strSection = "";
    string strClassID = "";
    string strSectionID = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        Master.chkUser();
        if (Session["UserId"] == null || Session["AcademicID"] == null)
        {
            Response.Redirect("Default.aspx?ses=expired");
        }
        else
        {
            AcademicID = Convert.ToInt32(Session["AcademicID"]);
            Userid = Convert.ToInt32(Session["UserId"]);
            hfUserId.Value = Userid.ToString();

            if (!IsPostBack)
            {
                Session["strSection"] = "";
                Session["strSectionID"] = "";
                Session["strExamName"] = "";
                Session["strExamNameID"] = "";
                Session["strSubject"] = "";
                Session["strSubjectID"] = "";

                BindClass();
                BindExamName_List();

                utl = new Utilities();
                utl.ExecuteQuery("DeleteDuplicate '" + AcademicID + "'");
                DataTable dtSchool = new DataTable();
                dtSchool = utl.GetDataTable("exec sp_schoolDetails");
                ReportParameter Schoolname = new ReportParameter("Schoolname", dtSchool.Rows[0]["SchoolName"].ToString());
            }
        }
    }

    protected void BindClass()
    {
        utl = new Utilities();
        DataSet dsClass = new DataSet();
        dsClass = utl.GetDataset("sp_GetClass");
        if (dsClass != null && dsClass.Tables.Count > 0 && dsClass.Tables[0].Rows.Count > 0)
        {
            ddlClass.DataSource = dsClass;
            ddlClass.DataTextField = "ClassName";
            ddlClass.DataValueField = "ClassID";
            ddlClass.DataBind();
        }
        else
        {
            ddlClass.DataSource = null;
            ddlClass.DataTextField = "";
            ddlClass.DataValueField = "";
            ddlClass.DataBind();
        }
    }

    protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
    {

        if (ddlClass.SelectedItem.Text == "---Select---" || ddlClass.SelectedItem.Value == "---Select---")
        {
            strClass = "";
            strClassID = "";
            strSection = "";
            strSectionID = "";
            Session["strSection"] = "";
            Session["strSectionID"] = "";

        }
        else
        {
            Session["strClass"] = ddlClass.SelectedItem.Text;
            Session["strClassID"] = ddlClass.SelectedValue;
            strSection = "";
            strSectionID = "";
            Session["strSection"] = "";
            Session["strSectionID"] = "";

        }
        BindSectionByClass();
    }

    protected string BindExamname()
    {
        utl = new Utilities();
        DataTable dt = new DataTable();
        StringBuilder sb = new StringBuilder();

        dt = utl.GetDataTable("sp_GetExamNameList  " + "''" + "," + AcademicID);
        if (dt != null && dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                sb.Append("<div class=\"checkbox\"><input id=\"rd_" + dr["ExamNameID"].ToString() + "\" style=\"border:0px;\" type=\"checkbox\" class=\"chkSubjects\" name=\"chkSubjects\" value=\"" + dr["ExamNameID"].ToString() + "\" />");
                sb.Append("<label name=\"lblSubjects\" id=\"lbl_rd_" + dr["ExamNameID"].ToString() + "\" for=\"rd_" + dr["ExamNameID"].ToString() + "\">" + dr["ExamName"].ToString() + "</label></div>");
            }

        }
        return sb.ToString();
    }


    protected void BindSectionByClass()
    {
        utl = new Utilities();
        DataSet dsSection = new DataSet();
        dsSection = utl.GetDataset("sp_GetSectionByClass " + ddlClass.SelectedValue);
        ddlSection.DataSource = null;
        ddlSection.AppendDataBoundItems = false;
        if (dsSection != null && dsSection.Tables.Count > 0 && dsSection.Tables[0].Rows.Count > 0)
        {
            ddlSection.DataSource = dsSection;
            ddlSection.DataTextField = "SectionName";
            ddlSection.DataValueField = "SectionID";
            ddlSection.DataBind();
        }
        else
        {
            ddlSection.DataSource = null;
            ddlSection.DataTextField = "";
            ddlSection.DataValueField = "";
            ddlSection.DataBind();
        }
        ddlSection.Items.Insert(0, "---Select---");
    }


    protected void ddlSection_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlSection.SelectedItem.Text == "---Select---" || ddlSection.SelectedItem.Value == "---Select---")
        {
            strSection = "";
            strSectionID = "";
            Session["strSection"] = "";
            Session["strSectionID"] = "";
        }
        else
        {
            Session["strSection"] = ddlSection.SelectedItem.Text;
            Session["strSectionID"] = ddlSection.SelectedValue;
        }
    }

    private void BindExamName_List()
    {
        string query = "sp_GetExamNameList " + "''" + "," + AcademicID + "";

        Utilities utl = new Utilities();
        DataTable dt = new DataTable();
        dt = utl.GetDataTable(query);
        if (dt != null && dt.Rows.Count > 0)
        {
            ddlExamName.DataSource = dt;
            ddlExamName.DataTextField = "ExamName";
            ddlExamName.DataValueField = "ExamNameID";
            ddlExamName.DataBind();
        }
        else
        {
            ddlExamName.DataSource = null;
            ddlExamName.DataBind();
        }

        //foreach (ListItem li in ddlExamName.Items)
        //    li.Attributes.Add("Classes", li.Value);
    }

    string SubjectListID = "";
    string CO_SubjectListID = "";
    string GA_SubjectListID = "";
    string allSubjects;
    private void Disp_SubjectList()
    {

        utl = new Utilities();
        DataSet ds = new DataSet();
        string query = "SP_GETPerformanceLANGUAGELIST " + Convert.ToInt32(ddlClass.Text) + ",''," + AcademicID + "";
        ds = utl.GetDataset(query);

        if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
        {

            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {

                if (ds.Tables[0].Rows[i]["Type"].ToString() == "Co-Curricular Activities")
                {
                    if (CO_SubjectListID == "")
                    {
                        CO_SubjectListID = ds.Tables[0].Rows[i]["Subjectid"].ToString();
                    }

                    else
                    {
                        CO_SubjectListID = CO_SubjectListID + "," + ds.Tables[0].Rows[i]["Subjectid"].ToString();
                    }
                }

                else if (ds.Tables[0].Rows[i]["Type"].ToString() == "General Activities")
                {
                    if (GA_SubjectListID == "")
                    {
                        GA_SubjectListID = ds.Tables[0].Rows[i]["Subjectid"].ToString();
                    }

                    else
                    {
                        GA_SubjectListID = GA_SubjectListID + "," + ds.Tables[0].Rows[i]["Subjectid"].ToString();
                    }
                }

                else
                {
                    if (SubjectListID == "")
                    {
                        SubjectListID = ds.Tables[0].Rows[i]["Subjectid"].ToString();
                    }

                    else
                    {
                        SubjectListID = SubjectListID + "," + ds.Tables[0].Rows[i]["Subjectid"].ToString();
                    }
                }
            }
        }
    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            Disp_SubjectList();

            LOAD_Totdays();
            LOAD_RESULT();
        }

        catch (Exception ex)
        {
            //Response.Write("<script>alert('"+ex.Message+"')</script>");
            ClientScript.RegisterClientScriptBlock(this.GetType(), "bnn", "<script>jAlert('" + ex.Message + "')</script>");
        }
    }


    //Main Search Function

    string stroption;
    StringBuilder dvContent = new StringBuilder();
    DataSet dsGet = new DataSet();
    string examnochk = string.Empty;

    private void LOAD_RESULT()
    {
        try
        {
            DISPLAY();
        }
        catch
        {

        }
        //Normal Type only - Samacheer and General Result

        dvContent.Append(stroption);
        dvCard.InnerHtml = dvContent.ToString();
    }
    

    string acadamicyear;
    private void DISPLAY()
    {
        string sqlqry = "select YEAR(StartDate) from m_academicyear where AcademicId='" + AcademicID + "'";
        acadamicyear = utl.ExecuteScalar(sqlqry);

        stroption = "";
        utl = new Utilities();

        string[] SUBList = SubjectListID.Split(',');
        if ((Session["strClassID"] != null && Session["strSectionID"] != null) && (Session["strClassID"].ToString() != "" && Session["strSectionID"].ToString() != ""))
        {
            sqlstr = "sp_getscholasticreport '" + Session["strClassID"] + "','" + ddlSection.SelectedValue + "'," + "'" + ddlExamName.SelectedValue + "'" + "," + "''" + ",'" + txtSearch.Text + "'," + AcademicID;
            dsGet = utl.GetDataset(sqlstr);
        }
        sqlstr = "select schooltypeid from m_class where classid='" + ddlClass.SelectedValue + "'";
        string classid = ddlClass.SelectedValue.ToString();
        string schooltypeid = utl.ExecuteScalar(sqlstr);

        if (dsGet != null && dsGet.Tables.Count > 0 && dsGet.Tables[0].Rows.Count > 0)
        {
            DataSet dsGetRank = new DataSet();
            sqlstr1 = "SP_GetConsolidateReport '" + ddlClass.SelectedValue + "','" + ddlSection.SelectedValue + "'," + "'" + ddlExamName.SelectedValue + "'" + "," + "''" + "," + "'General'" + ",'" + txtSearch.Text + "'," + AcademicID;
            dsGetRank = utl.GetDataset(sqlstr1);

            for (int i = 0; i < dsGet.Tables[0].Rows.Count; i++)
            {
                if (examnochk != dsGet.Tables[0].Rows[i]["RegNo"].ToString())
                {
                    string dateofissue = utl.ExecuteScalar("select convert(varchar(10),dateofissue,103) from p_exammarks xmark inner join p_examtypes xtype on (xmark.ClassId=xtype.ClassId and xmark.ExamTypeId=xtype.ExamTypeID and xmark.AcademicID=xtype.AcademicID and xmark.IsActive=1)  where  xmark.ClassID= '" + Session["strClassID"] + "' and xtype.ExamNameID= '" + ddlExamName.SelectedValue + "' and type='General' and xmark.academicId='" + AcademicID + "' and xmark.isactive=1 and dateofissue is not null and regno='" + dsGet.Tables[0].Rows[i]["RegNo"].ToString() + "'");

                    stroption += @"<table width='100%' border='0' cellspacing='0' cellpadding='0' class='terms-bg'><tr><td height='1419' align='center' valign='top'><div class='terms-cont'> <table width='1000' border='0' cellspacing='0' cellpadding='0'><tr><td height='20' align='center'><br/><h3 style='font-size: 31px;'>AMALORPAVAM HR. SEC. SCHOOL </h3> <h3 style=' margin-top: -20px;'>LOURDES CAMPUS, VANARAPET, PUDUCHERRY.</h3><h3 style=' margin-top: -5px;'>www.amalorpavamschool.org</h3></td></tr><tr><td height='30' align='center'><table border='0' cellspacing='0' cellpadding='0'><tr><td align='right' valign='bottom'><img src='../img/title-left.jpg' width='113' height='74' /></td><td class='titlebg' ><Div class='title-hd'><h1>PERFORMANCE CHART</h1> </Div> </td><td align='left'> <img src='../img/title-right.jpg' width='110' height='74' /></td></tr></table></td><td></td></tr><tr><td><Div class='terms-student-details terms-studentname'><table width='100%' border='0' cellspacing='0' cellpadding='0'><tr><td align='left' height='40' valign='top'></td></tr><tr><td width='19%' style='border-bottom:1px solid #000;' height='35'>Student Name&nbsp;&nbsp;&nbsp;<span style='padding-left:3px;'>:</span> </td><td colspan='3' style='border-bottom:1px solid #000;'  width='25%'>" + dsGet.Tables[0].Rows[i]["StudentName"].ToString() + "</td><td  style='border-bottom:1px solid #000;padding-left: 200px;' height='35'>Reg. No : " + dsGet.Tables[0].Rows[i]["RegNo"].ToString() + "</td></tr><tr><td style='border-bottom:1px solid #000;' height='35'>Class & Section : </td><td  colspan='3' style='border-bottom:1px solid #000;' width='15%'>" + ddlClass.SelectedItem.Text + "  " + ddlSection.SelectedItem.Text + "</td><td style='border-bottom:1px solid #000;padding-left: 200px;' width='48%'>Exam No : " + dsGet.Tables[0].Rows[i]["ExamNo"].ToString() + "</td></tr><tr><td style='border-bottom:1px solid #000;' height='35'>Exam Name :</td><td colspan='3' style='border-bottom:1px solid #000;'> " + ddlExamName.SelectedItem.Text + "</td><td style='border-bottom:1px solid #000;padding-left: 200px;' height='35'>Date :" + dateofissue.ToString() + "</td></tr></table></div></td></tr>";

                    DataRow[] drExamPattern = dsGet.Tables[0].Select("Pattern='None' and RegNo=" + dsGet.Tables[0].Rows[i]["RegNo"].ToString() + " ");

                    if (drExamPattern.Length > 0)
                    {
                        //General Type only - Result -START

                            stroption += @"<tr><td><div class='terms-student-details terms-markareaHSSCO'><table width='100%' border='0' cellspacing='0' cellpadding='0'><tr>
              <td height='35' align='center' class='terms-title'>SCHOLASTIC AREAS </td></tr><tr><td><div class='scholastictable'><table width='100%' border='0' cellspacing='0' cellpadding='0'> <tr><td class='heading' width='15%' height='20'>Subjects</td><td class='heading' width='15%'>Minimum Marks</td><td class='heading' width='15%'>Maximum Marks</td><td class='heading' width='15%'>Marks Obtained</td><td class='heading' width='15%'>Result</td>";
                       
                        if (ddlType.Text == "Grade")
                        {
                            stroption += @"<td class='heading' width='15%'>Mark Grade</td>";
                        }

                        stroption += @"</tr>";

                        double TotalMarks = 0;
                        double MaxMarks = 0;
                        int SUBListcount = 0;
                        double MarksPercetage = 0;
                        string Mark_Grade = "";
                        foreach (string SUBListID in SUBList)
                        {

                            SUBListcount += 1;
                            DataRow[] drSubject = dsGet.Tables[0].Select("Pattern='None' and RegNo=" + dsGet.Tables[0].Rows[i]["RegNo"].ToString() + " and SubExperienceid=" + SUBListID + "");
                            if (drSubject.Length > 0)
                            {
                                string ActualMark = drSubject[0]["Mark"].ToString();
                                double dblActualMark = 0;
                                if (ActualMark == null || ActualMark == "")
                                {
                                    dblActualMark = 0;
                                    ActualMark = "A";
                                }
                                else
                                {
                                    dblActualMark = Convert.ToDouble(drSubject[0]["Mark"].ToString());
                                }
                                if (drSubject[0]["Mark"].ToString() != null && drSubject[0]["Mark"].ToString() != "")
                                {
                                    TotalMarks += Convert.ToDouble(drSubject[0]["Mark"].ToString());
                                }

                                MaxMarks += Convert.ToDouble(drSubject[0]["MaxMark"].ToString());
                                //Grade Calculation Based on the Mark In None type
                                if (drSubject[0]["Mark"].ToString() != null && drSubject[0]["Mark"].ToString() != "")
                                {
                                    sqlstr1 = "sp_getCalculateGrade " + "'None'" + "," + Convert.ToInt32(Math.Ceiling(Convert.ToDouble(drSubject[0]["Mark"].ToString()))) + "," + "'" + Session["AcademicID"].ToString() + "'";
                                    Mark_Grade = utl.ExecuteScalar(sqlstr1);
                                }
                                else
                                {
                                    Mark_Grade = "ABSENT";
                                }

                               
                                    if (Convert.ToDouble(drSubject[0]["PassMark"].ToString()) <= Convert.ToDouble(dblActualMark))
                                    {

                                        stroption += @"<tr><td height='20' align='left'><b>" + drSubject[0]["SubExperienceName"].ToString() + "</b></td><td style='padding-right: 75px;text-align: right;'>" + drSubject[0]["PassMark"].ToString() + "</td><td style='padding-right: 75px;text-align: right;'>" + drSubject[0]["MaxMark"].ToString() + "</td><td style='padding-right: 75px;text-align: right;'>" + ActualMark + "</td><td style='padding-right: 50px;text-align: right;'>PASS</td>";
                                    }

                                    else
                                    {
                                        if (ActualMark == "A")
                                        {
                                            stroption += @"<tr><td height='20' align='left'><b>" + drSubject[0]["SubExperienceName"].ToString() + "</b></td><td style='padding-right: 75px;text-align: right;'>" + drSubject[0]["PassMark"].ToString() + "</td><td style='padding-right: 75px;text-align: right;'>" + drSubject[0]["MaxMark"].ToString() + "</td><td style='padding-right: 75px;text-align: right;'>" + ActualMark + "</td><td style='padding-right: 50px;text-align: right;'>ABSENT</td>";
                                        }
                                        else
                                        {
                                            stroption += @"<tr><td height='20' align='left'><b>" + drSubject[0]["SubExperienceName"].ToString() + "</b></td><td style='padding-right: 75px;text-align: right;'>" + drSubject[0]["PassMark"].ToString() + "</td><td style='padding-right: 75px;text-align: right;'>" + drSubject[0]["MaxMark"].ToString() + "</td><td style='padding-right: 75px;text-align: right;'>" + ActualMark + "</td><td style='padding-right: 50px;text-align: right;'>FAIL</td>";
                                        }
                                    }
                                if (ddlType.Text == "Grade")
                                {
                                    if (Convert.ToDouble(drSubject[0]["PassMark"].ToString()) <= Convert.ToDouble(dblActualMark))
                                    {

                                        stroption += @"<td style='text-align: center;'>" + Mark_Grade + "</td>";
                                    }

                                    else
                                    {
                                        stroption += @"<td style='text-align: center;'>" + Mark_Grade + "</td>";
                                    }
                                }
                                stroption += @"</tr>";
                            }
                        }

                        MarksPercetage = Math.Round(((TotalMarks / MaxMarks) * 100), 2);

                        DataRow[] drRank = dsGetRank.Tables[0].Select("RegNo=" + dsGet.Tables[0].Rows[i]["RegNo"].ToString() + "");


                        //if (schooltypeid == "1")
                        //{
                        //    stroption += @"<tr><td height='25' align='left'></td><td align='center'></td><td class='percentage'><b>percentage : " + Math.Round(MarksPercetage, 1) + "</b></td><td class='total'><b>Total : " + TotalMarks.ToString() + "</b></td><td class='total'><b>&nbsp;</b></td></tr>";
                        //}
                        //else 

                        

                            sqlstr = "select count(*) from s_studentinfo where  Active in('C','N') and class= '" + ddlClass.SelectedValue + "' and academicyear='" + Session["AcademicID"] + "' ";
                            string ClassCnt = utl.ExecuteScalar(sqlstr);

                            sqlstr = "select count(*) from s_studentinfo where  Active in('C','N') and class='" + ddlClass.SelectedValue + "' and  section='" + ddlSection.SelectedValue + "'  and academicyear='" + Session["AcademicID"] + "'";
                            string SectionCnt = utl.ExecuteScalar(sqlstr);

                            if (ddlType.Text == "Grade")
                            {
                                stroption += @"<tr><td colspan='2' align='left' style='padding-left:42px;'><b>TOTAL &nbsp;&nbsp;&nbsp;<span style='padding-left:42px;'>:</span> " + TotalMarks.ToString() + " / " + MaxMarks.ToString() + "</b></td><td colspan='4' style='padding-left: 172px;' align='left'><b>PERCENTAGE &nbsp;&nbsp;&nbsp;<span style='padding-left:1px;'>:</span> " + MarksPercetage + "</b></td></tr><tr><td height='20' colspan='2' align='left' style='padding-left:42px;'><b>SECTION RANK : " + drRank[0]["SectionRank"].ToString() + " / " + SectionCnt + "</b></td><td align='left' colspan='4' style='padding-left: 172px;'></td></tr>";

                                //<b>OVERALL RANK : " + drRank[0]["ClassRank"].ToString() + " / " + ClassCnt + "</b>
                            }

                            if (ddlType.Text == "Grade")
                            {
                                //  stroption += @"<tr><td height='25' align='left'></td><td align='center'></td><td class='percentage'><b>percentage : " + MarksPercetage + "</b></td><td class='total'><b>Total : " + TotalMarks.ToString() + "</b></td><td class='total'><b>Rank : " + drRank[0]["SectionRank"].ToString() + "</b></td></tr>";
                            }


                        string StudRegno = dsGet.Tables[0].Rows[i]["RegNo"].ToString();
                        //double StudPresentdays = Attenance(StudRegno);
                        //double Attpercentage = (StudPresentdays / totdays);
                        string studAtt = Attenance(StudRegno);

                        if (ddlExamName.SelectedValue!="179" && ddlExamName.SelectedValue!="180")
                        {
                            stroption += @"<tr><td align='center' colspan='6'><b>ATTENDANCE: " + studAtt + "/" + totdays + " </b></td></tr>";    
                        }
                        

                       // stroption += @"</table></div></td></tr><tr><td></td></tr><tr><td></td></tr></table></div></td></tr>";

                        stroption += @"</table></div></td></tr><tr><td>&nbsp;</td></tr></tr></table></div></td></tr>";

                        //General Type only - Result -START
                    }

                    else
                    {

                        //Normal Type only - Samacheer Result -START

                        stroption += @"<tr><td><div class='terms-student-details terms-markareaSCO'><table width='100%' border='0' cellspacing='0' cellpadding='0'><tr>
              <td height='35' align='center' class='terms-title'>SCHOLASTIC AREAS </td></tr><tr><td><div class='scholastictable'><table width='100%' border='0' cellspacing='0' cellpadding='0'><tr><td class='heading' width='25%' height='25'>Subjects</td><td class='heading' width='25%'>Grade FA</td><td class='heading' width='25%'>Grade SA</td><td class='heading' width='25%'>Overall Grade</td></tr>";

                        foreach (string SUBListID in SUBList)
                        {
                            double FAtot = 0;
                            double FBtot = 0;
                            double FABTotal = 0;
                            double SAtot = 0;
                            double Total = 0;

                            string strFAtot = "";
                            string strFBtot = "";
                            string strSAtot = "";
                            string strFABTotal = "";
                            string strTotal = "";
                            DataRow[] drFAScroedMarkTOT = dsGet.Tables[0].Select("Pattern='FA(a)' and RegNo=" + dsGet.Tables[0].Rows[i]["RegNo"].ToString() + " and SubExperienceid='" + SUBListID + "'");
                            if (drFAScroedMarkTOT.Length > 0)
                            {
                                if (drFAScroedMarkTOT[0]["ScoredMarkTotal"].ToString() != "" && drFAScroedMarkTOT[0]["ScoredMarkTotal"].ToString() != null)
                                {
                                    FAtot = Convert.ToDouble(drFAScroedMarkTOT[0]["ScoredMarkTotal"].ToString());
                                    strFAtot = FAtot.ToString();
                                }
                                else
                                {
                                    strFAtot = "";
                                }
                            }
                            else
                            {
                                FAtot = 0;
                                strFAtot = "";
                            }


                            DataRow[] drFBScroedMarkTOT = dsGet.Tables[0].Select("Pattern='FA(b)' and RegNo=" + dsGet.Tables[0].Rows[i]["RegNo"].ToString() + " and SubExperienceid='" + SUBListID + "'");

                            if (drFBScroedMarkTOT.Length > 0)
                            {
                                if (drFBScroedMarkTOT[0]["ScoredMarkTotal"].ToString() != "" && drFBScroedMarkTOT[0]["ScoredMarkTotal"].ToString() != null)
                                {
                                    FBtot = Convert.ToDouble(drFBScroedMarkTOT[0]["ScoredMarkTotal"].ToString());
                                    strFBtot = FBtot.ToString();
                                }
                                else
                                {
                                    strFBtot = "";
                                }
                            }
                            else
                            {
                                FBtot = 0;
                                strFBtot = "";
                            }

                            if ((strFAtot != "" && strFBtot != "") && (strFAtot != null && strFBtot != null))
                            {
                                FABTotal = Convert.ToInt32(Math.Ceiling(FAtot + FBtot));
                                strFABTotal = FABTotal.ToString();
                            }
                            else if ((strFAtot == "" && strFBtot != "") || (strFAtot == null && strFBtot != null))
                            {
                                FABTotal = Convert.ToInt32(Math.Ceiling(FBtot));
                                strFABTotal = FABTotal.ToString();
                            }
                            else if ((strFAtot != "" && strFBtot == "") || (strFAtot != null && strFBtot == null))
                            {
                                FABTotal = Convert.ToInt32(Math.Ceiling(FAtot));
                                strFABTotal = FABTotal.ToString();
                            }
                            else
                            {
                                strFABTotal = "";
                            }




                            DataRow[] drSAScroedMarkTOT = dsGet.Tables[0].Select("Pattern='SA' and RegNo=" + dsGet.Tables[0].Rows[i]["RegNo"].ToString() + " and SubExperienceid='"
+ SUBListID + "'");

                            if (drSAScroedMarkTOT.Length > 0)
                            {
                                if (drSAScroedMarkTOT[0]["Mark"].ToString() != "" && drSAScroedMarkTOT[0]["Mark"].ToString() != null)
                                {
                                    SAtot = Convert.ToDouble(drSAScroedMarkTOT[0]["Mark"].ToString());
                                    strSAtot = SAtot.ToString();
                                }
                                else
                                {
                                    strSAtot = "";
                                }
                            }
                            else
                            {
                                SAtot = 0;
                                strSAtot = "";
                            }
                            if (strSAtot != "" && strFABTotal != "")
                            {
                                Total = Convert.ToInt32(Math.Ceiling(FABTotal + SAtot));
                                strTotal = Total.ToString();
                            }
                            else if (strSAtot == "" && strFABTotal != "")
                            {
                                Total = Convert.ToInt32(Math.Ceiling(FABTotal));
                                strTotal = Total.ToString();
                            }
                            else if (strSAtot != "" && strFABTotal == "")
                            {
                                Total = Convert.ToInt32(Math.Ceiling(SAtot));
                                strTotal = Total.ToString();
                            }
                            else
                            {
                                strTotal = "";
                            }


                            //Grade Calculation
                            string FA_Grade = "";
                            if (strFAtot != "" || strFBtot != "")
                            {
                                sqlstr1 = "sp_getCalculateGrade " + "'FA'" + "," + FABTotal + "," + "'" + Session["AcademicID"].ToString() + "'";
                                FA_Grade = utl.ExecuteScalar(sqlstr1);
                            }
                            else
                            {
                                FA_Grade = "ABSENT";
                            }

                            string SA_Grade = "";
                            if (strSAtot != "")
                            {
                                sqlstr1 = "sp_getCalculateGrade " + "'SA'" + "," + SAtot + "," + "'" + Session["AcademicID"].ToString() + "'"; ;
                                SA_Grade = utl.ExecuteScalar(sqlstr1);
                            }
                            else
                            {
                                SA_Grade = "ABSENT";
                            }

                            string TOTALL_Grade = "";
                            if (strTotal != "")
                            {
                                sqlstr1 = "sp_getCalculateGrade " + "'OverAll'" + "," + Total + "," + "'" + Session["AcademicID"].ToString() + "'"; ;
                                TOTALL_Grade = utl.ExecuteScalar(sqlstr1);
                            }
                            else
                            {
                                TOTALL_Grade = "ABSENT";
                            }

                            sqlstr1 = "select SubExperienceName from m_SubExperiences where SubExperienceId=" + SUBListID + "";
                            string SubjectName = utl.ExecuteScalar(sqlstr1);


                            stroption += @"<tr><td height='25' align='left'><b>" + SubjectName + "</b></td><td align='left' style='padding-left: 97px;'>" + FA_Grade + "</td><td align='left' style='padding-left: 97px;'>" + SA_Grade + "</td><td align='left' style='padding-left: 97px;'>" + TOTALL_Grade + "</td></tr>";

                        }

                        //Student Attendance Details

                        string StudRegno = dsGet.Tables[0].Rows[i]["RegNo"].ToString();
                        //double StudPresentdays = Attenance(StudRegno);
                        //double Attpercentage = (StudPresentdays / totdays);
                        string studAtt = Attenance(StudRegno);

                        stroption += @"<tr><td align='center' colspan='6'><b>ATTENDANCE: " + studAtt + "/" + totdays + " </b></td></tr>";

                        stroption += @"</table></div></td></tr><tr><td></td></tr><tr><td></td></tr></table></div></td></tr>";

                        //Normal Type only - Samacheer Result -END
                    }

                    if (CO_SubjectListID != "" || GA_SubjectListID != "")
                    {

                        stroption += @"<tr><td><div class='terms-student-details terms-markareaCO'><table width='100%' border='0' cellspacing='0' cellpadding='0'><tr><td height='35' align='center' class='terms-title'>CO-SCHOLASTIC AREAS </td></tr><tr><td><div class='scholastictable'>";

                        //Co-scholastic Type only - Cocurricular Activities Result -START

                        string[] CO_SUBList = CO_SubjectListID.Split(',');

                        if (CO_SubjectListID != "")
                        {
                            stroption += @"<div class='performance curricular-block'><table width='100%' cellspacing='0' cellpadding='0' border='0'><tr><td class='heading' width='100%'align='left' colspan='2'>Co-Curricular Activities</td></tr><tbody>";

                            foreach (string CO_SUBListID in CO_SUBList)
                            {
                                DataRow[] drCO_CAScroedMarkTOT = dsGet.Tables[0].Select("SubjectType='Co-Curricular Activities' and RegNo=" + dsGet.Tables[0].Rows[i]["RegNo"].ToString() + " and SubExperienceid='" + CO_SUBListID + "'");

                                if (drCO_CAScroedMarkTOT.Length > 0)
                                {
                                    string strCAmark = "";
                                    string strMaxCAmark = "";
                                    sqlstr1 = "select SubExperienceName from m_SubExperiences where SubExperienceId=" + CO_SUBListID + "";
                                    string SubjectName = utl.ExecuteScalar(sqlstr1);

                                    strCAmark = drCO_CAScroedMarkTOT[0]["Mark"].ToString();
                                    strMaxCAmark = drCO_CAScroedMarkTOT[0]["MaxMark"].ToString();
                                    if (strCAmark != "" && strCAmark != null)
                                    {
                                        sqlstr1 = "sp_getCalculateGrade " + "'Co-Curricular Activities'" + "," + Convert.ToInt32(Math.Ceiling(Convert.ToDouble(strCAmark))) + "," + "'" + Session["AcademicID"].ToString() + "'";
                                        string CO_Grade = utl.ExecuteScalar(sqlstr1);

                                        stroption += @"<tr><td width='80%' align='left'><b>" + SubjectName + "</b></td><td width='20%'align='right' style='padding-right: 20px;'>" + CO_Grade + "</td></tr>";
                                       // stroption += @"<tr><td width='80%' align='left'><b>" + SubjectName + "</b></td><td width='20%' align='right' style='padding-right: 20px;'>" + Math.Ceiling(Convert.ToDouble(strCAmark)) + "/" + Math.Ceiling(Convert.ToDouble(strMaxCAmark)) + "</td></tr>";
                                    }
                                    else
                                    {
                                        stroption += @"<tr><td width='80%' align='left'><b>" + SubjectName + "</b></td><td width='20%' align='right' style='padding-right: 8px;'>ABSENT</td></tr>";
                                    }
                                }
                            }

                            stroption += @"</tbody></table></div>";
                        }

                        //Co-scholastic Type only - Cocurricular Activities Result -END


                        //Co-scholastic Type only - General Activities Result -START

                        string[] GA_SUBList = GA_SubjectListID.Split(',');

                        stroption += @"<div class='performance general-block'><table width='100%' cellspacing='0' cellpadding='0' border='0'><tr><td class='heading' width='100%'align='left' colspan='2'>Disciplinary Activities</td></tr><tbody>";

                        foreach (string GA_SUBListID in GA_SUBList)
                        {
                            DataRow[] drCO_GAScroedMarkTOT = dsGet.Tables[0].Select("SubjectType='General Activities' and RegNo=" + dsGet.Tables[0].Rows[i]["RegNo"].ToString() + " and SubExperienceid='" + GA_SUBListID + "'");

                            if (drCO_GAScroedMarkTOT.Length > 0)
                            {
                                string strGAmark = "";
                                string strMaxGAmark = "";
                                sqlstr1 = "select SubExperienceName from m_SubExperiences where SubExperienceId=" + GA_SUBListID + "";
                                string SubjectName = utl.ExecuteScalar(sqlstr1);

                                strGAmark = drCO_GAScroedMarkTOT[0]["Mark"].ToString();
                                strMaxGAmark = drCO_GAScroedMarkTOT[0]["MaxMark"].ToString();
                                if (strGAmark != "" && strGAmark != null)
                                {

                                    sqlstr1 = "sp_getCalculateGrade " + "'General Activities'" + "," + Convert.ToInt32(Math.Ceiling(Convert.ToDouble(strGAmark))) + "," + "'" + Session["AcademicID"].ToString() + "'";
                                    string GA_Grade = utl.ExecuteScalar(sqlstr1);

                                    stroption += @"<tr><td width='80%' align='left'><b>" + SubjectName + "</b></td><td width='20%'align='right' style='padding-right: 20px;'>" + GA_Grade + "</td></tr>";
                                    //stroption += @"<tr><td width='80%' align='left'><b>" + SubjectName + "</b></td><td width='20%' align='right' style='padding-right: 20px;'>" + Math.Ceiling(Convert.ToDouble(strGAmark)) + "/" + Math.Ceiling(Convert.ToDouble(strMaxGAmark)) + "</td></tr>";
                                }
                                else
                                {
                                    stroption += @"<tr><td width='80%' align='left'><b>" + SubjectName + "</b></td><td width='20%' align='right' style='padding-right: 8px;'>ABSENT</td></tr>";
                                }
                            }
                        }

                        stroption += @"</tbody></table></div>";


                        //Co-scholastic Type only - General Activities Result -END

                        stroption += @"</div></td></tr></table></div></td></tr>";
						
						//<tr><td>&nbsp;</td></tr><tr><td>&nbsp;</td></tr>
                    }

                    //Signature List Row - start
                    //if (dsGet.Tables[0].Rows[i]["Signature"].ToString() != "" && (Server.MapPath("~\\Signature\\") + dsGet.Tables[0].Rows[i]["Signature"].ToString())!="")
                    //{
                    //    stroption += @"<tr><td> </td></tr></table></div></td></tr><tr><td height='300' align='center' valign='top'><table width='100%' border='0' cellspacing='0' cellpadding='0'><tbody><tr><td width='33%'></td><td width='33%'></td><tdwidth='33%'></td></tr><tr><td>&nbsp;</td><td align='center' ><img class='signature' src='Signature/" + dsGet.Tables[0].Rows[i]["Signature"].ToString() + "' style='width: 100px;height: 50px;' /></td><td>&nbsp;</td></tr></tbody></table></td></tr></table> <p class='pagebreakhere' style='page-break-after:auto; color: Red;'></p>";
                    //}
                    //else
                    //{
                   // stroption += @"<tr><td>&nbsp;</td></tr></table></div></td></tr></table><p class='pagebreakhere' style='page-break-after:auto; color: Red;'></p>";

                    stroption += @"<tr><td> </td></tr></table></div></td></tr><tr><td align='center' valign='top'><table width='100%' border='0' cellspacing='0' cellpadding='0'><tbody><tr><td width='33%'></td><td width='33%'></td><tdwidth='33%'></td></tr><tr><td>&nbsp;</td><td align='center' >&nbsp;</td><td>&nbsp;</td></tr></tbody></table></td></tr></table> <p class='pagebreakhere' style='page-break-after:always; color: Red;'></p>";
                     //<p class='pagebreakhere' style='page-break-after:auto; color: Red;'></p>
                 //    }                  


                    #region Subject Header Tab starts

                    decimal MaxTotal = 0;
                    decimal ObtainedTotal = 0;
                    string subexp = "";

                    DataTable dsheader = new DataTable();
                    dsheader = utl.GetDataTable(@"SELECT a.Regno, 
                                               a.class AS ClassID, 
                                               e.SubExperienceName, 
                                               SubjectHeaderName, 
                                               ISNULL(MaxMark, 0) AS MaxMark, 
                                               ISNULL(k.Mark, 0) AS Mark 
                                        FROM s_studentinfo a WITH (NOLOCK)
                                        INNER JOIN m_class c WITH (NOLOCK) ON a.class = c.classid
                                        INNER JOIN m_schooltypes b WITH (NOLOCK) ON c.SchoolTypeId = b.schooltypeid
                                        INNER JOIN [p_ClassSubjects] d WITH (NOLOCK) ON d.schooltypeid = b.schooltypeid 
                                                                                    AND d.ClassId = c.ClassId
                                        INNER JOIN m_subexperiences e WITH (NOLOCK) ON d.subjectid = e.subexperienceid
                                        LEFT JOIN p_subjectheaders j WITH (NOLOCK) ON j.ClassSubjectID = d.ClassSubjectID 
                                                                                  AND j.isactive = 1
                                        INNER JOIN p_examheadermarks k WITH (NOLOCK) ON k.regno = a.regno 
                                                                                    AND k.sectionid = a.Section 
                                                                                    AND j.SubjectheaderID = k.SubjectheaderID 
                                                                                    AND k.isactive = 1
                                        INNER JOIN p_examtypes pe WITH (NOLOCK) ON pe.ExamTypeID = k.ExamTypeId 
                                                                               AND pe.AcademicID = k.AcademicID 
                                                                               AND pe.IsActive = 1
                                        INNER JOIN p_examnamelist px WITH (NOLOCK) ON px.ExamNameID = pe.ExamNameID 
                                                                                  AND px.AcademicID = px.AcademicID 
                                                                                  AND px.isactive = 1
                                        WHERE d.isactive = 1 and a.active in ('C','N')  and a.class='" + ddlClass.SelectedValue + "' and a.section='" + ddlSection.SelectedValue + "' and px.ExamNameID='" + ddlExamName.SelectedValue + "' and a.AcademicYear=" + AcademicID + " and a.RegNo='" + dsGet.Tables[0].Rows[i]["RegNo"].ToString() + "' order by a.Regno,d.subjectid,Sortorder");
                    string str = "";
                    if (dsheader.Rows.Count > 0)
                    {
                        int cnt = 0;
                        str = str + @"<table width='95%' margin: 3px 15px; border='1' cellspacing='0' cellpadding='0' style='margin-left: 30px !important;'>";

                        for (int l = 0; l < dsheader.Rows.Count; l++)
                        {
                            if (cnt == 0)
                            {
                                str = str + "<tr><td width='19%' class='terms-title' style='padding-left:3px;' height='35'>Student Name : " + dsGet.Tables[0].Rows[i]["StudentName"].ToString() + "</td><td class='terms-title' style='padding-left:3px;' height='35'>Reg. No : " + dsGet.Tables[0].Rows[i]["RegNo"].ToString() + "</td></tr><td height='35' align='center' colspan='3' class='terms-title'>DESCRIPTION OF SCHOLASTIC AREAS </td><tr>";
                            }
                            if (subexp != dsheader.Rows[l]["SubExperienceName"].ToString())
                            {
                                string alignstr = "";

                                MaxTotal = 0;
                                ObtainedTotal = 0;

                                DataTable dtrow = new DataTable();
                                DataRow[] drrow = dsheader.Select("RegNo=" + dsheader.Rows[l]["RegNo"].ToString() + " and SubExperienceName='" + dsheader.Rows[l]["SubExperienceName"].ToString() + "'");
                                if (drrow.Length > 0)
                                {
                                    str = str + @"<td width='50%' style='border:1px solid #dfdfdf;font-family: Arial, Helvetica, sans-serif;'><table width='100%' cellpadding='0' cellspacing='0' style='border:0px solid #dfdfdf;font-size: 13px;'> <tr  style='background-color: #bfbdbd;'> <td style='border:1px solid #dfdfdf;'><p style='margin: 3px 15px;' align='center'> <b>Description</b></p></td><td style='border:1px solid #dfdfdf;'><p style='margin: 3px 15px;' align='center'> <b>Max Marks</b></p></td><td style='border:1px solid #dfdfdf;'><p style='margin: 3px 15px;'  align='center'> <b>Marks Obtained</b></p></td></tr>";
                                    str = str + @"<tr  style='background-color:#edebeb;'><td style='border:1px solid #dfdfdf;' width='312' colspan='3'><p style='margin:3px 15px' align='center'> <b> " + dsheader.Rows[l]["SubExperienceName"].ToString() + " </b> </p></td></tr>";
                                    for (int m = 0; m < drrow.Length; m++)
                                    {
                                        MaxTotal += Convert.ToDecimal(drrow[m].Field<double>("MaxMark").ToString());
                                        ObtainedTotal += Convert.ToDecimal(drrow[m].Field<double>("Mark").ToString());
                                        str = str + @"<tr style='line-height: 25px !important;'> <td style='border:1px solid #dfdfdf;' width='312'><p style='margin: 3px 15px;'  align='left'> " + drrow[m].Field<string>("SubjectHeaderName").ToString() + "  </p></td><td  style='border:1px solid #dfdfdf;' valign='top'><p style='margin: 3px 15px;' align='right'>" + drrow[m].Field<double>("MaxMark").ToString() + "</p></td><td  style='border:1px solid #dfdfdf;'><p style='margin: 3px 15px;'  align='right'>" + drrow[m].Field<double>("Mark").ToString() + "</p></td>";
                                    }
                                }

                                str = str + @"<tr style='background-color: #edebeb;'> <td  style='border:1px solid #dfdfdf;' valign='top'><p style='margin: 3px 15px;'  align='right'> <b> TOTAL </b> </p></td><td  style='border:1px solid #dfdfdf;'><p style='margin: 3px 15px;'  align='right'><b>" + MaxTotal + " </b> </p></td><td  style='border:1px solid #dfdfdf;'><p style='margin: 3px 15px;'  align='right'><b>" + ObtainedTotal + " </b> </p></td></tr><tr> <td  style='border:1px solid #dfdfdf;' valign='top'><p style='margin: 3px 15px;' >&nbsp;</p></td><td  style='border:1px solid #dfdfdf;'><p style='margin: 3px 15px;' align='right'>&nbsp;</p></td><td  style='border:1px solid #dfdfdf;'><p style='margin: 3px 15px;'  align='right'>&nbsp;</p></td></tr></table></td>";
                                if (cnt > 0)
                                {
                                    if (((cnt + 1) % 2) == 0)
                                    {
                                        str = str + "</tr><tr>";
                                    }
                                }
                                cnt = cnt + 1;
                                subexp = dsheader.Rows[l]["SubExperienceName"].ToString();
                            }

                        }
                        str = str + @"</table>";

                        str = str + "<br/><p style='margin-left:30px'>MA : Multiple Assessment</p>";
                        str = str + "<p style='margin-left:30px'>SE : Subject Enrichment </p>";
                        str = str + "<p class='pagebreakhere' style='page-break-after:always; color: Red;'></p>";

                    }
                    stroption += str;
                   // stroption += @"<p class='pagebreakhere' style='page-break-after:auto; color: Red;'></p>";

                    #endregion Subject Header TabSubject Header Tab end


                    examnochk = dsGet.Tables[0].Rows[i]["RegNo"].ToString();
                }
            }
        }
    }


    decimal totdays;
    string startdate;
    string enddate;
    string SD;
    string ED;
    int monthcnt = 0;
    decimal Retval = 0;
    private void LOAD_Totdays()
    {
        utl2 = new Utilities();
        DataSet dsTotdays = new DataSet();
        string dsStartMonthCount = "0";
        string dsEndMonthCount = "0";
        string sql;

        //sql = "select SUM(convert(int,noofdays))as Totaldays from m_DaysinMonths where AcademicID='" + AcademicID + "' ";
        //totdays = Convert.ToInt32(utl2.ExecuteScalar(sql));
        sql = " select DATEDIFF(M,startdate,enddate) as Month  from p_examnamelist where ExamNameID='" + ddlExamName.SelectedValue + "' and AcademicID='" + AcademicID + "' and isactive=1";
        string MonthCount = utl.ExecuteScalar(sql);
        if (MonthCount != "" && MonthCount != "0")
        {

            sql = "select DATEDIFF(d,startdate,enddate) as totdays,convert(varchar(10),StartDate,121)as sdate ,convert(varchar(10),EndDate,121)as edate,convert(varchar(2),datepart(d,StartDate),121)as SD ,convert(varchar(2),datepart(d,EndDate),121)as ED from p_examnamelist where ExamNameID='" + ddlExamName.SelectedValue + "' and AcademicID='" + AcademicID + "' and isactive=1";
            dsTotdays = utl.GetDataset(sql);

            sql = " select isnull(convert(decimal(18,1),NoofDays),0) from m_DaysinMonths where  ClassID=" + Session["strClassID"].ToString() + " and AcademicID='" + AcademicID + "' and isactive=1   and MonthID=(select MONTH(StartDate) from p_examnamelist where ExamNameID='" + ddlExamName.SelectedValue + "' and AcademicID='" + AcademicID + "' and isactive=1 )";

           // sql = "select COUNT(*) from m_DaysList where dayvalue >= (select convert(varchar(2),datepart(d,StartDate),121)  from p_examnamelist where ExamNameID='" + ddlExamName.SelectedValue + "'  and AcademicID='" + AcademicID + "' and isactive=1 ) and MonthID=(select convert(varchar(2),datepart(m,StartDate),121) from p_examnamelist where ExamNameID='" + ddlExamName.SelectedValue + "'   and AcademicID='" + AcademicID + "' and isactive=1) and ClassID=" + Session["strClassID"].ToString() + "  and AcademicID='" + AcademicID + "' and isactive=1";

            dsStartMonthCount = utl.ExecuteScalar(sql);

            if (dsStartMonthCount=="" || dsStartMonthCount==null)
            {
                dsStartMonthCount = "0";
            }
           // sql = "select COUNT(*) from m_DaysList where dayvalue <= (select convert(varchar(2),datepart(d,EndDate),121)  from p_examnamelist where ExamNameID='" + ddlExamName.SelectedValue + "'  and AcademicID='" + AcademicID + "' and isactive=1) and MonthID=(select convert(varchar(2),datepart(m,EndDate),121) from p_examnamelist where ExamNameID='" + ddlExamName.SelectedValue + "' and AcademicID='" + AcademicID + "' and isactive=1) and ClassID=" + Session["strClassID"].ToString() + "  and AcademicID='" + AcademicID + "' and isactive=1";

            sql = " select isnull(convert(decimal(18,1),NoofDays),0) from m_DaysinMonths where  ClassID=" + Session["strClassID"].ToString() + " and AcademicID='" + AcademicID + "' and isactive=1  and MonthID=(select MONTH(EndDate) from p_examnamelist where ExamNameID='" + ddlExamName.SelectedValue + "' and AcademicID='" + AcademicID + "' and isactive=1 )";

            dsEndMonthCount = utl.ExecuteScalar(sql);


            if (dsEndMonthCount == "" || dsEndMonthCount == null)
            {
                dsEndMonthCount = "0";
            }
            if (dsTotdays != null && dsTotdays.Tables.Count > 0 && dsTotdays.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < dsTotdays.Tables[0].Rows.Count; i++)
                {
                    totdays = Convert.ToInt32(dsTotdays.Tables[0].Rows[i]["totdays"].ToString());
                    startdate = dsTotdays.Tables[0].Rows[i]["sdate"].ToString();
                    enddate = dsTotdays.Tables[0].Rows[i]["edate"].ToString();
                    SD = dsTotdays.Tables[0].Rows[i]["SD"].ToString();
                    ED = dsTotdays.Tables[0].Rows[i]["ED"].ToString();
                }
            }

            DataTable dt = utl2.GetDataTable("select * from dbo.[fn_getMonthNumber]((select convert(varchar(10),StartDate,121) from p_examnamelist where ExamNameID='" + ddlExamName.SelectedValue + "' and AcademicID='" + AcademicID + "' and isactive=1),(select convert(varchar(10),EndDate,121) from p_examnamelist where ExamNameID='" + ddlExamName.SelectedValue + "'  and AcademicID='" + AcademicID + "' and isactive=1))");
            if (dt.Rows.Count > 0)
            {
                for (int k = 1; k < dt.Rows.Count - 1; k++)
                {
                    sqlstr = " select convert(decimal(18,1),isnull(NoofDays,0)) from m_DaysinMonths where  ClassID=" + Session["strClassID"].ToString() + " and AcademicID='" + AcademicID + "' and isactive=1   and MonthID='" + dt.Rows[k]["Month_Number"].ToString() + "' ";

                  //  sqlstr = "select COUNT(*) from m_DaysList where ClassID=" + Session["strClassID"] + " and AcademicID=" + AcademicID + " and MonthID ='" + dt.Rows[k]["Month_Number"].ToString() + "' and IsActive=1";
                    string days = utl.ExecuteScalar(sqlstr);
                    if (days != null && days != "" && days != "0")
                    {
                        Retval += Convert.ToDecimal(utl.ExecuteScalar(sqlstr));
                    }                

                }
            }
        }
        else
        {
            DataTable dt1 = utl2.GetDataTable("select * from dbo.[fn_getMonthNumber]((select convert(varchar(10),StartDate,121) from p_examnamelist where ExamNameID='" + ddlExamName.SelectedValue + "' and AcademicID='" + AcademicID + "' and isactive=1),(select convert(varchar(10),EndDate,121) from p_examnamelist where ExamNameID='" + ddlExamName.SelectedValue + "' and AcademicID='" + AcademicID + "' and isactive=1))");
            if (dt1.Rows.Count > 0)
            {
                for (int k = 0; k < dt1.Rows.Count; k++)
                {
                   // sqlstr = "select COUNT(*) from m_DaysList where ClassID=" + Session["strClassID"] + " and AcademicID=" + AcademicID + " and MonthID ='" + dt1.Rows[k]["Month_Number"].ToString() + "' and IsActive=1";

                    sqlstr = " select isnull(convert(decimal(18,1),NoofDays),0) from m_DaysinMonths where  ClassID=" + Session["strClassID"].ToString() + " and AcademicID='" + AcademicID + "' and isactive=1   and MonthID='" + dt1.Rows[k]["Month_Number"].ToString() + "' ";
                    string noofdays = utl.ExecuteScalar(sqlstr).ToString();
                    if (noofdays == "" || noofdays == null)
                    {
                        noofdays = "0";
                        Retval = Convert.ToDecimal(noofdays);
                    }
                    else
                    {
                        Retval += Convert.ToDecimal(utl.ExecuteScalar(sqlstr));
                    }
                   
                }
            }
        }

        totdays = Convert.ToDecimal(dsStartMonthCount) + Convert.ToDecimal(Retval) + Convert.ToDecimal(dsEndMonthCount);


    }


    private string Attenance(string regno)
    {
        utl2 = new Utilities();
        string AttendanceDetail;

        double presentdays = 0;
        string sql2="";

        double NoofPresent = 0;


        DataTable dt1 = utl2.GetDataTable("select * from dbo.[fn_getMonthNumber]((select convert(varchar(10),StartDate,121) from p_examnamelist where ExamNameID='" + ddlExamName.SelectedValue + "' and AcademicID='" + AcademicID + "' and isactive=1),(select convert(varchar(10),EndDate,121) from p_examnamelist where ExamNameID='" + ddlExamName.SelectedValue + "' and AcademicID='" + AcademicID + "' and isactive=1))");
        if (dt1.Rows.Count > 0)
        {
            for (int k = 0; k < dt1.Rows.Count; k++)
            {
                sqlstr = "select COUNT(*) from m_DaysList where ClassID=" + ddlClass.SelectedValue + " and MonthID='" + dt1.Rows[k]["Month_Number"].ToString() + "' and AcademicID=" + AcademicID + " and IsActive=1";
                string strtotdays = utl.ExecuteScalar(sqlstr);

                sql2 = "select (convert(float,((dbo.[fn_GetFNAttCount]('" + regno + "','" + AcademicID + "','" + dt1.Rows[k]["Month_Number"].ToString() + "','" + strtotdays + "'))+(dbo.[fn_GetANAttCount]('" + regno + "','" + AcademicID + "','" + dt1.Rows[k]["Month_Number"].ToString() + "','" + strtotdays + "')))/2)) as PresentDays";
                presentdays = Convert.ToDouble(utl2.ExecuteScalar(sql2));

                NoofPresent += presentdays;
            }
        }

       // sql2 = "select (convert(float,((dbo.[fn_GetFNCount]('" + regno + "','" + AcademicID + "','" + startdate + "','" + enddate + "','" + totdays + "'))+(dbo.[fn_GetANCount]('" + regno + "','" + AcademicID + "','" + startdate + "','" + enddate + "','" + totdays + "')))/2)) as PresentDays";

      

        AttendanceDetail = NoofPresent.ToString();

        return AttendanceDetail;
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        utl = new Utilities();
        string dateofissue = "";
        if (ddlClass.Text!="" && ddlExamName.Text!="" && txtIssueDate.Text!="")
        {
            if (txtIssueDate.Text != "")
            {
                string[] myDateTimeString = txtIssueDate.Text.Split('/');
                dateofissue = "'" + myDateTimeString[2] + "/" + myDateTimeString[1] + "/" + myDateTimeString[0] + "'";
                string extension = "";
                if (FuPhoto.PostedFile.FileName != null && FuPhoto.PostedFile.FileName != "")
                {

                    FuPhoto.PostedFile.SaveAs(Server.MapPath("~/Performance/Signature/" + FuPhoto.PostedFile.FileName));

                    utl.ExecuteQuery("update xmark set xmark.dateofissue=" + dateofissue + ",signature='" + FuPhoto.PostedFile.FileName + "' from p_exammarks xmark inner join p_examtypes xtype on (xmark.ClassId=xtype.ClassId and xmark.ExamTypeId=xtype.ExamTypeID and xmark.AcademicID=xtype.AcademicID and xmark.IsActive=1)  where  xmark.ClassID= '" + ddlClass.SelectedValue + "' and xtype.ExamNameID= '" + ddlExamName.SelectedValue + "' and type='General' and xmark.academicId='" + AcademicID + "' and xtype.isactive=1");
                }
                else
                {
                    utl.ExecuteQuery("update xmark set xmark.dateofissue=" + dateofissue + " from p_exammarks xmark inner join p_examtypes xtype on (xmark.ClassId=xtype.ClassId and xmark.ExamTypeId=xtype.ExamTypeID and xmark.AcademicID=xtype.AcademicID and xmark.IsActive=1)  where  xmark.ClassID= '" + ddlClass.SelectedValue + "' and xtype.ExamNameID= '" + ddlExamName.SelectedValue + "' and type='General' and xmark.academicId='" + AcademicID + "' and xtype.isactive=1");
                }
          
            }
        }     
       
    }
}