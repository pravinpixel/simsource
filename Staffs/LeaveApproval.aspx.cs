using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Web.Services;
using System.Data.SqlClient;
using System.Globalization;


public partial class Staffs_LeaveApproval : System.Web.UI.Page
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
            Userid = Convert.ToInt32(Session["UserId"]);
            hdnUserId.Value = Session["UserId"].ToString();
            if (!IsPostBack)
            {
                BindDummyRow();
                BindDesignation();
                BindAcademicYear();

            }
        }
    }

    private void BindAcademicYear()
    {
        utl = new Utilities();
        DataTable dtAcademicYear = utl.GetDataTable("exec sp_getAdmissionBelongYear");
        if (dtAcademicYear != null && dtAcademicYear.Rows.Count > 0)
        {
            ListItem currentYear = new ListItem(dtAcademicYear.Rows[0]["currentacd"].ToString(), dtAcademicYear.Rows[0]["academicid"].ToString());
            currentYear.Selected = true;
            ListItem nextYear = new ListItem(dtAcademicYear.Rows[0]["nextacd"].ToString(), "new");
            radlAcademicYear.Items.Add(currentYear);
            radlAcademicYear.Items.Add(nextYear);
        }
    }

    private void BindDummyRow()
    {
        HiddenField hdnID = (HiddenField)Page.Master.FindControl("hfViewPrm");

        if (hdnID.Value.ToLower() == "true")
        {
            DataTable dummy = new DataTable();
            dummy.Columns.Add("EmpCode");
            dummy.Columns.Add("Name");
           // dummy.Columns.Add("RoleNo");
            dummy.Columns.Add("Designation");
            dummy.Columns.Add("RequestedDate");
            dummy.Columns.Add("NoOfDays");
            dummy.Columns.Add("From");
            dummy.Columns.Add("To");
            dummy.Columns.Add("Attachment");
            dummy.Columns.Add("LeaveType");
            dummy.Columns.Add("StatusName");
            dummy.Columns.Add("StaffLeaveId");
            dummy.Rows.Add();
            grdLeaveApproval.DataSource = dummy;
            grdLeaveApproval.DataBind();
        }
    }

    protected void BindDesignation()
    {
        Utilities utl = new Utilities();
        string sqlstr = "sp_Getdesignation";
        DataTable dt = new DataTable();
        dt = utl.GetDataTable(sqlstr);

        if (dt != null && dt.Rows.Count > 0)
        {
            ddlDesignation.DataSource = dt;
            ddlDesignation.DataTextField = "DesignationName";
            ddlDesignation.DataValueField = "DesignationId";
            ddlDesignation.DataBind();
        }
        else
        {
            ddlDesignation.DataSource = null;
            ddlDesignation.DataBind();
        }
        ddlDesignation.Items.Insert(0, new ListItem("--Select---", ""));
    }
    [WebMethod]
    public static string GetSectionByClassID(int ClassID)
    {
        Utilities utl = new Utilities();
        DataSet ds = new DataSet();
        string query = "sp_GetSectionByClass " + ClassID;
        return utl.GetDatasetTable(query,  "others", "SectionByClass").GetXml();

    }
    [WebMethod]
    public static string GetLeaveApprovalList(int pageIndex, string empCode, string designation, string staffName)
    {
        Utilities utl = new Utilities();
        string query = "[SP_GETLEAVEAPPROVAL]";
        SqlCommand cmd = new SqlCommand(query);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@PageIndex", pageIndex);
        cmd.Parameters.AddWithValue("@PageSize", PageSize);
        cmd.Parameters.Add("@RecordCount", SqlDbType.Int, 4).Direction = ParameterDirection.Output;
        cmd.Parameters.AddWithValue("@StaffId", empCode);
        cmd.Parameters.AddWithValue("@Designation", designation);
        cmd.Parameters.AddWithValue("@StaffName", staffName);
        cmd.Parameters.AddWithValue("@AcademicID", HttpContext.Current.Session["AcademicID"]);
        return utl.GetData(cmd, pageIndex, "LeaveApproval", PageSize).GetXml();
    }   


    [WebMethod]
    public static string UpdateLeaveApproval(string StaffLeaveId, string status, string userId)
    {
        Utilities utl = new Utilities();

        //leaveApproval - Attendance update when only status approved  - START
         
        if (status == "1")
        {
            string StaffId = string.Empty;
            int chk_halfday, chk_noon;

            DateTime fromdate, todate;
           
            DataSet dsget_datelist = new DataSet();
            dsget_datelist = utl.GetDataset("select StaffId, LeaveFrom, LeaveTo,chk_halfday,chk_noon from e_Staffleave where StaffLeaveId= " + StaffLeaveId + " and AcademicYear='" + HttpContext.Current.Session["AcademicID"] + "' ");
           
            foreach (DataRow dr in dsget_datelist.Tables[0].Rows)
            {
                fromdate = Convert.ToDateTime(dr["LeaveFrom"]);
                todate = Convert.ToDateTime(dr["LeaveTo"]);                          
                                              
                StaffId = dr["StaffId"].ToString();

                chk_halfday = Convert.ToInt32(dr["chk_halfday"].ToString());
                chk_noon = Convert.ToInt32(dr["chk_noon"].ToString());

                if (chk_halfday == 1)
                {
                    DateTime op_date = fromdate;

                    //chk_noon [1-forenoon, 2-afternoon]
                    if (chk_noon == 1)
                    {
                        string sqlstr = "select isnull(forenoon,0) from e_StaffAttendance where EmpId='" + StaffId + "' and AttDate='" + op_date + "' and AcademicID=" + HttpContext.Current.Session["AcademicID"] + "";
                        string iCount = Convert.ToString(utl.ExecuteScalar(sqlstr));

                        if (iCount == "")
                        {
                            utl.ExecuteQuery("insert into  e_StaffAttendance(EmpId,attdate,forenoon,userid,AcademicID)values('" + StaffId + "','" + op_date + "','true'," + userId + "," + HttpContext.Current.Session["AcademicID"] + ")");                           

                        }
                        else
                        {
                            if (iCount == "True")
                            {
                                utl.ExecuteQuery("update e_StaffAttendance set forenoon=null where AcademicID=" + HttpContext.Current.Session["AcademicID"] + "  and EmpId='" + StaffId + "' and attdate=" + op_date + "");
                            }
                            else if (iCount == "False")
                            {
                                utl.ExecuteQuery("update e_StaffAttendance set forenoon='true'where AcademicID=" + HttpContext.Current.Session["AcademicID"] + " and EmpId='" + StaffId + "' and attdate=" + op_date + "");
                            }                                                        
                        }
                    }
                    else if (chk_noon == 2)                    
                    {
                        string sqlstr = "select isnull(afternoon,0) from e_StaffAttendance where EmpId='" + StaffId + "' and AttDate='" + op_date + "' and AcademicID=" + HttpContext.Current.Session["AcademicID"] + "";
                        string iCount = Convert.ToString(utl.ExecuteScalar(sqlstr));

                        if (iCount == "")
                        {
                            utl.ExecuteQuery("insert into  e_StaffAttendance(EmpId,attdate,afternoon,userid,AcademicID)values('" + StaffId + "','" + op_date + "','true'," + userId + "," + HttpContext.Current.Session["AcademicID"] + ")");                           

                        }
                        else
                        {
                            if (iCount == "True")
                            {
                                utl.ExecuteQuery("update e_StaffAttendance set afternoon=null where AcademicID=" + HttpContext.Current.Session["AcademicID"] + " and  EmpId='" + StaffId + "' and attdate=" + op_date + "");
                            }
                            else if (iCount == "False")
                            {
                                utl.ExecuteQuery("update e_StaffAttendance set afternoon='true' where AcademicID=" + HttpContext.Current.Session["AcademicID"] + " and EmpId='" + StaffId + "' and attdate=" + op_date + "");
                            }

                         }

                    }
                    
                }
                else
                {                    
                    for (DateTime op_date = fromdate; op_date <= todate; op_date = op_date.AddDays(1))
                    {
                        string sqlstr = "select isnull(forenoon,0) from e_StaffAttendance where EmpId='" + StaffId + "' and AttDate='" + op_date + "' and AcademicID=" + HttpContext.Current.Session["AcademicID"] + "";
                        string iCount = Convert.ToString(utl.ExecuteScalar(sqlstr));

                        if (iCount == "")
                        {
                            //insert 
                            utl.ExecuteQuery("insert into  e_StaffAttendance(EmpId,attdate,forenoon, afternoon,userid,AcademicID)values('" + StaffId + "','" + op_date + "','true', 'true'," + userId + "," + HttpContext.Current.Session["AcademicID"] + ")");

                        }
                        else
                        {
                            //update
                            utl.ExecuteQuery("update e_StaffAttendance set forenoon='true',afternoon='true' where AcademicID=" + HttpContext.Current.Session["AcademicID"] + " and EmpId='" + StaffId + "' and attdate='" + op_date + "'");
                        }
                    }
                }
                
            }
          
        }
         
        //leaveApproval - Attendance update when only status approved  - END


        string returnVal = utl.ExecuteQuery("update e_Staffleave set statusID='" + status + "',userid='" + userId + "', ApprovedBy='" + userId + "'  where StaffLeaveId= " + StaffLeaveId + " and AcademicYear='" + HttpContext.Current.Session["AcademicID"] + "'");
        if (returnVal == "")
            return "Updated";
        else
            return "Update Failed";       
          
    }

    [WebMethod]
    public static string GetDpStatus()
    {
        Utilities utl = new Utilities();
        string query = "select statusid,statusname from m_approvestatus where isactive='true'";
        DataSet ds = new DataSet();
        ds = utl.GetDataset(query);
        StringBuilder sb=new StringBuilder();
         sb.Append("<select>");
        foreach (DataRow dr in ds.Tables[0].Rows)
        {
            sb.Append("<option value=\"" + dr["statusid"].ToString() + "\">" + dr["statusname"].ToString() + "</option>");
        }
        sb.Append("</select>");
        return sb.ToString();
    }

}