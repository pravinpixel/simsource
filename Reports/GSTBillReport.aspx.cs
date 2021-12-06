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
using System.Text;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
using System.Drawing;
using System.ComponentModel;
using System.Drawing.Imaging;
using System.Web.SessionState;
using System.Web.UI.HtmlControls;

public partial class Reports_GSTBillReport : System.Web.UI.Page
{
    StringBuilder str = new StringBuilder();
    string strClass = "";
    string strSection = "";
    string strClassID = "";
    string strSectionID = "";
    Utilities utl = null;
    public static int Userid = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtStartdate.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtEnddate.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            Session["FromDate"] = txtStartdate.Text;
            Session["ToDate"] = txtEnddate.Text;
            
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
        ddlSection.Items.Insert(0, "-----Select-----");
    }

    protected void Page_UnLoad(object sender, EventArgs e)
    {


    }
    protected void StudentIdCardReport_Unload(object sender, EventArgs e)
    {

    }

    public static string PrinTaxtBill(string billId)
    {
        string clientMachineName, clientIPAddress = "";
        string strPrintContent = "";

        StringBuilder str = new StringBuilder();
        Utilities utl = new Utilities();
        string sqlstr = "select isactive from m_academicyear where AcademicID='" + HttpContext.Current.Session["AcademicID"].ToString() + "'";
        string Isactive = utl.ExecuteScalar(sqlstr);
        HttpContext.Current.Session["Isactive"] = Isactive.ToString();
        string query = "";
        DataSet dsStud = new DataSet();
        if (Isactive == "True")
        {
            query = "[sp_GetStudentTaxBill] " + billId + "";

            DataSet dsPrint = utl.GetDataset(query);
            int yPos = 0;
            int headCount = 0;
            string printerName = ConfigurationManager.AppSettings["JuneFeesPrinter"];

            clientIPAddress = HttpContext.Current.Request.ServerVariables["remote_addr"];

            if (dsPrint.Tables.Count > 1)
            {

                StringBuilder str1 = new StringBuilder();

                StringFormat stringAlignRight = new StringFormat();
                stringAlignRight.Alignment = StringAlignment.Far;
                stringAlignRight.LineAlignment = StringAlignment.Center;

                StringFormat stringAlignLeft = new StringFormat();
                stringAlignLeft.Alignment = StringAlignment.Near;
                stringAlignLeft.LineAlignment = StringAlignment.Center;

                StringFormat stringAlignCenter = new StringFormat();
                stringAlignCenter.Alignment = StringAlignment.Center;
                stringAlignCenter.LineAlignment = StringAlignment.Center;

                if (dsPrint.Tables[0].Rows.Count > 0)
                {
                    sqlstr = "select isnull(count(b.TaxBillID),0) from f_studenttaxbillmaster a inner join f_studenttaxbills b on a.TaxBillID=b.TaxBillID where BillID='" + billId + "' and a.isactive=1";
                    string ibillcnt = utl.ExecuteScalar(sqlstr);
                    if (ibillcnt == "0")
                    {
                        sqlstr = " select* from f_studentbills where billID='" + billId + "'";
                        DataTable dtbill = new DataTable();
                        dtbill = utl.GetDataTable(sqlstr);
                        if (dtbill != null && dtbill.Rows.Count > 0)
                        {
                            for (int i = 0; i < dtbill.Rows.Count; i++)
                            {
                                string classID = utl.ExecuteScalar("select class from s_studentinfo where regno = '" + dsPrint.Tables[1].Rows[0]["RegNo"].ToString() + "'");

                                string headID = utl.ExecuteScalar("select feesheadid from m_feescategoryhead where FeesCatHeadID='" + dtbill.Rows[i]["FeesCatHeadId"] + "' and academicID='" + HttpContext.Current.Session["AcademicID"] + "' and ClassID='" + classID + "' and feescategoryID='" + dsPrint.Tables[3].Rows[0]["FeesCategoryID"].ToString() + "' and formonth like '%" + dsPrint.Tables[1].Rows[0]["BillMonth"].ToString() + "%'");

                                DataTable dttax = new DataTable();
                                dttax = utl.GetDataTable("select a.* from m_tax a  where a.isactive=1 and a.academicid='" + HttpContext.Current.Session["AcademicID"] + "' and a.feeheadid='" + headID + "'");
                                if (dttax.Rows.Count > 0)
                                {
                                    decimal taxvalue = Convert.ToDecimal(dtbill.Rows[i]["Amount"]) / (100 + Convert.ToDecimal(dttax.Rows[0]["Percentage"].ToString())) * Convert.ToDecimal(dttax.Rows[0]["Percentage"].ToString());

                                    string taxQuery = "insert into f_studenttaxbills(TaxBillID,FeesCatId,TaxID,TaxPercent,TaxAmount,isactive,userid)values('" + dsPrint.Tables[3].Rows[0]["TaxBillID"].ToString().Trim() + "','" + dtbill.Rows[i]["FeesCatHeadId"].ToString().Trim() + "','" + dttax.Rows[0]["TaxID"].ToString().Trim() + "','" + dttax.Rows[0]["Percentage"].ToString().Trim() + "','" + taxvalue + "','true','" + dsPrint.Tables[1].Rows[0]["UserId"].ToString().Trim() + "')";
                                    utl.ExecuteQuery(taxQuery);
                                }
                            }
                        }

                    }

                    str.Append("<table width='100%' border='0' align='center' cellpadding='0' cellspacing='0'><tr class='billcont'><td height='30'>Hail Mary!</td><td style='text-align:right;' height='30'>Praise the Lord!</td></tr><tr class='billcont'><td height='5'></td><td height='5'></td></tr><tr class='billcont'><td style='text-align:center;font-size: 18px;' colspan='2' height='25'>" + dsPrint.Tables[2].Rows[0]["SchoolShortName"].ToString().ToUpper() + "</td></tr><tr class='billcont'><td style='text-align:center;' colspan='2' height='25'> (A unit of Amalorpavam Educational Welfare Society)</td></tr><tr class='billcont'><td style='text-align:center;' colspan='2' height='25'> " + dsPrint.Tables[2].Rows[0]["SchoolAddress"].ToString().ToUpper() + ", " + dsPrint.Tables[2].Rows[0]["SchoolCity"].ToString().ToUpper() + ", " + dsPrint.Tables[2].Rows[0]["SchoolDist"].ToString().ToUpper() + "</td></tr><tr class='billcont'><td style='text-align:center;' colspan='2' height='25'><b>GSTIN : </b>" + dsPrint.Tables[2].Rows[0]["GSTIN"].ToString().ToUpper() + "</td></tr><tr class='billcont'><td height='25'>BILL No.: " + dsPrint.Tables[3].Rows[0]["TaxBillNo"].ToString().ToUpper() + "</td><td style='padding-left:200px;' height='25'>Ref. No .: " + dsPrint.Tables[3].Rows[0]["BillNo"].ToString().ToUpper() + "</td></tr><tr class='billcont'><td height='25'>Regn. No.: " + dsPrint.Tables[3].Rows[0]["RegNo"].ToString().ToUpper() + "</td><td style='padding-left:200px;' height='25'>Class & Sec. : " + dsPrint.Tables[3].Rows[0]["ClassName"].ToString().ToUpper() + " " + dsPrint.Tables[3].Rows[0]["SectionName"].ToString().ToUpper() + "</td></tr><tr class='billcont'><td height='25'>Student Name : " + dsPrint.Tables[3].Rows[0]["StName"].ToString().ToUpper() + " </td><td style='padding-left:200px;' height='25'>State Code : 34</td></tr><tr class='billcont'><td height='5'></td><td height='5'></td></tr></table><table width='100%' border='0' align='center' cellpadding='0' cellspacing='0' style='border:1px solid #000;'><tr class='billcont'><th style='border-bottom: 1px solid #000;border-right: 1px solid #000;' height='25'>SL. NO.</th><th style='border-bottom: 1px solid #000;border-right: 1px solid #000;' height='25'>DESCRIPTION OF GOODS</th><th style='border-bottom: 1px solid #000;border-right: 1px solid #000;' height='25'>QTY</th><th style='border-bottom: 1px solid #000;border-right: 1px solid #000;' height='25'>RATE</th><th style='border-bottom: 1px solid #000;border-right: 1px solid #000;' height='25'>TAXABLE VALUE</th><th style='border-bottom: 1px solid #000;border-right: 1px solid #000;' height='25'>GST%</th><th style='border-bottom: 1px solid #000;border-right: 1px solid #000;' height='25'>GST% AMOUNT</th><th style='border-bottom: 1px solid #000;border-right: 1px solid #000;' height='25'>SGST</th><th style='border-bottom: 1px solid #000;border-right: 1px solid #000;' height='25'>CGST</th><th style='border-bottom: 1px solid #000;'>AMOUNT</th></tr> ");

                    decimal total = 0;

                    for (int i = 0; i < dsPrint.Tables[4].Rows.Count; i++)
                    {
                        total += Math.Round(Convert.ToDecimal(dsPrint.Tables[4].Rows[i]["Amount"]));

                        str.Append(" <tr class=' billcont' style='text-align:center;'><td height='25' style='border-bottom: 1px solid #000;border-right: 1px solid #000;'> " + (i + 1).ToString() + " </td><td height='25' style='text-align:left;border-bottom: 1px solid #000;border-right: 1px solid #000;'>  " + dsPrint.Tables[4].Rows[i]["FeesHeadName"].ToString().ToUpper() + "</td><td height='25' style='border-bottom: 1px solid #000;border-right: 1px solid #000;'>  " + dsPrint.Tables[4].Rows[i]["qty"].ToString().ToUpper() + "</td><td height='25' style='border-bottom: 1px solid #000;border-right: 1px solid #000;'>  " + dsPrint.Tables[4].Rows[i]["extax"].ToString().ToUpper() + "</td><td height='25' style='border-bottom: 1px solid #000;border-right: 1px solid #000;'>  " + (Convert.ToDecimal(dsPrint.Tables[4].Rows[i]["qty"]) * Convert.ToDecimal(dsPrint.Tables[4].Rows[i]["extax"])).ToString().ToUpper() + "</td><td height='25' style='border-bottom: 1px solid #000;border-right: 1px solid #000;'> " + dsPrint.Tables[4].Rows[i]["TaxPercent"].ToString().ToUpper() + "</td><td height='25' style='border-bottom: 1px solid #000;border-right: 1px solid #000;'>  " + dsPrint.Tables[4].Rows[i]["TaxAmount"].ToString().ToUpper() + "</td><td height='25' style='border-bottom: 1px solid #000;border-right: 1px solid #000;'>  " + dsPrint.Tables[4].Rows[i]["cgst"].ToString().ToUpper() + "</td><td height='25' style='border-bottom: 1px solid #000;border-right: 1px solid #000;'>  " + dsPrint.Tables[4].Rows[i]["cgst"].ToString().ToUpper() + " </td><td height='25' style='border-bottom: 1px solid #000;border-right: 1px solid #000;text-align:right;padding-right: 10px;'>  " + Math.Round(Convert.ToDecimal(dsPrint.Tables[4].Rows[i]["Amount"].ToString().ToUpper())).ToString() + " </td></tr>");
                    }

                    string roundoff = utl.ExecuteScalar("select round(" + Math.Round(Convert.ToDecimal(total)).ToString() + ",-1)");

                    decimal roundval = Convert.ToDecimal(roundoff) - Math.Round(Convert.ToDecimal(total));
                    str.Append("<tr class='billcont'><td colspan='9' height='25' style='border-bottom: 1px solid #000;border-right: 1px solid #000;text-align:right;padding-right: 10px;'> SUB TOTAL</td><td height='25' style='border-bottom: 1px solid #000;text-align:right;padding-right: 10px;'> " + Math.Round(Convert.ToDecimal(total)) + "</td></tr><tr class='billcont'><td colspan='9' height='25' style='border-bottom: 1px solid #000;border-right: 1px solid #000;text-align:right;padding-right: 10px;'> ROUND OFF</td><td height='25' style='border-bottom: 1px solid #000;text-align:right;padding-right: 10px;'> " + Convert.ToDecimal(roundval).ToString() + "</td></tr><tr class='billcont'><td colspan='9' height='25' style='border-right: 1px solid #000;text-align:right;padding-right: 10px;'> TOTAL</td><td height='25' style='text-align:right;padding-right: 10px;'> " + roundoff.ToString().ToUpper() + "</td></tr></table><table width='100%' border='0' align='center' cellpadding='0' cellspacing='0'><tr class='billcont'><td height='5'></td><td height='5'></td></tr><tr class='billcont'><td colspan='2' height='10'>Amount in words :  " + utl.retWord(Math.Round(Convert.ToDecimal(roundoff.ToString().ToUpper()))) + " Only</td></tr><tr class='billcont'><td height='50'>Date : " + dsPrint.Tables[3].Rows[0]["BillDate"].ToString() + "</td><td height='50' style='text-align:right;'><strong>Cashier</strong></td></tr></table>");

                }

                strPrintContent = str.ToString();
            }
        }
        return strPrintContent;
    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (Session["strClassID"] != null && Session["strClassID"].ToString() != "")
        {
            strClassID = Session["strClassID"].ToString();
        }

        if (Session["strSectionID"] != null && Session["strSectionID"].ToString() != "")
        {
            strSectionID = Session["strSectionID"].ToString();
        }
        if (Session["strClass"] != null && Session["strClass"].ToString() != "")
        {
            strClass = Session["strClass"].ToString();
        }

        if (Session["strSection"] != null && Session["strSection"].ToString() != "")
        {
            strSection = Session["strSection"].ToString();
        }
        if (strClass == "")
        {
            strClass = "All Classes";
        }
        if (strSection == "")
        {
            strSection = "All Sections";
        }
        StringBuilder strprint = new StringBuilder();
        if (strClassID != "")
        {
            string sqlstr = "[sp_GetStudentStudentTaxBillList] '" + ddlClass.SelectedValue + "','" + ddlSection.SelectedValue + "','" + Session["AcademicID"] + "'";
            DataSet dts = new DataSet();
            dts = utl.GetDataset(sqlstr);
            if (dts != null && dts.Tables.Count > 0 && dts.Tables[1].Rows.Count > 0)
            {
                strprint.Append("<table width='100%'><tr>");
                for (int i = 0; i < dts.Tables[1].Rows.Count; i++)
                {
                    strprint.Append(PrinTaxtBill(dts.Tables[1].Rows[i]["BillId"].ToString()));
                    if (i > 0)
                    {

                        if (((i + 1) % 2) == 0)
                        {
                            strprint.Append(@"</td></tr></table> <p class='pagebreakhere' style='page-break-after: always; color: Red;'></p><table width='100%'  style='padding-top:50px;'><tr><td>");
                        }


                    }
                }

            }
            strprint.Append(@"</tr></table>");
            dvCard.InnerHtml = strprint.ToString();
        }
    }

    [WebMethod]
    public static string PrintBillDetails()
    {
        string stdate = "";
        string eddate = "";
        if (HttpContext.Current.Session["FromDate"] != "")
        {
            string[] myDateTimeString = HttpContext.Current.Session["FromDate"].ToString().Split('/');
            stdate = "'" + myDateTimeString[2] + "-" + myDateTimeString[1] + "-" + myDateTimeString[0] + "'";
        }
        if (HttpContext.Current.Session["ToDate"] != "")
        {
            string[] myDateTimeString = HttpContext.Current.Session["ToDate"].ToString().Split('/');
            eddate = "'" + myDateTimeString[2] + "-" + myDateTimeString[1] + "-" + myDateTimeString[0] + "'";
        }

        if (HttpContext.Current.Session["strClassID"] =="")
        {
            HttpContext.Current.Session["strClassID"] = "-1";
        }
        if (HttpContext.Current.Session["strSectionID"] == "")
        {
            HttpContext.Current.Session["strSectionID"] = "-1";
        }
        if (HttpContext.Current.Session["AcademicID"] == "")
        {
            HttpContext.Current.Session["AcademicID"] = "-1";
        }
        string sqlstr = "[sp_GetStudentStudentTaxBillList] '" + HttpContext.Current.Session["strClassID"] + "','" + HttpContext.Current.Session["strSectionID"] + "'," + stdate.ToString() + "," + eddate.ToString() + ",'" + HttpContext.Current.Session["AcademicID"] + "'";
        DataSet dts = new DataSet();
        Utilities utl = new Utilities();
        StringBuilder strprintnew = new StringBuilder();
        dts = utl.GetDataset(sqlstr);
        if (dts != null && dts.Tables.Count > 0 && dts.Tables[1].Rows.Count > 0)
        {
            strprintnew.Append("<table width='100%'><tr>");
            for (int i = 0; i < dts.Tables[1].Rows.Count; i++)
            {
                strprintnew.Append(PrinTaxtBill(dts.Tables[1].Rows[i]["BillId"].ToString()));
                if (i > 0)
                {

                    if (((i + 1) % 2) == 0)
                    {
                        strprintnew.Append(@"</td></tr></table> <p class='pagebreakhere' style='page-break-after: always; color: Red;'></p><table width='100%'  style='padding-top:50px;'><tr><td>");
                    }


                }
            }
            strprintnew.Append(@"</tr></table>");
        }
      
        string StrContent = strprintnew.ToString();

        return StrContent;
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
                if (!IsPostBack)
                {
                    Session["strClass"] = null;
                    Session["strSection"] = null;
                    Session["strClassID"] = null;
                    Session["strSectionID"] = null;
                }
                ddlSection.DataSource = null;
                DataTable dt = new DataTable();
                utl = new Utilities();
                BindClass();



            }
        }
        catch (Exception)
        {


        }
    }



    private void LoadImage(DataRow objDataRow, string strImageField, string FilePath)
    {
        try
        {
            FileStream fs = new FileStream(FilePath,
                       System.IO.FileMode.Open, System.IO.FileAccess.Read);
            byte[] Image = new byte[fs.Length];
            fs.Read(Image, 0, Convert.ToInt32(fs.Length));
            fs.Close();
            objDataRow[strImageField] = Image;
        }
        catch (Exception ex)
        {
            Response.Write("<font color=red>" + ex.Message + "</font>");
        }
    }
    private void LoadPath(DataRow objDataRow, string strImageField, string FilePath)
    {
        try
        {
            objDataRow[strImageField] = FilePath;
        }
        catch (Exception ex)
        {
            Response.Write("<font color=red>" + ex.Message + "</font>");
        }
    }
    protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindSectionByClass();
        if (ddlClass.SelectedItem.Text == "-----Select-----" || ddlClass.SelectedItem.Value == "-----Select-----")
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
    }
    protected void ddlSection_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlSection.SelectedItem.Text == "-----Select-----" || ddlSection.SelectedItem.Value == "-----Select-----")
        {
            strSection = "";
            strSectionID = "";

        }
        else
        {
            Session["strSection"] = ddlSection.SelectedItem.Text;
            Session["strSectionID"] = ddlSection.SelectedValue;
        }
    }



    protected void txtStartdate_TextChanged(object sender, EventArgs e)
    {
        if (txtStartdate.Text != "")
        {
            Session["FromDate"] = txtStartdate.Text;
        }


    }
    protected void txtEnddate_TextChanged(object sender, EventArgs e)
    {
        if (txtEnddate.Text != "")
        {
            Session["ToDate"] = txtEnddate.Text;
        }

    }
}