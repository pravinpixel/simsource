using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Services;
using System.Globalization;
using System.IO;

public partial class AddEvent : System.Web.UI.Page
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
            if (Session["UserId"] != null)
                hdnUserId.Value = Session["UserId"].ToString();
            if (Request.Params["eventID"] != null)
                hfEventID.Value = Request.Params["eventID"].ToString();

            else
                hfEventID.Value = "";
        }
        if (!IsPostBack)
        {
            BindBatch();
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
        ddlBatchTo.Items.Clear();
        for (int i = 1994; i < Convert.ToInt32(System.DateTime.Now.Year); i++)
        {
            ddlBatchTo.Items.Add(i.ToString());
            if (i.ToString().Trim() == System.DateTime.Now.Year.ToString().Trim())
            {
                ddlBatchTo.SelectedIndex = i;
            }
        }
    }



    [WebMethod]
    public static string GetEventInfo(int eventID)
    {
        Utilities utl = new Utilities();
        DataSet ds = new DataSet();
        string query = "";

        query = "sp_GetEventInfo " + eventID + "";

        return utl.GetDatasetTable(query,  "others", "EventInfo").GetXml();
    }

    [WebMethod]
    public static string SaveEvent(string eventid, string title, string description, string batchfrom, string batchto, string eventdate, string eventtime, string venue, string others, string Status)
    {
        Utilities utl = new Utilities();
        string sqlstr = string.Empty;
        string strQueryStatus = string.Empty;
        string message = string.Empty;
        Userid = Convert.ToInt32(HttpContext.Current.Session["UserId"]);
        if (eventdate != "")
        {
            string[] myDateTimeString = eventdate.Split('/');
            eventdate = "'" + myDateTimeString[2] + "/" + myDateTimeString[0] + "/" + myDateTimeString[1] + "'";
        }


        sqlstr = "sp_SaveEvent " + "'" + eventid + "','" + title.Replace("'", "''") + "','" + description.Replace("'", "''") + "','" + batchfrom + "','" + batchto + "'," + eventdate + ",'" + eventtime + "','" + venue + "','" + others + "','" + Userid + "','" + Status + "'";
        strQueryStatus = utl.ExecuteScalar(sqlstr);

        if (strQueryStatus != "")
        {
            return strQueryStatus;
        }
        else
        {
            return "Update Failed";
        }

    }



}