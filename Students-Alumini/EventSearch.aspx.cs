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


public partial class EventSearch : System.Web.UI.Page
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

            }
           

        }
    }
    private void BindBatch()
    {
        ddlBatchFrom.Items.Clear();
        for (int i = 1994; i < Convert.ToInt32(System.DateTime.Now.Year); i++)
        {
            ddlBatchFrom.Items.Add(i.ToString());
            if (i.ToString().Trim() == System.DateTime.Now.Year.ToString().Trim())
            {
                ddlBatchFrom.SelectedIndex = i;
            }
        }
        ddlBatchFrom.Items.Insert(0,"Select");

        ddlBatchTo.Items.Clear();
        for (int i = 1994; i < Convert.ToInt32(System.DateTime.Now.Year); i++)
        {
            ddlBatchTo.Items.Add(i.ToString());
            if (i.ToString().Trim() == System.DateTime.Now.Year.ToString().Trim())
            {
                ddlBatchTo.SelectedIndex = i;
            }
        }
        ddlBatchTo.Items.Insert(0, "Select");
    }

    [WebMethod]
    public static string GetEvent(string eventID)
    {
        Utilities utl = new Utilities();
        DataSet ds = new DataSet();
        string query = "";
        query = "sp_GetEventInfo " + eventID + "";
        return utl.GetDatasetTable(query, "Event").GetXml();
    }
    

    private void BindDummyRow()
    {
        HiddenField hdnID = (HiddenField)Page.Master.FindControl("hfViewPrm");
        if (hdnID.Value.ToLower() == "true")
        {
            DataTable dummy = new DataTable();
            dummy.Columns.Add("SlNo");
            dummy.Columns.Add("title");
            dummy.Columns.Add("batchfrom");
            dummy.Columns.Add("batchto");
            dummy.Columns.Add("eventdate");
            dummy.Columns.Add("venue");
            dummy.Columns.Add("Status");
            dummy.Columns.Add("eventID");
            dummy.Rows.Add();
            dgEventInfo.DataSource = dummy;
            dgEventInfo.DataBind();
        }
    }
    public static DataSet GetData(SqlCommand cmd, int pageIndex)
    {

        string strConnString = ConfigurationManager.AppSettings["SIMConnection"].ToString();
        using (SqlConnection con = new SqlConnection(strConnString))
        {
            using (SqlDataAdapter sda = new SqlDataAdapter())
            {
                cmd.Connection = con;
                sda.SelectCommand = cmd;
                using (DataSet ds = new DataSet())
                {
                    sda.Fill(ds, "EventInfo");
                    DataTable dt = new DataTable("Pager");
                    dt.Columns.Add("PageIndex");
                    dt.Columns.Add("PageSize");
                    dt.Columns.Add("RecordCount");
                    dt.Rows.Add();
                    dt.Rows[0]["PageIndex"] = pageIndex;
                    dt.Rows[0]["PageSize"] = PageSize;
                    dt.Rows[0]["RecordCount"] = cmd.Parameters["@RecordCount"].Value;
                    ds.Tables.Add(dt);
                    return ds;
                }
            }
        }
    }

    [WebMethod]
    public static string GetEventInfo(int pageIndex, string eventID, string title, string batchfrom, string batchto, string eventdate)
    {
        Utilities utl = new Utilities();

       
         string  query = "[GetEventInfo_Pager]";
        
       
        SqlCommand cmd = new SqlCommand(query);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@PageIndex", pageIndex);
        cmd.Parameters.AddWithValue("@PageSize", PageSize);
        cmd.Parameters.Add("@RecordCount", SqlDbType.Int, 4).Direction = ParameterDirection.Output;
        cmd.Parameters.AddWithValue("@title", title);
        cmd.Parameters.AddWithValue("@batchfrom", batchfrom);
        cmd.Parameters.AddWithValue("@batchto", batchto);
        cmd.Parameters.AddWithValue("@eventdate", eventdate);
        
        return GetData(cmd, pageIndex).GetXml();

    }
    [WebMethod]
    public static string GetModuleId(string path)
    {
        Utilities utl = new Utilities();
        DataSet ds = new DataSet();
        string query = "sp_GetModuleMenuIdByPath '" + path + "'," + Userid + "";
        ds = utl.GetDatasetTable(query, "ModuleMenusByPath");
        return ds.GetXml();
    }
  
    [WebMethod]
    public static string EditEventInfo(int EventInfoID)
    {
        Utilities utl = new Utilities();
        DataSet ds = new DataSet();
        string query = "";

       
            query = "sp_GetEventInfo " + EventInfoID + "'";
       
        return utl.GetDatasetTable(query, "EditEventInfo").GetXml();
    }

    [WebMethod]
    public static string DeleteEventInfo(string eventID)
    {
        Utilities utl = new Utilities();
        string sqlstr = string.Empty;
        string strQueryStatus = string.Empty;
        string message = string.Empty;
        Userid = Convert.ToInt32(HttpContext.Current.Session["UserId"]);
        strQueryStatus = utl.ExecuteQuery("sp_DeleteEventInfo " + "" + eventID + ",'" + Userid + "'");
        if (strQueryStatus == "")
            return "Deleted";
        else
            return "Delete Failed";
    }
}