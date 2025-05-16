using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Text;
using System.IO;
using System.Drawing.Printing;
using System.Drawing;
using System.Net;
using System.Data;
using System.Globalization;




public partial class Students_ViewTransferCertificate : System.Web.UI.Page
{

    public string _SchoolName = "";
    public string _SchoolDist = "";
    public string _StudCourceHistory = "";
    public string _AdminNo = "";
    public string _SerialNo = "";
    public string _Regno = "";
    public string _Studentuid = "";
    Utilities utl = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            Master.chkUser();
            if (Session["UserId"] == null || Session["AcademicID"] == null)
            {
                Response.Redirect("Default.aspx?ses=expired");
            }
            else
            {

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

                if (Request.QueryString.AllKeys.Contains("regno"))
                {
                    if (Request.QueryString["regno"].ToString() != string.Empty)
                    {
                        _Regno = Request.QueryString["regno"].ToString();
                        hdnRegNo.Value = Request.QueryString["regno"].ToString();
                        BindConduct();
                        BindData(_Regno);
                        BindCourseStudy(_Regno);
                    }
                    else
                    {
                        Response.Redirect("TCSearch.aspx");
                    }
                }
                //else
                //{
                //    Response.Redirect("TCSearch.aspx");
                //}
            }
        }
    }

    [WebMethod]
    public static string ChangeApproval(string regNo)
    {
        Utilities utl = new Utilities();

        string sqlstr = "select isactive from m_academicyear where AcademicID='" + HttpContext.Current.Session["AcademicID"].ToString() + "'";
        string Isactive = utl.ExecuteScalar(sqlstr);
        string query = "";
        if (Isactive == "True")
        {
            query = "SP_UPDATETCSTATUS " + regNo;
        }
        else
        {
            query = "SP_PromoUPDATETCSTATUS " + regNo + ", " + "''" + "," + "''" + "," + "'" + HttpContext.Current.Session["AcademicID"].ToString() + "'";
        }

        string strError = utl.ExecuteQuery(query);

        if (strError == string.Empty)
            return "";
        else
            return "fail";
    }

    [WebMethod]
    public static string GetModuleMenuId(string path, string UserId)
    {
        Utilities utl = new Utilities();
        DataSet ds = new DataSet();
        string query = "sp_GetModuleMenuId '" + path + "'," + UserId;
        return utl.GetDatasetTable(query, "ModuleMenu").GetXml();
    }


    protected void BindData(string regno)
    {

        utl = new Utilities();
        string[] formats = { "dd/MM/yyyy" };
        string sqlstr = "select isactive from m_academicyear where AcademicID='" + HttpContext.Current.Session["AcademicID"].ToString() + "'";
        string Isactive = utl.ExecuteScalar(sqlstr);
        string query = "";
        if (Isactive == "True")
        {
            query = "sp_getStudentTCInfo " + regno + "," + HttpContext.Current.Session["AcademicID"].ToString();
        }
        else
        {
            query = "sp_getPromoStudentTCInfo " + regno + "," + HttpContext.Current.Session["AcademicID"].ToString();
        }
        DataSet dsTCDetail = utl.GetDataset(query);
        if (dsTCDetail != null && dsTCDetail.Tables.Count > 0 && dsTCDetail.Tables[0].Rows.Count > 0)
        {
            _SchoolName = dsTCDetail.Tables[0].Rows[0]["schoolname"].ToString().ToUpper();
            _SchoolDist = dsTCDetail.Tables[0].Rows[0]["schoolDist"].ToString().ToUpper();
            txtStudentName.Text = dsTCDetail.Tables[0].Rows[0]["name"].ToString();
            txtParentName.Text = dsTCDetail.Tables[0].Rows[0]["parent"].ToString();
            txtNationality.Text = dsTCDetail.Tables[0].Rows[0]["nationality"].ToString();
            txtCommunity.Text = dsTCDetail.Tables[0].Rows[0]["community"].ToString();
            txtSex.Text = dsTCDetail.Tables[0].Rows[0]["sex"].ToString();
            string[] Dateformats = { "dd/MM/yyyy" };
            txtDOB.Text = dsTCDetail.Tables[0].Rows[0]["DOB"].ToString() + "\r\n" + ConvertDate.DateToText(DateTime.ParseExact(dsTCDetail.Tables[0].Rows[0]["DOB"].ToString(), Dateformats, new CultureInfo("en-US"), DateTimeStyles.None), true);

            string[] _IdMarks = dsTCDetail.Tables[0].Rows[0]["idmarks"].ToString().Split(';');
            string IdMarks = "";
            int slno = 1;
            foreach (string idmark in _IdMarks)
            {
                if (idmark.ToUpper().CompareTo("NIL") != 0)
                {
                    IdMarks += slno.ToString() + ") " + idmark.ToUpper() + "\r\n";
                    slno += 1;
                }
            }
            if (slno > 1)
            {
                IdMarks = IdMarks.Remove(IdMarks.Length - 2);
            }
            else
                IdMarks = "NIL";

            txtIdMarks.Text = IdMarks;

            txtDOA.Text = dsTCDetail.Tables[0].Rows[0]["DOA"].ToString() + "\r\n";
            txtDOA.Text += dsTCDetail.Tables[0].Rows[0]["adclass"].ToString() + " STD";

            txtSTD.Text = dsTCDetail.Tables[0].Rows[0]["class"].ToString() + " STD";
            txtScholer.Text = dsTCDetail.Tables[0].Rows[0]["scholar"].ToString();
            _AdminNo = dsTCDetail.Tables[0].Rows[0]["adminno"].ToString();
            _Studentuid = dsTCDetail.Tables[0].Rows[0]["student_uid"].ToString();

            string sql = "select TcSlno from s_studenttc where RegNo=" + regno + "  and AcademicId=" + Session["AcademicID"] + " and isactive=1";
            string TcSlno = utl.ExecuteScalar(sql);
            if (TcSlno != null && TcSlno != "")
            {
                _SerialNo = TcSlno;
            }
            else
            {
                string sqls = "select isnull(max(TCID)+1,1) from s_studenttc where TcSlno<>''";
                string Slno = utl.ExecuteScalar(sqls);
                sqls = "select distinct convert(varchar,year(startdate))+'-'+  convert(varchar,Datepart(yy,enddate)) as AcademicYear   from m_academicyear  where academicID='" + Session["AcademicID"] + "'";
                string AcademicYear = utl.ExecuteScalar(sqls);
                _SerialNo = Slno + " / " + AcademicYear;
            }


            txtPromotion.Text = dsTCDetail.Tables[0].Rows[0]["PromotionText"].ToString();
            if (dsTCDetail.Tables[0].Rows[0]["MedicalCheckup"].ToString() != string.Empty)
                sltMedicalInspection.Value = dsTCDetail.Tables[0].Rows[0]["MedicalCheckup"].ToString();
            txtTCStudLateDate.Value = dsTCDetail.Tables[0].Rows[0]["LastDate"].ToString();
            if (dsTCDetail.Tables[0].Rows[0]["Conduct"].ToString() != string.Empty)
                ddlConduct.Text = dsTCDetail.Tables[0].Rows[0]["Conduct"].ToString();
            txtTCAppDate.Value = dsTCDetail.Tables[0].Rows[0]["ApplicationDate"].ToString();
            txtTCDate.Value = dsTCDetail.Tables[0].Rows[0]["TcDate"].ToString();
            txtTCCoures.Value = dsTCDetail.Tables[0].Rows[0]["CourseofStudy"].ToString();
            sql = "select TCReason from s_studenttc where RegNo=" + regno + "  and AcademicId=" + Session["AcademicID"] + " and isactive=1";
            string TCReason = utl.ExecuteScalar(sql);
            if (TCReason != null && TCReason != "")
            {
                txtTCReason.Value = TCReason.ToString();
            }
        }


    }
    protected void BindConduct()
    {

        utl = new Utilities();
        DataSet dsConduct = utl.GetDataset("sp_getConduct");
        ddlConduct.DataSource = dsConduct.Tables[0];
        ddlConduct.DataValueField = "conductname";
        ddlConduct.DataTextField = "conductname";
        ddlConduct.DataBind();

    }
    protected void BindCourseStudy(string regno)
    {
        utl = new Utilities();
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
            OldSchool.Visible = true;

            foreach (DataRow _course in dsCourseStudy.Tables[0].Rows)
            {
                _StudCourceHistory += "<tr>";
                _StudCourceHistory += "<td width='20%' class='cours-brd-tl'><p>" + _course["schooladdr"].ToString() + "</p></td>";
                _StudCourceHistory += "<td width='20%' class='cours-brd-tl'><p>" + _course["acdyears"].ToString() + "</p></td>";
                _StudCourceHistory += "<td width='20%' class='cours-brd-tl'><p>" + _course["classes"].ToString() + "</p></td>";
                _StudCourceHistory += "<td width='20%' class='cours-brd-tl'><p>" + _course["firstlang"].ToString() + "</p></td>";
                _StudCourceHistory += "<td width='20%' class='cours-brd-tlr'><p>" + _course["mis"].ToString() + "</p></td>";
                _StudCourceHistory += "</tr>";
            }
        }
        else
        {
            OldSchool.Visible = false;


        }
    }

    [WebMethod]
    public static string SaveTCDetails(string isPrint, string regNo, string academicId, string userId, string leaveOfStudy, string promotionText, string medicalCheckup, string lastDate, string conduct, string applicationDate, string tcDate,
        string courseofStudy, string printtc)
    {
        string tcSlno = string.Empty;
        string[] formats = { "dd/MM/yyyy" };
        string lDate = string.Empty;
        string aDate = string.Empty;
        string tDate = string.Empty;

        if (lastDate != string.Empty)
            lDate = DateTime.ParseExact(lastDate, formats, new CultureInfo("en-US"), DateTimeStyles.None).ToString("yyyy-MM-dd");

        if (applicationDate != string.Empty)
            aDate = DateTime.ParseExact(applicationDate, formats, new CultureInfo("en-US"), DateTimeStyles.None).ToString("yyyy-MM-dd");

        if (tcDate != string.Empty)
            tcDate = DateTime.ParseExact(tcDate, formats, new CultureInfo("en-US"), DateTimeStyles.None).ToString("yyyy-MM-dd");

        Utilities utl = new Utilities();

        DataSet dstemp = utl.GetDataset("select count(*) from s_studenttc where regno=" + regNo + " and academicID='"+ HttpContext.Current.Session["AcademicID"].ToString() +"'");

        string strProcedureName = string.Empty;


        string sqlstr = "select isactive from m_academicyear where AcademicID='" + HttpContext.Current.Session["AcademicID"].ToString() + "'";
        string Isactive = utl.ExecuteScalar(sqlstr);
        string query = "";
        if (Isactive == "True")
        {
            if (dstemp != null && dstemp.Tables.Count > 0 && dstemp.Tables[0].Rows.Count > 0 && Convert.ToInt32(dstemp.Tables[0].Rows[0][0].ToString()) != 0)
                strProcedureName = "SP_UPDATETCDETAILS ";
            else
                strProcedureName = "SP_UPDATETCDETAILS1 ";
        }
        else
        {
            if (dstemp != null && dstemp.Tables.Count > 0 && dstemp.Tables[0].Rows.Count > 0 && Convert.ToInt32(dstemp.Tables[0].Rows[0][0].ToString()) != 0)
                strProcedureName = "SP_PromoUPDATETCDETAILS ";
            else
                strProcedureName = "SP_PromoUPDATETCDETAILS1 ";
        }

        printtc = "0";

        string sqls = "select isnull(max(TCID)+1,1) from s_studenttc";
        string Slno = utl.ExecuteScalar(sqls);
        sqls = "select distinct convert(varchar,year(startdate))+'-'+  convert(varchar,Datepart(yy,enddate)) as AcademicYear   from m_academicyear  where academicID='" + HttpContext.Current.Session["AcademicID"] + "'";
        string AcademicYear = utl.ExecuteScalar(sqls);
        tcSlno = Slno + " / " + AcademicYear;

        query = strProcedureName + regNo + ", " + academicId + ",'" + tcSlno + "','" + leaveOfStudy + "','" + promotionText + "','" + medicalCheckup + "','" + lDate + "','" + conduct + "','" + aDate + "','" + tcDate + "','" + courseofStudy + "','" + printtc + "'," + userId + "," + isPrint + ",'',''";

        string strError = utl.ExecuteQuery(query);
        if (strError == string.Empty)
            return isPrint;
        else
            return "fail";
    }
}