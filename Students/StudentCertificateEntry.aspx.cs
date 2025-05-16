using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Services;

public partial class Students_StudentCertificateEntry : System.Web.UI.Page
{
    public string _StudCourceHistory = "";
    Utilities utl = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.chkUser();
        GetCompFor();
        string regNo = string.Empty;
        string compfor = string.Empty;
        if (Request.QueryString["StudentID"] != null)
        {
            regNo = Request.QueryString["StudentID"].ToString();
            compfor = Request.QueryString["compfor"].ToString();
            ddlFor.Text = compfor.ToString();
            hdnRegNo.Value = regNo;
            string acdid = string.Empty;
            if (Session["AcademicID"] != null)
                acdid = Session["AcademicID"].ToString();
            string sRegNo = GetInfo(regNo, compfor, acdid);
        }
        utl = new Utilities();
        lblAcdYear.Text = utl.ExecuteScalar("select convert(varchar(10),year(startdate))+'-'+convert(varchar(10),year(enddate)) from m_academicyear where AcademicID='" + HttpContext.Current.Session["AcademicID"].ToString() + "'");
    }

    private void GetCompFor()
    {
        Utilities utl = new Utilities();
        string sqlstr = "sp_GetCertificateType";
        DataTable dt = new DataTable();
        ddlFor.DataSource = null;
        ddlFor.Items.Clear();
        dt = utl.GetDataTable(sqlstr);

        if (dt != null && dt.Rows.Count > 0)
        {
            ddlFor.DataSource = dt;
            ddlFor.DataTextField = "CertificateTypeName";
            ddlFor.DataValueField = "CertificateTypeName";
            ddlFor.DataBind();
        }
        else
        {
            ddlFor.DataSource = null;
            ddlFor.DataBind();
        }
    }

    [WebMethod]
    public static string StudentInfo(string regno)
    {
        Utilities utl = new Utilities();
        DataSet ds = new DataSet();
        string query = "";
        query = "sp_GetStudentInfo ''," + regno + "";

        return utl.GetDatasetTable(query, "StudentInfo").GetXml();
    }

    [WebMethod]
    public static string GetStudentInfo(int studentid)
    {
        Utilities utl = new Utilities();
        DataSet ds = new DataSet();
        string query = "";
        query = "sp_GetStudentInfo " + studentid + "";

        return utl.GetDatasetTable(query, "StudentInfo").GetXml();
    }

    private string GetInfo(string id, string compfor, string acdid)
    {
        Utilities utl = new Utilities();

        string sqlstr = "select isactive from m_academicyear where AcademicID='" + HttpContext.Current.Session["AcademicID"].ToString() + "'";
        string Isactive = utl.ExecuteScalar(sqlstr);
        string query = "";
        string comptype = "", position = "", isprint = "";
        if (Isactive == "True")
        {
            query = "[sp_GetStudentCertificateInfo] " + id + ",'" + compfor + "'," + acdid + "";
        }
        else
        {
            query = "[Sp_getoldstudentcertificateinfo] " + id + ",'" + compfor + "'," + acdid + "";
        }


        DataSet ds = new DataSet();
        string sRegNo = string.Empty;
        ds = utl.GetDataset(query);
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            if (ds.Tables[0].Rows[0]["SCId"] != null && ds.Tables[0].Rows[0]["SCId"] != "")
                lblSLNo.Text = ds.Tables[0].Rows[0]["SCId"].ToString().ToUpper();
            if (ds.Tables[0].Rows[0]["RegNo"] != null && ds.Tables[0].Rows[0]["RegNo"] != "")
                sRegNo = ds.Tables[0].Rows[0]["RegNo"].ToString().ToUpper();
            txtRegNo.Text = ds.Tables[0].Rows[0]["RegNo"].ToString().ToUpper();
            if (ds.Tables[0].Rows[0]["AcdYear"] != null && ds.Tables[0].Rows[0]["AcdYear"] != "")
                lblAcdYear.Text = ds.Tables[0].Rows[0]["AcdYear"].ToString().ToUpper();
            if (ds.Tables[0].Rows[0]["StudentName"] != null && ds.Tables[0].Rows[0]["StudentName"] != "")
                lblName.Text = ds.Tables[0].Rows[0]["StudentName"].ToString().ToUpper();
           if (ds.Tables[0].Rows[0]["conductedby"] != null && ds.Tables[0].Rows[0]["conductedby"] != "")
                txtConductedby.Text = ds.Tables[0].Rows[0]["conductedby"].ToString().ToUpper();
            if (ds.Tables[0].Rows[0]["SCId"] != null && ds.Tables[0].Rows[0]["SCId"] != "")
                hdnSCID.Value = ds.Tables[0].Rows[0]["SCId"].ToString().ToUpper();
            if (ds.Tables[0].Rows[0]["remarks"] != null && ds.Tables[0].Rows[0]["remarks"] != "")
                ddlPosition.Text = ds.Tables[0].Rows[0]["remarks"].ToString();
            if (ds.Tables[0].Rows[0]["comptype"] != null && ds.Tables[0].Rows[0]["comptype"] != "")
                comptype = ds.Tables[0].Rows[0]["comptype"].ToString().Trim();
            if (comptype == "Inter School")
            {
                rbtntype1.Checked = true;
            }
            if (comptype == "Intra School")
            {
                rbtntype2.Checked = true;
            }
            if (ds.Tables[0].Rows[0]["position"] != null && ds.Tables[0].Rows[0]["position"] != "")
                position = ds.Tables[0].Rows[0]["position"].ToString().Trim();
            if (position == "National")
            {
                rbtnLevel1.Checked = true;
            }
            if (position == "State")
            {
                rbtnLevel2.Checked = true;
            }
            if (position == "Zonal")
            {
                rbtnLevel3.Checked = true;
            }
            if (position == "School")
            {
                rbtnLevel4.Checked = true;
            }
            if (ds.Tables[0].Rows[0]["compfor"] != null && ds.Tables[0].Rows[0]["CertificateTypeId"].ToString() != "")
                try
                {
                    ddlFor.Text = ds.Tables[0].Rows[0]["compfor"].ToString().Trim();
                    ddlFor.SelectedValue = ds.Tables[0].Rows[0]["compfor"].ToString().Trim();
                }
                catch
                {

                    ddlFor.SelectedItem.Value = ds.Tables[0].Rows[0]["compfor"].ToString().Trim();
                }

            if (ds.Tables[0].Rows[0]["position"] != null && ds.Tables[0].Rows[0]["position"].ToString() != "")
                try
                {
                    ddlPosition.Text = ds.Tables[0].Rows[0]["position"].ToString().Trim();
                    ddlPosition.SelectedValue = ds.Tables[0].Rows[0]["position"].ToString().Trim();
                }
                catch
                {

                    ddlPosition.SelectedItem.Value = ds.Tables[0].Rows[0]["position"].ToString().Trim();
                }


            if (ds.Tables[0].Rows[0]["awardtype"] != null && ds.Tables[0].Rows[0]["awardtype"] != "")
                txtawardtype.Text = ds.Tables[0].Rows[0]["awardtype"].ToString();

            if (ds.Tables[0].Rows[0]["remarks"] != null && ds.Tables[0].Rows[0]["remarks"] != "")
                txtremarks.Text = ds.Tables[0].Rows[0]["remarks"].ToString();

            if (ds.Tables[0].Rows[0]["remarks"] != null && ds.Tables[0].Rows[0]["remarks"] != "")
                txtremarks.Text = ds.Tables[0].Rows[0]["remarks"].ToString();

            if (ds.Tables[0].Rows[0]["compdate"] != null && ds.Tables[0].Rows[0]["compdate"] != "")
                txtDate.Text = ds.Tables[0].Rows[0]["compdate"].ToString();

            if (ds.Tables[0].Rows[0]["eventname"] != null && ds.Tables[0].Rows[0]["eventname"] != "")
                txtEvent.Text = ds.Tables[0].Rows[0]["eventname"].ToString();

            if (ds.Tables[0].Rows[0]["result"] != null && ds.Tables[0].Rows[0]["result"] != "")
                ddlresult.Text = ds.Tables[0].Rows[0]["result"].ToString().Trim();

            if (ds.Tables[0].Rows[0]["compenddate"] != null && ds.Tables[0].Rows[0]["compenddate"] != "")
                txtEndDate.Text = ds.Tables[0].Rows[0]["compenddate"].ToString();


            if (ds.Tables[0].Rows[0]["isprint"] != null && ds.Tables[0].Rows[0]["isprint"] != "")
                isprint = ds.Tables[0].Rows[0]["isprint"].ToString().Trim();
            if (isprint == "Yes")
            {
                rbtnPrintYes.Checked = true;
            }
            if (comptype == "No")
            {
                rbtnPrintNo.Checked = true;
            }
        }

        return sRegNo;
    }

    [WebMethod]
    public static string GetModuleId(string path)
    {
        Utilities utl = new Utilities();
        DataSet ds = new DataSet();
        string query = "sp_GetModuleMenuIdByPath '" + path + "'," + Convert.ToInt32(HttpContext.Current.Session["UserId"]) + "";


        ds = utl.GetDatasetTable(query, "ModuleMenusByPath");
        return ds.GetXml();
    }

    [WebMethod]

    public static string Save(string slNo, string RegNo, string AcademicId, string title, string comptype,
        string complevel, string compfor, string compdate, string compenddate, string awardtype, string Conductby, string remarks, string eventname, string result,string position, string isprint, string UserId)
    {
        Utilities utl = new Utilities();
        string strQueryStatus = "";
        if (compdate != "")
        {
            string[] myDateTimeString = compdate.Split('/');
            compdate = "'" + myDateTimeString[2] + "/" + myDateTimeString[1] + "/" + myDateTimeString[0] + "'";
        }
        else
        {
            compdate = "NULL";
        }

        if (compenddate != "")
        {
            string[] myDateTimeString = compenddate.Split('/');
            compenddate = "'" + myDateTimeString[2] + "/" + myDateTimeString[1] + "/" + myDateTimeString[0] + "'";
        }
        else
        {
            compenddate="NULL";
        }
        string sqlstr = "select isactive from m_academicyear where AcademicID='" + HttpContext.Current.Session["AcademicID"].ToString() + "'";
        string Isactive = utl.ExecuteScalar(sqlstr);
        sqlstr = "";
        if (Isactive == "True")
        {
            sqlstr = "select regno from vw_getstudent where studentid='" + RegNo + "' and AcademicYear='" + HttpContext.Current.Session["AcademicID"].ToString() + "'";
        }

        string strRegno = utl.ExecuteScalar(sqlstr);
        if (strRegno != "")
        {
            sqlstr = "select count(*) from s_Certificate where regno='" + strRegno + "' and AcademicId='" + AcademicId + "' and comptype='" + comptype + "' and complevel='" + complevel + "' and compfor='" + compfor + "'";
            string retval = utl.ExecuteScalar(sqlstr);
            if (retval == "" || retval == "0")
            {
                sqlstr = "SP_InsertCertificate " + strRegno + "," + AcademicId + ",'" + title + "','" + comptype + "','" + complevel + "'," +
           "'" + compfor + "'," + compdate + "," + compenddate + ",'" + awardtype + "','" + Conductby + "','" + remarks + "','" + eventname + "','" + result + "','" + position + "','" + isprint + "'," + UserId + "";
                strQueryStatus = utl.ExecuteScalar(sqlstr);
            }
            else
            {
                sqlstr = "SP_UpdateCertificate'" + slNo + "'," + strRegno + "," + AcademicId + ",'" + title + "','" + comptype + "','" + complevel + "'," +
           "'" + compfor + "'," + compdate + "," + compenddate + ",'" + awardtype + "','" + Conductby + "','" + remarks + "','" + eventname + "','" + result + "','" + position + "','" + isprint + "'," + UserId + "";
                strQueryStatus = utl.ExecuteScalar(sqlstr);
            }
        }

        if (strQueryStatus == string.Empty)
            return "";
        else
            return strQueryStatus;
    }
    [WebMethod]
    public static string GetSerialNo()
    {
        Utilities utl = new Utilities();
        string query = "Select isnull(Max(SCId)+ 1,1)as  SerialNo from s_Certificate";
        return utl.GetDatasetTable(query, "SCIDs").GetXml();

    }


    protected void ddlFor_SelectedIndexChanged(object sender, EventArgs e)
    {
        //if (ddlFor.Text != "Select")
        //{
        //    GetInfo(hdnRegNo.Value, ddlFor.Text, HttpContext.Current.Session["AcademicID"].ToString());
        //}

    }
    protected void btnsearch_Click(object sender, EventArgs e)
    {
        Utilities utl = new Utilities();
        DataTable dt = new DataTable();
        dt = utl.GetDataTable("sp_getstudentinfo '', " + txtRegNo.Text + "");
        if (dt != null && dt.Rows.Count > 0)
        {

        }
    }
}