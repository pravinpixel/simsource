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
using System.Drawing.Imaging;
using System.Drawing.Printing;
using System.Text;

public partial class Reports_UniformBillingReport : System.Web.UI.Page
{
    string strClass = "";
    string strSection = "";
    string strClassID = "";
    string strSectionID = "";
    Utilities utl = null;
    public static int Userid = 0;
    
    public int m_currentPageIndex;
    public IList<Stream> m_streams;
    PrintDocument printDoc = new PrintDocument();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
           
            BindClass();
            utl = new Utilities();
            DataTable dtSchool = new DataTable();
            dtSchool = utl.GetDataTable("exec sp_schoolDetails");
            ReportParameter Schoolname = new ReportParameter("schoolname", dtSchool.Rows[0]["SchoolName"].ToString());
            ReportParameter Printdate = new ReportParameter("Printdate", System.DateTime.Now.ToString("dd/MM/yyyy"));
            UniformReport.LocalReport.SetParameters(new ReportParameter[] { Schoolname });
            UniformReport.LocalReport.SetParameters(new ReportParameter[] { Printdate });

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
        dsSection = utl.GetDataset("sp_GetSectionByClass " + ddlClass.SelectedValue);
        else
            ddlSection.Items.Clear();
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
        ddlSection.Items.Insert(0, new ListItem("--Select---", ""));
    }
    protected void Page_UnLoad(object sender, EventArgs e)
    {
        

    }     
    protected void btnSearch_Click(object sender, EventArgs e)
    {
       
        utl = new Utilities();
        DataTable dtSchool = new DataTable();
        dtSchool = utl.GetDataTable("exec sp_schoolDetails");
        ReportParameter Schoolname = new ReportParameter("schoolname", dtSchool.Rows[0]["SchoolName"].ToString());
        ReportParameter Printdate = new ReportParameter("Printdate", System.DateTime.Now.ToString("dd/MM/yyyy"));
        ReportParameter className = new ReportParameter("class", Session["strClass"].ToString() + "/" + Session["strSection"].ToString());
        UniformReport.LocalReport.SetParameters(new ReportParameter[] { Schoolname });
        UniformReport.LocalReport.SetParameters(new ReportParameter[] { Printdate });
        UniformReport.LocalReport.SetParameters(new ReportParameter[] { className });

        UniformReport.LocalReport.Refresh();
    }
   
    private void Page_Init(object sender, EventArgs e)
    {


        try
        {
            Master.chkUser();
            if (Session["UserId"] == null || Session["AcademicID"] == null)
            {

                Response.Redirect("Default.aspx?ses=expired");
            }
            else
            {
                if (!Page.IsPostBack)
                {
                    Session["strClass"] = "All Class";
                    Session["strSection"] = "All Section";
                }
                // btnSearch_Click(sender, e);
            }

        }
        catch (Exception)
        {


        }

    }

   
  
    protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindSectionByClass();
        if (ddlClass.SelectedValue == string.Empty)
        {
            strClass = "";
            strClassID = "";
            strSection = "";
            strSectionID = "";
            Session["strSection"] = "All Section";
            Session["strClass"] = "All Class";
        }
        else
        {
            Session["strClass"]  = ddlClass.SelectedItem.Text;
            Session["strClassID"] = ddlClass.SelectedValue;
            strSection = "";
            strSectionID = "";
            Session["strSection"] = "All Section";
            Session["strSectionID"] = "";
           
        }


    }
    protected void ddlSection_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlSection.SelectedItem.Value == string.Empty)
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

    public void Dispose()
    {
        if (m_streams != null)
        {
            foreach (Stream stream in m_streams)
                stream.Close();
            m_streams = null;
        }
    }

   
    
}