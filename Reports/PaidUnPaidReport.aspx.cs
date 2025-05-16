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

public partial class Reports_PaidUnPaidReport : System.Web.UI.Page
{
    string strClass = "";
    string strSection = "";
    string strClassID = "";
    string strSectionID = "";
    string Month = "";
    Utilities utl = null;
    public static int Userid = 0;
    public int m_currentPageIndex;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            BindAcademicMonths();
            BindClass();
            DataTable dtSchool = new DataTable();
            utl = new Utilities();
            dtSchool = utl.GetDataTable("exec sp_schoolDetails");
            string monthname = "";
            if (ddlMonth.SelectedItem != null)
            {
                if (ddlMonth.SelectedItem.Text == "---Select---")
                {
                    monthname = "";
                }
                else
                {
                    monthname = ddlMonth.SelectedItem.Text;
                }
            }
            if (rbtnPaid.Checked == true)
            {
                rbtnUnPaid.Checked = false;
                Session["strType"] = "PaidList";
            }
            else if (rbtnUnPaid.Checked == true)
            {
                rbtnPaid.Checked = false;
                Session["strType"] = "PaidList";
            }
            string istrType = Session["strType"].ToString();
        }

    }

    private void BindAcademicMonths()
    {
        utl = new Utilities();
        DataTable dt = new DataTable();
        dt = utl.GetDataTable("select top 1 convert(varchar,startdate,121)startdate,convert(Varchar,enddate,121)enddate from m_academicyear where  academicid='" + Session["AcademicID"].ToString() + "' order by academicid desc");
        if (dt.Rows.Count > 0)
        {
            DataTable dtmon = new DataTable();
            dtmon = utl.GetDataTable("exec sp_getacademicmonths '" + dt.Rows[0]["startdate"].ToString() + "','" + dt.Rows[0]["enddate"].ToString() + "'");
            if (dtmon != null && dtmon.Rows.Count > 0)
            {
                ddlMonth.DataSource = dtmon;
                ddlMonth.DataTextField = "fullmonth";
                ddlMonth.DataValueField = "shortmonth";
                ddlMonth.DataBind();
            }
            else
            {
                ddlMonth.DataSource = null;
                ddlMonth.DataTextField = "";
                ddlMonth.DataValueField = "";
                ddlMonth.DataBind();
            }
            ddlMonth.Items.Insert(0, new ListItem("---Select---", ""));
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


    private void Page_Init(object sender, EventArgs e)
    {
        Master.chkUser();
        if (Session["UserId"] == null || Session["AcademicID"] == null)
        {
            Response.Redirect("Default.aspx?ses=expired");
        }
    }

    private void LOAD_RESULT()
    {
        utl = new Utilities();
        string monthname = "";
        if (ddlMonth.SelectedItem != null)
        {
            if (ddlMonth.SelectedItem.Text == "---Select---")
            {
                monthname = "";
            }
            else
            {
                monthname = ddlMonth.SelectedItem.Text;
            }
        }

        //string feetype = "";
        //if (dpFeesType.SelectedItem != null)
        //{
        //    feetype = dpFeesType.SelectedItem.Text;

        //}
        DataTable dts = new DataTable();
        string istrType = Session["strType"].ToString();
        if (rbtnPaid.Checked == true)
        {
            rbtnUnPaid.Checked = false;
            Session["strType"] = "PaidList";
        }
        else if (rbtnUnPaid.Checked == true)
        {
            rbtnPaid.Checked = false;
            Session["strType"] = "UnPaidList";
        }

        Session["strClassID"] = ddlClass.SelectedValue.ToString();
        Session["strSectionID"] = ddlSection.SelectedValue.ToString();
        dts = utl.GetDataTable("[PaidUnPaidList] '" + Session["strType"] + "','" + ddlMonth.SelectedValue + "','" + Session["AcademicID"] + "','" + Session["strClassID"] + "','" + Session["strSectionID"] + "'");
        string strmaintable = string.Empty;
        if (dts != null && dts.Rows.Count > 0)
        {
            strmaintable = "<table border='1' cellspacing='0' cellpadding='0'><thead><tr><th>Sl.No.</th><th>RegNo</th><th>Class</th><th>Section</th><th>Name</th><th>Actual</th><th>Paid</th><th>FatherCell</th><th>MotherCell</th></tr></thead><tbody>";
            int k = 0;

            for (int i = 0; i < dts.Rows.Count; i++)
            {
                k = k + 1;
                strmaintable = strmaintable + "<tr><td>" + (k).ToString() + "</td><td>" + dts.Rows[i]["regno"].ToString() + "</td><td>" + dts.Rows[i]["Classname"].ToString() + "</td><td>" + dts.Rows[i]["Sectionname"].ToString() + "</td><td>" + dts.Rows[i]["student"].ToString() + "</td><td>" + dts.Rows[i]["ActualAmt"].ToString() + "</td><td>" + dts.Rows[i]["PaidAmt"].ToString() + "</td><td>" + dts.Rows[i]["fathercell"].ToString() + "</td><td>" + dts.Rows[i]["mothercell"].ToString() + "</td></tr>";

            }
            strmaintable = strmaintable + "</tbody></table>";

            dvCard.InnerHtml = strmaintable;
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            LOAD_RESULT();
        }

        catch (Exception ex)
        {
            //Response.Write("<script>alert('"+ex.Message+"')</script>");
            ClientScript.RegisterClientScriptBlock(this.GetType(), "bnn", "<script>jAlert('" + ex.Message + "')</script>");
        }


    }


    protected void ddlMonth_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlMonth.Text == "" || ddlMonth.SelectedValue == "---Select---" || ddlMonth.SelectedItem.Text == "---Select---")
        {
            Month = "";
            Session["strSection"] = "All Section";
        }
        else if (ddlMonth.SelectedValue != "---Select---" && ddlMonth.SelectedItem.Text != "---Select---")
        {
            Session["Month"] = ddlMonth.SelectedValue;
        }
    }



    protected void rbtnPaid_CheckedChanged(object sender, EventArgs e)
    {
        if (rbtnPaid.Checked == true)
        {
            rbtnUnPaid.Checked = false;
            Session["strType"] = "PaidList";
        }
    }
    protected void rbtnUnPaid_CheckedChanged(object sender, EventArgs e)
    {
        if (rbtnUnPaid.Checked == true)
        {
            rbtnPaid.Checked = false;
            Session["strType"] = "UnPaidList";
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
}