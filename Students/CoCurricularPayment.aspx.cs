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

public partial class Students_CoCurricularPayment : System.Web.UI.Page
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

            string Academicyear = "";
            utl = new Utilities();
            //Academicyear = utl.ExecuteScalar("select top 1 (convert(varchar(4),year(startdate))+'-'+ convert(varchar(4),year(enddate))) from m_academicyear where isactive=1 order by academicid desc");
            if (Session["AcademicID"].ToString() != "")
            {
                Academicyear = utl.ExecuteScalar("select top 1 academicid from m_academicyear where  academicid='" + Session["AcademicID"].ToString() + "' order by academicid desc");
                if (Academicyear != "")
                {
                    hfAcademicyear.Value = Academicyear.ToString();
                }
            }
            Userid = Convert.ToInt32(Session["UserId"]);
            hfUserId.Value = Userid.ToString();
            
            if (Request.Params["StudentID"] != null)
                hfStudentInfoID.Value = Request.Params["StudentID"].ToString();

            else
                hfStudentInfoID.Value = "";

            if (!IsPostBack)
            {
                if (Request.Params["StudentID"] != null)
                {
                    BindCocurricular_Details();
                    BindAcademicMonths();

                }
                
            }
        }
    }

    private void BindCocurricular_Details()
    {
        Utilities utl = new Utilities();
        string Regno = utl.ExecuteScalar("select RegNo from s_studentinfo where StudentId='" + Request.Params["StudentID"].ToString() + "' ");
        DataSet dsGet = new DataSet();
        string get_cocurricular_list_query;
        string rslt_cocurricular_list;


        //check the student in SPORTS / FINEARTS [any one to participate]
        string query_chk = " select (select isnull(count(*),0) from s_studentsports where RegNo='" + Regno + "' and AcademicId='" + Session["AcademicID"].ToString() + "') as chk_sports, (select isnull(count(*),0) from s_studentfinearts where RegNo='" + Regno + "' and AcademicId='" + Session["AcademicID"].ToString() + "') as chk_finearts";

        dsGet = utl.GetDataset(query_chk);

        int chk_sports = Convert.ToInt32(dsGet.Tables[0].Rows[0]["chk_sports"].ToString());
        int chk_finearts = Convert.ToInt32(dsGet.Tables[0].Rows[0]["chk_finearts"].ToString());

        if (chk_sports == 0 && chk_finearts == 0)
        {
            lblCocurriculardet.Text = "N/A";
        }
        else
        {           
            if (chk_sports > 0)
            {
                get_cocurricular_list_query = "sp_GetcocurricularListbyRegno 1,'" + Regno + "', '" + Session["AcademicID"].ToString() + "' ";
                rslt_cocurricular_list = utl.ExecuteScalar(get_cocurricular_list_query);

                lblCocurriculardet.Text = "Sports [ " +rslt_cocurricular_list+ " ]";
                hdnChkcocurricular.Value = "1";
            }
            else
            {
                get_cocurricular_list_query = "sp_GetcocurricularListbyRegno 2,'" + Regno + "', '" + Session["AcademicID"].ToString() + "' ";
                rslt_cocurricular_list = utl.ExecuteScalar(get_cocurricular_list_query);
                               
                lblCocurriculardet.Text = "FineArts [ " + rslt_cocurricular_list + " ]";
                hdnChkcocurricular.Value = "2";
            }
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
                ddlMonth.DataValueField = "fullmonth";
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


    [WebMethod]
    public static string get_cocurricular_paymentDetails(string RegNo, string month_name, string cocurricular_type)
    {
        Utilities utl = new Utilities();
        DataSet dsGet = new DataSet();
        string res_html = string.Empty;
        string qry_list = string.Empty;
        string payment_status_html = string.Empty;


        if (cocurricular_type == "1" || cocurricular_type == "2")
        {
            if (cocurricular_type == "1")
            {
                qry_list = "select t2.*,t1.StudSportId, t1.SportId as act_id, t3.SportName as cc_name from s_studentsports t1 left join s_cocurricular_payment t2 on t1.SportId = t2.cc_id and t2.RegNo='" + RegNo + "' and t2.AcademicId='" + HttpContext.Current.Session["AcademicID"].ToString() + "' and t2.formonth='" + month_name + "' inner join m_sports t3 on t1.SportId = t3.SportId where 1=1 and  t1.RegNo='" + RegNo + "' and t1.AcademicId='" + HttpContext.Current.Session["AcademicID"].ToString() + "' ";           
            }
            else
            {
                qry_list = "select t2.*,t1.StudFineArtId, t1.FineArtId as act_id, t3.FineArtName as cc_name from s_studentfinearts t1 left join s_cocurricular_payment t2 on t1.FineArtId = t2.cc_id and t2.RegNo='" + RegNo + "' and t2.AcademicId='" + HttpContext.Current.Session["AcademicID"].ToString() + "' and t2.formonth='" + month_name + "' inner join m_finearts t3 on t1.FineArtId = t3.FineArtId where 1=1 and  t1.RegNo='" + RegNo + "' and t1.AcademicId='" + HttpContext.Current.Session["AcademicID"].ToString() + "' ";
            }

            
            dsGet = utl.GetDataset(qry_list);
            if (dsGet != null && dsGet.Tables.Count > 0 && dsGet.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < dsGet.Tables[0].Rows.Count; i++)
                {
                    payment_status_html = "<select onchange='payment_status_change(this.value, \"" + month_name + "\", \"" + dsGet.Tables[0].Rows[i]["act_id"].ToString() + "\", \"0\");'><option value=''>Select</option> <option value='1'>Paid</option> <option value='2'>Not Paid</option> </select>";

                    if (dsGet.Tables[0].Rows[i]["payment_status"].ToString() == "1")
                    {
                        payment_status_html = "<select onchange='payment_status_change(this.value, \"" + month_name + "\", \"" + dsGet.Tables[0].Rows[i]["act_id"].ToString() + "\", \"" + dsGet.Tables[0].Rows[i]["cc_payment_id"].ToString() + "\");'><option value=''>Select</option> <option value='1' selected>Paid</option> <option value='2'>Not Paid</option> </select>";
                    }
                    else if (dsGet.Tables[0].Rows[i]["payment_status"].ToString() == "2")
                    {
                        payment_status_html = "<select onchange='payment_status_change(this.value, \"" + month_name + "\", \"" + dsGet.Tables[0].Rows[i]["act_id"].ToString() + "\", \"" + dsGet.Tables[0].Rows[i]["cc_payment_id"].ToString() + "\");'><option value=''>Select</option> <option value='1' selected>Paid</option> <option selected value='2'>Not Paid</option> </select>";
                    }

                    res_html += @"<tr class='even'> <td>" + dsGet.Tables[0].Rows[i]["cc_name"].ToString() + "</td> <td>" + payment_status_html + "</td> </tr>";


                }
            }
            else
            {
                res_html = @"<tr> <td colspan='2'>No-Data</td>   </tr>";
            }


        }
        else
        {
            res_html = @"<tr> <td colspan='2'>No-Data</td>   </tr>";
        }
                               
        
        return res_html;
    }


    [WebMethod]
    public static string save_cocurricular_paymentDetails(string payment_id, string RegNo, string month_name, string activity_id, string payment_status)
    {
        Utilities utl = new Utilities();
        string sqlstr = string.Empty;
        string rslt_data = string.Empty;

        if (payment_id != "0")
        {
            //update [payment_status = 1-paid, 2-notpaid]
            sqlstr = "update s_cocurricular_payment set payment_status='" + payment_status + "',UserId='" + HttpContext.Current.Session["UserId"].ToString() + "'  where cc_payment_id='" + payment_id + "' ";

            rslt_data = utl.ExecuteQuery(sqlstr);
        }
        else
        {
            //insert
            sqlstr = "insert into s_cocurricular_payment(RegNo, AcademicId, formonth, cc_id, payment_status, IsActive, UserId, CreatedDate) values('" + RegNo + "', '" + HttpContext.Current.Session["AcademicID"].ToString() + "','" + month_name + "', '" + activity_id + "', '" + payment_status + "', '1','" + HttpContext.Current.Session["UserId"].ToString() + "', GETDATE() )";

            rslt_data = utl.ExecuteQuery(sqlstr);
        }

        return "succ";
    }



    [WebMethod]
    public static string GetStudentInfo(int studentid)
    {
        Utilities utl = new Utilities();
        DataSet ds = new DataSet();
        string sqlstr = "select isactive from m_academicyear where AcademicID='" + HttpContext.Current.Session["AcademicID"].ToString() + "'";
        string Isactive = utl.ExecuteScalar(sqlstr);
        string query = "";
        if (Isactive == "True")
        {
            query = "sp_GetStudentInfo " + studentid + "";
        }
        else
        {
            query = "sp_GetPromoStudentInfo " + studentid + "";
        }
        return utl.GetDatasetTable(query, "StudentInfo").GetXml();
    }


    [WebMethod]
    public static string GetSportsInfo(int regno)
    {
        Utilities utl = new Utilities();
        DataSet ds = new DataSet();
        string query = "sp_GetSportsInfo " + regno + "," + HttpContext.Current.Session["AcademicID"].ToString();
        return utl.GetDatasetTable(query, "Sports").GetXml();
    }


    [WebMethod]
    public static string GetFineArtsInfo(int regno)
    {
        Utilities utl = new Utilities();
        DataSet ds = new DataSet();
        string query = "sp_GetFineArtsInfo " + regno + "," + HttpContext.Current.Session["AcademicID"].ToString();
        return utl.GetDatasetTable(query, "FineArts").GetXml();
    }




}