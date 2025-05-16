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
using System.Web.Script.Services;
using System.Web.Script.Serialization;
using System.Xml;
using System.Runtime.Serialization.Json;
using System.Xml.Linq;
using System.Text;
using System.IO;
using Newtonsoft.Json;

public partial class AluminiSearch : System.Web.UI.Page
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
            Userid = Convert.ToInt32(Session["UserId"]);

            if (!IsPostBack)
            {
                BindBatch();
                BindDummyRow();

                Utilities utl = new Utilities();
                utl.ExecuteQuery("update amp_alumni set status=0 where aluminicode is null or alumnipwd is null");
                lblappcnt.Text = utl.ExecuteScalar("select count(*) from amp_alumni where status=1");
                lblpendcnt.Text = utl.ExecuteScalar("select count(*) from amp_alumni where status=0");
            }
            
        }
    }
    private void BindBatch()
    {
        ddlBatch.Items.Clear();
        for (int i = 1994; i < Convert.ToInt32(System.DateTime.Now.Year); i++)
        {
            ddlBatch.Items.Add(i.ToString() + " - " + (i + 1).ToString());
            if (i.ToString().Trim() == System.DateTime.Now.Year.ToString().Trim())
            {
                ddlBatch.SelectedIndex = i;
            }
        }
        ddlBatch.Items.Insert(0, "Select");
    }

    [WebMethod]
    public static string GetStudent(string StudentName, string RegNo)
    {
        Utilities utl = new Utilities();
        DataSet ds = new DataSet();
        string query = "";
        query = "sp_GetAluminiInfo " + "''" + ",'" + RegNo + "','" + StudentName + "'";
        return utl.GetDatasetTable(query,  "others", "Student").GetXml();
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

    private class Info
    {
        public string alumniID { get; set; }
        public string name { get; set; }
        public string class_from { get; set; }
        public string class_to { get; set; }
        public string year { get; set; }
        public string dob { get; set; }
        public string fothrname { get; set; }
        public string mothrname { get; set; }
        public string m_status { get; set; }
        public string religion { get; set; }
        public string spus_name { get; set; }
        public string classs { get; set; }
        public string batch { get; set; }
        public string address { get; set; }
        public string contactNo { get; set; }
        public string mobile { get; set; }
        public string emailId { get; set; }
        public string ename { get; set; }
        public string eaddress { get; set; }
        public string designation { get; set; }
        public string photoUpload { get; set; }
        public string currentStatus { get; set; }
        public string descriptionofJb { get; set; }
        public string anySuggestion { get; set; }
        public string admin_id { get; set; }
        public string status { get; set; }
        public string aluminicode { get; set; }
    }
    private void BindDummyRow()
    {
        HiddenField hdnID = (HiddenField)Page.Master.FindControl("hfViewPrm");
        if (hdnID.Value.ToLower() == "true")
        {
            DataTable dummy = new DataTable();
            dummy.Columns.Add("SlNo");
            dummy.Columns.Add("Batch");
            dummy.Columns.Add("aluminicode");
            dummy.Columns.Add("alumnipwd");
            dummy.Columns.Add("name");
            dummy.Columns.Add("mobile");
            dummy.Columns.Add("Status");
            dummy.Columns.Add("alumniID");
            dummy.Rows.Add();
            dgAluminiInfo.DataSource = dummy;
            dgAluminiInfo.DataBind();
        }
    }
    public static DataSet GetData(SqlCommand cmd, int pageIndex)
    {

        string strConnString = ConfigurationManager.AppSettings["ASSConnection"].ToString();
        using (SqlConnection con = new SqlConnection(strConnString))
        {
            using (SqlDataAdapter sda = new SqlDataAdapter())
            {
                cmd.Connection = con;
                sda.SelectCommand = cmd;
                using (DataSet ds = new DataSet())
                {
                    sda.Fill(ds, "AluminiInfo");
                    DataTable dt = new DataTable("Pager");
                    dt.Columns.Add("PageIndex");
                    dt.Columns.Add("PageSize");
                    dt.Columns.Add("RecordCount");
                    dt.Rows.Add();
                    dt.Rows[0]["PageIndex"] = pageIndex;
                    dt.Rows[0]["PageSize"] = PageSize;
                    dt.Rows[0]["RecordCount"] = ds.Tables[1].Rows[0][0];
                    ds.Tables.Add(dt);
                    return ds;
                }
            }
        }
    }

    [WebMethod]
    public static string GetAluminiInfo(int pageIndex, string alumniID, string batch, string studentname, string mobileno,string status)
    {
        Utilities utl = new Utilities();


        string query = "[GetAluminiInfo_Pager]";


        SqlCommand cmd = new SqlCommand(query);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@PageIndex", pageIndex);
        cmd.Parameters.AddWithValue("@PageSize", PageSize);
        cmd.Parameters.Add("@RecordCount", SqlDbType.Int, 4).Direction = ParameterDirection.Output;
        cmd.Parameters.AddWithValue("@batch", batch);
        cmd.Parameters.AddWithValue("@studentname", studentname);
        cmd.Parameters.AddWithValue("@mobile", mobileno);
        cmd.Parameters.AddWithValue("@status", status);
        return GetData(cmd, pageIndex).GetXml();

    }
    [WebMethod]
    public static string GetModuleId(string path)
    {
        Utilities utl = new Utilities();
        DataSet ds = new DataSet();
        string query = "sp_GetModuleMenuIdByPath '" + path + "'," + Userid + "";
        ds = utl.GetDatasetTable(query,  "others", "ModuleMenusByPath");
        return ds.GetXml();
    }

    [WebMethod]
    public static string EditAluminiInfo(int AluminiInfoID)
    {
        Utilities utl = new Utilities();
        DataSet ds = new DataSet();
        string query = "";


        query = "sp_GetAluminiInfo " + AluminiInfoID + "'";

        return utl.GetDatasetTable(query,  "others", "EditAluminiInfo").GetXml();
    }

    [WebMethod]
    public static string DeleteAluminiInfo(string alumniID)
    {
        Utilities utl = new Utilities();
        string sqlstr = string.Empty;
        string strQueryStatus = string.Empty;
        string message = string.Empty;
        Userid = Convert.ToInt32(HttpContext.Current.Session["UserId"]);
        strQueryStatus = utl.ExecuteQuery("sp_DeleteAluminiInfo " + "" + alumniID + ",'" + Userid + "'");
        if (strQueryStatus == "")
            return "Deleted";
        else
            return "Delete Failed";
    }
}