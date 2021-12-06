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
using System.Globalization;
using System.Net;

public partial class Reports_CurricularReport : System.Web.UI.Page
{
    string strClass = "";
    string strSection = "";
    string strClassID = "";
    string strSectionID = "";
    Utilities utl = null;
    public static int Userid = 0;
    public int m_currentPageIndex;
    public IList<Stream> m_streams;
    private PageSettings m_pagesettings;
    PrintDocument printDoc = new PrintDocument();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            BindClass();
            DataTable dtSchool = new DataTable();
            utl = new Utilities();
            dtSchool = utl.GetDataTable("exec sp_schoolDetails");
            ReportParameter Schoolname = new ReportParameter("Schoolname", dtSchool.Rows[0]["SchoolName"].ToString());
            if (rbtnFineArts.Checked == true)
            {
                rbtnSports.Checked = false;
                Session["strType"] = "FineArts";
            }
            else if (rbtnSports.Checked == true)
            {
                rbtnFineArts.Checked = false;
                Session["strType"] = "Sports";
            }
            string istrType = Session["strType"].ToString();


            Session["strClass"] = "All Class";
            Session["strSection"] = "All Section";
            ReportParameter Printdate = new ReportParameter("Printdate", System.DateTime.Now.ToString("dd/MM/yyyy"));
            ReportParameter Class = new ReportParameter("Class", "AllClass/AllSections");
            ReportParameter strType = new ReportParameter("strType", istrType);


            rptCurricular.LocalReport.SetParameters(new ReportParameter[] { strType });
            rptCurricular.LocalReport.SetParameters(new ReportParameter[] { Schoolname });
            rptCurricular.LocalReport.SetParameters(new ReportParameter[] { Printdate });
            rptCurricular.LocalReport.SetParameters(new ReportParameter[] { Class });


        }
    }

    protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["strClass"] = "All Class";
        Session["strSection"] = "All Section";
        BindSectionByClass();
        if (ddlClass.SelectedItem.Text == "-----Select-----" || ddlClass.SelectedItem.Value == "-----Select-----" || ddlClass.SelectedItem.Value == "")
        {
            strClass = "";
            strClassID = "";
            strSection = "";
            strSectionID = "";
            Session["strClass"] = "All Class";
            Session["strSection"] = "All Section";
            Session["strSectionID"] = "";
        }
        else
        {
            Session["strClass"] = ddlClass.SelectedItem.Text;
            Session["strClassID"] = ddlClass.SelectedValue;
            strSection = "";
            strSectionID = "";
            Session["strSection"] = "All Section";
            Session["strSectionID"] = "";
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
    protected void BindSectionByClass()
    {
        utl = new Utilities();
        DataSet dsSection = new DataSet();
        if (ddlClass.SelectedValue != string.Empty)
        {
            dsSection = utl.GetDataset("sp_GetSectionByClass " + ddlClass.SelectedValue);
        }
        else
        {
            ddlSection.Items.Clear();
        }

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
        ddlSection.Items.Insert(0, "-----Select-----");
    }
    protected void ddlSection_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlSection.SelectedItem.Text == "-----Select-----" || ddlSection.SelectedItem.Value == "-----Select-----")
        {
            strSection = "";
            strSectionID = "";
            Session["strSection"] = "All Section";
        }
        else
        {
            Session["strSection"] = ddlSection.SelectedItem.Text;
            Session["strSectionID"] = ddlSection.SelectedValue;
        }
    }

    protected void Page_UnLoad(object sender, EventArgs e)
    {
        if (rptCurricular != null)
        {
            rptCurricular.Dispose();
            GC.Collect();
        }
    }
    private void Page_Init(object sender, EventArgs e)
    {
        Master.chkUser();
        if (Session["UserId"] == null || Session["AcademicID"] == null)
        {
            Response.Redirect("Default.aspx?ses=expired");
        }
        else
        {
            btnSearch_Click(sender, e);
        }

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        DataTable dtSchool = new DataTable();
        utl = new Utilities();
        dtSchool = utl.GetDataTable("exec sp_schoolDetails");

        if (rbtnFineArts.Checked == true)
        {
            rbtnSports.Checked = false;
            Session["strType"] = "FineArts";
        }
        else if (rbtnSports.Checked == true)
        {
            rbtnFineArts.Checked = false;
            Session["strType"] = "Sports";
        }
        string istrType = Session["strType"].ToString();

        ReportParameter Schoolname = new ReportParameter("Schoolname", dtSchool.Rows[0]["SchoolName"].ToString());
        ReportParameter Printdate = new ReportParameter("Printdate", System.DateTime.Now.ToString("dd/MM/yyyy"));
        ReportParameter Class = new ReportParameter("Class", Session["strClass"] + "/" + Session["strSection"]);
        ReportParameter strType = new ReportParameter("strType", istrType);

        rptCurricular.LocalReport.SetParameters(new ReportParameter[] { strType });
        rptCurricular.LocalReport.SetParameters(new ReportParameter[] { Schoolname });
        rptCurricular.LocalReport.SetParameters(new ReportParameter[] { Printdate });
        rptCurricular.LocalReport.SetParameters(new ReportParameter[] { Class });


    }
    protected void rbtnSports_CheckedChanged(object sender, EventArgs e)
    {
        if (rbtnSports.Checked == true)
        {
            rbtnFineArts.Checked = false;
            Session["strType"] = "Sports";
        }
    }
    protected void rbtnFineArts_CheckedChanged(object sender, EventArgs e)
    {
        if (rbtnFineArts.Checked == true)
        {
            rbtnSports.Checked = false;
            Session["strType"] = "FineArts";
        }
    }
}