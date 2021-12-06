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
using System.Web.Script.Serialization;

public partial class ApproveAlumini : System.Web.UI.Page
{
    Utilities utl = new Utilities();

    protected void Page_Load(object sender, EventArgs e)
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
                BindTemplate();
                // BindSMSCopyTo();
                BindDummyRow();
            }

        }
    }
    private void BindTemplate()
    {
        string query = "sp_GetMessageTemplate";

        Utilities utl = new Utilities();
        DataTable dt = new DataTable();
        dt = utl.GetDataTable(query);
        if (dt != null && dt.Rows.Count > 0)
        {
            ddlTemplate.DataSource = dt;
            ddlTemplate.DataTextField = "MessageTemplateName";
            ddlTemplate.DataValueField = "MessageTemplateID";
            ddlTemplate.DataBind();

        }
        else
        {
            ddlTemplate.DataSource = null;
            ddlTemplate.DataBind();
            ddlTemplate.Items.Clear();
        }
        ddlTemplate.SelectedIndex = 0;
    }
    [WebMethod]
    public static string GetMessageTemplate(int MessTempID)
    {
        Utilities utl = new Utilities();
        DataSet ds = new DataSet();
        string query = "sp_GetMessageTemplate " + "" + MessTempID + "";
        return utl.GetDatasetTable(query, "GetMessageTemplate").GetXml();
    }


    protected string BindSMScopy()
    {
        utl = new Utilities();
        DataTable dt = new DataTable();
        StringBuilder sb = new StringBuilder();

        dt = utl.GetDataTable("sp_GetSMSCopy");
        if (dt != null && dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                sb.Append("<div class=\"checkbox1\"><input id=\"rd_" + dr["StaffID"].ToString() + "\" style=\"border:0px;\" type=\"checkbox\" class=\"chkSmscopy\" name=\"chkSmscopy\" value=\"" + dr["StaffID"].ToString() + "\" />");
                sb.Append("<label name=\"lblSmscopy\" id=\"lbl_rd_" + dr["StaffID"].ToString() + "\" for=\"rd_" + dr["StaffID"].ToString() + "\">" + dr["StaffName"].ToString() + "</label></div>");
            }

        }
        return sb.ToString();

    }



    private void BindDummyRow()
    {

        HiddenField hdnID = (HiddenField)Page.Master.FindControl("hfViewPrm");

        if (hdnID.Value.ToLower() == "true")
        {
            DataTable dummy = new DataTable();
            dummy.Columns.Add("AddPrm");
            dummy.Columns.Add("StudentName");
            dummy.Columns.Add("Mobile");
            dummy.Columns.Add("emailid");
            dummy.Rows.Add();
            dgStudentList.DataSource = dummy;
            dgStudentList.DataBind();
        }
    }

    [WebMethod]
    public static string GetStudents(string mobileno, string dob)
    {
        if (dob != "")
        {
            string[] myDateTimeString = dob.ToString().Split('/');
            dob = "" + myDateTimeString[2] + "-" + myDateTimeString[1] + "-" + myDateTimeString[0] + "";
        }

        string query = "";
        Utilities utl = new Utilities();
        DataSet ds = new DataSet();

        query = "[sp_GetPendingAluminiInfo] '','" + mobileno + "','" + dob + "'";

        return utl.GetDatasetTable(query, "Students").GetXml();
    }

    [WebMethod]
    public static string SaveSMS(string studlist, string msg, string userid, string stafflist)
    {
        try
        {
            string sqlquery;
            string phNumber;
            string EXECquery;
            string query;
            string result="";
            DataSet dsGet = new DataSet();
            Utilities utl = new Utilities();

            string sqlquery1;
            DataSet dsGet1 = new DataSet();


            sqlquery = "select * from amp_alumni where alumniID IN(" + studlist + ")";

            dsGet = utl.GetDataset(sqlquery);
            if (dsGet != null && dsGet.Tables.Count > 0 && dsGet.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < dsGet.Tables[0].Rows.Count; i++)
                {
                    EXECquery = "insert into O_message(MessageDate,MobileNumber,Message,MessageType,ReceiverType,Status,Regno,Userid,createddate,modifiedDate) values('" + DateTime.Now.ToString("yyyy-MM-dd") + "','" + dsGet.Tables[0].Rows[i]["mobile"].ToString() + "','" + msg + "','Alumni','Student','U','" + dsGet.Tables[0].Rows[i]["alumniID"].ToString() + "','" + Convert.ToInt32(userid) + "','" + DateTime.Now.ToString("yyyy-MM-dd") + "','" + DateTime.Now.ToString("yyyy-MM-dd") + "')";
                    utl.ExecuteQuery(EXECquery);

                    string stralumnipwd = "";
                    stralumnipwd = utl.ExecuteScalar("select alumnipwd from amp_alumni  where alumniID='" + dsGet.Tables[0].Rows[i]["alumniID"].ToString() + "'");
                    if (stralumnipwd == "" || stralumnipwd == null)
                    {
                        string pwd = Convert.ToString(utl.ExecuteScalar("SELECT LEFT(NEWID(), 6)"));
                        string sqlstr = "update amp_alumni set    aluminicode = ('AL'+'-'+ convert(varchar, year(GETDATE())) +'-'+  REPLACE(STR(" + dsGet.Tables[0].Rows[i]["alumniID"].ToString() + ",len(" + dsGet.Tables[0].Rows[i]["alumniID"].ToString() + ")),' ','0')), alumnipwd='" + pwd + "' where alumniID='" + dsGet.Tables[0].Rows[i]["alumniID"].ToString() + "'";
                        utl.ExecuteQuery(sqlstr);
                    }

                }
            }




            //SMS Copy To Staff
            sqlquery1 = "select StaffId,MobileNo from e_staffinfo where StaffId IN(" + stafflist + ")";
            dsGet1 = utl.GetDataset(sqlquery1);
            if (dsGet1 != null && dsGet1.Tables.Count > 0 && dsGet1.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < dsGet1.Tables[0].Rows.Count; i++)
                {
                    EXECquery = "insert into O_message(MessageDate,MobileNumber,Message,MessageType,ReceiverType,Status,Regno,Userid,createddate,modifiedDate) values('" + DateTime.Now.ToString("yyyy-MM-dd") + "','" + dsGet1.Tables[0].Rows[i]["MobileNo"].ToString() + "','" + msg + "','Alumni','SMSCopy','U','" + dsGet1.Tables[0].Rows[i]["StaffId"].ToString() + "','" + Convert.ToInt32(userid) + "','" + DateTime.Now.ToString("yyyy-MM-dd") + "','" + DateTime.Now.ToString("yyyy-MM-dd") + "')";

                    utl.ExecuteQuery(EXECquery);
                }
            }




            DataSet dt_smsgroup = new DataSet();
            string sms_list_group = " select * from O_Message a inner join amp_alumni b on a.Regno=b.alumniID where 1=1 and a.[Status]='U' and CONVERT(varchar(10),messagedate,103)=CONVERT(varchar(10),GETDATE(),103) and MessageType='Alumni'";
            //  string sms_list_group = " select * from O_Message where 1=1 and [Status]='U' ";
            dt_smsgroup = utl.GetDataset(sms_list_group);

            if (dt_smsgroup != null && dt_smsgroup.Tables.Count > 0 && dt_smsgroup.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < dt_smsgroup.Tables[0].Rows.Count; i++)
                {
                    string Aluminicode = dt_smsgroup.Tables[0].Rows[i]["Aluminicode"].ToString();
                    string cusmobile = dt_smsgroup.Tables[0].Rows[i]["MobileNumber"].ToString();
                    string username = ConfigurationManager.AppSettings["sms_username"].ToString();
                    string password = ConfigurationManager.AppSettings["sms_password"].ToString();
                    string sender_id = ConfigurationManager.AppSettings["sms_senderid"].ToString();
                    string message = "Your alumnicode is " + Aluminicode + ", Your alumnicode will be your the username for logging into website alumni module and the password is: " + dt_smsgroup.Tables[0].Rows[i]["alumnipwd"].ToString() + "";


                    string createdURL = "http://www.1message.com/services/sendmessage.aspx?account=" + username + "&password=" + password + "&sender=" + sender_id + "&message=" + HttpUtility.UrlEncode(message) + "&mobile=" + cusmobile + "";


                    System.Net.HttpWebRequest myReq = (System.Net.HttpWebRequest)System.Net.WebRequest.Create(createdURL);
                    System.Net.HttpWebResponse myResp = (System.Net.HttpWebResponse)myReq.GetResponse();
                    System.IO.StreamReader respStreamReader = new System.IO.StreamReader(myResp.GetResponseStream());
                    string responseString = respStreamReader.ReadToEnd();
                    respStreamReader.Close();
                    myResp.Close();

                    string strQueryStatus = "";
                    StringBuilder strB = new StringBuilder();
                    strB.AppendFormat(@"<table width='100%'  border='1' cellpadding='3' cellspacing='0' bordercolor='#0050a5'>
  <tr>
    <td><table width='100%' height='144' border='0' cellpadding='5' cellspacing='0'>
      <tr bgcolor='#0050a5'>
        <td height='24' colspan='3' valign='top'><font face='Arial, Helvetica, sans-serif' size='4' color='#FFFFFF'>Amalorpavam school : Alumni Registration Confirmation</font></td>
      </tr>
      <tr>
        <td width='24%' height='24' valign='top'><font face='Arial, Helvetica, sans-serif' size='2' color='#000d5a'><b>Name</b></font></td>
        <td width='2%' valign='top'>: </td>
        <td width='74%' valign='top' ><font face='Arial, Helvetica, sans-serif' size='2' color='#000d5a'>" + dt_smsgroup.Tables[0].Rows[i]["name"].ToString() + "</font></td>");
                    strB.AppendFormat(@" </tr> ");
                    strB.AppendFormat(@"<tr>");
                    strB.AppendFormat(@"<td height='24' valign='top'><font face='Arial, Helvetica, sans-serif' size='2' color='#000d5a'><b>Mobile No</b></font></td>
        <td valign='top'>: </td>
        <td valign='top' ><font face='Arial, Helvetica, sans-serif' size='2' color='#000d5a'>" + dt_smsgroup.Tables[0].Rows[i]["mobile"].ToString() + "</font></td>");
                    strB.AppendFormat(@" </tr> ");
                    strB.AppendFormat(@"<tr>");
                    strB.AppendFormat(@"<td height='24' valign='top'><font face='Arial, Helvetica, sans-serif' size='2' color='#000d5a'><b>Email ID</b></font></td>
        <td valign='top'>: </td>
        <td valign='top' ><font face='Arial, Helvetica, sans-serif' size='2' color='#000d5a'>" + dt_smsgroup.Tables[0].Rows[i]["emailid"].ToString() + "</font></td>");
                    strB.AppendFormat(@" </tr> ");


                    strB.AppendFormat(@"<tr>");
                    strB.AppendFormat(@"<td height='24' valign='top'><font face='Arial, Helvetica, sans-serif' size='2' color='#000d5a'><b>Username</b></font></td>
        <td valign='top'>: </td>
        <td valign='top' ><font face='Arial, Helvetica, sans-serif' size='2' color='#000d5a'>" + Aluminicode + "</font></td>");
                    strB.AppendFormat(@" </tr> ");
                    strB.AppendFormat(@"<tr>");
                    strB.AppendFormat(@"<td height='24' valign='top'><font face='Arial, Helvetica, sans-serif' size='2' color='#000d5a'><b>Password</b></font></td>
        <td valign='top'>: </td>
        <td valign='top' ><font face='Arial, Helvetica, sans-serif' size='2' color='#000d5a'>" + dt_smsgroup.Tables[0].Rows[i]["alumnipwd"].ToString() + "</font></td>");
                    strB.AppendFormat(@" </tr> ");
                    strB.AppendFormat(@"<tr>");
                    strB.AppendFormat(@"<td height='24' valign='top'><font face='Arial, Helvetica, sans-serif' size='2' color='#000d5a'><b>Alumni Code</b></font></td>
        <td valign='top'>: </td>
        <td valign='top' ><font face='Arial, Helvetica, sans-serif' size='2' color='#000d5a'>" + Aluminicode + "</font></td>");
                    strB.AppendFormat(@" </tr> ");
                    strB.AppendFormat(@"</table></td></tr></table>");

                    strQueryStatus = utl.sendE_Mail("" + dt_smsgroup.Tables[0].Rows[i]["emailid"].ToString() + "", "Amalorpavam school : Alumni Registration Confirmation", strB.ToString());

                    //update o_message table if message send
                    string str_update_qry = "update O_Message set [Status]='A', ModifiedDate=GETDATE() where MessageId='" + dt_smsgroup.Tables[0].Rows[i]["MessageId"].ToString() + "'  ";
                    utl.ExecuteQuery(str_update_qry);

                    str_update_qry = "update amp_alumni set [Status]=1 where Aluminicode='" + Aluminicode + "'";
                    result = utl.ExecuteQuery(str_update_qry);

                }

                // string result = Sync();
                // if (result=="Data synchronised from Online & Local")
                if (result == "")
                {
                    return "success";
                }
            }
        }

        catch (Exception ex)
        {
            return "InsertFailed";
        }

        return "success";
    }


    [WebMethod]
    public static string Sync()
    {
        string createdURL = "";
        string php_port = ConfigurationManager.AppSettings["php_port"].ToString();
        //createdURL = "http://" + php_port + "/amalorpavam/ampws_alumni.php";
        createdURL = "http://" + php_port + "/amalorpavam/website/ampws_alumni.php";
        System.Net.HttpWebRequest myReq = (System.Net.HttpWebRequest)System.Net.WebRequest.Create(createdURL);
        System.Net.HttpWebResponse myResp = (System.Net.HttpWebResponse)myReq.GetResponse();
        System.IO.StreamReader respStreamReader = new System.IO.StreamReader(myResp.GetResponseStream());
        string responseString = respStreamReader.ReadToEnd();
        respStreamReader.Close();
        myResp.Close();
        createdURL = "http://" + php_port + "/amalorpavam/website/ampws_alumniupdate.php";
        myReq = (System.Net.HttpWebRequest)System.Net.WebRequest.Create(createdURL);
        myResp = (System.Net.HttpWebResponse)myReq.GetResponse();
        respStreamReader = new System.IO.StreamReader(myResp.GetResponseStream());
        responseString = respStreamReader.ReadToEnd();
        respStreamReader.Close();
        myResp.Close();
        createdURL = "http://" + php_port + "/amalorpavam/website/ampws_takeeventsonline.php";
        myReq = (System.Net.HttpWebRequest)System.Net.WebRequest.Create(createdURL);
        myResp = (System.Net.HttpWebResponse)myReq.GetResponse();
        respStreamReader = new System.IO.StreamReader(myResp.GetResponseStream());
        responseString = respStreamReader.ReadToEnd();
        respStreamReader.Close();
        myResp.Close();
        createdURL = "http://" + php_port + "/amalorpavam/website/ampws_eventbookings.php";
        myReq = (System.Net.HttpWebRequest)System.Net.WebRequest.Create(createdURL);
        myResp = (System.Net.HttpWebResponse)myReq.GetResponse();
        respStreamReader = new System.IO.StreamReader(myResp.GetResponseStream());
        responseString = respStreamReader.ReadToEnd();
        respStreamReader.Close();
        myResp.Close();


        return "Data synchronised from Online & Local";
    }


}
