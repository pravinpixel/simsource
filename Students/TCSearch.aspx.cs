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
using System.Globalization;
using System.Text;


public partial class Students_TCSearch : System.Web.UI.Page
{
    Utilities utl = null;
    string sqlstr = "";
    public static int Userid = 0;
    private static int PageSize = 10;

    protected void Page_Load(object sender, EventArgs e)
    {
        Master.chkUser();

        if (Session["UserId"] == null || Session["AcademicID"] == null)
        {
            Response.Redirect("Default.aspx?ses=expired");
        }
        else
        {
            Userid = Convert.ToInt32(Session["UserId"]);
            hdnUserId.Value = Session["UserId"].ToString();

            if (Session["AcademicID"] != null && Session["AcademicID"].ToString() != string.Empty)
            {
                hdnAcademicYearId.Value = Session["AcademicID"].ToString();
            }
            else
            {
                Utilities utl = new Utilities();
                hdnAcademicYearId.Value = utl.ExecuteScalar("select top 1 academicid from m_academicyear where isactive=1 order by academicid desc");
            }

            if (!IsPostBack)
            {
                BindClass();
                BindAcademinYear();
                BindDummyRow();
            }
        }
    }

    private void BindClass()
    {
        utl = new Utilities();
        sqlstr = "sp_GetClass";
        DataTable dt = new DataTable();
        dt = utl.GetDataTable(sqlstr);

        if (dt != null && dt.Rows.Count > 0)
        {
            ddlClass.DataSource = dt;
            ddlClass.DataTextField = "ClassName";
            ddlClass.DataValueField = "ClassID";
            ddlClass.DataBind();

            ddlDupClass.DataSource = dt;
            ddlDupClass.DataTextField = "ClassName";
            ddlDupClass.DataValueField = "ClassID";
            ddlDupClass.DataBind();

            ddlClassForApproval.DataSource = dt;
            ddlClassForApproval.DataTextField = "ClassName";
            ddlClassForApproval.DataValueField = "ClassID";
            ddlClassForApproval.DataBind();

            ddlBulkUpdCls.DataSource = dt;
            ddlBulkUpdCls.DataTextField = "ClassName";
            ddlBulkUpdCls.DataValueField = "ClassID";
            ddlBulkUpdCls.DataBind();

            dpIPrintBulkClass.DataSource = dt;
            dpIPrintBulkClass.DataTextField = "ClassName";
            dpIPrintBulkClass.DataValueField = "ClassID";
            dpIPrintBulkClass.DataBind();

            dpPrintBulkClassDup.DataSource = dt;
            dpPrintBulkClassDup.DataTextField = "ClassName";
            dpPrintBulkClassDup.DataValueField = "ClassID";
            dpPrintBulkClassDup.DataBind();
        }
        else
        {
            ddlClass.DataSource = null;
            ddlClass.DataBind();
            ddlClass.SelectedIndex = 0;

            ddlDupClass.DataSource = null;
            ddlDupClass.DataBind();
            ddlDupClass.SelectedIndex = 0;

            ddlClassForApproval.DataSource = null;
            ddlClassForApproval.DataBind();
            ddlClassForApproval.SelectedIndex = 0;

            ddlBulkUpdCls.DataSource = null;
            ddlBulkUpdCls.DataBind();
            ddlBulkUpdCls.SelectedIndex = 0;

            dpIPrintBulkClass.DataSource = null;
            dpIPrintBulkClass.DataBind();
            dpIPrintBulkClass.SelectedIndex = 0;


            dpPrintBulkClassDup.DataSource = null;
            dpPrintBulkClassDup.DataBind();
            dpPrintBulkClassDup.SelectedIndex = 0;
        }

        ddlClassForApproval.Items.Insert(0, new ListItem("-- Select--", ""));
        ddlBulkUpdCls.Items.Insert(0, new ListItem("-- Select--", ""));
        dpIPrintBulkClass.Items.Insert(0, new ListItem("-- Select--", ""));
        dpPrintBulkClassDup.Items.Insert(0, new ListItem("-- Select--", ""));
    }

    private void BindAcademinYear()
    {
        utl = new Utilities();
        sqlstr = "sp_getAcademinYear";
        DataTable dt = new DataTable();
        dt = utl.GetDataTable(sqlstr);

        if (dt != null && dt.Rows.Count > 0)
        {
            ddlDupYear.DataSource = dt;
            ddlDupYear.DataTextField = "academicyear";
            ddlDupYear.DataValueField = "academicid";
            ddlDupYear.DataBind();
        }
        else
        {
            ddlDupYear.DataSource = null;
            ddlDupYear.DataBind();
            ddlDupYear.SelectedIndex = 0;
        }
    }



    private void BindDummyRow()
    {
        HiddenField hdnID = (HiddenField)Page.Master.FindControl("hfViewPrm");
        if (hdnID.Value.ToLower() == "true")
        {
            DataTable dummy = new DataTable();
            dummy.Columns.Add("Check All");
            dummy.Columns.Add("Serial No");
            dummy.Columns.Add("Register No");
            dummy.Columns.Add("Admission No");
            dummy.Columns.Add("Student Name");
            dummy.Columns.Add("Class");
            dummy.Columns.Add("Section");
            dummy.Columns.Add("Due Status");
            dummy.Columns.Add("Approval Status");
            dummy.Columns.Add("Option");
            dummy.Rows.Add();
            grdStudentTCInfo.DataSource = dummy;
            grdStudentTCInfo.DataBind();
        }
    }


    [WebMethod]
    public static string GetStudentsTCDetail(int pageIndex, string Regno, string AdminNo, string gender, string Class, string Section, string StudentName)
    {
        Utilities utl = new Utilities();
        string sqlstr = "select isactive from m_academicyear where AcademicID='" + HttpContext.Current.Session["AcademicID"].ToString() + "'";
        string Isactive = utl.ExecuteScalar(sqlstr);
        string query = "";
        if (Isactive == "True")
        {
            query = "[sp_GetTCStudList]";
        }
        else
        {
            query = "[sp_GetPromoTCStudList]";
        }

        SqlCommand cmd = new SqlCommand(query);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@PageIndex", pageIndex);
        cmd.Parameters.AddWithValue("@PageSize", PageSize);
        cmd.Parameters.AddWithValue("@regno", Regno);
        cmd.Parameters.AddWithValue("@adminno", AdminNo);
        cmd.Parameters.AddWithValue("@gender", gender == "undefined" ? "" : gender);
        cmd.Parameters.AddWithValue("@classname", Class);
        cmd.Parameters.AddWithValue("@section", Section);
        cmd.Parameters.AddWithValue("@studentname", StudentName);
        cmd.Parameters.Add("@RecordCount", SqlDbType.Int, 4).Direction = ParameterDirection.Output;
        cmd.Parameters.AddWithValue("@AcademicId", HttpContext.Current.Session["AcademicID"].ToString());
        return utl.GetData(cmd, pageIndex, "StudentInfo", PageSize).GetXml();

    }



    [WebMethod]
    public static string GetStudentsOLDTC(int pageIndex, string Regno, string AdminNo, string leaveYear, string gender, string Class, string Section, string StudentName, string parent, string DOB)
    {
        string formatDOB = string.Empty;
        if (DOB != string.Empty)
        {
            string[] formats = { "dd/MM/yyyy" };
            formatDOB = DateTime.ParseExact(DOB, formats, new CultureInfo("en-US"), DateTimeStyles.None).ToShortDateString();
        }

        Utilities utl = new Utilities();
        string sqlstr = "select isactive from m_academicyear where AcademicID='" + HttpContext.Current.Session["AcademicID"].ToString() + "'";
        string Isactive = utl.ExecuteScalar(sqlstr);
        string query = "";
        if (Isactive == "True")
        {
            query = "[sp_GetTCOldStudList]";
        }
        else
        {
            query = "[sp_GetPromoTCOldStudList]";
        }


        SqlCommand cmd = new SqlCommand(query);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@PageIndex", pageIndex);
        cmd.Parameters.AddWithValue("@PageSize", PageSize);
        cmd.Parameters.Add("@RecordCount", SqlDbType.Int, 4).Direction = ParameterDirection.Output;
        cmd.Parameters.AddWithValue("@regno", Regno);
        cmd.Parameters.AddWithValue("@adminno", AdminNo);
        if (leaveYear != "" && leaveYear != null)
        {
            cmd.Parameters.AddWithValue("@leaveYear", leaveYear);
        }
        else
        {
            cmd.Parameters.AddWithValue("@leaveYear", HttpContext.Current.Session["AcademicID"].ToString());
        }

        cmd.Parameters.AddWithValue("@gender", gender == "undefined" ? "" : gender);
        cmd.Parameters.AddWithValue("@classname", Class);
        cmd.Parameters.AddWithValue("@section", Section);
        cmd.Parameters.AddWithValue("@studentname", StudentName);
        cmd.Parameters.AddWithValue("@parentname", parent);
        cmd.Parameters.AddWithValue("@dob", formatDOB);
        return utl.GetData(cmd, pageIndex, "StudentInfo", PageSize).GetXml();

    }

    [WebMethod]
    public static string GetStudentDup(int dupYear, string dupClass, string dupSection)
    {
        Utilities utl = new Utilities();
        DataSet ds = new DataSet();
        string query = "";
        string sqlstr = "select isactive from m_academicyear where AcademicID='" + HttpContext.Current.Session["AcademicID"].ToString() + "'";
        string Isactive = utl.ExecuteScalar(sqlstr);
        if (Isactive == "True")
        {
            query = "[sp_getStudentByDup]" + dupYear + ",'" + dupClass + "','" + dupSection + "'";
        }
        else
        {
            query = "[sp_getPromoStudentByDup]" + dupYear + ",'" + dupClass + "','" + dupSection + "'";
        }

        return utl.GetDatasetTable(query, "Students").GetXml();

    }

    [WebMethod]
    public static string GetSectionByClassID(int ClassID)
    {

        Utilities utl = new Utilities();
        DataSet ds = new DataSet();
        string query = "sp_GetSectionByClass " + ClassID;
        return utl.GetDatasetTable(query, "SectionByClass").GetXml();

    }

    [WebMethod]
    public static string GetStudentBySection(string Class, string Section)
    {
        Utilities utl = new Utilities();
        DataSet ds = new DataSet();
        string sqlstr = "select isactive from m_academicyear where AcademicID='" + HttpContext.Current.Session["AcademicID"].ToString() + "'";
        string Isactive = utl.ExecuteScalar(sqlstr);
        string query = "";
        if (Isactive == "True")
        {
            query = "sp_GetStudentBySection '" + Class + "','" + Section + "'";
        }
        else
        {
            query = "sp_GetPromoStudentBySection '" + Class + "','" + Section + "'";
        }
        return utl.GetDatasetTable(query, "Students").GetXml();
    }


    [WebMethod]
    public static string GetModuleMenuId(string path, string UserId)
    {
        Utilities utl = new Utilities();
        DataSet ds = new DataSet();
        string query = "sp_GetModuleMenuId '" + path + "'," + UserId;
        return utl.GetDatasetTable(query, "ModuleMenu").GetXml();
    }
    [WebMethod]
    public static string GetFeePendingList(string RegNo, string Active, string AcademicId)
    {
        Utilities utl = new Utilities();

        string sqlstr = "select isactive from m_academicyear where AcademicID='" + HttpContext.Current.Session["AcademicID"].ToString() + "'";
        string Isactive = utl.ExecuteScalar(sqlstr);
        string query = "";
        if (Isactive == "True")
        {
            query = "sp_AcademicFeesDueStatus " + RegNo + ",'" + Active + "'," + AcademicId;
        }
        else
        {
            query = "sp_PromoAcademicFeesDueStatus " + RegNo + ",'" + Active + "'," + AcademicId;
        }

        DataSet ds = utl.GetDataset(query);
        return ds.GetXml();
    }

    [WebMethod]
    public static string SendForApporval(string RegNo, string AcademicId, string userId)
    {
        Utilities utl = new Utilities();
        string sqlstr = "select isactive from m_academicyear where AcademicID='" + HttpContext.Current.Session["AcademicID"].ToString() + "'";
        string Isactive = utl.ExecuteScalar(sqlstr);
        string query = "";
        if (Isactive == "True")
        {
            query = "sp_TCSendForApporval " + RegNo + "," + AcademicId + "," + userId;
        }
        else
        {
            query = "sp_PromoTCSendForApporval " + RegNo + "," + AcademicId + "," + userId;
        }
        string strError = utl.ExecuteQuery(query);
        string icnt = "";
        icnt = utl.ExecuteScalar("select count(*) from s_studentpromotion where regno='" + RegNo + "' and AcademicId='" + HttpContext.Current.Session["AcademicID"].ToString() + "'");
        if (icnt == "" || icnt == "0")
        {
            utl.ExecuteQuery("insert into s_studentpromotion(RegNo,AcademicId,ClassId,SectionId,UserId) (select regno,Class,Section,BusFacility,Concession,Hostel,Scholar,academicyear,Active,1 from s_studentinfo  where regno='" + RegNo + "' and AcademicId='" + HttpContext.Current.Session["AcademicID"].ToString() + "')");
        }
        else
        {
            utl.ExecuteQuery("update s_studentpromotion set active='O' where regno='" + RegNo + "' and AcademicID='" + HttpContext.Current.Session["AcademicID"].ToString() + "'");
        }
        if (strError == string.Empty)
            return "1";
        else
            return "2";
    }

    [WebMethod]
    public static string printTc(string pregno)
    {
        string strQuery = string.Empty;

        StringBuilder tcContent = new StringBuilder();

        Utilities utl = new Utilities();
        DataSet ds = new DataSet();

        string sqlstr = "select isactive from m_academicyear where AcademicID='" + HttpContext.Current.Session["AcademicID"].ToString() + "'";
        string Isactive = utl.ExecuteScalar(sqlstr);
        string query = "";
        if (Isactive == "True")
        {
            query = "SP_GETTCBULKPRINTINFO " + pregno + "," + "''" + "," + "''" + "," + "'" + HttpContext.Current.Session["AcademicID"].ToString() + "'";
        }
        else
        {
            query = "SP_PromoGETTCBULKPRINTINFO " + pregno + "," + "''" + "," + "''" + "," + "'" + HttpContext.Current.Session["AcademicID"].ToString() + "'";
        }

        ds = utl.GetDataset(query);

        if (ds.Tables[0].Rows.Count > 0)
        {


            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                string sql = "select TCReason from s_studenttc where RegNo=" + dr["RegNo"].ToString() + "  and AcademicId=" + HttpContext.Current.Session["AcademicID"].ToString() + " and isactive=1";
                string TCReason = utl.ExecuteScalar(sql);


                string[] Dateformats = { "dd/MM/yyyy" };
                string regno = dr["RegNo"].ToString();
                string IdMarks = "";
                if (dr["idmarks"].ToString().Contains(";"))
                {
                    string[] _IdMarks = dr["idmarks"].ToString().Split(';');

                    int slno = 1;
                    foreach (string idmark in _IdMarks)
                    {
                        if (idmark.ToUpper().CompareTo("NIL") != 0)
                        {
                            IdMarks += slno.ToString() + ") " + idmark.ToUpper() + "<br/>";
                            slno += 1;
                        }
                    }
                    if (slno > 1)
                    {
                        IdMarks = IdMarks.Remove(IdMarks.Length - 2);
                    }
                    else
                        IdMarks = "NIL";
                }
                else if (dr["idmarks"].ToString().Contains(":"))
                {
                    string[] _IdMarks = dr["idmarks"].ToString().Split(':');

                    int slno = 1;
                    foreach (string idmark in _IdMarks)
                    {
                        if (idmark.ToUpper().CompareTo("NIL") != 0)
                        {
                            IdMarks += slno.ToString() + ") " + idmark.ToUpper() + "<br/>";
                            slno += 1;
                        }
                    }
                    if (slno > 1)
                    {
                        IdMarks = IdMarks.Remove(IdMarks.Length - 2);
                    }
                    else
                        IdMarks = "NIL";
                }
                tcContent.Append("<table class='formtc'><tr><td align='center' style='padding:0px;' class='tctext'><img src='../images/tc-header-transp.png' alt='tc-header' width=110 height=110/></td></tr><tr><td align='center' valign='bottom' style='padding:0px;'><table width='98%' border='0' cellspacing='0' cellpadding='0' class='tcbg' style='padding:0px;'><tr><td width='33%' align='left' valign='middle' class='ser-no' style='padding:0px;'><br />Serial No : " + dr["SlNo"].ToString() + "<br />Admission No : " + dr["AdmissionNo"].ToString() + "<br/>Student UID : " + dr["student_uid"].ToString() + "</td><td width='33%' align='center' valign='middle' class='tctext' style='padding:0px;'></td><td width='33%' align='right' valign='middle' class='tc-photo' style='padding:0px;'><div class='tc-imgplace' ><div class='tc-img' ><img src='Photos/" + dr["RegNo"].ToString() + ".jpg'  alt='' /></div></div</td></tr></table></td></tr><tr><td style='padding:0px;' class=''><table width='100%' cellpadding='4' cellspacing='0' class='formtctxt'><tr><td width='4%' height='30' class=''>1.</td><td width='43%' class=''><span class='alignleft'>a)  Name of the School<br /></span></td><td width='3%' class=''>:</td><td width='50%' class='tc-txt-upper'><b>" + dr["SchoolName"].ToString() + "</b></td></tr><tr><td height='30' class='tdHeight35'>&nbsp;</td><td class='alignleft'>b)  Name of the Education District / Revenue District </td><td>:</td><td class='tc-txt-upper' ><b>" + dr["SchoolDist"].ToString() + "</b></td></tr><tr><td height='35' class='tdHeight35'>2.</td><td><span class='alignleft'>Name of the pupil (in Block letters) </span></td><td>:</td><td class='tc-txt-upper' >" + dr["Name"].ToString() + "</td></tr><tr><td height='35' class='tdHeight35'>3.</td><td><span class='alignleft'>Name of the Father and Mother of the pupil </span></td><td>:</td><td class='tc-txt-upper'>" + dr["ParentName"].ToString() + "</td></tr><tr><td height='35' class='tdHeight35'>4.</td><td><span class='alignleft'>Nationality and Religion </span></td><td>:</td><td class='tc-txt-upper'>" + dr["Nationality"].ToString() + "</td></tr><tr><td height='35' valign='top' class='tdHeight35'>5.</td><td valign='top'><span class='alignleft'>Community <br>Whether he / she belongs to SC / ST / BC / MBC / OC </span></td><td valign='top'>:</td><td valign='top' class='tc-txt-upper'>" + dr["Community"].ToString() + "</td></tr><tr><td height='35' class='tdHeight35'>6.</td><td><span class='alignleft'>Sex</span></td><td>:</td><td class='tc-txt-upper'>" + dr["Gender"].ToString() + "</td></tr><tr><td height='35' valign='top' class='tdHeight35'>7.</td><td valign='top'>Date of Birth as entered in the Admission<br />Register in figures and words</td><td valign='top'>:</td><td valign='top' class='tc-txt-upper'>" + dr["DOB"].ToString() + "<br/><div style='float:left; width:320px'>" + ConvertDate.DateToText(DateTime.ParseExact(dr["DOB"].ToString(), Dateformats, new CultureInfo("en-US"), DateTimeStyles.None), true) + "</div></td></tr><tr><td height='35' valign='top' class='tdHeight35'>8.</td><td valign='top'><span class='alignleft'>Personal Marks of Identification </span></td><td valign='top'>:</td><td valign='top' class='tc-txt-upper'>" + IdMarks + "</td></tr><tr><td height='35' class='tdHeight35'>9.</td><td><span class='alignleft'>Date of Admission and Standard in which admitted </span></td><td>:</td><td class='tc-txt-upper'>" + dr["DOA"].ToString() + "</td></tr><tr><td height='35' valign='top' class='tdHeight35'>10.</td><td valign='top'><span class='alignleft'>Standard in which the pupil was studying at the time <br>of leaving (in words)</span></td><td valign='top'>:</td><td valign='top' class='tc-txt-upper'>" + dr["LeaveofStudy"].ToString() + "</td></tr><tr><td height='35' class='tdHeight35'>11.</td><td><span class='alignleft'>Whether qualified for promotion to higher standard </span></td><td>:</td><td class='tc-txt-upper'>" + dr["Promotion"].ToString() + "</td></tr><tr><td height='35' valign='top' class='tdHeight35'>12.</td><td valign='top'><span class='alignleft'>Whether the pupil was in the receipt of any scholarship ?<br />(Nature of the scholarship to be specified) </span></td><td valign='top'>:</td><td valign='top' class='tc-txt-upper'>" + dr["Scholarship"].ToString() + "</td></tr><tr><td height='35' valign='top' class='tdHeight35'>13.</td><td valign='top'><span class='alignleft'>Whether the pupil has undergone Medical inspection <br>during the last academic year </span></td><td valign='top'>:</td><td valign='top' class='tc-txt-upper'>" + dr["MedicalCheckup"].ToString() + "</td></tr><tr><td height='35' class='tdHeight35'>14.</td><td><span class='alignleft'>Date on which the pupil actually left the school </span></td><td>:</td><td class='tc-txt-upper'>" + dr["LastDate"].ToString() + "</td></tr>");
                if (regno == "520179156")
                {
                    tcContent.Append("<tr><td height='35' class='tdHeight35' style='vertical-align: top; padding-top: 9px;'>15.</td><td style='vertical-align: top; padding-top: 9px;'><span class='alignleft'>Reason for availing Transfer Certificate</span></td><td style='vertical-align: top; padding-top: 9px;'>:</td><td class='tc-txt-upper'>" + TCReason.ToString() + "</td></tr>");

                    tcContent.Append("<tr><td height='35' class='tdHeight35' style='vertical-align: top; padding-top: 9px;'>16.</td><td style='vertical-align: top; padding-top: 9px;'><span class='alignleft'>The pupil’s conduct and character </span></td><td style='vertical-align: top; padding-top: 9px;'>:</td><td class='tc-txt-upper'>" + dr["Conduct"].ToString() + "</td></tr><tr><td height='35' valign='top' class='tdHeight35' >17.</td><td valign='top' ><span class='alignleft'>Date on which application for Transfer Certificate was <br>madeon behalf of the pupil by the parent or guardian </span></td><td valign='top'>:</td><td valign='top' class='tc-txt-upper'>" + dr["ApplicationDate"].ToString() + "</td></tr><tr><td height='35' class='tdHeight35' style='vertical-align: top; padding-top: 9px;'>18.</td><td style='vertical-align: top; padding-top: 9px;'><span class='alignleft'>Date of the Transfer Certificate </span></td><td >:</td><td class='tc-txt-upper'>" + dr["TcDate"].ToString() + "</td></tr><tr><td height='35' class='tdHeight35' style='vertical-align: top; padding-top: 9px;'>19.</td><td style='vertical-align: top; padding-top: 9px;'><span class='alignleft'>Course of Study </span></td><td style='vertical-align: top; padding-top: 9px;'>:</td><td class='tc-txt-upper'>" + dr["CourseOfStudy"].ToString() + "</td></tr>");
                }
                else
                {
                    tcContent.Append("<tr><td height='35' class='tdHeight35' style='vertical-align: top; padding-top: 9px;'>15.</td><td style='vertical-align: top; padding-top: 9px;'><span class='alignleft'>The pupil’s conduct and character </span></td><td style='vertical-align: top; padding-top: 9px;'>:</td><td class='tc-txt-upper'>" + dr["Conduct"].ToString() + "</td></tr><tr><td height='35' valign='top' class='tdHeight35' >16.</td><td valign='top' ><span class='alignleft'>Date on which application for Transfer Certificate was <br>madeon behalf of the pupil by the parent or guardian </span></td><td valign='top'>:</td><td valign='top' class='tc-txt-upper'>" + dr["ApplicationDate"].ToString() + "</td></tr><tr><td height='35' class='tdHeight35' style='vertical-align: top; padding-top: 9px;'>17.</td><td style='vertical-align: top; padding-top: 9px;'><span class='alignleft'>Date of the Transfer Certificate </span></td><td >:</td><td class='tc-txt-upper'>" + dr["TcDate"].ToString() + "</td></tr><tr><td height='35' class='tdHeight35' style='vertical-align: top; padding-top: 9px;'>18.</td><td style='vertical-align: top; padding-top: 9px;'><span class='alignleft'>Course of Study </span></td><td style='vertical-align: top; padding-top: 9px;'>:</td><td class='tc-txt-upper'>" + dr["CourseOfStudy"].ToString() + "</td></tr>");
                }

                tcContent.Append("</table></td></tr><tr><td style='vertical-align: top; padding: 0px;'><table border='0' class='bord-bott course' cellspacing='0' cellpadding='5' width='95%' style='text-align: center;'><tbody><tr><td width='20%' valign='middle' class='cours-brd-tl ' style='padding:5px 0px;'  ><strong>Name of the School</strong></td><td width='20%' valign='middle' class='cours-brd-tl'style='padding:5px 0px;'><p><strong>Academic Year </strong></p></td><td width='20%' valign='middle' class='cours-brd-tl'style='padding:5px 0px;'><p><strong>Standard  studied</strong></p></td><td width='20%' valign='middle' class='cours-brd-tl' style='padding:5px 0px;'><p><strong>First Language</strong></p></td><td width='20%' valign='middle' class='cours-brd-tlr' style='padding:5px 0px;'><p><strong>Medium of Instruction</strong></p></td></tr>" + BindCourseStudy(regno) + "</tbody></table></td></tr><tr><td style='vertical-align: top; padding-top: 30px;' class='signparent' align='right'><br/><br/><strong><span>Signature of the Principal<br/> with date and school seal</span></strong></td></tr><tr><td style='vertical-align: top; padding-top: 0px;'><span class='aligncenter'>Note: </span></td></tr><tr><td style='vertical-align: top; padding-top: 0px;'><span class='alignleft'>1. Erasures and unauthenticated or fraudulent alteration will lead to its cancellation.</span><br /><span class='alignleft'>2. Should be signed in ink by the Head of the Institution,</span><br /><span class='alignleft'>&nbsp;&nbsp;&nbsp;&nbsp;who will be held responsible for correctness of the entries.</span> </td></tr><tr><td align='center' style='padding-top: 10px;'><span class='decleartion'><strong>Declaration by the Parent or Guardian </strong></span><br /><span class='aligncenter'>I hereby declare that the particular record against items 2 to 7 are correct and that no change will be demanded by me in future. </span></td></tr><tr><td align='right' styl='vertical-align: top; padding-top: 29px;'>&nbsp;</td></tr><tr><td class='signparent' align='right'><br/><strong>Signature of the Parent / Guardian </strong></td></tr><tr><td height='50' style='vertical-align: top; padding-top: 9px;'>&nbsp;</td></tr></table><p class=\"pagebreakhere\" style=\"page-break-after: always; color:Red;\"></p>");
            }

            Utilities utls = new Utilities();
            strQuery = utls.ExecuteScalar("exec SP_UPDATETCPRINT " + pregno + "");

        }
        return tcContent.ToString();

    }


    [WebMethod]
    public static string printDuplicateTc(string pregno)
    {
        string strQuery = string.Empty;

        StringBuilder tcContent = new StringBuilder();

        Utilities utl = new Utilities();
        DataSet ds = new DataSet();

        string sqlstr = "select isactive from m_academicyear where AcademicID='" + HttpContext.Current.Session["AcademicID"].ToString() + "'";
        string Isactive = utl.ExecuteScalar(sqlstr);
        string query = "";
        if (Isactive == "True")
        {
            query = "SP_GETDuplicateTCPRINT " + pregno + "," + "''" + "," + "''" + "," + "'" + HttpContext.Current.Session["AcademicID"].ToString() + "'";
        }
        else
        {
            query = "SP_PromoGETDuplicateTCPRINT " + pregno + "," + "''" + "," + "''" + "," + "'" + HttpContext.Current.Session["AcademicID"].ToString() + "'";
        }

        ds = utl.GetDataset(query);

        if (ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                string sql = "select TCReason from s_studenttc where RegNo=" + dr["RegNo"].ToString() + "  and AcademicId=" + HttpContext.Current.Session["AcademicID"].ToString() + " and isactive=1";
                string TCReason = utl.ExecuteScalar(sql);

                string[] Dateformats = { "dd/MM/yyyy" };
                string regno = dr["RegNo"].ToString();
                string[] _IdMarks;
                string IdMarks = "";
                int slno = 1;
                if (dr["idmarks"].ToString().Contains(';'))
                {
                    _IdMarks = dr["idmarks"].ToString().Split(';');
                    IdMarks = "";

                    foreach (string idmark in _IdMarks)
                    {
                        if (idmark.ToUpper().CompareTo("NIL") != 0)
                        {
                            IdMarks += slno.ToString() + ") " + idmark.ToUpper() + "<br/>";
                            slno += 1;
                        }
                    }
                    if (slno > 1)
                    {
                        IdMarks = IdMarks.Remove(IdMarks.Length - 2);
                    }
                    else
                        IdMarks = "NIL";
                }
                else if (dr["idmarks"].ToString().Contains(':'))
                {
                    _IdMarks = dr["idmarks"].ToString().Split(':');
                    IdMarks = "";
                    slno = 1;
                    foreach (string idmark in _IdMarks)
                    {
                        if (idmark.ToUpper().CompareTo("NIL") != 0)
                        {
                            IdMarks += slno.ToString() + ") " + idmark.ToUpper() + "<br/>";
                            slno += 1;
                        }
                    }
                    if (slno > 1)
                    {
                        IdMarks = IdMarks.Remove(IdMarks.Length - 2);
                    }
                    else
                        IdMarks = "NIL";
                }
                else
                {

                }


                tcContent.Append("<table class='formtc'><tr><td align='center' style='padding:0px;' class='tctext'><img src='../images/tc-header-transp.png' alt='tc-header' width=110 height=110/></td></tr><tr><td align='center' valign='bottom' style='padding:0px;'><table width='98%' border='0' cellspacing='0' cellpadding='0' class='tcbg' style='padding:0px;'><tr><td width='33%' align='left' valign='middle' class='ser-no' style='padding:0px;'><br />Serial No : " + dr["SlNo"].ToString() + "<br />Admission No : " + dr["AdmissionNo"].ToString() + " <br />Student UID : " + dr["student_uid"].ToString() + " </td><td width='33%' align='center' valign='middle' class='tctext' style='padding:0px;'></td><td width='33%' align='right' valign='middle' class='tc-photo' style='padding:0px;'><div class='tc-imgplace' ><div class='tc-img' ><img src='Photos/" + dr["RegNo"].ToString() + ".jpg'  alt='' /></div></div</td></tr></table></td></tr><tr><td style='padding:0px;' class=''><table width='100%' cellpadding='4' cellspacing='0' class='formtctxt'><tr><td width='4%' height='30' class=''>1.</td><td width='43%' class=''><span class='alignleft'>a)  Name of the School<br /></span></td><td width='3%' class=''>:</td><td width='50%' class='tc-txt-upper'><b>" + dr["SchoolName"].ToString() + "</b></td></tr><tr><td height='30' class='tdHeight35'>&nbsp;</td><td class='alignleft'>b)  Name of the Education District / Revenue District </td><td>:</td><td class='tc-txt-upper' ><b>" + dr["SchoolDist"].ToString() + "</b></td></tr><tr><td height='35' class='tdHeight35'>2.</td><td><span class='alignleft'>Name of the pupil (in Block letters) </span></td><td>:</td><td class='tc-txt-upper' >" + dr["Name"].ToString() + "</td></tr><tr><td height='35' class='tdHeight35'>3.</td><td><span class='alignleft'>Name of the Father and Mother of the pupil </span></td><td>:</td><td class='tc-txt-upper'>" + dr["ParentName"].ToString() + "</td></tr><tr><td height='35' class='tdHeight35'>4.</td><td><span class='alignleft'>Nationality and Religion </span></td><td>:</td><td class='tc-txt-upper'>" + dr["Nationality"].ToString() + "</td></tr><tr><td height='35' valign='top' class='tdHeight35'>5.</td><td valign='top'><span class='alignleft'>Community <br>Whether he / she belongs to SC / ST / BC / MBC / OC </span></td><td valign='top'>:</td><td valign='top' class='tc-txt-upper'>" + dr["Community"].ToString() + "</td></tr><tr><td height='35' class='tdHeight35'>6.</td><td><span class='alignleft'>Sex</span></td><td>:</td><td class='tc-txt-upper'>" + dr["Gender"].ToString() + "</td></tr><tr><td height='35' valign='top' class='tdHeight35'>7.</td><td valign='top'>Date of Birth as entered in the Admission<br />Register in figures and words</td><td valign='top'>:</td><td valign='top' class='tc-txt-upper'>" + dr["DOB"].ToString() + "<br/><div style='float:left; width:320px'>" + ConvertDate.DateToText(DateTime.ParseExact(dr["DOB"].ToString(), Dateformats, new CultureInfo("en-US"), DateTimeStyles.None), true) + "</div></td></tr><tr><td height='35' valign='top' class='tdHeight35'>8.</td><td valign='top'><span class='alignleft'>Personal Marks of Identification </span></td><td valign='top'>:</td><td valign='top' class='tc-txt-upper'>" + IdMarks + "</td></tr><tr><td height='35' class='tdHeight35'>9.</td><td><span class='alignleft'>Date of Admission and Standard in which admitted </span></td><td>:</td><td class='tc-txt-upper'>" + dr["DOA"].ToString() + "</td></tr><tr><td height='35' valign='top' class='tdHeight35'>10.</td><td valign='top'><span class='alignleft'>Standard in which the pupil was studying at the time <br>of leaving (in words)</span></td><td valign='top'>:</td><td valign='top' class='tc-txt-upper'>" + dr["LeaveofStudy"].ToString() + "</td></tr><tr><td height='35' class='tdHeight35'>11.</td><td><span class='alignleft'>Whether qualified for promotion to higher standard </span></td><td>:</td><td class='tc-txt-upper'>" + dr["Promotion"].ToString() + "</td></tr><tr><td height='35' valign='top' class='tdHeight35'>12.</td><td valign='top'><span class='alignleft'>Whether the pupil was in the receipt of any scholarship ?<br />(Nature of the scholarship to be specified) </span></td><td valign='top'>:</td><td valign='top' class='tc-txt-upper'>" + dr["Scholarship"].ToString() + "</td></tr><tr><td height='35' valign='top' class='tdHeight35'>13.</td><td valign='top'><span class='alignleft'>Whether the pupil has undergone Medical inspection <br>during the last academic year </span></td><td valign='top'>:</td><td valign='top' class='tc-txt-upper'>" + dr["MedicalCheckup"].ToString() + "</td></tr><tr><td height='35' class='tdHeight35'>14.</td><td><span class='alignleft'>Date on which the pupil actually left the school </span></td><td>:</td><td class='tc-txt-upper'>" + dr["LastDate"].ToString() + "</td></tr>");

                if (regno == "520179156")
                {
                    tcContent.Append("<tr><td height='35' class='tdHeight35' style='vertical-align: top; padding-top: 9px;'>15.</td><td style='vertical-align: top; padding-top: 9px;'><span class='alignleft'>Reason for availing Transfer Certificate</span></td><td style='vertical-align: top; padding-top: 9px;'>:</td><td class='tc-txt-upper'>" + TCReason.ToString() + "</td></tr>");

                    tcContent.Append("<tr><td height='35' class='tdHeight35' style='vertical-align: top; padding-top: 9px;'>16.</td><td style='vertical-align: top; padding-top: 9px;'><span class='alignleft'>The pupil’s conduct and character </span></td><td style='vertical-align: top; padding-top: 9px;'>:</td><td class='tc-txt-upper'>" + dr["Conduct"].ToString() + "</td></tr><tr><td height='35' valign='top' class='tdHeight35' >17.</td><td valign='top' ><span class='alignleft'>Date on which application for Transfer Certificate was <br>madeon behalf of the pupil by the parent or guardian </span></td><td valign='top'>:</td><td valign='top' class='tc-txt-upper'>" + dr["ApplicationDate"].ToString() + "</td></tr><tr><td height='35' class='tdHeight35' style='vertical-align: top; padding-top: 9px;'>18.</td><td style='vertical-align: top; padding-top: 9px;'><span class='alignleft'>Date of the Transfer Certificate </span></td><td >:</td><td class='tc-txt-upper'>" + dr["TcDate"].ToString() + "</td></tr><tr><td height='35' class='tdHeight35' style='vertical-align: top; padding-top: 9px;'>19.</td><td style='vertical-align: top; padding-top: 9px;'><span class='alignleft'>Course of Study </span></td><td style='vertical-align: top; padding-top: 9px;'>:</td><td class='tc-txt-upper'>" + dr["CourseOfStudy"].ToString() + "</td></tr>");
                }
                else
                {
                    tcContent.Append("<tr><td height='35' class='tdHeight35' style='vertical-align: top; padding-top: 9px;'>15.</td><td style='vertical-align: top; padding-top: 9px;'><span class='alignleft'>The pupil’s conduct and character </span></td><td style='vertical-align: top; padding-top: 9px;'>:</td><td class='tc-txt-upper'>" + dr["Conduct"].ToString() + "</td></tr><tr><td height='35' valign='top' class='tdHeight35' >16.</td><td valign='top' ><span class='alignleft'>Date on which application for Transfer Certificate was <br>madeon behalf of the pupil by the parent or guardian </span></td><td valign='top'>:</td><td valign='top' class='tc-txt-upper'>" + dr["ApplicationDate"].ToString() + "</td></tr><tr><td height='35' class='tdHeight35' style='vertical-align: top; padding-top: 9px;'>17.</td><td style='vertical-align: top; padding-top: 9px;'><span class='alignleft'>Date of the Transfer Certificate </span></td><td >:</td><td class='tc-txt-upper'>" + dr["TcDate"].ToString() + "</td></tr><tr><td height='35' class='tdHeight35' style='vertical-align: top; padding-top: 9px;'>18.</td><td style='vertical-align: top; padding-top: 9px;'><span class='alignleft'>Course of Study </span></td><td style='vertical-align: top; padding-top: 9px;'>:</td><td class='tc-txt-upper'>" + dr["CourseOfStudy"].ToString() + "</td></tr>");
                }
                tcContent.Append("</table></td></tr><tr><td style='vertical-align: top; padding: 0px;'><table border='0' class='bord-bott course' cellspacing='0' cellpadding='5' width='95%' style='text-align: center;'><tbody><tr><td width='20%' valign='middle' class='cours-brd-tl ' style='padding:5px 0px;'  ><strong>Name of the School</strong></td><td width='20%' valign='middle' class='cours-brd-tl'style='padding:5px 0px;'><p><strong>Academic Year </strong></p></td><td width='20%' valign='middle' class='cours-brd-tl'style='padding:5px 0px;'><p><strong>Standard  studied</strong></p></td><td width='20%' valign='middle' class='cours-brd-tl' style='padding:5px 0px;'><p><strong>First Language</strong></p></td><td width='20%' valign='middle' class='cours-brd-tlr' style='padding:5px 0px;'><p><strong>Medium of Instruction</strong></p></td></tr>" + BindCourseStudy(regno) + "</tbody></table></td></tr><tr><td style='vertical-align: top; padding-top: 30px;' class='signparent' align='right'><br/><br/><strong><span>Signature of the Principal<br/> with date and school seal</span></strong></td></tr><tr><td style='vertical-align: top; padding-top: 0px;'><span class='aligncenter'>Note: </span></td></tr><tr><td style='vertical-align: top; padding-top: 0px;'><span class='alignleft'>1. Erasures and unauthenticated or fraudulent alteration will lead to its cancellation.</span><br /><span class='alignleft'>2. Should be signed in ink by the Head of the Institution,</span><br /><span class='alignleft'>&nbsp;&nbsp;&nbsp;&nbsp;who will be held responsible for correctness of the entries.</span> </td></tr><tr><td align='center' style='padding-top: 10px;'><span class='decleartion'><strong>Declaration by the Parent or Guardian </strong></span><br /><span class='aligncenter'>I hereby declare that the particular record against items 2 to 7 are correct and that no change will be demanded by me in future. </span></td></tr><tr><td align='right' styl='vertical-align: top; padding-top: 29px;'>&nbsp;</td></tr><tr><td class='signparent' align='right'><br/><strong>Signature of the Parent / Guardian </strong></td></tr><tr><td height='50' style='vertical-align: top; padding-top: 9px;'>&nbsp;</td></tr></table><p class=\"pagebreakhere\" style=\"page-break-after: always; color:Red;\"></p>");
            }

            Utilities utls = new Utilities();
            //  strQuery = utls.ExecuteScalar("exec SP_UPDATETCPRINT " + pregno + "");

        }
        return tcContent.ToString();

    }


    [WebMethod]
    public static string BulkApproval(string classId, string sectionId, string academicId, string userId)
    {
        Utilities utl = new Utilities();
        string sqlstr = "select isactive from m_academicyear where AcademicID='" + HttpContext.Current.Session["AcademicID"].ToString() + "'";
        string Isactive = utl.ExecuteScalar(sqlstr);
        string query = "";
        if (Isactive == "True")
        {
            query = "EXEC SP_IsClassExistsInTC " + classId + "," + sectionId + "," + academicId + "";
        }
        else
        {
            query = "EXEC SP_PromoIsClassExistsInTC " + classId + "," + sectionId + "," + academicId + "";
        }

        int count = utl.GetCounts(query);
        if (count != 0)
        {
            sqlstr = "select isactive from m_academicyear where AcademicID='" + HttpContext.Current.Session["AcademicID"].ToString() + "'";
            Isactive = utl.ExecuteScalar(sqlstr);
            string strError = "";
            if (Isactive == "True")
            {
                query = "sp_TCSendForApporval ''," + academicId + "," + userId + "," + classId + "," + sectionId + "";
                //  strError = utl.ExecuteQuery(query);

                query = "Select a.regno FROM s_studenttc a inner join s_studentinfo b on a.regno=b.regno  where academicID=" + academicId + " and approvestatus=0 and printtc=0 and isactive=1 order by stname";
                DataTable dt = new DataTable();
                dt = utl.GetDataTable(query);

                if (dt != null && dt.Rows.Count > 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        query = " SELECT (select convert(Varchar(10),max(convert(int,rtrim(ltrim(left(tcslno, LEN(tcslno) + 1 - 12)))))+1)  from s_studenttc tc  where tc.approvestatus=1   and tc.AcademicId=" + academicId + "  and isactive=1 and TcSlno<>'') + ' / ' + (select distinct convert(varchar,year(startdate))+'-'+  convert(varchar,Datepart(yy,enddate)) as AcademicYear   from m_academicyear  where academicID=" + academicId + ")";
                        string tcslno = utl.ExecuteScalar(query);
                        if (tcslno != "")
                        {
                            query = " update s_studenttc set TcSlno='" + tcslno + "',approvestatus=1 where regno='" + dt.Rows[i]["regno"].ToString() + "' and academicid=" + academicId + " and isactive=1  ";
                            strError = utl.ExecuteQuery(query);
                        }
                    }
                }
            }
            else
            {
                query = "sp_PromoTCSendForApporval ''," + academicId + "," + userId + "," + classId + "," + sectionId + "";
                strError = utl.ExecuteQuery(query);

                query = "Select a.regno FROM s_studenttc a inner join s_studentinfo b on a.regno=b.regno  where academicID=" + academicId + " and approvestatus=1 and printtc=0 and isactive=1 order by stname";
                DataTable dt = new DataTable();
                dt = utl.GetDataTable(query);

                if (dt != null && dt.Rows.Count > 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        query = "SELECT (select convert(Varchar(10),max(convert(int,rtrim(ltrim(left(tcslno, LEN(tcslno) + 1 - 12)))))+1) from s_studenttc tc  where tc.approvestatus=1 and tc.AcademicId=" + academicId + " and isactive=1  and TcSlno<>'') + ' / ' + (select distinct convert(varchar,year(startdate))+'-'+  convert(varchar,Datepart(yy,enddate)) as AcademicYear   from m_academicyear  where academicID=" + academicId + ")";
                        string tcslno = utl.ExecuteScalar(query);
                        if (tcslno != "")
                        {
                            query = " update s_studenttc set TcSlno='" + tcslno + "',approvestatus=1 where regno='" + dt.Rows[i]["regno"].ToString() + "' and academicid=" + academicId + "  and isactive=1 ";
                            strError = utl.ExecuteQuery(query);
                        }
                    }
                }
            }



            if (strError == string.Empty)
                return "1";
            else
                return "2";
        }
        else
            return "0";
    }

    [WebMethod]
    public static string BulkUpdate(string classId, string sectionId, string academicId, string userId, string leaveOfStudy, string promotionText,
        string lastDate, string applicationDate, string tcDate, string courseofStudy)
    {
        Utilities utls = new Utilities();
        string sqlstr = "select isactive from m_academicyear where AcademicID='" + HttpContext.Current.Session["AcademicID"].ToString() + "'";
        string Isactive = utls.ExecuteScalar(sqlstr);
        string query = "";
        if (Isactive == "True")
        {
            query = "EXEC SP_IsClassExistsInTC " + classId + "," + sectionId + "," + academicId + "";
        }
        else
        {
            query = "EXEC SP_PromoIsClassExistsInTC " + classId + "," + sectionId + "," + academicId + "";
        }

        int count = utls.GetCounts(query);

        if (count == 0)
        {
            string tcSlno = string.Empty;
            string medicalCheckup = string.Empty;
            string[] formats = { "dd/MM/yyyy" };
            string lDate = string.Empty;
            string aDate = string.Empty;
            string tDate = string.Empty;
            string conduct = "Good";
            if (lastDate != string.Empty)
                lDate = DateTime.ParseExact(lastDate, formats, new CultureInfo("en-US"), DateTimeStyles.None).ToString();

            if (applicationDate != string.Empty)
                aDate = DateTime.ParseExact(applicationDate, formats, new CultureInfo("en-US"), DateTimeStyles.None).ToString();

            if (tcDate != string.Empty)
                tcDate = DateTime.ParseExact(tcDate, formats, new CultureInfo("en-US"), DateTimeStyles.None).ToString();

            Utilities utl = new Utilities();

            sqlstr = "select isactive from m_academicyear where AcademicID='" + HttpContext.Current.Session["AcademicID"].ToString() + "'";
            Isactive = utls.ExecuteScalar(sqlstr);
            medicalCheckup = "1";

            if (Isactive == "True")
            {
                query = "SP_UPDATETCDETAILS1 '', " + academicId + ",'" + tcSlno + "','" + leaveOfStudy + "','" + promotionText + "','" + medicalCheckup + "','" + lDate + "','" + conduct + "','" + aDate + "','" + tcDate + "','" + courseofStudy + "',0," + userId + ",'False'," + classId + "," + sectionId + "";
            }
            else
            {
                query = "SP_PromoUPDATETCDETAILS1 '', " + academicId + ",'" + tcSlno + "','" + leaveOfStudy + "','" + promotionText + "','" + medicalCheckup + "','" + lDate + "','" + conduct + "','" + aDate + "','" + tcDate + "','" + courseofStudy + "',0," + userId + ",'False'," + classId + "," + sectionId + "";
            }


            string strError = utl.ExecuteQuery(query);


            query = "select distinct convert(varchar,year(startdate))+'-'+  convert(varchar,Datepart(yy,enddate)) as AcademicYear   from m_academicyear  where academicID='" + HttpContext.Current.Session["AcademicID"] + "'";
            string AcademicYear = utl.ExecuteScalar(query);

            // query = "select count(*) from s_studenttc where academicID='" + HttpContext.Current.Session["AcademicID"] + "' and isactive=1";
            // string Icnt = utl.ExecuteScalar(query);

            //  query = "update s_studenttc set TCSlno=convert(varchar(10),tcid)+ ' / ' + '" + AcademicYear + "'  where academicID='" + HttpContext.Current.Session["AcademicID"] + "'";
            //   query = utl.ExecuteScalar(query);

            if (strError == string.Empty)
                return "1";
            else
                return "2";
        }
        else
        {
            return "0";
        }
    }

    [WebMethod]
    public static string BulkPrint(string classId, string sectionId, string academicId)
    {
        string strQuery = string.Empty;

        StringBuilder tcContent = new StringBuilder();

        if (sectionId == string.Empty)
            sectionId = "''";

        Utilities utl = new Utilities();
        DataSet ds = new DataSet();

        string sqlstr = "select isactive from m_academicyear where AcademicID='" + HttpContext.Current.Session["AcademicID"].ToString() + "'";
        string Isactive = utl.ExecuteScalar(sqlstr);
        string query = "";
        if (Isactive == "True")
        {
            query = "exec SP_GETTCBULKPRINTINFO '', " + classId + "," + sectionId + "," + academicId + "";
        }
        else
        {
            query = "exec SP_PromoGETTCBULKPRINTINFO '', " + classId + "," + sectionId + "," + academicId + "";
        }

        ds = utl.GetDataset(query);

        if (ds.Tables[0].Rows.Count > 0)
        {

            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                string[] Dateformats = { "dd/MM/yyyy" };
                string regno = dr["RegNo"].ToString();
                string[] _IdMarks;
                string IdMarks = "";
                int slno = 1;
                if (dr["idmarks"].ToString().Contains(';'))
                {
                    _IdMarks = dr["idmarks"].ToString().Split(';');
                    IdMarks = "";

                    foreach (string idmark in _IdMarks)
                    {
                        if (idmark.ToUpper().CompareTo("NIL") != 0)
                        {
                            IdMarks += slno.ToString() + ") " + idmark.ToUpper() + "<br/>";
                            slno += 1;
                        }
                    }
                    if (slno > 1)
                    {
                        IdMarks = IdMarks.Remove(IdMarks.Length - 2);
                    }
                    else
                        IdMarks = "NIL";
                }
                else if (dr["idmarks"].ToString().Contains(':'))
                {
                    _IdMarks = dr["idmarks"].ToString().Split(':');
                    IdMarks = "";
                    slno = 1;
                    foreach (string idmark in _IdMarks)
                    {
                        if (idmark.ToUpper().CompareTo("NIL") != 0)
                        {
                            IdMarks += slno.ToString() + ") " + idmark.ToUpper() + "<br/>";
                            slno += 1;
                        }
                    }
                    if (slno > 1)
                    {
                        IdMarks = IdMarks.Remove(IdMarks.Length - 2);
                    }
                    else
                        IdMarks = "NIL";
                }
                else
                {

                }


                tcContent.Append("<table class='formtc'><tr><td align='center' style='padding:0px;' class='tctext'><img src='../images/tc-header-transp.png' alt='tc-header' width=110 height=110/></td></tr><tr><td align='center' valign='bottom' style='padding:0px;'><table width='98%' border='0' cellspacing='0' cellpadding='0' class='tcbg' style='padding:0px;'><tr><td width='33%' align='left' valign='middle' class='ser-no' style='padding:0px;'><br />Serial No : " + dr["SlNo"].ToString() + "<br />Admission No : " + dr["AdmissionNo"].ToString() + "<br />Student UID : " + dr["student_uid"].ToString() + "</td><td width='33%' align='center' valign='middle' class='tctext' style='padding:0px;'></td><td width='33%' align='right' valign='middle' class='tc-photo' style='padding:0px;'><div class='tc-imgplace' ><div class='tc-img' ><img src='Photos/" + dr["RegNo"].ToString() + ".jpg'  alt='' /></div></div</td></tr></table></td></tr><tr><td style='padding:0px;' class=''><table width='100%' cellpadding='4' cellspacing='0' class='formtctxt'><tr><td width='4%' height='30' class=''>1.</td><td width='43%' class=''><span class='alignleft'>a)  Name of the School<br /></span></td><td width='3%' class=''>:</td><td width='50%' class='tc-txt-upper'><b>" + dr["SchoolName"].ToString() + "</b></td></tr><tr><td height='30' class='tdHeight35'>&nbsp;</td><td class='alignleft'>b)  Name of the Education District / Revenue District </td><td>:</td><td class='tc-txt-upper' ><b>" + dr["SchoolDist"].ToString() + "</b></td></tr><tr><td height='35' class='tdHeight35'>2.</td><td><span class='alignleft'>Name of the pupil (in Block letters) </span></td><td>:</td><td class='tc-txt-upper' >" + dr["Name"].ToString() + "</td></tr><tr><td height='35' class='tdHeight35'>3.</td><td><span class='alignleft'>Name of the Father and Mother of the pupil </span></td><td>:</td><td class='tc-txt-upper'>" + dr["ParentName"].ToString() + "</td></tr><tr><td height='35' class='tdHeight35'>4.</td><td><span class='alignleft'>Nationality and Religion </span></td><td>:</td><td class='tc-txt-upper'>" + dr["Nationality"].ToString() + "</td></tr><tr><td height='35' valign='top' class='tdHeight35'>5.</td><td valign='top'><span class='alignleft'>Community <br>Whether he / she belongs to SC / ST / BC / MBC / OC </span></td><td valign='top'>:</td><td valign='top' class='tc-txt-upper'>" + dr["Community"].ToString() + "</td></tr><tr><td height='35' class='tdHeight35'>6.</td><td><span class='alignleft'>Sex</span></td><td>:</td><td class='tc-txt-upper'>" + dr["Gender"].ToString() + "</td></tr><tr><td height='35' valign='top' class='tdHeight35'>7.</td><td valign='top'>Date of Birth as entered in the Admission<br />Register in figures and words</td><td valign='top'>:</td><td valign='top' class='tc-txt-upper'>" + dr["DOB"].ToString() + "<br/><div style='float:left; width:320px'>" + ConvertDate.DateToText(DateTime.ParseExact(dr["DOB"].ToString(), Dateformats, new CultureInfo("en-US"), DateTimeStyles.None), true) + "</div></td></tr><tr><td height='35' valign='top' class='tdHeight35'>8.</td><td valign='top'><span class='alignleft'>Personal Marks of Identification </span></td><td valign='top'>:</td><td valign='top' class='tc-txt-upper'>" + IdMarks + "</td></tr><tr><td height='35' class='tdHeight35'>9.</td><td><span class='alignleft'>Date of Admission and Standard in which admitted </span></td><td>:</td><td class='tc-txt-upper'>" + dr["DOA"].ToString() + "</td></tr><tr><td height='35' valign='top' class='tdHeight35'>10.</td><td valign='top'><span class='alignleft'>Standard in which the pupil was studying at the time <br>of leaving (in words)</span></td><td valign='top'>:</td><td valign='top' class='tc-txt-upper'>" + dr["LeaveofStudy"].ToString() + "</td></tr><tr><td height='35' class='tdHeight35'>11.</td><td><span class='alignleft'>Whether qualified for promotion to higher standard </span></td><td>:</td><td class='tc-txt-upper'>" + dr["Promotion"].ToString() + "</td></tr><tr><td height='35' valign='top' class='tdHeight35'>12.</td><td valign='top'><span class='alignleft'>Whether the pupil was in the receipt of any scholarship ?<br />(Nature of the scholarship to be specified) </span></td><td valign='top'>:</td><td valign='top' class='tc-txt-upper'>" + dr["Scholarship"].ToString() + "</td></tr><tr><td height='35' valign='top' class='tdHeight35'>13.</td><td valign='top'><span class='alignleft'>Whether the pupil has undergone Medical inspection <br>during the last academic year </span></td><td valign='top'>:</td><td valign='top' class='tc-txt-upper'>" + dr["MedicalCheckup"].ToString() + "</td></tr><tr><td height='35' class='tdHeight35'>14.</td><td><span class='alignleft'>Date on which the pupil actually left the school </span></td><td>:</td><td class='tc-txt-upper'>" + dr["LastDate"].ToString() + "</td></tr><tr><td height='35' class='tdHeight35' style='vertical-align: top; padding-top: 9px;'>15.</td><td style='vertical-align: top; padding-top: 9px;'><span class='alignleft'>The pupil’s conduct and character </span></td><td style='vertical-align: top; padding-top: 9px;'>:</td><td class='tc-txt-upper'>" + dr["Conduct"].ToString() + "</td></tr><tr><td height='35' valign='top' class='tdHeight35' >16.</td><td valign='top' ><span class='alignleft'>Date on which application for Transfer Certificate was <br>madeon behalf of the pupil by the parent or guardian </span></td><td valign='top'>:</td><td valign='top' class='tc-txt-upper'>" + dr["ApplicationDate"].ToString() + "</td></tr><tr><td height='35' class='tdHeight35' style='vertical-align: top; padding-top: 9px;'>17.</td><td style='vertical-align: top; padding-top: 9px;'><span class='alignleft'>Date of the Transfer Certificate </span></td><td >:</td><td class='tc-txt-upper'>" + dr["TcDate"].ToString() + "</td></tr><tr><td height='35' class='tdHeight35' style='vertical-align: top; padding-top: 9px;'>18.</td><td style='vertical-align: top; padding-top: 9px;'><span class='alignleft'>Course of Study </span></td><td style='vertical-align: top; padding-top: 9px;'>:</td><td class='tc-txt-upper'>" + dr["CourseOfStudy"].ToString() + "</td></tr></table></td></tr><tr><td style='vertical-align: top; padding: 0px;'><table border='0' class='bord-bott course' cellspacing='0' cellpadding='5' width='95%' style='text-align: center;'><tbody><tr><td width='20%' valign='middle' class='cours-brd-tl ' style='padding:5px 0px;'  ><strong>Name of the School</strong></td><td width='20%' valign='middle' class='cours-brd-tl'style='padding:5px 0px;'><p><strong>Academic Year </strong></p></td><td width='20%' valign='middle' class='cours-brd-tl'style='padding:5px 0px;'><p><strong>Standard  studied</strong></p></td><td width='20%' valign='middle' class='cours-brd-tl' style='padding:5px 0px;'><p><strong>First Language</strong></p></td><td width='20%' valign='middle' class='cours-brd-tlr' style='padding:5px 0px;'><p><strong>Medium of Instruction</strong></p></td></tr>" + BindCourseStudy(regno) + "</tbody></table></td></tr><tr><td style='vertical-align: top; padding-top: 30px;' class='signparent' align='right'><br/><br/><strong><span>Signature of the Principal<br/> with date and school seal</span></strong></td></tr><tr><td style='vertical-align: top; padding-top: 0px;'><span class='aligncenter'>Note: </span></td></tr><tr><td style='vertical-align: top; padding-top: 0px;'><span class='alignleft'>1. Erasures and unauthenticated or fraudulent alteration will lead to its cancellation.</span><br /><span class='alignleft'>2. Should be signed in ink by the Head of the Institution,</span><br /><span class='alignleft'>&nbsp;&nbsp;&nbsp;&nbsp;who will be held responsible for correctness of the entries.</span> </td></tr><tr><td align='center' style='padding-top: 10px;'><span class='decleartion'><strong>Declaration by the Parent or Guardian </strong></span><br /><span class='aligncenter'>I hereby declare that the particular record against items 2 to 7 are correct and that no change will be demanded by me in future. </span></td></tr><tr><td align='right' styl='vertical-align: top; padding-top: 29px;'>&nbsp;</td></tr><tr><td class='signparent' align='right'><br/><strong>Signature of the Parent / Guardian </strong></td></tr><tr><td height='50' style='vertical-align: top; padding-top: 9px;'>&nbsp;</td></tr></table><p class=\"pagebreakhere\" style=\"page-break-after: always; color:Red;\"></p>");
            }

            Utilities utls = new Utilities();

            sqlstr = "select isactive from m_academicyear where AcademicID='" + HttpContext.Current.Session["AcademicID"].ToString() + "'";
            Isactive = utl.ExecuteScalar(sqlstr);
            query = "";
            if (Isactive == "True")
            {
                strQuery = utls.ExecuteScalar("exec SP_UPDATETCPRINT ''," + classId + "," + sectionId + "," + HttpContext.Current.Session["AcademicID"].ToString() + "");
            }
            else
            {
                strQuery = utls.ExecuteScalar("exec SP_PromoUPDATETCPRINT ''," + classId + "," + sectionId + "," + HttpContext.Current.Session["AcademicID"].ToString() + "");
            }


        }
        return tcContent.ToString();
    }

    public static string BindCourseStudy(string regno)
    {
        Utilities utl = new Utilities();
        string _StudCourceHistory = string.Empty;
        string sqlstr = "select isactive from m_academicyear where AcademicID='" + HttpContext.Current.Session["AcademicID"].ToString() + "'";
        string Isactive = utl.ExecuteScalar(sqlstr);
        string query = "";
        if (Isactive == "True")
        {
            query = "sp_getTCCourseStudy " + regno;
        }
        else
        {
            query = "sp_getPromoTCCourseStudy " + regno + "," + HttpContext.Current.Session["AcademicID"].ToString();
        }


        DataSet dsCourseStudy = utl.GetDataset(query);

        if (dsCourseStudy != null && dsCourseStudy.Tables.Count > 0 && dsCourseStudy.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow _course in dsCourseStudy.Tables[0].Rows)
            {
                _StudCourceHistory += "<tr>";
                _StudCourceHistory += "<td width='20%' class='cours-brd-tl'><p>" + _course["schooladdr"].ToString() + "</p></td>";
                _StudCourceHistory += "<td width='20%' class='cours-brd-tl-lower'><p>" + _course["acdyears"].ToString() + "</p></td>";
                _StudCourceHistory += "<td width='20%' class='cours-brd-tl-lower'><p>" + _course["classes"].ToString() + "</p></td>";
                _StudCourceHistory += "<td width='20%' class='cours-brd-tl'><p>" + _course["firstlang"].ToString() + "</p></td>";
                _StudCourceHistory += "<td width='20%' class='cours-brd-tlr'><p>" + _course["mis"].ToString() + "</p></td>";
                _StudCourceHistory += "</tr>";
            }
        }

        return _StudCourceHistory;
    }
}

