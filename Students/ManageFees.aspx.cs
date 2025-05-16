﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Globalization;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.UI.HtmlControls;
using System.Configuration;
using System.Drawing.Printing;
using System.Drawing;
using System.Web.Script.Serialization;
using System.Net;

public partial class Students_ManageFees : System.Web.UI.Page
{
    Utilities utl = null;
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
            if (Request.QueryString.AllKeys.Contains("regno"))
            {
                hdnRegNo.Value = Request.QueryString["regno"].ToString();

            }
            if (Request.QueryString["RegNo"] != null)
            {
                hdnRegNo.Value = Request.QueryString["RegNo"].ToString();
            }

            if (Session["AcademicID"] != null && Session["AcademicID"].ToString() != string.Empty)
            {
                hdnAcademicId.Value = Session["AcademicID"].ToString();
            }
            else
            {
                Utilities utl = new Utilities();
                hdnAcademicId.Value = utl.ExecuteScalar("select top 1 academicid from m_academicyear where isactive=1 order by academicid desc");
            }

            hdnDate.Value = DateTime.Now.ToString("dd/MM/yyyy");


            Userid = Convert.ToInt32(Session["UserId"]);
            hdnUserId.Value = Session["UserId"].ToString();
            if (!IsPostBack)
            {
                //  BindAcademicYearMonth();
            }
        }
    }

 

    [WebMethod]
    public static string checkConcession(string regno)
    {
        Utilities utl=new Utilities();
       string ConcessType= utl.ExecuteScalar("select ltrim(rtrim(ConcessType)) from s_studentconcession where AcademicId='" + HttpContext.Current.Session["AcademicID"].ToString() + "' and RegNo='" + regno + "' and IsActive=1");
       return ConcessType;
    }


    [WebMethod]
    public static string BindAcademicYearMonth(string regNo, string academicId, string editPrm, string delPrm, string btype)
    {
        string strConnString = ConfigurationManager.AppSettings["ASSConnection"].ToString();

        StringBuilder str = new StringBuilder();
        DataSet dsManageFees = new DataSet();
        SqlConnection conn = new SqlConnection(strConnString);
        Utilities utl = new Utilities();
        string sqlstr = "select isactive from m_academicyear where AcademicID='" + HttpContext.Current.Session["AcademicID"].ToString() + "'";
        string Isactive = utl.ExecuteScalar(sqlstr);
        HttpContext.Current.Session["Isactive"] = Isactive.ToString();
        string query = "";
        SqlCommand cmd = new SqlCommand();
        string firstContent = string.Empty;
        string secondContent = string.Empty;
        string thirdContent = string.Empty;
        HttpContext.Current.Session["feetab"] = string.Empty;
        if (btype=="Single")
        {
            if (Isactive == "True")
            {
                cmd = new SqlCommand("sp_ManageFee");
            }
            else
            {
                cmd = new SqlCommand("[sp_ManageOldFee]");
            }

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@regno", regNo);
            cmd.Parameters.AddWithValue("@AcademicId", academicId);
            cmd.Parameters.Add("@FeesCatId", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@FeesMonthName", SqlDbType.VarChar, 20).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@FeesTotalAmt", SqlDbType.Decimal, 18).Direction = ParameterDirection.Output;
            cmd.Parameters["@FeesTotalAmt"].Precision = 18;
            cmd.Parameters["@FeesTotalAmt"].Scale = 2;
            cmd.Parameters.Add("@FeesMonth", SqlDbType.VarChar, 20).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@FeesType", SqlDbType.VarChar, 20).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@isTerm", SqlDbType.Int).Direction = ParameterDirection.Output;
            conn.Open();
            cmd.Connection = conn;
            SqlDataAdapter daManageFees = new SqlDataAdapter();
            daManageFees.SelectCommand = cmd;

            daManageFees.Fill(dsManageFees);
            conn.Close();



            if (dsManageFees != null && dsManageFees.Tables.Count > 0)
            {
                firstContent = GetFirstContent(dsManageFees, cmd, regNo, academicId, editPrm, delPrm);
                secondContent = GetSecondContent(dsManageFees, cmd, regNo, academicId);
                thirdContent = GetThirdContent(dsManageFees, cmd, regNo, academicId, editPrm, delPrm);
            }
        }

        else if (btype == "Double")
        {
            if (Isactive == "True")
            {
                cmd = new SqlCommand("sp_ManageBiMonthFee");
            }
            else
            {
                cmd = new SqlCommand("[sp_ManageOldFee]");
            }
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@regno", regNo);
            cmd.Parameters.AddWithValue("@AcademicId", academicId);           
            cmd.Parameters.Add("@FeesCatId", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@FeesMonthName", SqlDbType.VarChar, 20).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@FeesTotalAmt", SqlDbType.Decimal, 18).Direction = ParameterDirection.Output;
            cmd.Parameters["@FeesTotalAmt"].Precision = 18;
            cmd.Parameters["@FeesTotalAmt"].Scale = 2;
            cmd.Parameters.Add("@FeesMonth", SqlDbType.VarChar, 20).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@FeesType", SqlDbType.VarChar, 20).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@isTerm", SqlDbType.Int).Direction = ParameterDirection.Output;
            conn.Open();
            cmd.Connection = conn;
            SqlDataAdapter daManageFees = new SqlDataAdapter();
            daManageFees.SelectCommand = cmd;
        
            daManageFees.Fill(dsManageFees);
            conn.Close();

            if (dsManageFees != null && dsManageFees.Tables.Count > 0)
            {
                HttpContext.Current.Session["feetab"] = (DataTable)dsManageFees.Tables[4]; 
                firstContent = GetFirstBiMonthContent(dsManageFees, cmd, regNo, academicId, editPrm, delPrm);
                secondContent = GetSecondBiMonthContent(dsManageFees, cmd, regNo, academicId);
                thirdContent = GetThirdContent(dsManageFees, cmd, regNo, academicId, editPrm, delPrm);
            }
        }

        DataSet ds = new DataSet();
        DataTable dt = new DataTable("FirstContent");
        dt.Columns.Add(new DataColumn("firsthtml", typeof(string)));

        DataRow dr = dt.NewRow();
        dr["firsthtml"] = firstContent;
        dt.Rows.Add(dr);

        DataTable dt2 = new DataTable("SecondContent");
        dt2.Columns.Add(new DataColumn("secondhtml", typeof(string)));

        DataRow dr2 = dt2.NewRow();
        dr2["secondhtml"] = secondContent;
        dt2.Rows.Add(dr2);

        DataTable dt3 = new DataTable("ThirdContent");
        dt3.Columns.Add(new DataColumn("thirdhtml", typeof(string)));

        DataRow dr3 = dt3.NewRow();
        dr3["thirdhtml"] = thirdContent;
        dt3.Rows.Add(dr3);

        ds.Tables.Add(dt);
        ds.Tables.Add(dt2);
        ds.Tables.Add(dt3);

        return ds.GetXml();

    }

    public static string GetFirstContent(DataSet dsManageFees, SqlCommand cmd, string regno, string academicId, string editPrm, string delPrm)
    {
        StringBuilder divFirstContent = new StringBuilder();
        string strOptions = string.Empty;
        string _Billno = string.Empty;
        string _BillDate = string.Empty;
        string _BillUser = string.Empty;
        string feesCatHeadId = string.Empty;
        string feesHeadAmt = string.Empty;
        string feesCatId = string.Empty;
        string feesMonthName = string.Empty;
        string feestotalAmount = string.Empty;
        if (cmd.Parameters["@FeesCatId"] != null)
            feesCatId = cmd.Parameters["@FeesCatId"].Value.ToString();

        if (cmd.Parameters["@FeesMonthName"] != null)
            feesMonthName = cmd.Parameters["@FeesMonthName"].Value.ToString();

        if (cmd.Parameters["@FeesTotalAmt"] != null)
            feestotalAmount = cmd.Parameters["@FeesTotalAmt"].Value.ToString();

        if (dsManageFees.Tables.Count > 4 && dsManageFees.Tables[3].Rows.Count > 0)
        {
            for (int k = 0; k < dsManageFees.Tables[3].Rows.Count; k++)
            {

                feesCatHeadId += dsManageFees.Tables[3].Rows[k]["feescatheadid"].ToString() + "|";
                feesHeadAmt += "0.00|";
            }
        }


        if (dsManageFees.Tables[0].Rows.Count > 0)
        {
            divFirstContent.Append(" <table class='data display datatable' id='example'><thead><tr><th width='20%' class='sorting_mod center' >Months</th><th width='20% center' class='sorting_mod' >Receipt/Bill No</th><th width='16%' class='sorting_mod center' >Date</th><th width='18%' class='sorting_mod center' >Received By</th><th width='30% center' class='sorting_mod' >Option</th></tr></thead>");
            for (int i = 0; i < dsManageFees.Tables[0].Rows.Count; i++)
            {


                _Billno = "<td class='center'>-</td>";
                _BillDate = "<td class='center'>-</td>";
                _BillUser = "<td class='center'>-</td>";



                if (dsManageFees.Tables[0].Rows[i]["monthnum"].ToString() == cmd.Parameters["@FeesMonth"].Value.ToString() && cmd.Parameters["@FeesType"].Value.ToString().Trim().ToUpper() == "ACADEMIC")
                    //  strOptions = "<table cellpadding='10' cellspacing='10' > <tr><td><a href='javascript:CreateBill(\"" + regno + "\",\"" + academicId + "\");'> Create </a> </td><td> <a href='javascript:IgnoreBill(\"" + regno + "\",\"" + academicId + "\");'>  Ignore </a> </td></tr></table>";
                    strOptions = "<table cellpadding='10' cellspacing='10' > <tr><td><a href='javascript:CreateBill();' class='creat-link'> <img src='../img/creat.png' alt='' width='22' height='22' align='absmiddle' />  Create </a> </td><td> <a href='javascript:IgnoreBill(\"" + regno + "\",\"" + academicId + "\",\"" + feesCatHeadId + "\",\"" + feesHeadAmt + "\",\"" + feesCatId + "\",\"" + feesMonthName + "\",\"0.00\");'  class='creat-link' > <img src='../img/ignor.jpg' alt='' width='22' height='22' align='absmiddle' />   Ignore </a> </td></tr></table>";
                else
                    strOptions = "<table cellpadding='10' cellspacing='10' > <tr><td> - </td><td> - </td></tr></table>";
                if (dsManageFees.Tables[1].Rows.Count > 0)
                {

                    DataRow[] drPaidFees = dsManageFees.Tables[1].Select("billmonth='" + dsManageFees.Tables[0].Rows[i]["monthname"].ToString().ToUpper().Trim() + "' and feescatcode<>'F' ");

                    if (drPaidFees.Length > 0)
                    {
                        _Billno = "<td class='center'>" + drPaidFees[0]["billno"].ToString() + "</td>";
                        _BillDate = "<td class='center'>" + drPaidFees[0]["billdate"].ToString() + "</td>";
                        _BillUser = "<td class='center'>" + drPaidFees[0]["StaffshortName"].ToString() + "</td>";
                        if (drPaidFees[0]["billid"].ToString() != string.Empty)
                            strOptions = "<table cellpadding='10' cellspacing='10' > <tr><td> <a href='javascript:ViewBill(\"" + drPaidFees[0]["billid"].ToString() + "\");'  class='creat-link'>  <img src='../img/creat.png' alt='' width='22' height='22' align='absmiddle' />  View </a> </td>";
                        else
                            strOptions = "<table cellpadding='10' cellspacing='10' > <tr><td> <a href='javascript:ViewBiMonthBill(\"" + drPaidFees[0]["BillRefNo"].ToString() + "\");'  class='creat-link'>  <img src='../img/creat.png' alt='' width='22' height='22' align='absmiddle' />  View </a> </td>";

                    

                        if (HttpContext.Current.Session["Isactive"] != null && HttpContext.Current.Session["Isactive"].ToString() != "" && HttpContext.Current.Session["Isactive"].ToString().ToLower() != "false")
                        {
                            if (delPrm == "true" && HttpContext.Current.Session["Isactive"].ToString().ToLower() == "true")
                            {
                                strOptions += " <td> <a href='javascript:DeleteBill(\"" + drPaidFees[0]["billid"].ToString() + "\");'  class='creat-link' >  <img src='../img/delete.png' alt='' align='absmiddle' />  Delete </a><td>";
                            }
                            if (editPrm == "true" && HttpContext.Current.Session["Isactive"].ToString().ToLower() == "true")
                            {
                                if(drPaidFees[0]["billid"].ToString()!=string.Empty)
                                strOptions += " <td> <a href='javascript:PrintBill(\"" + drPaidFees[0]["billid"].ToString() + "\");'  class='creat-link' >  <img src='../img/print.png' alt='' width='22' height='22' align='absmiddle' />  Print </a> </td>";
                                else
                                    strOptions += " <td> <a href='javascript:PrintBiMonthBill(\"" + drPaidFees[0]["BillRefNo"].ToString() + "\");'  class='creat-link' >  <img src='../img/print.png' alt='' width='22' height='22' align='absmiddle' />  Print </a> </td>";

                            }
                        }
                        else
                        {
                            if (editPrm == "true")
                            {
                                if (drPaidFees[0]["billid"].ToString() != string.Empty)
                                    strOptions += " <td> <a href='javascript:PrintBill(\"" + drPaidFees[0]["billid"].ToString() + "\");'  class='creat-link' >  <img src='../img/print.png' alt='' width='22' height='22' align='absmiddle' />  Print </a> </td>";
                                else
                                    strOptions += " <td> <a href='javascript:PrintBiMonthBill(\"" + drPaidFees[0]["BillRefNo"].ToString() + "\");'  class='creat-link' >  <img src='../img/print.png' alt='' width='22' height='22' align='absmiddle' />  Print </a> </td>";

                            }
                        }


                        strOptions += " </tr>";
                        if (dsManageFees.Tables[0].Rows[i]["monthnum"].ToString() == cmd.Parameters["@FeesMonth"].Value.ToString() && cmd.Parameters["@FeesType"].Value.ToString().Trim().ToUpper() == "ACADEMIC")
                            strOptions += "<tr><td><a href='javascript:updateBill(\"" + drPaidFees[0]["billid"].ToString() + "\");' class='creat-link'> <img src='../img/creat.png' alt='' width='22' height='22' align='absmiddle' />  Update Bill </a> </td><td> <a href='javascript:IgnoreExistingBill(\"" + drPaidFees[0]["billid"].ToString() + "\",\"" + academicId + "\",\"" + feesCatHeadId + "\",\"" + feesHeadAmt + "\",\"" + feesCatId + "\",\"" + feesMonthName + "\",\"0.00\");'  class='creat-link' > <img src='../img/ignor.jpg' alt='' width='22' height='22' align='absmiddle' />   Ignore </a> </td></tr>";

                        strOptions += " </table>";

                    }


                }

                if (cmd.Parameters["@isTerm"] != null && cmd.Parameters["@isTerm"].Value.ToString() == "1")
                {
                    DataRow[] monthtoterm = dsManageFees.Tables[dsManageFees.Tables.Count - 1].Select("fullmonth='" + dsManageFees.Tables[0].Rows[i]["monthname"].ToString() + "'");
                    divFirstContent.Append("<tr class='odd gradeX'><td class='center'>" + monthtoterm[0][4].ToString() + "</td>");
                }
                else
                    divFirstContent.Append("<tr class='odd gradeX'><td class='center'>" + dsManageFees.Tables[0].Rows[i]["monthname"].ToString() + "</td>");
                divFirstContent.Append(_Billno);
                divFirstContent.Append(_BillDate);
                divFirstContent.Append(_BillUser);
                divFirstContent.Append("<td>" + strOptions.ToString() + "</td>");
                divFirstContent.Append("</tr>");

            }
            divFirstContent.Append("</table>");

            //divAcademicFees.InnerHtml = divFirstContent.ToString();

        }
        return divFirstContent.ToString();
    }

    public static string GetFirstBiMonthContent(DataSet dsManageFees, SqlCommand cmd, string regno, string academicId,string editPrm,string delPrm)
    {
        StringBuilder divFirstContent = new StringBuilder();
        string strOptions = string.Empty;
        string _Billno = string.Empty;
        string _BillDate = string.Empty;
        string _BillUser = string.Empty;
        string feesCatHeadId = string.Empty;
        string feesHeadAmt = string.Empty;
        string feesCatId = string.Empty;
        string feesMonthName = string.Empty;
        string feestotalAmount = string.Empty;
        if (cmd.Parameters["@FeesCatId"] != null)
            feesCatId = cmd.Parameters["@FeesCatId"].Value.ToString();

        if (cmd.Parameters["@FeesMonthName"] != null)
            feesMonthName = cmd.Parameters["@FeesMonthName"].Value.ToString();

        if (cmd.Parameters["@FeesTotalAmt"] != null)
            feestotalAmount = cmd.Parameters["@FeesTotalAmt"].Value.ToString();

        if (dsManageFees.Tables.Count > 4 && dsManageFees.Tables[3].Rows.Count > 0)
        {
            for (int k = 0; k < dsManageFees.Tables[3].Rows.Count; k++)
            {

                feesCatHeadId += dsManageFees.Tables[3].Rows[k]["feescatheadid"].ToString() + "|";
                feesHeadAmt += "0.00|";
            }
        }


        if (dsManageFees.Tables[0].Rows.Count > 0)
        {
            divFirstContent.Append(" <table class='data display datatable' id='example'><thead><tr><th width='20%' class='sorting_mod center' >Months</th><th width='20% center' class='sorting_mod' >Receipt/Bill No</th><th width='16%' class='sorting_mod center' >Date</th><th width='18%' class='sorting_mod center' >Received By</th><th width='30% center' class='sorting_mod' >Option</th></tr></thead>");
            for (int i = 0; i < dsManageFees.Tables[0].Rows.Count; i++)
            {


                _Billno = "<td class='center'>-</td>";
                _BillDate = "<td class='center'>-</td>";
                _BillUser = "<td class='center'>-</td>";


                string[] bimonth = cmd.Parameters["@FeesMonth"].Value.ToString().Split(',');
                if (dsManageFees.Tables[0].Rows[i]["monthnum"].ToString() == bimonth[0].ToString() && cmd.Parameters["@FeesType"].Value.ToString().Trim().ToUpper() == "ACADEMIC")
                    //  strOptions = "<table cellpadding='10' cellspacing='10' > <tr><td><a href='javascript:CreateBill(\"" + regno + "\",\"" + academicId + "\");'> Create </a> </td><td> <a href='javascript:IgnoreBill(\"" + regno + "\",\"" + academicId + "\");'>  Ignore </a> </td></tr></table>";
                    strOptions = "<table cellpadding='10' cellspacing='10' > <tr><td><a href='javascript:CreateBill();' class='creat-link'> <img src='../img/creat.png' alt='' width='22' height='22' align='absmiddle' />  Create </a> </td><td> <a href='javascript:IgnoreBill(\"" + regno + "\",\"" + academicId + "\",\"" + feesCatHeadId + "\",\"" + feesHeadAmt + "\",\"" + feesCatId + "\",\"" + feesMonthName + "\",\"0.00\");'  class='creat-link' > <img src='../img/ignor.jpg' alt='' width='22' height='22' align='absmiddle' />   Ignore </a> </td></tr></table>";
                else
                    strOptions = "<table cellpadding='10' cellspacing='10' > <tr><td> - </td><td> - </td></tr></table>";
                if (dsManageFees.Tables[1].Rows.Count > 0)
                {

                    DataRow[] drPaidFees = dsManageFees.Tables[1].Select("billmonth='" + dsManageFees.Tables[0].Rows[i]["monthname"].ToString().ToUpper().Trim() + "' and feescatcode<>'F' ");

                    if (drPaidFees.Length > 0)
                    {
                        _Billno = "<td class='center'>" + drPaidFees[0]["billno"].ToString() + "</td>";
                        _BillDate = "<td class='center'>" + drPaidFees[0]["billdate"].ToString() + "</td>";
                        _BillUser = "<td class='center'>" + drPaidFees[0]["StaffshortName"].ToString() + "</td>";

                        if (drPaidFees[0]["BillRefNo"].ToString() == string.Empty)
                            strOptions = "<table cellpadding='10' cellspacing='10' > <tr><td> <a href='javascript:ViewBill(\"" + drPaidFees[0]["billid"].ToString() + "\");'  class='creat-link'>  <img src='../img/creat.png' alt='' width='22' height='22' align='absmiddle' />  View </a> </td>";
                        else
                            strOptions = "<table cellpadding='10' cellspacing='10' > <tr><td> <a href='javascript:ViewBiMonthBill(\"" + drPaidFees[0]["BillRefNo"].ToString() + "\");'  class='creat-link'>  <img src='../img/creat.png' alt='' width='22' height='22' align='absmiddle' />  View </a> </td>";

                    

                        if (HttpContext.Current.Session["Isactive"] != null && HttpContext.Current.Session["Isactive"].ToString() != "" && HttpContext.Current.Session["Isactive"].ToString().ToLower() != "false")
                        {
                            if (delPrm == "true" && HttpContext.Current.Session["Isactive"].ToString().ToLower()=="true")
                            {
                                strOptions += " <td> <a href='javascript:DeleteBill(\"" + drPaidFees[0]["billid"].ToString() + "\");'  class='creat-link' >  <img src='../img/delete.png' alt='' align='absmiddle' />  Delete </a><td>";
                            }
                            if (editPrm == "true" && HttpContext.Current.Session["Isactive"].ToString().ToLower() == "true")
                            {
                                if (drPaidFees[0]["BillRefNo"].ToString() == string.Empty)
                                    strOptions += " <td> <a href='javascript:PrintBill(\"" + drPaidFees[0]["billid"].ToString() + "\");'  class='creat-link' >  <img src='../img/print.png' alt='' width='22' height='22' align='absmiddle' />  Print </a> </td>";
                                else
                                    strOptions += " <td> <a href='javascript:PrintBiMonthBill(\"" + drPaidFees[0]["BillRefNo"].ToString() + "\");'  class='creat-link' >  <img src='../img/print.png' alt='' width='22' height='22' align='absmiddle' />  Print </a> </td>";

                            }
                        }
                        else
                        {
                            if (editPrm == "true")
                            {
                                if (drPaidFees[0]["BillRefNo"].ToString() == string.Empty)
                                    strOptions += " <td> <a href='javascript:PrintBill(\"" + drPaidFees[0]["billid"].ToString() + "\");'  class='creat-link' >  <img src='../img/print.png' alt='' width='22' height='22' align='absmiddle' />  Print </a> </td>";
                                else
                                    strOptions += " <td> <a href='javascript:PrintBiMonthBill(\"" + drPaidFees[0]["BillRefNo"].ToString() + "\");'  class='creat-link' >  <img src='../img/print.png' alt='' width='22' height='22' align='absmiddle' />  Print </a> </td>";

                            }
                        }
                       

                        strOptions += " </tr>";
                        if (dsManageFees.Tables[0].Rows[i]["monthnum"].ToString() == bimonth[0].ToString() && cmd.Parameters["@FeesType"].Value.ToString().Trim().ToUpper() == "ACADEMIC")
                            strOptions += "<tr><td><a href='javascript:updateBill(\"" + drPaidFees[0]["billid"].ToString() + "\");' class='creat-link'> <img src='../img/creat.png' alt='' width='22' height='22' align='absmiddle' />  Update Bill </a> </td><td> <a href='javascript:IgnoreExistingBill(\"" + drPaidFees[0]["billid"].ToString() + "\",\"" + academicId + "\",\"" + feesCatHeadId + "\",\"" + feesHeadAmt + "\",\"" + feesCatId + "\",\"" + feesMonthName + "\",\"0.00\");'  class='creat-link' > <img src='../img/ignor.jpg' alt='' width='22' height='22' align='absmiddle' />   Ignore </a> </td></tr>";
                            
                             strOptions += " </table>";

                    }


                }

                if (cmd.Parameters["@isTerm"] != null && cmd.Parameters["@isTerm"].Value.ToString() == "1")
                {
                    DataRow[] monthtoterm = dsManageFees.Tables[dsManageFees.Tables.Count - 1].Select("fullmonth='" + dsManageFees.Tables[0].Rows[i]["monthname"].ToString() + "'");
                    divFirstContent.Append("<tr class='odd gradeX'><td class='center'>" + monthtoterm[0][4].ToString() + "</td>");
                }
                else
                divFirstContent.Append("<tr class='odd gradeX'><td class='center'>" + dsManageFees.Tables[0].Rows[i]["monthname"].ToString() + "</td>");
                divFirstContent.Append(_Billno);
                divFirstContent.Append(_BillDate);
                divFirstContent.Append(_BillUser);
                divFirstContent.Append("<td>" + strOptions.ToString() + "</td>");
                divFirstContent.Append("</tr>");

            }
            divFirstContent.Append("</table>");

            //divAcademicFees.InnerHtml = divFirstContent.ToString();

        }
        return divFirstContent.ToString();
    }


    public static string GetThirdContent(DataSet dsManageFees, SqlCommand cmd, string regno, string academicId,string editPrm, string delPrm)
    {

        StringBuilder divThirdContent = new StringBuilder();
        string strOptions = string.Empty;
        string _Billno = string.Empty;
        string _BillDate = string.Empty;
        string _BillUser = string.Empty;
        string feesCatHeadId = string.Empty;
        string feesHeadAmt = string.Empty;
        string feesCatId = string.Empty;
        string feesMonthName = string.Empty;
        string feestotalAmount = string.Empty;


        if (cmd.Parameters["@FeesType"].Value.ToString().Trim().ToUpper() == "ADVANCE")
        {


            if (cmd.Parameters["@FeesCatId"] != null)
                feesCatId = cmd.Parameters["@FeesCatId"].Value.ToString();

            if (cmd.Parameters["@FeesMonthName"] != null)
                feesMonthName = cmd.Parameters["@FeesMonthName"].Value.ToString();

            if (cmd.Parameters["@FeesTotalAmt"] != null)
                feestotalAmount = cmd.Parameters["@FeesTotalAmt"].Value.ToString();

            if (dsManageFees.Tables[3].Rows.Count > 0)
            {
                for (int k = 0; k < dsManageFees.Tables[3].Rows.Count; k++)
                {

                    feesCatHeadId += dsManageFees.Tables[3].Rows[k]["feescatheadid"].ToString() + "|";
                    feesHeadAmt += "0.00|";
                }
            }

            _Billno = "<td class='center'>-</td>";
            _BillDate = "<td class='center'>-</td>";
            _BillUser = "<td class='center'>-</td>";

            strOptions = "<table cellpadding='10' cellspacing='10' > <tr><td><a href='javascript:CreateBill();' class='creat-link'> <img src='../img/creat.png' alt='' width='22' height='22' align='absmiddle' />  Create </a> </td><td> <a href='javascript:IgnoreBill(\"" + regno + "\",\"" + academicId + "\",\"" + feesCatHeadId + "\",\"" + feesHeadAmt + "\",\"" + feesCatId + "\",\"" + feesMonthName + "\",\"0.00\");'  class='creat-link' > <img src='../img/ignor.jpg' alt='' width='22' height='22' align='absmiddle' />   Ignore </a> </td></tr></table>";

            divThirdContent.Append(" <table class='data display datatable' id='example'><thead><tr><th width='20%' class='sorting_mod center' >Months</th><th width='20% center' class='sorting_mod' >Receipt/Bill No</th><th width='16%' class='sorting_mod center' >Date</th><th width='18%' class='sorting_mod center' >Received By</th><th width='30% center' class='sorting_mod' >Option</th></tr></thead>");

            divThirdContent.Append("<tr class='odd gradeX'><td class='center'> Advance Fee</td>");
            divThirdContent.Append(_Billno);
            divThirdContent.Append(_BillDate);
            divThirdContent.Append(_BillUser);
            divThirdContent.Append("<td>" + strOptions.ToString() + "</td>");
            divThirdContent.Append("</tr>");
            divThirdContent.Append("</table>");

        }
        else
        {
            DataRow[] drPaidFees = dsManageFees.Tables[1].Select(" feescatcode='F' ");
            if (drPaidFees.Length > 0)
            {

                _Billno = "<td class='center'>-</td>";
                _BillDate = "<td class='center'>-</td>";
                _BillUser = "<td class='center'>-</td>";

                divThirdContent.Append(" <table class='data display datatable' id='example'><thead><tr><th width='20%' class='sorting_mod center' >Months</th><th width='20% center' class='sorting_mod' >Receipt/Bill No</th><th width='16%' class='sorting_mod center' >Date</th><th width='18%' class='sorting_mod center' >Received By</th><th width='30% center' class='sorting_mod' >Option</th></tr></thead>");

                _Billno = "<td class='center'>" + drPaidFees[0]["billno"].ToString() + "</td>";
                _BillDate = "<td class='center'>" + drPaidFees[0]["billdate"].ToString() + "</td>";
                _BillUser = "<td class='center'>" + drPaidFees[0]["staffshortname"].ToString() + "</td>";
                strOptions = "<table cellpadding='10' cellspacing='10' > <tr><td> <a href='javascript:ViewBill(\"" + drPaidFees[0]["billid"].ToString() + "\");'  class='creat-link'>  <img src='../img/creat.png' alt='' width='22' height='22' align='absmiddle' />  View </a> </td>";

                if (HttpContext.Current.Session["Isactive"] != null && HttpContext.Current.Session["Isactive"].ToString() != "" && HttpContext.Current.Session["Isactive"].ToString().ToLower() != "false")
                {
                    if (delPrm == "true" && HttpContext.Current.Session["Isactive"].ToString().ToLower() == "true")
                    {
                        strOptions += " <td> <a href='javascript:DeleteBill(\"" + drPaidFees[0]["billid"].ToString() + "\");'  class='creat-link' >  <img src='../img/delete.png' alt='' align='absmiddle' />  Delete </a><td>";
                    }
                    if (editPrm == "true" && HttpContext.Current.Session["Isactive"].ToString().ToLower() == "true")
                    {
                        strOptions += " <td> <a href='javascript:PrintBill(\"" + drPaidFees[0]["billid"].ToString() + "\");'  class='creat-link' >  <img src='../img/print.png' alt='' width='22' height='22' align='absmiddle' />  Print </a> </td>";
                    }
                }
                else
                {
                    if (editPrm == "true")
                    {
                        strOptions += " <td> <a href='javascript:PrintBill(\"" + drPaidFees[0]["billid"].ToString() + "\");'  class='creat-link' >  <img src='../img/print.png' alt='' width='22' height='22' align='absmiddle' />  Print </a> </td>";
                    }
                }

                strOptions += " </tr></table>";

                divThirdContent.Append("<tr class='odd gradeX'><td class='center'> Advance Fee</td>");
                divThirdContent.Append(_Billno);
                divThirdContent.Append(_BillDate);
                divThirdContent.Append(_BillUser);
                divThirdContent.Append("<td>" + strOptions.ToString() + "</td>");
                divThirdContent.Append("</tr>");
                divThirdContent.Append("</table>");

            }

        }

        return divThirdContent.ToString();

    }

    public static string GetSecondBiMonthContent(DataSet dsManageFees, SqlCommand cmd, string regno, string academicId)
    {
        StringBuilder feePOPUPStudentDetails = new StringBuilder();
        StringBuilder feePOPUPHeadDetails = new StringBuilder();
        StringBuilder feePOPUPContent = new StringBuilder();

        if (dsManageFees.Tables[2].Rows.Count > 0 && dsManageFees.Tables[0].Rows.Count > 0)
        {

            string feesCatHeadId = "";
            string feesHeadAmt = "";
            string feesCatId = string.Empty;
            string feesMonthName = string.Empty;
            string feestotalAmount = string.Empty;
            string paymentMode = string.Empty;

            if (cmd.Parameters["@FeesCatId"] != null)
                feesCatId = cmd.Parameters["@FeesCatId"].Value.ToString();

            if (cmd.Parameters["@FeesMonthName"] != null)
                feesMonthName = cmd.Parameters["@FeesMonthName"].Value.ToString();

            if (cmd.Parameters["@FeesTotalAmt"] != null)
                feestotalAmount = cmd.Parameters["@FeesTotalAmt"].Value.ToString();

            if (cmd.Parameters["@FeesMonth"].Value.ToString() != string.Empty)
            {
                DataRow[] PaidMonthRow = dsManageFees.Tables[0].Select("monthnum in(" + cmd.Parameters["@FeesMonth"].Value.ToString() + ")");
                string PaidMonthName = "";
                string cashmode = "";
                string cardmode = "";

                if (PaidMonthRow.Length > 0)
                    PaidMonthName = PaidMonthRow[0]["monthname"].ToString() + "," + PaidMonthRow[1]["monthname"].ToString();

                if (dsManageFees.Tables[dsManageFees.Tables.Count - 2].Rows.Count > 0)
                {
                    paymentMode = "<select id=\"selPaymentMode\"  onchange=\"bindpaymode(this);\" name=\"selPaymentMode\">";
                    for (int q = 0; q < dsManageFees.Tables[dsManageFees.Tables.Count - 2].Rows.Count; q++)
                    {

                        paymentMode += "<option value=\"" + dsManageFees.Tables[dsManageFees.Tables.Count - 2].Rows[q]["paymentmodeid"].ToString() + "\">" + dsManageFees.Tables[dsManageFees.Tables.Count - 2].Rows[q]["paymentmodename"].ToString() + "</option>";

                        if ( dsManageFees.Tables[dsManageFees.Tables.Count - 2].Rows[q]["paymentmodeid"].ToString()=="9")
                        {
                            cashmode = "<input type=\"textbox\" readonly=\"false\" id=\"txtcashamt\" name=\"txtcashamt\" value=\"0\"/>";
                            cardmode = "<input type=\"textbox\" readonly=\"false\" id=\"txtcardamt\" name=\"txtcardamt\" value=\"0\"/>"; 
                        }
                        else
                        {
                            cashmode = "<input type=\"textbox\" readonly=\"true\" id=\"txtcashamt\" name=\"txtcashamt\" value=\"0\"/>";
                            cardmode = "<input type=\"textbox\" readonly=\"true\" id=\"txtcardamt\" name=\"txtcardamt\" value=\"0\"/>"; 
                        }

                    }
                    paymentMode += "</select>";
                }



                feePOPUPStudentDetails.Append(@"<table width='700px' border='0' cellpadding='3'  cellspacing='0' class='popup-form' >
                                           <tr>
	                                          <td width='100' >Reg No</td>
	                                          <td width='10' >:</td>
	                                          <td width='250' ><label for='textfield2'>" + dsManageFees.Tables[2].Rows[0]["regno"].ToString() + "</label> </td>");
                feePOPUPStudentDetails.Append(@"<td width='100'>Date Of Paid</td>
	                                          <td width='10'>:</td>
	                                          <td width='250'><input type='text' name='txtBillDate' id='txtBillDate' class='ptxtbx ' /></td>
	                                          </tr>");
                feePOPUPStudentDetails.Append(@"<tr><td  height='30' >Name</td>
	                                          <td  >:</td>
	                                          <td  ><label for='textfield2'>" + dsManageFees.Tables[2].Rows[0]["stname"].ToString().ToUpper() + "</label></td>");
                if (cmd.Parameters["@isTerm"] != null && cmd.Parameters["@isTerm"].Value.ToString() == "1")
                {
                    DataRow[] monthtoterm = dsManageFees.Tables[dsManageFees.Tables.Count - 1].Select("fullmonth='" + PaidMonthName + "'");
                    feePOPUPStudentDetails.Append(@"<td  >Term </td>
	                                      <td  >:</td>
	                                      <td  ><label for='textfield2'>" + monthtoterm[0][4] + "</label></td></tr>");
                }
                else

                    feePOPUPStudentDetails.Append(@"<td  >Month </td>
	                                      <td  >:</td>
	                                      <td  ><label for='textfield2'>" + PaidMonthName + "</label></td></tr>");


                feePOPUPStudentDetails.Append(@"<tr>
	                              <td height='30' >Class</td>
	                              <td >:</td>
	                              <td ><label for='textfield2'>" + dsManageFees.Tables[2].Rows[0]["classname"].ToString().ToUpper() + "</label></td>");
                feePOPUPStudentDetails.Append(@"<td height='30' >Section</td>
	                                      <td >:</td>
	                                      <td ><label for='textfield2'>" + dsManageFees.Tables[2].Rows[0]["sectionname"].ToString().ToUpper() + "</label></td></tr>");
                if (paymentMode != string.Empty)
                {
                    feePOPUPStudentDetails.Append(@"<tr><td >Payment Mode</td>
	                                          <td >:</td>
	                                          <td >" + paymentMode + "</td><td></td><td>" + cashmode + "</td><td>" + cardmode + "</td></tr>");
                }
                feePOPUPStudentDetails.Append(@"</tr></table>");


                if (dsManageFees.Tables[3].Rows.Count > 0 && dsManageFees.Tables[0].Rows.Count > 0)
                {

                    feePOPUPHeadDetails.Append(@" <table width='100%' border='0' cellspacing='0' cellpadding='5' class='popup-form'>
	                                          <tr class='tlb-trbg'><td width='79%' height='30' align='left' style='padding-left:10px;'>Heads</td><td width='21%' align='center'>Amount</td></tr>");
                    feePOPUPHeadDetails.Append(@"<tr><td colspan='2'><div class='' style='overflow:auto; height:120px; margin:10px 0px;width:100%;'>
                                                <table width='100%' border='0' cellspacing='0' cellpadding='0'>");

                    for (int k = 0; k < dsManageFees.Tables[3].Rows.Count; k++)
                    {
                        feesCatHeadId += dsManageFees.Tables[3].Rows[k]["feescatheadid"].ToString() + "|";
                        feesHeadAmt += dsManageFees.Tables[3].Rows[k]["amount"].ToString() + "|";
                        feePOPUPHeadDetails.Append(@"<tr><td height='30' class='tdbrd'> " + dsManageFees.Tables[3].Rows[k]["feesheadname"].ToString().ToUpper() + "</td>");
                        feePOPUPHeadDetails.Append(@"<td class='tdbrd amt-rgt'>" + dsManageFees.Tables[3].Rows[k]["amount"].ToString().ToUpper() + "</td></tr>");

                    }
                    feePOPUPHeadDetails.Append(@"</table></div></td></tr>");
                    feePOPUPHeadDetails.Append(@"<tr class='tlt-rs'><td height='30' class='tdbrd'>Total </td>
                                                    <td class='tdbrd'>Rs. " + cmd.Parameters["@FeesTotalAmt"].Value.ToString() + "</td></tr></table>");

                }

                feePOPUPContent.Append(@"<table width='650px' border='0' cellpadding='3'  cellspacing='0' class='popup-form tlt-mainbrd' style='border: 1px solid #bfbfbf; background-color:#fff;'>");
                feePOPUPContent.Append("<tr><td style='padding: 10px 10px 0px;float:right;'><a href='javascript:closeCreateBill()'>close</a></td></tr>");
                feePOPUPContent.Append("<tr><td  class='popup-form' style='padding:6px;'>" + feePOPUPStudentDetails.ToString() + "</td></tr>");

                feePOPUPContent.Append(@"<tr><td  class='popup-form' style='padding:6px;'>" + feePOPUPHeadDetails.ToString() + "</td></tr>");
                feePOPUPContent.Append("<tr><td style='text-align:center;' ><input id=\"btnSubmit\" type=\"button\" class=\"btn btn-navy\"  value=\"Save & Print\" onclick=\"SaveFeesBiMonthBill(\'" + regno + "\',\'" + academicId + "\',\'" + feesCatHeadId + "\',\'" + feesHeadAmt + "\',\'" + feesCatId + "\',\'" + feesMonthName + "\',\'" + feestotalAmount + "\');\" /></td> </tr>");
                feePOPUPContent.Append(@"<tr><td colspan='6' ></td></tr> </table>");
                feePOPUPContent.Append(@"<input type=""hidden"" id=""hdnMonthNum"" value='" + cmd.Parameters["@FeesMonth"].Value.ToString() + "'>");
                feePOPUPContent.Append(@"<input type=""hidden"" id=""hdnFeeType"" value=" + cmd.Parameters["@FeesType"].Value.ToString() + ">");

                //divBillContents.InnerHtml = feePOPUPContent.ToString();
            }
        }
        return feePOPUPContent.ToString();
    }

    public static string GetSecondContent(DataSet dsManageFees, SqlCommand cmd, string regno, string academicId)
    {
        StringBuilder feePOPUPStudentDetails = new StringBuilder();
        StringBuilder feePOPUPHeadDetails = new StringBuilder();
        StringBuilder feePOPUPContent = new StringBuilder();

        if (dsManageFees.Tables[2].Rows.Count > 0 && dsManageFees.Tables[0].Rows.Count > 0)
        {

            string feesCatHeadId = "";
            string feesHeadAmt = "";
            string feesCatId = string.Empty;
            string feesMonthName = string.Empty;
            string feestotalAmount = string.Empty;
            string paymentMode = string.Empty;

            if (cmd.Parameters["@FeesCatId"] != null)
                feesCatId = cmd.Parameters["@FeesCatId"].Value.ToString();

            if (cmd.Parameters["@FeesMonthName"] != null)
                feesMonthName = cmd.Parameters["@FeesMonthName"].Value.ToString();

            if (cmd.Parameters["@FeesTotalAmt"] != null)
                feestotalAmount = cmd.Parameters["@FeesTotalAmt"].Value.ToString();

            if (cmd.Parameters["@FeesMonth"].Value.ToString() != string.Empty)
            {
                DataRow[] PaidMonthRow = dsManageFees.Tables[0].Select("monthnum=" + cmd.Parameters["@FeesMonth"].Value.ToString());
                string PaidMonthName = "";

                string cashmode = "";
                string cardmode = "";

                if (PaidMonthRow.Length > 0)
                    PaidMonthName = PaidMonthRow[0]["monthname"].ToString();

                if (dsManageFees.Tables[dsManageFees.Tables.Count - 2].Rows.Count > 0)
                {
                    paymentMode = "<select id=\"selPaymentMode\"  onchange=\"bindpaymode(this);\" name=\"selPaymentMode\">";
                    for (int q = 0; q < dsManageFees.Tables[dsManageFees.Tables.Count - 2].Rows.Count; q++)
                    {

                        paymentMode += "<option value=\"" + dsManageFees.Tables[dsManageFees.Tables.Count - 2].Rows[q]["paymentmodeid"].ToString() + "\">" + dsManageFees.Tables[dsManageFees.Tables.Count - 2].Rows[q]["paymentmodename"].ToString() + "</option>";

                    }
                    paymentMode += "</select>";
                }



                feePOPUPStudentDetails.Append(@"<table width='700px' border='0' cellpadding='3'  cellspacing='0' class='popup-form' >
                                           <tr>
	                                          <td width='100' >Reg No</td>
	                                          <td width='10' >:</td>
	                                          <td width='250' ><label for='textfield2'>" + dsManageFees.Tables[2].Rows[0]["regno"].ToString() + "</label> </td>");
                feePOPUPStudentDetails.Append(@"<td width='100'>Date Of Paid</td>
	                                          <td width='10'>:</td>
	                                          <td width='250'><input type='text' name='txtBillDate' id='txtBillDate' class='ptxtbx ' /></td>
	                                          </tr>");
                feePOPUPStudentDetails.Append(@"<tr><td  height='30' >Name</td>
	                                          <td  >:</td>
	                                          <td  ><label for='textfield2'>" + dsManageFees.Tables[2].Rows[0]["stname"].ToString().ToUpper() + "</label></td>");
                if (cmd.Parameters["@isTerm"] != null && cmd.Parameters["@isTerm"].Value.ToString() == "1")
                {
                    DataRow[] monthtoterm = dsManageFees.Tables[dsManageFees.Tables.Count - 1].Select("fullmonth='" + PaidMonthName + "'");
                    feePOPUPStudentDetails.Append(@"<td  >Term </td>
	                                      <td  >:</td>
	                                      <td  ><label for='textfield2'>" + monthtoterm[0][4] + "</label></td></tr>");
                }
                else

                feePOPUPStudentDetails.Append(@"<td  >Month </td>
	                                      <td  >:</td>
	                                      <td  ><label for='textfield2'>" + PaidMonthName + "</label></td></tr>");


                feePOPUPStudentDetails.Append(@"<tr>
	                              <td height='30' >Class</td>
	                              <td >:</td>
	                              <td ><label for='textfield2'>" + dsManageFees.Tables[2].Rows[0]["classname"].ToString().ToUpper() + "</label></td>");
                feePOPUPStudentDetails.Append(@"<td height='30' >Section</td>
	                                      <td >:</td>
	                                      <td ><label for='textfield2'>" + dsManageFees.Tables[2].Rows[0]["sectionname"].ToString().ToUpper() + "</label></td></tr>");
                if (paymentMode != string.Empty)
                {
                    feePOPUPStudentDetails.Append(@"<tr><td >Payment Mode</td>
	                                          <td >:</td>
	                                          <td >" + paymentMode + "</td><td id=\"modes\" style='display: none;float: left;position: absolute;' colspan='3'>Cash: " + cashmode + "&nbsp;Card:" + cardmode + "</td></tr>");
                }
                feePOPUPStudentDetails.Append(@"</tr></table>");
                 

                if (dsManageFees.Tables[3].Rows.Count > 0 && dsManageFees.Tables[0].Rows.Count > 0)
                {

                    feePOPUPHeadDetails.Append(@" <table width='100%' border='0' cellspacing='0' cellpadding='5' class='popup-form'>
	                                          <tr class='tlb-trbg'><td width='79%' height='30' align='left' style='padding-left:10px;'>Heads</td><td width='21%' align='center'>Amount</td></tr>");
                    feePOPUPHeadDetails.Append(@"<tr><td colspan='2'><div class='' style='overflow:auto; height:120px; margin:10px 0px;width:100%;'>
                                                <table width='100%' border='0' cellspacing='0' cellpadding='0'>");

                    for (int k = 0; k < dsManageFees.Tables[3].Rows.Count; k++)
                    {
                        feesCatHeadId += dsManageFees.Tables[3].Rows[k]["feescatheadid"].ToString() + "|";
                        feesHeadAmt += dsManageFees.Tables[3].Rows[k]["amount"].ToString() + "|";
                        feePOPUPHeadDetails.Append(@"<tr><td height='30' class='tdbrd'> " + dsManageFees.Tables[3].Rows[k]["feesheadname"].ToString().ToUpper() + "</td>");
                        feePOPUPHeadDetails.Append(@"<td class='tdbrd amt-rgt'>" + dsManageFees.Tables[3].Rows[k]["amount"].ToString().ToUpper() + "</td></tr>");

                    }
                    feePOPUPHeadDetails.Append(@"</table></div></td></tr>");
                    feePOPUPHeadDetails.Append(@"<tr class='tlt-rs'><td height='30' class='tdbrd'>Total </td>
                                                    <td class='tdbrd'>Rs. " + cmd.Parameters["@FeesTotalAmt"].Value.ToString() + "</td></tr></table>");

                }

                feePOPUPContent.Append(@"<table width='650px' border='0' cellpadding='3'  cellspacing='0' class='popup-form tlt-mainbrd' style='border: 1px solid #bfbfbf; background-color:#fff;'>");
                feePOPUPContent.Append("<tr><td style='padding: 10px 10px 0px;float:right;'><a href='javascript:closeCreateBill()'>close</a></td></tr>");
                feePOPUPContent.Append("<tr><td  class='popup-form' style='padding:6px;'>" + feePOPUPStudentDetails.ToString() + "</td></tr>");

                feePOPUPContent.Append(@"<tr><td  class='popup-form' style='padding:6px;'>" + feePOPUPHeadDetails.ToString() + "</td></tr>");
                feePOPUPContent.Append("<tr><td style='text-align:center;' ><input id=\"btnSubmit\" type=\"button\" class=\"btn btn-navy\"  value=\"Save & Print\" onclick=\"SaveFeesBill(\'" + regno + "\',\'" + academicId + "\',\'" + feesCatHeadId + "\',\'" + feesHeadAmt + "\',\'" + feesCatId + "\',\'" + feesMonthName + "\',\'" + feestotalAmount + "\');\" /></td> </tr>");
                feePOPUPContent.Append(@"<tr><td colspan='6' ></td></tr> </table>");
                feePOPUPContent.Append(@"<input type=""hidden"" id=""hdnMonthNum"" value=" + cmd.Parameters["@FeesMonth"].Value.ToString() + ">");
                feePOPUPContent.Append(@"<input type=""hidden"" id=""hdnFeeType"" value=" + cmd.Parameters["@FeesType"].Value.ToString() + ">");

                //divBillContents.InnerHtml = feePOPUPContent.ToString();
            }
        }
        return feePOPUPContent.ToString();
    }


    [WebMethod]
    public static string SaveBiMonthBillDetails(string regNo, string AcademicId, string FeesHeadIds, string FeesAmount, string FeesCatId, string FeesMonthName, string FeestotalAmount, string BillDate, string userId, string PaymentMode, string MonthNum, string FeeType)
    {

        string[] MonthNumarr = MonthNum.Split(',');
        string[] FeesMonthNamearr = FeesMonthName.Split(',');
        
            Utilities utl = new Utilities();
            FeesHeadIds = FeesHeadIds.Substring(0, FeesHeadIds.Length - 1);
            FeesAmount = FeesAmount.Substring(0, FeesAmount.Length - 1);
            DataTable feemonth = (DataTable) HttpContext.Current.Session["feetab"];

            DataSet dsSaveBill=null;
          

            string[] feeHead = FeesHeadIds.Split('|');
            string[] feeAmount = FeesAmount.Split('|');
            string billrefno = "";
            for (int k = 0; k < MonthNumarr.Length; k++)
            {
                string subQuery = string.Empty;
                int i = 0;

                object obj = feemonth.Compute("sum(amount)", " monthnum='" + MonthNumarr[k] + "' ");
                string totamount = obj.ToString();
                DataRow[] rw = feemonth.Select("monthnum='" + MonthNumarr[k] + "' ");

                foreach (DataRow head in rw)
                {
                    subQuery += "INSERT INTO [dbo].[f_studentbills]([BillId],[FeesCatHeadId],[BillMonth],[Amount],[IsActive],[UserId])VALUES(''DummyBill''," + head["feescatheadid"].ToString() + ",''" + FeesMonthNamearr[k].ToString().Trim() + "''," + head["amount"].ToString() + ",''True''," + userId + ")";
                    i++;
                }

                if (BillDate == string.Empty)
                {
                    BillDate = DateTime.Now.ToString("dd/MM/yyyy");
                }

                string[] formats = { "dd/MM/yyyy" };
                string formatBillDate = DateTime.ParseExact(BillDate, formats, new CultureInfo("en-US"), DateTimeStyles.None).ToShortDateString();


                string query = "[SP_InsertBimonthFeesBill] '0000'," + AcademicId + "," + FeesCatId + "," + regNo + ",'" + FeesMonthNamearr[k].ToString().Trim() + "'," + totamount + ",'" + formatBillDate + "'," + userId + ",'" + subQuery + "'," + PaymentMode + ",'" + billrefno + "'";

                 dsSaveBill = utl.GetDataset(query);
                billrefno = dsSaveBill.Tables[0].Rows[0][0].ToString();
            }
            HttpContext.Current.Session["feetab"] = "";

            if (dsSaveBill != null && dsSaveBill.Tables.Count > 0 && dsSaveBill.Tables[0].Rows.Count > 0)
        {
            if (MonthNum.Trim() == "0, 1" && FeeType.ToUpper() == "ACADEMIC")
            {
                PrintBiMonthBill(dsSaveBill.Tables[0].Rows[0][0].ToString());
                PrintBiMonthSlip(dsSaveBill.Tables[0].Rows[0][0].ToString(), regNo, AcademicId);

            }
            else
                PrintBiMonthBill(dsSaveBill.Tables[0].Rows[0][0].ToString());
            return "Updated";
        }
        else
            return "Failed";
    }

    [WebMethod]
    public static string SaveBillDetails(string regNo, string AcademicId, string FeesHeadIds, string FeesAmount, string FeesCatId, string FeesMonthName, string FeestotalAmount, string BillDate, string userId, string PaymentMode, string MonthNum, string FeeType)
    {
        Utilities utl = new Utilities();
        FeesHeadIds = FeesHeadIds.Substring(0, FeesHeadIds.Length - 1);
        FeesAmount = FeesAmount.Substring(0, FeesAmount.Length - 1);
        string[] feeHead = FeesHeadIds.Split('|');
        string[] feeAmount = FeesAmount.Split('|');

        string subQuery = string.Empty;
        int i = 0;
        foreach (string head in feeHead)
        {
            subQuery += "INSERT INTO [dbo].[f_studentbills]([BillId],[FeesCatHeadId],[BillMonth],[Amount],[IsActive],[UserId])VALUES(''DummyBill''," + head + ",''" + FeesMonthName + "''," + feeAmount[i] + ",''True''," + userId + ")";
            i++;
        }

        if (BillDate == string.Empty)
        {
            BillDate = DateTime.Now.ToString("dd/MM/yyyy");
        }

        string[] formats = { "dd/MM/yyyy" };
        string formatBillDate = DateTime.ParseExact(BillDate, formats, new CultureInfo("en-US"), DateTimeStyles.None).ToShortDateString();

        string query = "[SP_InsertFeesBill] '0000'," + AcademicId + "," + FeesCatId + "," + regNo + ",'" + FeesMonthName + "'," + FeestotalAmount + ",'" + formatBillDate + "'," + userId + ",'" + subQuery + "'," + PaymentMode + "," + FeestotalAmount + "," + "0";

        DataSet dsSaveBill = utl.GetDataset(query);

        DataSet dsCCSlip = new DataSet();
        DataSet dsBBSlip = new DataSet();
        DataSet dsActSlip = new DataSet();
        if (dsSaveBill != null && dsSaveBill.Tables.Count > 0 && dsSaveBill.Tables[0].Rows.Count > 0)
        {
            if (MonthNum.Trim() == "0" && FeeType.ToUpper() == "ACADEMIC")
            {
                PrintBill(dsSaveBill.Tables[0].Rows[0][0].ToString());
                PrintSlip(dsSaveBill.Tables[0].Rows[0][0].ToString(), regNo, AcademicId);

                dsCCSlip = utl.GetDataset("select * from m_feescategoryhead a inner join vw_getstudent b on a.classID=b.classID and a.academicid=b.academicyear  and a.isactive=1 inner join m_feescategory c on c.FeesCategoryId=a.FeesCategoryId and b.Active=c.FeesCatCode  and c.IsActive=1 inner join f_studentbillmaster d on d.regno=b.regno and d.AcademicId=b.AcademicYear  and d.IsActive=1 inner join f_studentbills e on e.BillId=d.BillId and a.FeesCatHeadID=e.FeesCatHeadId and e.IsActive=1 inner join s_studentactivities f  on f.regno=b.regno and f.AcademicId=b.AcademicYear and f.ActId=a.FeesHeadId  and f.IsActive=1 inner join m_feeshead g on g.FeesHeadId=a.FeesHeadId and FeesHeadCode='CC' where b.regno=" + regNo + " and d.BillId='" + dsSaveBill.Tables[0].Rows[0][0].ToString() + "'");
                if (dsCCSlip != null && dsCCSlip.Tables.Count > 0 && dsCCSlip.Tables[0].Rows.Count > 0)
                {
                    PrintCricketSlip(dsCCSlip, regNo, AcademicId);
                }

                dsBBSlip = utl.GetDataset("select * from m_feescategoryhead a inner join vw_getstudent b on a.classID=b.classID and a.academicid=b.academicyear  and a.isactive=1 inner join m_feescategory c on c.FeesCategoryId=a.FeesCategoryId and b.Active=c.FeesCatCode  and c.IsActive=1 inner join f_studentbillmaster d on d.regno=b.regno and d.AcademicId=b.AcademicYear  and d.IsActive=1 inner join f_studentbills e on e.BillId=d.BillId and a.FeesCatHeadID=e.FeesCatHeadId and e.IsActive=1 inner join s_studentactivities f  on f.regno=b.regno and f.AcademicId=b.AcademicYear and f.ActId=a.FeesHeadId  and f.IsActive=1  inner join m_feeshead g on g.FeesHeadId=a.FeesHeadId and FeesHeadCode='BB' where b.regno=" + regNo + " and d.BillId='" + dsSaveBill.Tables[0].Rows[0][0].ToString() + "'");
                if (dsBBSlip != null && dsBBSlip.Tables.Count > 0 && dsBBSlip.Tables[0].Rows.Count > 0)
                {
                    PrintBadmintonSlip(dsBBSlip, regNo, AcademicId);
                }

                dsActSlip = utl.GetDataset("select * from m_feescategoryhead a inner join vw_getstudent b on a.classID=b.classID and a.academicid=b.academicyear  and a.isactive=1 inner join m_feescategory c on c.FeesCategoryId=a.FeesCategoryId and b.Active=c.FeesCatCode  and c.IsActive=1 inner join f_studentbillmaster d on d.regno=b.regno and d.AcademicId=b.AcademicYear  and d.IsActive=1 inner join f_studentbills e on e.BillId=d.BillId and a.FeesCatHeadID=e.FeesCatHeadId and e.IsActive=1 inner join s_studentactivities f  on f.regno=b.regno and f.AcademicId=b.AcademicYear and f.ActId=a.FeesHeadId  and f.IsActive=1  inner join m_feeshead g on g.FeesHeadId=a.FeesHeadId and FeesHeadCode in('F','S')  where  b.regno=" + regNo + " and d.BillId='" + dsSaveBill.Tables[0].Rows[0][0].ToString() + "'");
                if (dsActSlip != null && dsActSlip.Tables.Count > 0 && dsActSlip.Tables[0].Rows.Count > 0)
                {
                    PrintActivitySlip(dsActSlip, regNo, AcademicId);
                }
            }
            else
            {
                PrintBill(dsSaveBill.Tables[0].Rows[0][0].ToString());

                dsCCSlip = utl.GetDataset("select * from m_feescategoryhead a inner join vw_getstudent b on a.classID=b.classID and a.academicid=b.academicyear  and a.isactive=1 inner join m_feescategory c on c.FeesCategoryId=a.FeesCategoryId and b.Active=c.FeesCatCode  and c.IsActive=1 inner join f_studentbillmaster d on d.regno=b.regno and d.AcademicId=b.AcademicYear  and d.IsActive=1 inner join f_studentbills e on e.BillId=d.BillId and a.FeesCatHeadID=e.FeesCatHeadId and e.IsActive=1 inner join s_studentactivities f  on f.regno=b.regno and f.AcademicId=b.AcademicYear and f.ActId=a.FeesHeadId  and f.IsActive=1 inner join m_feeshead g on g.FeesHeadId=a.FeesHeadId and FeesHeadCode='CC' where b.regno=" + regNo + " and d.BillId='" + dsSaveBill.Tables[0].Rows[0][0].ToString() + "'");
                if (dsCCSlip != null && dsCCSlip.Tables.Count > 0 && dsCCSlip.Tables[0].Rows.Count > 0)
                {
                    PrintCricketSlip(dsCCSlip, regNo, AcademicId);
                }

                dsBBSlip = utl.GetDataset("select * from m_feescategoryhead a inner join vw_getstudent b on a.classID=b.classID and a.academicid=b.academicyear  and a.isactive=1 inner join m_feescategory c on c.FeesCategoryId=a.FeesCategoryId and b.Active=c.FeesCatCode  and c.IsActive=1 inner join f_studentbillmaster d on d.regno=b.regno and d.AcademicId=b.AcademicYear  and d.IsActive=1 inner join f_studentbills e on e.BillId=d.BillId and a.FeesCatHeadID=e.FeesCatHeadId and e.IsActive=1 inner join s_studentactivities f  on f.regno=b.regno and f.AcademicId=b.AcademicYear and f.ActId=a.FeesHeadId  and f.IsActive=1  inner join m_feeshead g on g.FeesHeadId=a.FeesHeadId and FeesHeadCode='BB' where b.regno=" + regNo + " and d.BillId='" + dsSaveBill.Tables[0].Rows[0][0].ToString() + "'");
                if (dsBBSlip != null && dsBBSlip.Tables.Count > 0 && dsBBSlip.Tables[0].Rows.Count > 0)
                {
                    //PrintBadmintonSlip(dsBBSlip, regNo, AcademicId);
                }

                dsActSlip = utl.GetDataset("select * from m_feescategoryhead a inner join vw_getstudent b on a.classID=b.classID and a.academicid=b.academicyear  and a.isactive=1 inner join m_feescategory c on c.FeesCategoryId=a.FeesCategoryId and b.Active=c.FeesCatCode  and c.IsActive=1 inner join f_studentbillmaster d on d.regno=b.regno and d.AcademicId=b.AcademicYear  and d.IsActive=1 inner join f_studentbills e on e.BillId=d.BillId and a.FeesCatHeadID=e.FeesCatHeadId and e.IsActive=1 inner join s_studentactivities f  on f.regno=b.regno and f.AcademicId=b.AcademicYear and f.ActId=a.FeesHeadId  and f.IsActive=1  inner join m_feeshead g on g.FeesHeadId=a.FeesHeadId and FeesHeadCode in('F','S')  where  b.regno=" + regNo + " and d.BillId='" + dsSaveBill.Tables[0].Rows[0][0].ToString() + "'");
                if (dsActSlip != null && dsActSlip.Tables.Count > 0 && dsActSlip.Tables[0].Rows.Count > 0)
                {
                    //PrintActivitySlip(dsActSlip, regNo, AcademicId);
                } 
            }

            return "Updated";
        }
        else
            return "Failed";
    }

    public static void PrintActivitySlip(DataSet Bill, string regNo, string AcademicId)
    {
        try
        {
            string BillId = "";
            PrintDocument fd = new PrintDocument();
            Utilities utl = new Utilities();
            string SlipType = string.Empty;
            string query = "[sp_PrintSlip] " + Bill.Tables[0].Rows[0]["BillId"].ToString();
            DataSet dsPrint = utl.GetDataset(query);
            string printerName = ConfigurationManager.AppSettings["FeesPrinter"];
            string clientMachineName, clientIPAddress;
            //  clientMachineName = (Dns.GetHostEntry(Request.ServerVariables["remote_addr"]).HostName);
            clientIPAddress = HttpContext.Current.Request.ServerVariables["remote_addr"];
            int yPos = 0;
            int headCount = 0;
            if (dsPrint != null && dsPrint.Tables.Count > 1 && dsPrint.Tables[0].Rows.Count > 0 && Bill.Tables[0].Rows[0]["BillId"].ToString() != string.Empty)
            {

                for (int i = 0; i < 2; i++)
                {

                    StringBuilder str = new StringBuilder();
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

                    str.Append(dsPrint.Tables[0].Rows[0]["SchoolShortName"].ToString().ToUpper() + " \r\n  " + dsPrint.Tables[0].Rows[0]["Schoolstate"].ToString().ToUpper() + " - " + dsPrint.Tables[0].Rows[0]["SchoolZip"].ToString() + "PHONE NO - " + dsPrint.Tables[0].Rows[0]["phoneno"].ToString().ToUpper() + "\r\n");



                    fd.PrintPage += (s, args) =>
                    {

                        if (dsPrint.Tables[0].Rows.Count > 0)
                        {
                            args.Graphics.DrawString(dsPrint.Tables[0].Rows[0]["SchoolShortName"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 0, 250, 25), stringAlignCenter);
                            args.Graphics.DrawString(dsPrint.Tables[0].Rows[0]["Schoolstate"].ToString().ToUpper() + "-" + dsPrint.Tables[0].Rows[0]["SchoolZip"].ToString() + " PHONE NO-" + dsPrint.Tables[0].Rows[0]["phoneno"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 8, FontStyle.Regular), Brushes.Black, new Rectangle(0, 20, 250, 25), stringAlignCenter);

                            args.Graphics.DrawLine(new Pen(Color.Black, 2), 0, 45, 500, 45);

                            args.Graphics.DrawString("Amalorpavam Educational Welfare Society", new System.Drawing.Font("ARIAL", 9, FontStyle.Underline), Brushes.Black, new Rectangle(0, 40, 250, 50), stringAlignCenter);


                            args.Graphics.DrawString("Bill No : " + dsPrint.Tables[1].Rows[0]["BillNo"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 80, 120, 50), stringAlignLeft);
                            args.Graphics.DrawString("Date : " + dsPrint.Tables[1].Rows[0]["BillDate"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(135, 80, 130, 50), stringAlignRight);

                            args.Graphics.DrawString("Name ", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 105, 90, 50), stringAlignLeft);
                            args.Graphics.DrawString(":", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(120, 105, 20, 50), stringAlignLeft);
                            args.Graphics.DrawString(dsPrint.Tables[1].Rows[0]["stname"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 8, FontStyle.Regular), Brushes.Black, new Rectangle(135, 105, 140, 50), stringAlignLeft);

                            args.Graphics.DrawString("Register No", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 125, 90, 50), stringAlignLeft);
                            args.Graphics.DrawString(":", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(120, 125, 20, 50), stringAlignLeft);
                            args.Graphics.DrawString(dsPrint.Tables[1].Rows[0]["regno"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(135, 125, 140, 50), stringAlignLeft);

                            args.Graphics.DrawString("Class", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 150, 90, 50), stringAlignLeft);
                            args.Graphics.DrawString(":", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(120, 150, 20, 50), stringAlignLeft);
                            args.Graphics.DrawString(dsPrint.Tables[1].Rows[0]["classname"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(135, 150, 140, 50), stringAlignLeft);

                            args.Graphics.DrawString("Section", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 175, 90, 50), stringAlignLeft);
                            args.Graphics.DrawString(":", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(120, 175, 20, 50), stringAlignLeft);
                            args.Graphics.DrawString(dsPrint.Tables[1].Rows[0]["sectionname"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(135, 175, 140, 50), stringAlignLeft);

                            args.Graphics.DrawString("PARTICULARS", new System.Drawing.Font("ARIAL", 8, FontStyle.Regular), Brushes.Black, new Rectangle(0, 135, 180, 50), stringAlignCenter);
                            args.Graphics.DrawString("AMOUNT ", new System.Drawing.Font("ARIAL", 8, FontStyle.Regular), Brushes.Black, new Rectangle(180, 135, 70, 50), stringAlignCenter);
                            if (Bill.Tables[0].Rows.Count > 0)
                            {
                                yPos = 158;

                                for (int k = 0; k < Bill.Tables[0].Rows.Count; k++, yPos += 25, headCount += 1)
                                {
                                    args.Graphics.DrawString(Bill.Tables[0].Rows[k]["FeesHeadName"].ToString(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(5, yPos, 180, 50), stringAlignLeft);
                                    args.Graphics.DrawString(Bill.Tables[0].Rows[k]["Amount"].ToString(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(165, yPos, 70, 50), stringAlignRight);
                                }
                            }

                            args.Graphics.DrawString("TOTAL", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, yPos + 8, 180, 50), stringAlignRight);
                            args.Graphics.DrawString(Bill.Tables[0].Rows[0]["TotalAmount"].ToString(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(165, yPos + 8, 70, 50), stringAlignRight);

                            args.Graphics.DrawString("Cashier", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 205, 250, 50), stringAlignRight);


                            args.Graphics.DrawString("Delivery Date : ", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 205, 110, 50), stringAlignLeft);

                            Pen pen = new Pen(Color.Black, 1);
                            pen.DashStyle = System.Drawing.Drawing2D.DashStyle.Dot;
                            args.Graphics.DrawLine(pen, 0, 215, 500, 215);

                            //args.Graphics.DrawLine(new Pen(Color.Black, 2), 0, 215, 500, 215);


                            args.Graphics.DrawString("Delivered", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(120, 255, 130, 50), stringAlignRight);

                            Pen pen1 = new Pen(Color.Black, 1);
                            pen1.DashStyle = System.Drawing.Drawing2D.DashStyle.Dot;
                            args.Graphics.DrawLine(pen1, 0, 290, 500, 290);

                            //args.Graphics.DrawLine(new Pen(Color.Black, 2), 0, 290, 500, 290);
                        }

                    };
                    // clientIPAddress = "192.168.0.43";
                    fd.PrinterSettings.PrinterName = "\\\\" + clientIPAddress + "\\" + printerName + "";
                    fd.Print();
                }
            }
            fd.Dispose();
            GC.SuppressFinalize(fd);
        }
        catch (Exception err)
        {

        }

        finally { GC.Collect(); GC.WaitForPendingFinalizers(); }

    }

    public static void PrintBadmintonSlip(DataSet Bill, string regNo, string AcademicId)
    {
        try
        {
            string BillId = "";
            PrintDocument fd = new PrintDocument();
            Utilities utl = new Utilities();
            string SlipType = string.Empty;
            string query = "[sp_PrintSlip] " + Bill.Tables[0].Rows[0]["BillId"].ToString();
            DataSet dsPrint = utl.GetDataset(query);
            string printerName = ConfigurationManager.AppSettings["FeesPrinter"];
            string clientMachineName, clientIPAddress;
            //  clientMachineName = (Dns.GetHostEntry(Request.ServerVariables["remote_addr"]).HostName);
            clientIPAddress = HttpContext.Current.Request.ServerVariables["remote_addr"];
            int yPos = 0;
            int headCount = 0;
            if (dsPrint != null && dsPrint.Tables.Count > 1 && dsPrint.Tables[0].Rows.Count > 0 && Bill.Tables[0].Rows[0]["BillId"].ToString() != string.Empty)
            {

                for (int i = 0; i < 2; i++)
                {

                    StringBuilder str = new StringBuilder();
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

                    str.Append(dsPrint.Tables[0].Rows[0]["SchoolShortName"].ToString().ToUpper() + " \r\n  " + dsPrint.Tables[0].Rows[0]["Schoolstate"].ToString().ToUpper() + " - " + dsPrint.Tables[0].Rows[0]["SchoolZip"].ToString() + "PHONE NO - " + dsPrint.Tables[0].Rows[0]["phoneno"].ToString().ToUpper() + "\r\n");



                    fd.PrintPage += (s, args) =>
                    {

                        if (dsPrint.Tables[0].Rows.Count > 0)
                        {
                            args.Graphics.DrawString(dsPrint.Tables[0].Rows[0]["SchoolShortName"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 0, 250, 25), stringAlignCenter);
                            args.Graphics.DrawString(dsPrint.Tables[0].Rows[0]["Schoolstate"].ToString().ToUpper() + "-" + dsPrint.Tables[0].Rows[0]["SchoolZip"].ToString() + " PHONE NO-" + dsPrint.Tables[0].Rows[0]["phoneno"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 8, FontStyle.Regular), Brushes.Black, new Rectangle(0, 20, 250, 25), stringAlignCenter);

                            args.Graphics.DrawLine(new Pen(Color.Black, 2), 0, 45, 500, 45);

                            
                            args.Graphics.DrawString("Ave Maria Badminton Academy", new System.Drawing.Font("ARIAL", 9, FontStyle.Underline), Brushes.Black, new Rectangle(0, 40, 250, 50), stringAlignCenter);


                            args.Graphics.DrawString("Bill No : " + dsPrint.Tables[1].Rows[0]["BillNo"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 80, 120, 50), stringAlignLeft);
                            args.Graphics.DrawString("Date : " + dsPrint.Tables[1].Rows[0]["BillDate"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(135, 80, 130, 50), stringAlignRight);

                            args.Graphics.DrawString("Name ", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 105, 90, 50), stringAlignLeft);
                            args.Graphics.DrawString(":", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(120, 105, 20, 50), stringAlignLeft);
                            args.Graphics.DrawString(dsPrint.Tables[1].Rows[0]["stname"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 8, FontStyle.Regular), Brushes.Black, new Rectangle(135, 105, 140, 50), stringAlignLeft);

                            args.Graphics.DrawString("Register No", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 125, 90, 50), stringAlignLeft);
                            args.Graphics.DrawString(":", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(120, 125, 20, 50), stringAlignLeft);
                            args.Graphics.DrawString(dsPrint.Tables[1].Rows[0]["regno"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(135, 125, 140, 50), stringAlignLeft);

                            args.Graphics.DrawString("Class", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 150, 90, 50), stringAlignLeft);
                            args.Graphics.DrawString(":", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(120, 150, 20, 50), stringAlignLeft);
                            args.Graphics.DrawString(dsPrint.Tables[1].Rows[0]["classname"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(135, 150, 140, 50), stringAlignLeft);

                            args.Graphics.DrawString("Section", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 175, 90, 50), stringAlignLeft);
                            args.Graphics.DrawString(":", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(120, 175, 20, 50), stringAlignLeft);
                            args.Graphics.DrawString(dsPrint.Tables[1].Rows[0]["sectionname"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(135, 175, 140, 50), stringAlignLeft);

                            args.Graphics.DrawString("PARTICULARS", new System.Drawing.Font("ARIAL", 8, FontStyle.Regular), Brushes.Black, new Rectangle(0, 135, 180, 50), stringAlignCenter);
                            args.Graphics.DrawString("AMOUNT ", new System.Drawing.Font("ARIAL", 8, FontStyle.Regular), Brushes.Black, new Rectangle(180, 135, 70, 50), stringAlignCenter);
                            if (Bill.Tables[0].Rows.Count > 0)
                            {
                                yPos = 158;

                                for (int k = 0; k < Bill.Tables[0].Rows.Count; k++, yPos += 25, headCount += 1)
                                {
                                    args.Graphics.DrawString(Bill.Tables[0].Rows[k]["FeesHeadName"].ToString(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(5, yPos, 180, 50), stringAlignLeft);
                                    args.Graphics.DrawString(Bill.Tables[0].Rows[k]["Amount"].ToString(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(165, yPos, 70, 50), stringAlignRight);
                                }
                            }

                            args.Graphics.DrawString("TOTAL", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, yPos + 8, 180, 50), stringAlignRight);
                            args.Graphics.DrawString(Bill.Tables[0].Rows[0]["TotalAmount"].ToString(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(165, yPos + 8, 70, 50), stringAlignRight);

                            args.Graphics.DrawString("Cashier", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 205, 250, 50), stringAlignRight);


                            args.Graphics.DrawString("Delivery Date : ", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 205, 110, 50), stringAlignLeft);

                            Pen pen = new Pen(Color.Black, 1);
                            pen.DashStyle = System.Drawing.Drawing2D.DashStyle.Dot;
                            args.Graphics.DrawLine(pen, 0, 215, 500, 215);

                            //args.Graphics.DrawLine(new Pen(Color.Black, 2), 0, 215, 500, 215);


                            args.Graphics.DrawString("Delivered", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(120, 255, 130, 50), stringAlignRight);

                            Pen pen1 = new Pen(Color.Black, 1);
                            pen1.DashStyle = System.Drawing.Drawing2D.DashStyle.Dot;
                            args.Graphics.DrawLine(pen1, 0, 290, 500, 290);

                            //args.Graphics.DrawLine(new Pen(Color.Black, 2), 0, 290, 500, 290);
                        }

                    };
                    // clientIPAddress = "192.168.0.43";
                    fd.PrinterSettings.PrinterName = "\\\\" + clientIPAddress + "\\" + printerName + "";
                    fd.Print();
                }
            }
            fd.Dispose();
            GC.SuppressFinalize(fd);
        }
        catch (Exception err)
        {

        }

        finally { GC.Collect(); GC.WaitForPendingFinalizers(); }

    }

    public static void PrintCricketSlip(DataSet Bill, string regNo, string AcademicId)
    {
        try
        {
            string BillId = ""; ;
            PrintDocument fd = new PrintDocument();
            Utilities utl = new Utilities();
            string SlipType = string.Empty;
            string query = "[sp_PrintSlip] " + Bill.Tables[0].Rows[0]["BillId"].ToString();
            DataSet dsPrint = utl.GetDataset(query);
            string printerName = ConfigurationManager.AppSettings["FeesPrinter"];
            string clientMachineName, clientIPAddress;
            //  clientMachineName = (Dns.GetHostEntry(Request.ServerVariables["remote_addr"]).HostName);
            clientIPAddress = HttpContext.Current.Request.ServerVariables["remote_addr"];

          
            int yPos = 0;
            int headCount = 0;
            if (dsPrint != null && dsPrint.Tables.Count > 1 && dsPrint.Tables[0].Rows.Count > 0 && Bill.Tables[0].Rows[0]["BillId"].ToString() != string.Empty)
            {

                    StringBuilder str = new StringBuilder();
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

                    str.Append(dsPrint.Tables[0].Rows[0]["SchoolShortName"].ToString().ToUpper() + " \r\n  " + dsPrint.Tables[0].Rows[0]["Schoolstate"].ToString().ToUpper() + " - " + dsPrint.Tables[0].Rows[0]["SchoolZip"].ToString() + "PHONE NO - " + dsPrint.Tables[0].Rows[0]["phoneno"].ToString().ToUpper() + "\r\n");


                    fd.PrintPage += (s, args) =>
                    {

                        if (dsPrint.Tables[0].Rows.Count > 0)
                        {
                            args.Graphics.DrawString(dsPrint.Tables[0].Rows[0]["SchoolShortName"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 0, 250, 25), stringAlignCenter);
                            args.Graphics.DrawString(dsPrint.Tables[0].Rows[0]["Schoolstate"].ToString().ToUpper() + "-" + dsPrint.Tables[0].Rows[0]["SchoolZip"].ToString() + " PHONE NO-" + dsPrint.Tables[0].Rows[0]["phoneno"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 8, FontStyle.Regular), Brushes.Black, new Rectangle(0, 20, 250, 25), stringAlignCenter);

                            args.Graphics.DrawLine(new Pen(Color.Black, 2), 0, 42, 500, 42);

                            args.Graphics.DrawString("Ave Maria Badminton Academy", new System.Drawing.Font("ARIAL", 9, FontStyle.Underline), Brushes.Black, new Rectangle(0, 40, 250, 50), stringAlignCenter);

                            args.Graphics.DrawString("Reg.No : " + Bill.Tables[0].Rows[0]["RegNo"].ToString(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 45, 150, 50), stringAlignLeft);
                            args.Graphics.DrawString("Rec.No : " + Bill.Tables[0].Rows[0]["BillNo"].ToString(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(120, 45, 120, 50), stringAlignRight);
                            args.Graphics.DrawString("Name 	:  " + Bill.Tables[0].Rows[0]["studentname"].ToString(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 70, 250, 50), stringAlignLeft);
                            args.Graphics.DrawString("Class & Section : 	" + Bill.Tables[0].Rows[0]["class"].ToString() + "  " + Bill.Tables[0].Rows[0]["section"].ToString(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 95, 150, 50), stringAlignLeft);
                            args.Graphics.DrawString(" Month 	: 	" + Bill.Tables[0].Rows[0]["BillMonth"].ToString(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(120, 95, 120, 50), stringAlignRight);
                            args.Graphics.DrawString("PARTICULARS", new System.Drawing.Font("ARIAL", 8, FontStyle.Regular), Brushes.Black, new Rectangle(0, 135, 180, 50), stringAlignCenter);
                            args.Graphics.DrawString("AMOUNT ", new System.Drawing.Font("ARIAL", 8, FontStyle.Regular), Brushes.Black, new Rectangle(180, 135, 70, 50), stringAlignCenter);
                            if (Bill.Tables[0].Rows.Count > 0)
                            {
                                yPos = 158;

                                for (int i = 0; i < Bill.Tables[0].Rows.Count; i++, yPos += 25, headCount += 1)
                                {
                                    args.Graphics.DrawString(Bill.Tables[0].Rows[i]["FeesHeadName"].ToString(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(5, yPos, 250, 50), stringAlignLeft);
                                    args.Graphics.DrawString(Bill.Tables[0].Rows[i]["Amount"].ToString(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(165, yPos, 250, 50), stringAlignRight);
                                }
                            }

                            args.Graphics.DrawString("TOTAL", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, yPos + 8, 180, 50), stringAlignRight);
                            args.Graphics.DrawString(Bill.Tables[0].Rows[0]["TotalAmount"].ToString(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(165, yPos + 8, 70, 50), stringAlignRight);


                            args.Graphics.DrawString("Date : " + dsPrint.Tables[0].Rows[0]["BillDate"].ToString(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, yPos + 40, 250, 50), stringAlignLeft);
                            args.Graphics.DrawString("Cashier : " + dsPrint.Tables[0].Rows[0]["staffname"].ToString(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, yPos + 40, 250, 150), stringAlignLeft);

                            //args.Graphics.DrawRectangle(new Pen(Color.Black, 1), 0, 145, 180, 25);
                            //args.Graphics.DrawRectangle(new Pen(Color.Black, 1), 180, 145, 68, 25);

                            Pen pen = new Pen(Color.Black, 1);
                            pen.DashStyle = System.Drawing.Drawing2D.DashStyle.Dot;
                            args.Graphics.DrawRectangle(pen, 0, 145, 180, 25);

                            Pen pen0 = new Pen(Color.Black, 1);
                            pen0.DashStyle = System.Drawing.Drawing2D.DashStyle.Dot;
                            args.Graphics.DrawRectangle(pen0, 180, 145, 68, 25);

                            Pen pen1 = new Pen(Color.Black, 1);
                            pen1.DashStyle = System.Drawing.Drawing2D.DashStyle.Dot;
                            args.Graphics.DrawRectangle(pen1, 0, 170, 180, 25 * headCount);

                            Pen pen2 = new Pen(Color.Black, 1);
                            pen2.DashStyle = System.Drawing.Drawing2D.DashStyle.Dot;
                            args.Graphics.DrawRectangle(pen2, 180, 170, 68, 25 * headCount);

                            Pen pen3 = new Pen(Color.Black, 1);
                            pen3.DashStyle = System.Drawing.Drawing2D.DashStyle.Dot;
                            args.Graphics.DrawRectangle(pen3, 0, yPos + 12, 180, 35);

                            Pen pen4 = new Pen(Color.Black, 1);
                            pen4.DashStyle = System.Drawing.Drawing2D.DashStyle.Dot;
                            args.Graphics.DrawRectangle(pen4, 180, yPos + 12, 68, 35);
                        }

                    };
                    // clientIPAddress = "192.168.0.43";
                    fd.PrinterSettings.PrinterName = "\\\\" + clientIPAddress + "\\" + printerName + "";
                    fd.Print();
                
            }
            fd.Dispose();
            GC.SuppressFinalize(fd);
        }
        catch (Exception err)
        {

        }

        finally { GC.Collect(); GC.WaitForPendingFinalizers(); }

    }

    [WebMethod]
    public static string UpdateBiMonthBillDetails(string BillId, string AcademicId, string FeesHeadIds, string FeesAmount, string FeesCatId, string FeesMonthName, string FeestotalAmount, string BillDate, string userId, string PaymentMode, string MonthNum, string FeeType)
    {

        string[] MonthNumarr = MonthNum.Split(',');
        string[] FeesMonthNamearr = FeesMonthName.Split(',');
        for (int k = 0; k < MonthNumarr.Length; k++)
        {
            Utilities utl = new Utilities();
            FeesHeadIds = FeesHeadIds.Substring(0, FeesHeadIds.Length - 1);
            FeesAmount = FeesAmount.Substring(0, FeesAmount.Length - 1);
            string[] feeHead = FeesHeadIds.Split('|');
            string[] feeAmount = FeesAmount.Split('|');

            string subQuery = string.Empty;
            int i = 0;
            foreach (string head in feeHead)
            {
                subQuery += "INSERT INTO [dbo].[f_studentbills]([BillId],[FeesCatHeadId],[BillMonth],[Amount],[IsActive],[UserId])VALUES(''DummyBill''," + head + ",''" + FeesMonthNamearr[i] + "''," + (Convert.ToDecimal(feeAmount[i]) / 2).ToString() + ",''True''," + userId + ")";
                i++;
            }

            if (BillDate == string.Empty)
            {
                BillDate = DateTime.Now.ToString("dd/MM/yyyy");
            }

            string[] formats = { "dd/MM/yyyy" };
            string formatBillDate = DateTime.ParseExact(BillDate, formats, new CultureInfo("en-US"), DateTimeStyles.None).ToShortDateString();

            string query = "[SP_UpdateFeesBill] '0000'," + AcademicId + "," + FeesCatId + "," + BillId + ",'" + FeesMonthName + "'," + FeestotalAmount + ",'" + formatBillDate + "'," + userId + ",'" + subQuery + "'," + PaymentMode;
            DataSet dsSaveBill = utl.GetDataset(query);
        }

        return "";
        //if (dsSaveBill != null && dsSaveBill.Tables.Count > 0 && dsSaveBill.Tables[0].Rows.Count > 0)
        //{
        //    if (MonthNum.Trim() == "0" && FeeType.ToUpper() == "ACADEMIC")
        //    {
        //        PrintBill(dsSaveBill.Tables[0].Rows[0][0].ToString());
        //        PrintSlip(dsSaveBill.Tables[0].Rows[0][0].ToString(), regNo, AcademicId);

        //    }
        //    else
        //        PrintBill(dsSaveBill.Tables[0].Rows[0][0].ToString());
        //    return "Updated";
        //}
        //else
        //    return "Failed";
    }

    [WebMethod]
    public static string UpdateBillDetails(string BillId, string AcademicId, string FeesHeadIds, string FeesAmount, string FeesCatId, string FeesMonthName, string FeestotalAmount, string BillDate, string userId, string PaymentMode, string MonthNum, string FeeType)
    {
        Utilities utl = new Utilities();
        FeesHeadIds = FeesHeadIds.Substring(0, FeesHeadIds.Length - 1);
        FeesAmount = FeesAmount.Substring(0, FeesAmount.Length - 1);
        string[] feeHead = FeesHeadIds.Split('|');
        string[] feeAmount = FeesAmount.Split('|');

        string subQuery = string.Empty;
        int i = 0;
        foreach (string head in feeHead)
        {
            subQuery += "INSERT INTO [dbo].[f_studentbills]([BillId],[FeesCatHeadId],[BillMonth],[Amount],[IsActive],[UserId])VALUES("+BillId+","+ head + ",''" + FeesMonthName + "''," + feeAmount[i] + ",''True''," + userId + ")";
            i++;
        }

        if (BillDate == string.Empty)
        {
            BillDate = DateTime.Now.ToString("dd/MM/yyyy");
        }

        string[] formats = { "dd/MM/yyyy" };
        string formatBillDate = DateTime.ParseExact(BillDate, formats, new CultureInfo("en-US"), DateTimeStyles.None).ToShortDateString();

        string query = "[SP_UpdateFeesBill] '0000'," + AcademicId + "," + FeesCatId + "," + BillId + ",'" + FeesMonthName + "'," + FeestotalAmount + ",'" + formatBillDate + "'," + userId + ",'" + subQuery + "'," + PaymentMode + "," + FeestotalAmount + "," + "0";

        DataSet dsSaveBill = utl.GetDataset(query);

        if (dsSaveBill != null && dsSaveBill.Tables.Count > 0 && dsSaveBill.Tables[0].Rows.Count > 0)
        {
                PrintBill(dsSaveBill.Tables[0].Rows[0][0].ToString());
            return "Updated";
        }
        else
            return "Failed";
    }

    [WebMethod]
    public static string ViewBiMonthBillDetails(string billId)
    {
        Utilities utl = new Utilities();
        string sqlstr = "select isactive from m_academicyear where AcademicID='" + HttpContext.Current.Session["AcademicID"].ToString() + "'";
        string Isactive = utl.ExecuteScalar(sqlstr);
        HttpContext.Current.Session["Isactive"] = Isactive.ToString();
        string query = "";
        DataSet dsStud = new DataSet();
        if (Isactive == "True")
        {
            query = "[sp_GetStudentBiMonthBill] " + billId + "";
        }
        else
        {
            query = "[sp_GetOldStudentBill] " + billId + ",'" + HttpContext.Current.Session["AcademicID"] + "'";
        }


        DataSet ds = utl.GetDataset(query);
        return ds.GetXml();
    }


    [WebMethod]
    public static string ViewBillDetails(string billId)
    {
        Utilities utl = new Utilities();
        string sqlstr = "select isactive from m_academicyear where AcademicID='" + HttpContext.Current.Session["AcademicID"].ToString() + "'";
        string Isactive = utl.ExecuteScalar(sqlstr);
        HttpContext.Current.Session["Isactive"] = Isactive.ToString();
        string query = "";
        DataSet dsStud = new DataSet();
        if (Isactive == "True")
        {
            query = "[sp_GetStudentBill] " + billId + "";
        }
        else
        {
            query = "[sp_GetOldStudentBill] " + billId + ",'" + HttpContext.Current.Session["AcademicID"] + "'";
        }

        
        DataSet ds = utl.GetDataset(query);
        return ds.GetXml();
    }

    [WebMethod]
    public static string BindStudDetails(string regNo, string academicId)
    {
        Utilities utl = new Utilities();

        string sqlstr = "select isactive from m_academicyear where AcademicID='" + HttpContext.Current.Session["AcademicID"].ToString() + "'";
        string Isactive = utl.ExecuteScalar(sqlstr);
        HttpContext.Current.Session["Isactive"] = Isactive.ToString();
        string query = "";
        DataSet dsStud = new DataSet();
        if (Isactive == "True")
        {
            dsStud = utl.GetDataset("sp_getStudentDetails " + regNo + "," + academicId);
        }
        else
        {
            dsStud = utl.GetDataset("sp_getOldStudentDetails " + regNo + "," + academicId);
        }
        return dsStud.GetXml();
    }

    [WebMethod]
    public static string DeleteBill(string billId)
    {
        Utilities utl = new Utilities();
        string query = "[SP_DeleteStudentBill] " + billId + "";
        string strError = string.Empty;
        strError = utl.ExecuteQuery(query);
        return strError;
    }

    [WebMethod]
    public static string PrintBillDetails(string billId)
    {
        PrintBill(billId);
        return "";
    }
    [WebMethod]
    public static string PrintBiMonthBillDetails(string billId)
    {
        PrintBiMonthBill(billId);
        return "";
    }
    public static void PrintBill(string billId)
    {
        try
        {
            PrintDocument fd = new PrintDocument();
            Utilities utl = new Utilities();
            string sqlstr = "select isactive from m_academicyear where AcademicID='" + HttpContext.Current.Session["AcademicID"].ToString() + "'";
            string Isactive = utl.ExecuteScalar(sqlstr);
            HttpContext.Current.Session["Isactive"] = Isactive.ToString();
            string query = "";
            DataSet dsStud = new DataSet();
            if (Isactive == "True")
            {
                query = "[sp_GetStudentBill] " + billId + "";
            }
            else
            {
                query = "[sp_GetOldStudentBill] " + billId + ",'" + HttpContext.Current.Session["AcademicID"] + "'";
            }

            DataSet dsPrint = utl.GetDataset(query);
            int yPos = 0;
            int headCount = 0;
            string printerName = ConfigurationManager.AppSettings["FeesPrinter"];
            string clientMachineName, clientIPAddress;
            //  clientMachineName = (Dns.GetHostEntry(Request.ServerVariables["remote_addr"]).HostName);
            clientIPAddress = HttpContext.Current.Request.ServerVariables["remote_addr"];

            if (dsPrint.Tables.Count > 1 && dsPrint.Tables[0].Rows.Count > 0)
            {
                StringBuilder str = new StringBuilder();
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



                fd.PrintPage += (s, args) =>
                {

                    if (dsPrint.Tables[0].Rows.Count > 0)
                    {
                        args.Graphics.DrawString(dsPrint.Tables[2].Rows[0]["SchoolShortName"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 0, 250, 25), stringAlignCenter);
                        args.Graphics.DrawString(dsPrint.Tables[2].Rows[0]["Schoolstate"].ToString().ToUpper() + "-" + dsPrint.Tables[2].Rows[0]["SchoolZip"].ToString() + " PHONE NO-" + dsPrint.Tables[2].Rows[0]["phoneno"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 8, FontStyle.Regular), Brushes.Black, new Rectangle(0, 20, 250, 25), stringAlignCenter);

                        args.Graphics.DrawLine(new Pen(Color.Black, 2), 0, 42, 500, 42);
                        args.Graphics.DrawString("Reg.No : " + dsPrint.Tables[0].Rows[0]["RegNo"].ToString(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 45, 150, 50), stringAlignLeft);
                        args.Graphics.DrawString("Rec.No : " + dsPrint.Tables[0].Rows[0]["BillNo"].ToString(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(120, 45, 120, 50), stringAlignRight);
                        args.Graphics.DrawString("Name 	:  " + dsPrint.Tables[0].Rows[0]["stname"].ToString(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 70, 250, 50), stringAlignLeft);
                        args.Graphics.DrawString("Class & Section : 	" + dsPrint.Tables[0].Rows[0]["classname"].ToString() + "  " + dsPrint.Tables[0].Rows[0]["sectionname"].ToString(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 95, 150, 50), stringAlignLeft);
                        args.Graphics.DrawString(" Month 	: 	" + dsPrint.Tables[0].Rows[0]["BillMonth"].ToString(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(120, 95, 120, 50), stringAlignRight);
                        args.Graphics.DrawString("PARTICULARS", new System.Drawing.Font("ARIAL", 8, FontStyle.Regular), Brushes.Black, new Rectangle(0, 135, 180, 50), stringAlignCenter);
                        args.Graphics.DrawString("AMOUNT ", new System.Drawing.Font("ARIAL", 8, FontStyle.Regular), Brushes.Black, new Rectangle(180, 135, 70, 50), stringAlignCenter);
                        if (dsPrint.Tables[1].Rows.Count > 0)
                        {
                            yPos = 158;

                            for (int i = 0; i < dsPrint.Tables[1].Rows.Count; i++, yPos += 25, headCount += 1)
                            {
                                args.Graphics.DrawString(dsPrint.Tables[1].Rows[i]["FeesHeadName"].ToString(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(5, yPos, 180, 50), stringAlignLeft);
                                args.Graphics.DrawString(dsPrint.Tables[1].Rows[i]["Amount"].ToString(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(165, yPos, 70, 50), stringAlignRight);
                            }
                        }

                        args.Graphics.DrawString("TOTAL", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, yPos + 8, 180, 50), stringAlignRight);
                        args.Graphics.DrawString(dsPrint.Tables[0].Rows[0]["TotalAmount"].ToString(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(165, yPos + 8, 70, 50), stringAlignRight);


                        args.Graphics.DrawString("Date : " + dsPrint.Tables[0].Rows[0]["BillDate"].ToString(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, yPos + 40, 250, 50), stringAlignLeft);
                        args.Graphics.DrawString("Cashier : " + dsPrint.Tables[0].Rows[0]["staffname"].ToString(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, yPos + 40, 250, 150), stringAlignLeft);
 
                        //args.Graphics.DrawRectangle(new Pen(Color.Black, 1), 0, 145, 180, 25);
                        //args.Graphics.DrawRectangle(new Pen(Color.Black, 1), 180, 145, 68, 25);

                        Pen pen = new Pen(Color.Black, 1);
                        pen.DashStyle = System.Drawing.Drawing2D.DashStyle.Dot;
                        args.Graphics.DrawRectangle(pen, 0, 145, 180, 25);

                        Pen pen0 = new Pen(Color.Black, 1);
                        pen0.DashStyle = System.Drawing.Drawing2D.DashStyle.Dot;
                        args.Graphics.DrawRectangle(pen0, 180, 145, 68, 25);

                        Pen pen1 = new Pen(Color.Black, 1);
                        pen1.DashStyle = System.Drawing.Drawing2D.DashStyle.Dot;
                        args.Graphics.DrawRectangle(pen1, 0, 170, 180, 25 * headCount);

                        Pen pen2 = new Pen(Color.Black, 1);
                        pen2.DashStyle = System.Drawing.Drawing2D.DashStyle.Dot;
                        args.Graphics.DrawRectangle(pen2, 180, 170, 68, 25 * headCount);

                        Pen pen3 = new Pen(Color.Black, 1);
                        pen3.DashStyle = System.Drawing.Drawing2D.DashStyle.Dot;
                        args.Graphics.DrawRectangle(pen3, 0, yPos + 12, 180, 35);

                        Pen pen4 = new Pen(Color.Black, 1);
                        pen4.DashStyle = System.Drawing.Drawing2D.DashStyle.Dot;
                        args.Graphics.DrawRectangle(pen4, 180, yPos + 12, 68, 35);
                        //args.Graphics.DrawRectangle(new Pen(Color.Black, 1), 0, 170, 180, 25 * headCount);
                        //args.Graphics.DrawRectangle(new Pen(Color.Black, 1), 180, 170, 68, 25 * headCount);

                        //args.Graphics.DrawRectangle(new Pen(Color.Black, 1), 0, yPos + 12, 180, 35);
                        //args.Graphics.DrawRectangle(new Pen(Color.Black, 1), 180, yPos + 12, 68, 35);
                    }

                };
               // clientIPAddress = "192.168.0.48";
                fd.PrinterSettings.PrinterName = "\\\\" + clientIPAddress + "\\" + printerName + "";
                fd.Print();
            }
            fd.Dispose();
        }
        catch (Exception err)
        {
        }
    }



    public static void PrintBiMonthBill(string billId)
    {
        try
        {
            PrintDocument fd = new PrintDocument();
            Utilities utl = new Utilities();
            string sqlstr = "select isactive from m_academicyear where AcademicID='" + HttpContext.Current.Session["AcademicID"].ToString() + "'";
            string Isactive = utl.ExecuteScalar(sqlstr);
            HttpContext.Current.Session["Isactive"] = Isactive.ToString();
            string query = "";
            DataSet dsStud = new DataSet();
            if (Isactive == "True")
            {
                query = "[sp_GetStudentBiMonthBill] " + billId + "";
            }
            else
            {
                query = "[sp_GetOldStudentBill] " + billId + ",'" + HttpContext.Current.Session["AcademicID"] + "'";
            }

            DataSet dsPrint = utl.GetDataset(query);
            int yPos = 0;
            int headCount = 0;
            string printerName = ConfigurationManager.AppSettings["FeesPrinter"];
            string clientMachineName, clientIPAddress;
            //  clientMachineName = (Dns.GetHostEntry(Request.ServerVariables["remote_addr"]).HostName);
            clientIPAddress = HttpContext.Current.Request.ServerVariables["remote_addr"];

            if (dsPrint.Tables.Count > 1)
            {
                StringBuilder str = new StringBuilder();
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



                fd.PrintPage += (s, args) =>
                {

                    if (dsPrint.Tables[0].Rows.Count > 0)
                    {
                        args.Graphics.DrawString(dsPrint.Tables[2].Rows[0]["SchoolShortName"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 0, 250, 25), stringAlignCenter);
                        args.Graphics.DrawString(dsPrint.Tables[2].Rows[0]["Schoolstate"].ToString().ToUpper() + "-" + dsPrint.Tables[2].Rows[0]["SchoolZip"].ToString() + " PHONE NO-" + dsPrint.Tables[2].Rows[0]["phoneno"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 8, FontStyle.Regular), Brushes.Black, new Rectangle(0, 20, 250, 25), stringAlignCenter);

                        args.Graphics.DrawLine(new Pen(Color.Black, 2), 0, 42, 500, 42);
                        args.Graphics.DrawString("Reg.No : " + dsPrint.Tables[0].Rows[0]["RegNo"].ToString(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 45, 150, 50), stringAlignLeft);
                        args.Graphics.DrawString("Rec.No : " + dsPrint.Tables[0].Rows[0]["BillNo"].ToString(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(120, 45, 120, 50), stringAlignRight);
                        args.Graphics.DrawString("Name 	:  " + dsPrint.Tables[0].Rows[0]["stname"].ToString(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 70, 250, 50), stringAlignLeft);
                        args.Graphics.DrawString("Class & Section : 	" + dsPrint.Tables[0].Rows[0]["classname"].ToString() + "  " + dsPrint.Tables[0].Rows[0]["sectionname"].ToString(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 95, 150, 50), stringAlignLeft);
                        args.Graphics.DrawString(" Month 	: 	" + dsPrint.Tables[0].Rows[0]["BillMonth"].ToString(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(120, 95, 120, 50), stringAlignRight);
                        args.Graphics.DrawString("PARTICULARS", new System.Drawing.Font("ARIAL", 8, FontStyle.Regular), Brushes.Black, new Rectangle(0, 135, 180, 50), stringAlignCenter);
                        args.Graphics.DrawString("AMOUNT ", new System.Drawing.Font("ARIAL", 8, FontStyle.Regular), Brushes.Black, new Rectangle(180, 135, 70, 50), stringAlignCenter);
                        if (dsPrint.Tables[1].Rows.Count > 0)
                        {
                            yPos = 158;

                            for (int i = 0; i < dsPrint.Tables[1].Rows.Count; i++, yPos += 25, headCount += 1)
                            {
                                args.Graphics.DrawString(dsPrint.Tables[1].Rows[i]["FeesHeadName"].ToString(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(5, yPos, 180, 50), stringAlignLeft);
                                args.Graphics.DrawString(dsPrint.Tables[1].Rows[i]["Amount"].ToString(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(165, yPos, 70, 50), stringAlignRight);
                            }
                        }

                        args.Graphics.DrawString("TOTAL", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, yPos + 8, 180, 50), stringAlignRight);
                        args.Graphics.DrawString(dsPrint.Tables[0].Rows[0]["TotalAmount"].ToString(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(165, yPos + 8, 70, 50), stringAlignRight);


                        args.Graphics.DrawString("Date : " + dsPrint.Tables[0].Rows[0]["BillDate"].ToString(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, yPos + 40, 250, 50), stringAlignLeft);
                        args.Graphics.DrawString("Cashier : " + dsPrint.Tables[0].Rows[0]["staffname"].ToString(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, yPos + 40, 250, 150), stringAlignLeft);

                        //args.Graphics.DrawRectangle(new Pen(Color.Black, 1), 0, 145, 180, 25);
                        //args.Graphics.DrawRectangle(new Pen(Color.Black, 1), 180, 145, 68, 25);

                        Pen pen = new Pen(Color.Black, 1);
                        pen.DashStyle = System.Drawing.Drawing2D.DashStyle.Dot;
                        args.Graphics.DrawRectangle(pen, 0, 145, 180, 25);

                        Pen pen0 = new Pen(Color.Black, 1);
                        pen0.DashStyle = System.Drawing.Drawing2D.DashStyle.Dot;
                        args.Graphics.DrawRectangle(pen0, 180, 145, 68, 25);

                        Pen pen1 = new Pen(Color.Black, 1);
                        pen1.DashStyle = System.Drawing.Drawing2D.DashStyle.Dot;
                        args.Graphics.DrawRectangle(pen1, 0, 170, 180, 25 * headCount);

                        Pen pen2 = new Pen(Color.Black, 1);
                        pen2.DashStyle = System.Drawing.Drawing2D.DashStyle.Dot;
                        args.Graphics.DrawRectangle(pen2, 180, 170, 68, 25 * headCount);

                        Pen pen3 = new Pen(Color.Black, 1);
                        pen3.DashStyle = System.Drawing.Drawing2D.DashStyle.Dot;
                        args.Graphics.DrawRectangle(pen3, 0, yPos + 12, 180, 35);

                        Pen pen4 = new Pen(Color.Black, 1);
                        pen4.DashStyle = System.Drawing.Drawing2D.DashStyle.Dot;
                        args.Graphics.DrawRectangle(pen4, 180, yPos + 12, 68, 35);
                        //args.Graphics.DrawRectangle(new Pen(Color.Black, 1), 0, 170, 180, 25 * headCount);
                        //args.Graphics.DrawRectangle(new Pen(Color.Black, 1), 180, 170, 68, 25 * headCount);

                        //args.Graphics.DrawRectangle(new Pen(Color.Black, 1), 0, yPos + 12, 180, 35);
                        //args.Graphics.DrawRectangle(new Pen(Color.Black, 1), 180, yPos + 12, 68, 35);
                    }


                };
                clientIPAddress = "192.168.0.48";
                fd.PrinterSettings.PrinterName = "\\\\" + clientIPAddress + "\\" + printerName + "";
                fd.Print();
            }
            fd.Dispose();
        }
        catch (Exception err)
        {
        }
    }



    public static void PrintBiMonthSlip(string BillId, string regNo, string AcademicId)
    {
        try
        {
            PrintDocument fd = new PrintDocument();
            Utilities utl = new Utilities();
            string SlipType = string.Empty;
            string query = "[sp_PrintSlip] " + BillId;
            DataSet dsPrint = utl.GetDataset(query);
            string printerName = ConfigurationManager.AppSettings["FeesPrinter"];
            string clientMachineName, clientIPAddress;
            //  clientMachineName = (Dns.GetHostEntry(Request.ServerVariables["remote_addr"]).HostName);
            clientIPAddress = HttpContext.Current.Request.ServerVariables["remote_addr"];

            if (dsPrint != null && dsPrint.Tables.Count > 1 && dsPrint.Tables[0].Rows.Count > 0 && BillId != string.Empty)
            {

                for (int i = 0; i < 2; i++)
                {

                    StringBuilder str = new StringBuilder();
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

                    str.Append(dsPrint.Tables[0].Rows[0]["SchoolShortName"].ToString().ToUpper() + " \r\n  " + dsPrint.Tables[0].Rows[0]["Schoolstate"].ToString().ToUpper() + " - " + dsPrint.Tables[0].Rows[0]["SchoolZip"].ToString() + "PHONE NO - " + dsPrint.Tables[0].Rows[0]["phoneno"].ToString().ToUpper() + "\r\n");



                    fd.PrintPage += (s, args) =>
                    {

                        if (dsPrint.Tables[0].Rows.Count > 0)
                        {
                            args.Graphics.DrawString(dsPrint.Tables[0].Rows[0]["SchoolShortName"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 0, 250, 25), stringAlignCenter);
                            args.Graphics.DrawString(dsPrint.Tables[0].Rows[0]["Schoolstate"].ToString().ToUpper() + "-" + dsPrint.Tables[0].Rows[0]["SchoolZip"].ToString() + " PHONE NO-" + dsPrint.Tables[0].Rows[0]["phoneno"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 8, FontStyle.Regular), Brushes.Black, new Rectangle(0, 20, 250, 25), stringAlignCenter);

                            args.Graphics.DrawLine(new Pen(Color.Black, 2), 0, 45, 500, 45);

                            if (i == 0)
                                SlipType = "BOOKS";
                            else
                                SlipType = "UNIFORM";

                            args.Graphics.DrawString("DELIVERY SLIP - " + SlipType, new System.Drawing.Font("ARIAL", 9, FontStyle.Underline), Brushes.Black, new Rectangle(0, 40, 250, 50), stringAlignCenter);


                            args.Graphics.DrawString("Bill No : " + dsPrint.Tables[1].Rows[0]["BillNo"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 80, 120, 50), stringAlignLeft);
                            args.Graphics.DrawString("Date : " + dsPrint.Tables[1].Rows[0]["BillDate"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(135, 80, 130, 50), stringAlignRight);

                            args.Graphics.DrawString("Name ", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 105, 90, 50), stringAlignLeft);
                            args.Graphics.DrawString(":", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(120, 105, 20, 50), stringAlignLeft);
                            args.Graphics.DrawString(dsPrint.Tables[1].Rows[0]["stname"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 8, FontStyle.Regular), Brushes.Black, new Rectangle(135, 105, 140, 50), stringAlignLeft);

                            args.Graphics.DrawString("Register No", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 125, 90, 50), stringAlignLeft);
                            args.Graphics.DrawString(":", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(120, 125, 20, 50), stringAlignLeft);
                            args.Graphics.DrawString(dsPrint.Tables[1].Rows[0]["regno"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(135, 125, 140, 50), stringAlignLeft);

                            args.Graphics.DrawString("Class", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 150, 90, 50), stringAlignLeft);
                            args.Graphics.DrawString(":", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(120, 150, 20, 50), stringAlignLeft);
                            args.Graphics.DrawString(dsPrint.Tables[1].Rows[0]["classname"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(135, 150, 140, 50), stringAlignLeft);

                            args.Graphics.DrawString("Section", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 175, 90, 50), stringAlignLeft);
                            args.Graphics.DrawString(":", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(120, 175, 20, 50), stringAlignLeft);
                            args.Graphics.DrawString(dsPrint.Tables[1].Rows[0]["sectionname"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(135, 175, 140, 50), stringAlignLeft);


                            args.Graphics.DrawString("Cashier", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 205, 250, 50), stringAlignRight);


                            args.Graphics.DrawString("Delivery Date : ", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 205, 110, 50), stringAlignLeft);

                            Pen pen = new Pen(Color.Black, 1);
                            pen.DashStyle = System.Drawing.Drawing2D.DashStyle.Dot;
                            args.Graphics.DrawLine(pen, 0, 215, 500, 215);

                            //args.Graphics.DrawLine(new Pen(Color.Black, 2), 0, 215, 500, 215);


                            args.Graphics.DrawString("Delivered", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(120, 255, 130, 50), stringAlignRight);

                            Pen pen1 = new Pen(Color.Black, 1);
                            pen1.DashStyle = System.Drawing.Drawing2D.DashStyle.Dot;
                            args.Graphics.DrawLine(pen1, 0, 290, 500, 290);

                            //args.Graphics.DrawLine(new Pen(Color.Black, 2), 0, 290, 500, 290);
                        }

                    };
                    //clientIPAddress = "192.168.0.43";
                    fd.PrinterSettings.PrinterName = "\\\\" + clientIPAddress + "\\" + printerName + "";
                    fd.Print();
                }
            }
            fd.Dispose();
            GC.SuppressFinalize(fd);
        }
        catch (Exception err)
        {

        }

        finally { GC.Collect(); GC.WaitForPendingFinalizers(); }

    }



    public static void PrintSlip(string BillId, string regNo, string AcademicId)
    {
        try
        {
            PrintDocument fd = new PrintDocument();
            Utilities utl = new Utilities();
            string SlipType = string.Empty;
            string query = "[sp_PrintSlip] " + BillId;
            DataSet dsPrint = utl.GetDataset(query);
            string printerName = ConfigurationManager.AppSettings["FeesPrinter"];
            string clientMachineName, clientIPAddress;
            //  clientMachineName = (Dns.GetHostEntry(Request.ServerVariables["remote_addr"]).HostName);
            clientIPAddress = HttpContext.Current.Request.ServerVariables["remote_addr"];

            if (dsPrint != null && dsPrint.Tables.Count > 1 && dsPrint.Tables[0].Rows.Count > 0 && BillId != string.Empty)
            {

                for (int i = 0; i < 2; i++)
                {

                    StringBuilder str = new StringBuilder();
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

                    str.Append(dsPrint.Tables[0].Rows[0]["SchoolShortName"].ToString().ToUpper() + " \r\n  " + dsPrint.Tables[0].Rows[0]["Schoolstate"].ToString().ToUpper() + " - " + dsPrint.Tables[0].Rows[0]["SchoolZip"].ToString() + "PHONE NO - " + dsPrint.Tables[0].Rows[0]["phoneno"].ToString().ToUpper() + "\r\n");



                    fd.PrintPage += (s, args) =>
                    {

                        if (dsPrint.Tables[0].Rows.Count > 0)
                        {
                            args.Graphics.DrawString(dsPrint.Tables[0].Rows[0]["SchoolShortName"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 0, 250, 25), stringAlignCenter);
                            args.Graphics.DrawString(dsPrint.Tables[0].Rows[0]["Schoolstate"].ToString().ToUpper() + "-" + dsPrint.Tables[0].Rows[0]["SchoolZip"].ToString() + " PHONE NO-" + dsPrint.Tables[0].Rows[0]["phoneno"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 8, FontStyle.Regular), Brushes.Black, new Rectangle(0, 20, 250, 25), stringAlignCenter);

                            args.Graphics.DrawLine(new Pen(Color.Black, 2), 0, 45, 500, 45);

                            if (i == 0)
                                SlipType = "BOOKS";
                            else
                                SlipType = "UNIFORM";

                            args.Graphics.DrawString("DELIVERY SLIP - " + SlipType, new System.Drawing.Font("ARIAL", 9, FontStyle.Underline), Brushes.Black, new Rectangle(0, 40, 250, 50), stringAlignCenter);


                            args.Graphics.DrawString("Bill No : " + dsPrint.Tables[1].Rows[0]["BillNo"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 80, 120, 50), stringAlignLeft);
                            args.Graphics.DrawString("Date : " + dsPrint.Tables[1].Rows[0]["BillDate"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(135, 80, 130, 50), stringAlignRight);

                            args.Graphics.DrawString("Name ", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 105, 90, 50), stringAlignLeft);
                            args.Graphics.DrawString(":", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(120, 105, 20, 50), stringAlignLeft);
                            args.Graphics.DrawString(dsPrint.Tables[1].Rows[0]["stname"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 8, FontStyle.Regular), Brushes.Black, new Rectangle(135, 105, 140, 50), stringAlignLeft);

                            args.Graphics.DrawString("Register No", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 125, 90, 50), stringAlignLeft);
                            args.Graphics.DrawString(":", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(120, 125, 20, 50), stringAlignLeft);
                            args.Graphics.DrawString(dsPrint.Tables[1].Rows[0]["regno"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(135, 125, 140, 50), stringAlignLeft);

                            args.Graphics.DrawString("Class", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 150, 90, 50), stringAlignLeft);
                            args.Graphics.DrawString(":", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(120, 150, 20, 50), stringAlignLeft);
                            args.Graphics.DrawString(dsPrint.Tables[1].Rows[0]["classname"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(135, 150, 140, 50), stringAlignLeft);

                            args.Graphics.DrawString("Section", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 175, 90, 50), stringAlignLeft);
                            args.Graphics.DrawString(":", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(120, 175, 20, 50), stringAlignLeft);
                            args.Graphics.DrawString(dsPrint.Tables[1].Rows[0]["sectionname"].ToString().ToUpper(), new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(135, 175, 140, 50), stringAlignLeft);


                            args.Graphics.DrawString("Cashier", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 205, 250, 50), stringAlignRight);


                            args.Graphics.DrawString("Delivery Date : ", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(0, 205, 110, 50), stringAlignLeft);

                            Pen pen = new Pen(Color.Black, 1);
                            pen.DashStyle = System.Drawing.Drawing2D.DashStyle.Dot;
                            args.Graphics.DrawLine(pen, 0, 215, 500, 215);

                            //args.Graphics.DrawLine(new Pen(Color.Black, 2), 0, 215, 500, 215);

                           
                            args.Graphics.DrawString("Delivered", new System.Drawing.Font("ARIAL", 9, FontStyle.Regular), Brushes.Black, new Rectangle(120, 255, 130, 50), stringAlignRight);

                            Pen pen1 = new Pen(Color.Black, 1);
                            pen1.DashStyle = System.Drawing.Drawing2D.DashStyle.Dot;
                            args.Graphics.DrawLine(pen1, 0, 290, 500, 290);

                            //args.Graphics.DrawLine(new Pen(Color.Black, 2), 0, 290, 500, 290);
                        }

                    };
                   // clientIPAddress = "192.168.0.43";
                    fd.PrinterSettings.PrinterName = "\\\\" + clientIPAddress + "\\" + printerName + "";
                    fd.Print();
                }
            }
            fd.Dispose();
            GC.SuppressFinalize(fd);
        }
        catch (Exception err)
        {

        }

        finally { GC.Collect(); GC.WaitForPendingFinalizers(); }

    }



    [WebMethod]
    public static string get_cocurricular_paymentDetails(string regNo, string academicId)
    {
        Utilities utl = new Utilities();        
        string res_html = string.Empty;
        string disp_cocurri = string.Empty;
        string payment_status_html = string.Empty;

        DataTable dt_academic = new DataTable();
        dt_academic = utl.GetDataTable("select top 1 convert(varchar,startdate,121)startdate,convert(Varchar,enddate,121)enddate from m_academicyear where  academicid='" + academicId + "' order by academicid desc");
        if (dt_academic.Rows.Count > 0)
        {
            //check the student in SPORTS / FINEARTS [any one to participate]
            string query_chk = " select (select isnull(count(*),0) from s_studentsports where RegNo='" + regNo + "' and AcademicId='" + academicId + "') as chk_sports, (select isnull(count(*),0) from s_studentfinearts where RegNo='" + regNo + "' and AcademicId='" + academicId + "') as chk_finearts";
            DataSet dsGet_chk = new DataSet();
            dsGet_chk = utl.GetDataset(query_chk);

            int chk_sports = Convert.ToInt32(dsGet_chk.Tables[0].Rows[0]["chk_sports"].ToString());
            int chk_finearts = Convert.ToInt32(dsGet_chk.Tables[0].Rows[0]["chk_finearts"].ToString());
            if (chk_sports == 0 && chk_finearts == 0)
            {
                res_html = @"N/A";
            }
            else
            {
                if (chk_sports > 0)
                {
                    disp_cocurri = "Sports";
                }
                else
                {
                    disp_cocurri = "FineArts";
                }


                DataSet dt_monthlist = new DataSet();
                dt_monthlist = utl.GetDataset("exec sp_getacademicmonths '" + dt_academic.Rows[0]["startdate"].ToString() + "','" + dt_academic.Rows[0]["enddate"].ToString() + "'");

                if (dt_monthlist != null && dt_monthlist.Tables.Count > 0 && dt_monthlist.Tables[0].Rows.Count > 0)
                {
                    res_html += disp_cocurri;
                    res_html += @"<table id='tbl_results' class='display' style='width:100%; border-collapse:collapse;' cellspacing='1' cellpadding='1' border='1'> <thead> <tr> <th class='sorting_mod' width='10%'>Month / Activity</th>  <th class='sorting_mod' width='10%'>Payment Status</th>  </tr> </thead>  <tbody id='result_list_html'>  ";

                    for (int i = 0; i < dt_monthlist.Tables[0].Rows.Count; i++)
                    {
                        res_html += @"<tr class='even'><td colspan='2'><b>" + dt_monthlist.Tables[0].Rows[i]["fullmonth"].ToString() + "</b></td></tr>";
                        DataSet dt_cocurricular_list = new DataSet();
                        string co_curri_query = string.Empty;

                        if (disp_cocurri == "Sports")
                        {
                            co_curri_query = " select t2.*,t1.StudSportId, t1.SportId as act_id, t3.SportName as cc_name from s_studentsports t1 left join s_cocurricular_payment t2 on t1.SportId = t2.cc_id and t2.RegNo='" + regNo + "' and t2.AcademicId='" + academicId + "' and t2.formonth='" + dt_monthlist.Tables[0].Rows[i]["fullmonth"].ToString() + "' inner join m_sports t3 on t1.SportId = t3.SportId where 1=1 and  t1.RegNo='1320169680' and t1.AcademicId='7' ";
                        }
                        else
                        {
                            co_curri_query = " select t2.*,t1.StudFineArtId, t1.FineArtId as act_id, t3.FineArtName as cc_name from s_studentfinearts t1 left join s_cocurricular_payment t2 on t1.FineArtId = t2.cc_id and t2.RegNo='" + regNo + "' and t2.AcademicId='" + academicId + "' and t2.formonth='" + dt_monthlist.Tables[0].Rows[i]["fullmonth"].ToString() + "' inner join m_finearts t3 on t1.FineArtId = t3.FineArtId where 1=1 and  t1.RegNo='1420169703' and t1.AcademicId='7'  ";
                        }

                        dt_cocurricular_list = utl.GetDataset(co_curri_query);
                        if (dt_cocurricular_list != null && dt_cocurricular_list.Tables.Count > 0 && dt_cocurricular_list.Tables[0].Rows.Count > 0)
                        {
                            for (int j = 0; j < dt_cocurricular_list.Tables[0].Rows.Count; j++)
                            {
                                string disp_payment_status = "Not Paid";
                                if (dt_cocurricular_list.Tables[0].Rows[j]["payment_status"].ToString() == "1")
                                {
                                    disp_payment_status = "Paid";
                                }

                                res_html += @"<tr class='even'><td>" + dt_cocurricular_list.Tables[0].Rows[j]["cc_name"].ToString() + "</td> <td>" + disp_payment_status + "</td> </tr>";
                            }
                        }
                        else
                        {
                            res_html += @"<tr><td colspan='2'>N/A</td></tr>";
                        }
                        
                    }

                    res_html += @"</tbody></table>";
                }
                else
                {
                    res_html = @"N/A";
                }


            }

        }
        else
        {
            res_html = @"N/A";
        }

        return res_html;
    }

}