using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Microsoft.Reporting.WebForms;
using System.Drawing.Printing;
using System.Drawing.Imaging;
using System.Text;
using System.Globalization;
using System.Net;
using System.IO;

public partial class Reports_AlumniReport : System.Web.UI.Page
{
    PrintDocument printDoc = new PrintDocument();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Utilities utl = new Utilities();
            DataTable dtSchool = new DataTable();
            dtSchool = utl.GetDataTable("exec sp_schoolDetails");
            ReportParameter Schoolname = new ReportParameter("schoolname", dtSchool.Rows[0]["SchoolName"].ToString());
            ReportParameter Printdate = new ReportParameter("printdate", System.DateTime.Now.ToString("dd/MM/yyyy"));
            AlumniReport.LocalReport.SetParameters(new ReportParameter[] { Schoolname });
            AlumniReport.LocalReport.SetParameters(new ReportParameter[] { Printdate });
          
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {

        if (txtStartdate.Text != "")
        {
            string[] myDateTimeString = txtStartdate.Text.ToString().Split('/');
            hfSDate.Value = "" + myDateTimeString[2] + "-" + myDateTimeString[1] + "-" + myDateTimeString[0] + "";
        }
        if (txtEnddate.Text != "")
        {
            string[] myDateTimeString = txtEnddate.Text.ToString().Split('/');
            hfEDate.Value = "" + myDateTimeString[2] + "-" + myDateTimeString[1] + "-" + myDateTimeString[0] + "";
        }
        Utilities utl = new Utilities();
        DataTable dtSchool = new DataTable();
        dtSchool = utl.GetDataTable("exec sp_schoolDetails");
        ReportParameter Schoolname = new ReportParameter("schoolname", dtSchool.Rows[0]["SchoolName"].ToString());
        ReportParameter Startdate = new ReportParameter("Startdate", txtStartdate.Text);
        ReportParameter Enddate = new ReportParameter("Enddate", txtEnddate.Text);
        ReportParameter Printdate = new ReportParameter("printdate", System.DateTime.Now.ToString("dd/MM/yyyy"));
        AlumniReport.LocalReport.SetParameters(new ReportParameter[] { Schoolname });
        AlumniReport.LocalReport.SetParameters(new ReportParameter[] { Printdate });
    }


    protected void txtStartdate_TextChanged(object sender, EventArgs e)
    {
        Session["sDate"] = txtStartdate.Text;
        Session["eDate"] = "";
    }
    protected void txtEnddate_TextChanged(object sender, EventArgs e)
    {
        Session["sDate"] = txtStartdate.Text;
        Session["eDate"] = txtEnddate.Text;
    }

    protected void AlumniReport_Load(object sender, EventArgs e)
    {
        string[] exportOption = new string[] { "PDF", "WORD" };


        foreach (var item in exportOption)
        {
            RenderingExtension extension = AlumniReport.LocalReport.ListRenderingExtensions().ToList().Find(x => x.Name.Equals(item, StringComparison.CurrentCultureIgnoreCase));
            if (extension != null)
            {
                System.Reflection.FieldInfo fieldInfo = extension.GetType().GetField("m_isVisible", System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic);
                fieldInfo.SetValue(extension, false);
            }
        }
    }
}