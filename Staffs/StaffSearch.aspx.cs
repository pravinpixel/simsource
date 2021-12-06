using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Services;
using System.Data.SqlClient;
using System.Configuration;

public partial class Staffs_StaffSearch : System.Web.UI.Page
{
    Utilities utl = null;
    private static int PageSize = 10;
    string sqlstr = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.chkUser();
        BindDummyRow();
        BindHdnValues();
        BndPlaceofwork();
        BindDepartment();
        BindDesignation();
        BindSubjectUpto();
        BindReligion();
        BindBloodGroup();
    }
    private void BindBloodGroup()
    {
        utl = new Utilities();
        sqlstr = "[sp_GetBloodGroup]";
        DataTable dt = new DataTable();
        dt = utl.GetDataTable(sqlstr);

        if (dt != null && dt.Rows.Count > 0)
        {
            ddlBloodGroup.DataSource = dt;
            ddlBloodGroup.DataTextField = "BloodGroupName";
            ddlBloodGroup.DataValueField = "BloodGroupID";
            ddlBloodGroup.DataBind();
        }
        else
        {
            ddlBloodGroup.DataSource = null;
            ddlBloodGroup.DataBind();
        }

        ddlBloodGroup.Items.Insert(0, new ListItem("--Select---", ""));
    }
    private void BindReligion()
    {
        utl = new Utilities();
        sqlstr = "sp_GetReligion";
        DataTable dt = new DataTable();
        dt = utl.GetDataTable(sqlstr);

        if (dt != null && dt.Rows.Count > 0)
        {
            ddlReligion.DataSource = dt;
            ddlReligion.DataTextField = "ReligionName";
            ddlReligion.DataValueField = "ReligionId";
            ddlReligion.DataBind();
        }
        else
        {
            ddlReligion.DataSource = null;
            ddlReligion.DataBind();
        }
        ddlReligion.Items.Insert(0, new ListItem("--Select---", ""));
    }
    private void BindDepartment()
    {
        utl = new Utilities();
        sqlstr = "[sp_GetDepartment]";
        DataTable dt = new DataTable();
        dt = utl.GetDataTable(sqlstr);

        if (dt != null && dt.Rows.Count > 0)
        {
            ddlDepartment.DataSource = dt;
            ddlDepartment.DataTextField = "DepartmentName";
            ddlDepartment.DataValueField = "DepartmentId";
            ddlDepartment.DataBind();         

        }
        else
        {
            ddlDepartment.DataSource = null;
            ddlDepartment.DataBind();            
        }

        ddlDepartment.Items.Insert(0, new ListItem("--Select---", ""));
       

    }

    private void BindDesignation()
    {
        utl = new Utilities();
        sqlstr = "sp_Getdesignation";
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

    private void BindSubjectUpto()
    {
        utl = new Utilities();
        sqlstr = "[sp_GetSubExperience]";
        DataTable dt = new DataTable();
        dt = utl.GetDataTable(sqlstr);

        if (dt != null && dt.Rows.Count > 0)
        {

            ddlSubject.DataSource = dt;
            ddlSubject.DataTextField = "SubExperienceName";
            ddlSubject.DataValueField = "SubExperienceId";
            ddlSubject.DataBind();

        }
        else
        {

            ddlSubject.DataSource = null;
            ddlSubject.DataBind();
        }
        ddlSubject.Items.Insert(0, new ListItem("--Select---", ""));
    }
    private void BndPlaceofwork()
    {
        Utilities utl = new Utilities();
        DataSet ds = new DataSet();
        ds = utl.GetDataset("sp_getplaceofwork ");
        if (ds.Tables[0].Rows.Count > 0)
        {
            ddlPlace.DataSource = ds.Tables[0];
            ddlPlace.DataTextField = "Placeofwork";
            ddlPlace.DataValueField = "PlaceofworkID";
            ddlPlace.DataBind();
        }
        else
        {
            ddlPlace.DataSource = null;
        }
        ddlPlace.Items.Insert(0, new ListItem("--Select---", ""));
    }
    private void BindHdnValues()
    {
        if (Request.QueryString["menuId"] != null)
            hdnContentMenuId.Value = Request.QueryString["menuId"].ToString();
        if (Request.QueryString["activeIndex"] != null)
            hdnContentActiveIndex.Value = Request.QueryString["activeIndex"].ToString();
        BindModuleMenuId();       
    }
    private void BindModuleMenuId()
    {
        if (Session["UserId"] != null)
        {
            string userId = Session["UserId"].ToString();
            string path = "Staffs/StaffInfo.aspx";
            string query = "sp_GetModuleMenuId'" + path + "'," + userId + "";

            Utilities utl = new Utilities();
            DataSet ds = new DataSet();
            ds = utl.GetDatasetTable(query, "ModuleMenusByPath");

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                hdnContentMenuId.Value = ds.Tables[0].Rows[0]["menuid"].ToString();
                hdnContentModuleId.Value = ds.Tables[0].Rows[0]["modulemenuid"].ToString();
            }
        }
    }
    private void BindDummyRow()
    {
        HiddenField hdnID = (HiddenField)Page.Master.FindControl("hfViewPrm");

        if (hdnID.Value.ToLower() == "true")
        {
            DataTable dummy = new DataTable();
            dummy.Columns.Add("SlNo");
            dummy.Columns.Add("EmpCode");
            dummy.Columns.Add("StaffName");
            dummy.Columns.Add("Designation");
            dummy.Columns.Add("Placeofwork");
            dummy.Columns.Add("PresentStatus");
            dummy.Columns.Add("StaffId");

            dummy.Rows.Add();
            dgStaffInfo.DataSource = dummy;
            dgStaffInfo.DataBind();
        }
    }
    
    
    [WebMethod]
    public static string GetStaffInfo(int index, string code, string name, string designation, string sex, string pNo, string emailId, string department, string presentstatus, string placeofwork, string bloodgroup, string religion, string subjecthandling)
    {
        Utilities utl = new Utilities();

        if (string.IsNullOrEmpty(code))code = "null";else code = "'" + code + "'";
        if (string.IsNullOrEmpty(name)) name = "null"; else name = "'" + name.Replace("'", "''") + "'";
        if (string.IsNullOrEmpty(designation)) designation = "null"; else designation = "'" + designation + "'";
        if (string.IsNullOrEmpty(sex)) sex = "null"; else sex = "'" + sex + "'";
        if (string.IsNullOrEmpty(pNo)) pNo = "null"; else pNo = "'" + pNo + "'";
        if (string.IsNullOrEmpty(emailId)) emailId = "null"; else emailId = "'" + emailId + "'";
        if (string.IsNullOrEmpty(department)) department = "null"; else department = "'" + department + "'";
        if (string.IsNullOrEmpty(presentstatus)) presentstatus = "null"; else presentstatus = "'" + presentstatus + "'";
        if (string.IsNullOrEmpty(placeofwork)) placeofwork = "null"; else placeofwork = "'" + placeofwork + "'";
        if (string.IsNullOrEmpty(bloodgroup)) bloodgroup = "null"; else bloodgroup = "'" + bloodgroup + "'";
        if (string.IsNullOrEmpty(religion)) religion = "null"; else religion = "'" + religion + "'";
        if (string.IsNullOrEmpty(subjecthandling)) subjecthandling = "null"; else subjecthandling = "'" + subjecthandling + "'";

        string query = "[GetStaffInfo_Pager] " + index + "," + PageSize + "," + 10 + "," + code + "," + name + "," + designation + "," + sex + "," + pNo + "," + emailId + "," + department + "," + presentstatus + "," + placeofwork + "," + bloodgroup + "," + religion + "," + subjecthandling + ",'" + HttpContext.Current.Session["AcademicID"] + "'";
        DataSet ds= utl.GetDatasetTable(query, "StaffInfo");
        DataTable dt = new DataTable("Pager");
        dt.Columns.Add("PageIndex");
        dt.Columns.Add("PageSize");
        dt.Columns.Add("RecordCount");
        dt.Rows.Add();
        dt.Rows[0]["PageIndex"] = index;
        dt.Rows[0]["PageSize"] = PageSize;
        dt.Rows[0]["RecordCount"] = ds.Tables[1].Rows[0][0];
        ds.Tables.Add(dt);
        return ds.GetXml();
    }
    
    [WebMethod]
    public static string GetEmployee(string staffName,string empCode)
    {
        Utilities utl = new Utilities();
        string query = "[sp_GetEmployee] '','" + staffName.Replace("'","''") + "','" + empCode + "'";
        DataSet ds = utl.GetDatasetTable(query, "Employee");
        return ds.GetXml();
    }

    [WebMethod]
    public static string TransferToCBSE(int staffID)
    {
        try
        {
            Utilities utl = new Utilities();
            string insertedStaffID = string.Empty;
            string tpl_fields = string.Empty;
            string tpl_fields_new = string.Empty;

            string dyntpl_cbse = string.Empty;
            string dyntpl_schl = string.Empty;
            string query = string.Empty;

            string strConnString_school = ConfigurationManager.AppSettings["SIMConnection"].ToString();
            string strConnString_cbse = ConfigurationManager.AppSettings["SIMCBSEConnection"].ToString();

            SqlConnectionStringBuilder schl_builder = new SqlConnectionStringBuilder(strConnString_school);
            SqlConnectionStringBuilder cbse_builder = new SqlConnectionStringBuilder(strConnString_cbse);

            string db_schl = schl_builder.InitialCatalog;
            string db_cbse = cbse_builder.InitialCatalog;


            //staff info insert
            dyntpl_cbse = db_cbse + ".dbo.e_staffinfo";
            dyntpl_schl = db_schl + ".dbo.e_staffinfo";
            tpl_fields = utl.ExecuteScalar("sp_GetFieldName 'e_staffinfo'");

            query = "INSERT INTO " + dyntpl_cbse + " (" + tpl_fields + ") SELECT " + tpl_fields + " FROM " + dyntpl_schl + " where StaffId=" + staffID + " SELECT SCOPE_IDENTITY() as lastinsertid";
            insertedStaffID = utl.ExecuteScalar(query);
            

            //e_staffacademicinfo insert
            dyntpl_cbse = db_cbse + ".dbo.e_staffacademicinfo";
            dyntpl_schl = db_schl + ".dbo.e_staffacademicinfo";
            tpl_fields = utl.ExecuteScalar("sp_GetFieldName 'e_staffacademicinfo'");
            tpl_fields_new = tpl_fields.Replace("StaffId", "'" + insertedStaffID + "'");

            query = "INSERT INTO " + dyntpl_cbse + " (" + tpl_fields + ") SELECT " + tpl_fields_new + " FROM " + dyntpl_schl + " where StaffId=" + staffID + "";
            utl.ExecuteQuery(query);


            //e_staffacdservices insert
            dyntpl_cbse = db_cbse + ".dbo.e_staffacdservices";
            dyntpl_schl = db_schl + ".dbo.e_staffacdservices";
            tpl_fields = utl.ExecuteScalar("sp_GetFieldName 'e_staffacdservices'");
            tpl_fields_new = tpl_fields.Replace("StaffId", "'" + insertedStaffID + "'");

            query = "INSERT INTO " + dyntpl_cbse + " (" + tpl_fields + ") SELECT " + tpl_fields_new + " FROM " + dyntpl_schl + " where StaffId=" + staffID + "";
            utl.ExecuteQuery(query);

            
            //e_staffattendance insert
           /* dyntpl_cbse = db_cbse + ".dbo.e_staffattendance";
            dyntpl_schl = db_schl + ".dbo.e_staffattendance";
            tpl_fields = utl.ExecuteScalar("sp_GetFieldName 'e_staffattendance'");
            tpl_fields_new = tpl_fields.Replace("StaffId", "'" + insertedStaffID + "'");

            query = "INSERT INTO " + dyntpl_cbse + " (" + tpl_fields + ") SELECT " + tpl_fields_new + " FROM " + dyntpl_schl + " where StaffId=" + staffID + "";
            utl.ExecuteQuery(query);*/


            //e_staffcareerservice insert
            dyntpl_cbse = db_cbse + ".dbo.e_staffcareerservice";
            dyntpl_schl = db_schl + ".dbo.e_staffcareerservice";
            tpl_fields = utl.ExecuteScalar("sp_GetFieldName 'e_staffcareerservice'");
            tpl_fields_new = tpl_fields.Replace("StaffId", "'" + insertedStaffID + "'");

            query = "INSERT INTO " + dyntpl_cbse + " (" + tpl_fields + ") SELECT " + tpl_fields_new + " FROM " + dyntpl_schl + " where StaffId=" + staffID + "";
            utl.ExecuteQuery(query);


            //e_stafffamilyinfo insert
            dyntpl_cbse = db_cbse + ".dbo.e_stafffamilyinfo";
            dyntpl_schl = db_schl + ".dbo.e_stafffamilyinfo";
            tpl_fields = utl.ExecuteScalar("sp_GetFieldName 'e_stafffamilyinfo'");
            tpl_fields_new = tpl_fields.Replace("StaffId", "'" + insertedStaffID + "'");

            query = "INSERT INTO " + dyntpl_cbse + " (" + tpl_fields + ") SELECT " + tpl_fields_new + " FROM " + dyntpl_schl + " where StaffId=" + staffID + "";
            utl.ExecuteQuery(query);


            //e_staffinvigilation insert
            dyntpl_cbse = db_cbse + ".dbo.e_staffinvigilation";
            dyntpl_schl = db_schl + ".dbo.e_staffinvigilation";
            tpl_fields = utl.ExecuteScalar("sp_GetFieldName 'e_staffinvigilation'");
            tpl_fields_new = tpl_fields.Replace("StaffId", "'" + insertedStaffID + "'");

            query = "INSERT INTO " + dyntpl_cbse + " (" + tpl_fields + ") SELECT " + tpl_fields_new + " FROM " + dyntpl_schl + " where StaffId=" + staffID + "";
            utl.ExecuteQuery(query);


            //e_stafflangknownservices insert
            dyntpl_cbse = db_cbse + ".dbo.e_stafflangknownservices";
            dyntpl_schl = db_schl + ".dbo.e_stafflangknownservices";
            tpl_fields = utl.ExecuteScalar("sp_GetFieldName 'e_stafflangknownservices'");
            tpl_fields_new = tpl_fields.Replace("StaffId", "'" + insertedStaffID + "'");

            query = "INSERT INTO " + dyntpl_cbse + " (" + tpl_fields + ") SELECT " + tpl_fields_new + " FROM " + dyntpl_schl + " where StaffId=" + staffID + "";
            utl.ExecuteQuery(query);


            //e_stafflangservices insert
            dyntpl_cbse = db_cbse + ".dbo.e_stafflangservices";
            dyntpl_schl = db_schl + ".dbo.e_stafflangservices";
            tpl_fields = utl.ExecuteScalar("sp_GetFieldName 'e_stafflangservices'");
            tpl_fields_new = tpl_fields.Replace("StaffId", "'" + insertedStaffID + "'");

            query = "INSERT INTO " + dyntpl_cbse + " (" + tpl_fields + ") SELECT " + tpl_fields_new + " FROM " + dyntpl_schl + " where StaffId=" + staffID + "";
            utl.ExecuteQuery(query);


            //e_staffleave insert
            dyntpl_cbse = db_cbse + ".dbo.e_staffleave";
            dyntpl_schl = db_schl + ".dbo.e_staffleave";
            tpl_fields = utl.ExecuteScalar("sp_GetFieldName 'e_staffleave'");
            tpl_fields_new = tpl_fields.Replace("StaffId", "'" + insertedStaffID + "'");

            query = "INSERT INTO " + dyntpl_cbse + " (" + tpl_fields + ") SELECT " + tpl_fields_new + " FROM " + dyntpl_schl + " where StaffId=" + staffID + "";
            utl.ExecuteQuery(query);


            //e_staffleaveallocation insert
            dyntpl_cbse = db_cbse + ".dbo.e_staffleaveallocation";
            dyntpl_schl = db_schl + ".dbo.e_staffleaveallocation";
            tpl_fields = utl.ExecuteScalar("sp_GetFieldName 'e_staffleaveallocation'");
            tpl_fields_new = tpl_fields.Replace("StaffID", "'" + insertedStaffID + "'");

            query = "INSERT INTO " + dyntpl_cbse + " (" + tpl_fields + ") SELECT " + tpl_fields_new + " FROM " + dyntpl_schl + " where StaffID=" + staffID + "";
            utl.ExecuteQuery(query);


            //e_staffmedicalrecords insert
            dyntpl_cbse = db_cbse + ".dbo.e_staffmedicalrecords";
            dyntpl_schl = db_schl + ".dbo.e_staffmedicalrecords";
            tpl_fields = utl.ExecuteScalar("sp_GetFieldName 'e_staffmedicalrecords'");
            tpl_fields_new = tpl_fields.Replace("StaffId", "'" + insertedStaffID + "'");

            query = "INSERT INTO " + dyntpl_cbse + " (" + tpl_fields + ") SELECT " + tpl_fields_new + " FROM " + dyntpl_schl + " where StaffId=" + staffID + "";
            utl.ExecuteQuery(query);


            //e_staffmodes insert
           /*   dyntpl_cbse = db_cbse + ".dbo.e_staffmodes";
            dyntpl_schl = db_schl + ".dbo.e_staffmodes";
            tpl_fields = utl.ExecuteScalar("sp_GetFieldName 'e_staffmodes'");
            tpl_fields_new = tpl_fields.Replace("StaffId", "'" + insertedStaffID + "'");

            query = "INSERT INTO " + dyntpl_cbse + " (" + tpl_fields + ") SELECT " + tpl_fields_new + " FROM " + dyntpl_schl + " where StaffId=" + staffID + "";
            utl.ExecuteQuery(query); */


            //e_staffnominees insert
            dyntpl_cbse = db_cbse + ".dbo.e_staffnominees";
            dyntpl_schl = db_schl + ".dbo.e_staffnominees";
            tpl_fields = utl.ExecuteScalar("sp_GetFieldName 'e_staffnominees'");
            tpl_fields_new = tpl_fields.Replace("StaffId", "'" + insertedStaffID + "'");

            query = "INSERT INTO " + dyntpl_cbse + " (" + tpl_fields + ") SELECT " + tpl_fields_new + " FROM " + dyntpl_schl + " where StaffId=" + staffID + "";
            utl.ExecuteQuery(query);


            //e_staffpunishment insert
            dyntpl_cbse = db_cbse + ".dbo.e_staffpunishment";
            dyntpl_schl = db_schl + ".dbo.e_staffpunishment";
            tpl_fields = utl.ExecuteScalar("sp_GetFieldName 'e_staffpunishment'");
            tpl_fields_new = tpl_fields.Replace("StaffId", "'" + insertedStaffID + "'");

            query = "INSERT INTO " + dyntpl_cbse + " (" + tpl_fields + ") SELECT " + tpl_fields_new + " FROM " + dyntpl_schl + " where StaffId=" + staffID + "";
            utl.ExecuteQuery(query);


            //e_staffrelation insert
            dyntpl_cbse = db_cbse + ".dbo.e_staffrelation";
            dyntpl_schl = db_schl + ".dbo.e_staffrelation";
            tpl_fields = utl.ExecuteScalar("sp_GetFieldName 'e_staffrelation'");
            tpl_fields_new = tpl_fields.Replace("StaffID", "'" + insertedStaffID + "'");

            query = "INSERT INTO " + dyntpl_cbse + " (" + tpl_fields + ") SELECT " + tpl_fields_new + " FROM " + dyntpl_schl + " where StaffID=" + staffID + "";
            utl.ExecuteQuery(query);


            //e_staffremarks insert
            dyntpl_cbse = db_cbse + ".dbo.e_staffremarks";
            dyntpl_schl = db_schl + ".dbo.e_staffremarks";
            tpl_fields = utl.ExecuteScalar("sp_GetFieldName 'e_staffremarks'");
            tpl_fields_new = tpl_fields.Replace("StaffId", "'" + insertedStaffID + "'");

            query = "INSERT INTO " + dyntpl_cbse + " (" + tpl_fields + ") SELECT " + tpl_fields_new + " FROM " + dyntpl_schl + " where StaffId=" + staffID + "";
            utl.ExecuteQuery(query);


            //e_staffresign insert
            dyntpl_cbse = db_cbse + ".dbo.e_staffresign";
            dyntpl_schl = db_schl + ".dbo.e_staffresign";
            tpl_fields = utl.ExecuteScalar("sp_GetFieldName 'e_staffresign'");
            tpl_fields_new = tpl_fields.Replace("StaffId", "'" + insertedStaffID + "'");

            query = "INSERT INTO " + dyntpl_cbse + " (" + tpl_fields + ") SELECT " + tpl_fields_new + " FROM " + dyntpl_schl + " where StaffId=" + staffID + "";
            utl.ExecuteQuery(query);


            //e_staffretirement insert
            dyntpl_cbse = db_cbse + ".dbo.e_staffretirement";
            dyntpl_schl = db_schl + ".dbo.e_staffretirement";
            tpl_fields = utl.ExecuteScalar("sp_GetFieldName 'e_staffretirement'");
            tpl_fields_new = tpl_fields.Replace("StaffId", "'" + insertedStaffID + "'");

            query = "INSERT INTO " + dyntpl_cbse + " (" + tpl_fields + ") SELECT " + tpl_fields_new + " FROM " + dyntpl_schl + " where StaffId=" + staffID + "";
            utl.ExecuteQuery(query);


            //e_staffsalaryinfo insert
            dyntpl_cbse = db_cbse + ".dbo.e_staffsalaryinfo";
            dyntpl_schl = db_schl + ".dbo.e_staffsalaryinfo";
            tpl_fields = utl.ExecuteScalar("sp_GetFieldName 'e_staffsalaryinfo'");
            tpl_fields_new = tpl_fields.Replace("StaffID", "'" + insertedStaffID + "'");

            query = "INSERT INTO " + dyntpl_cbse + " (" + tpl_fields + ") SELECT " + tpl_fields_new + " FROM " + dyntpl_schl + " where StaffID=" + staffID + "";
            utl.ExecuteQuery(query);


            //e_staffundergoing insert
            dyntpl_cbse = db_cbse + ".dbo.e_staffundergoing";
            dyntpl_schl = db_schl + ".dbo.e_staffundergoing";
            tpl_fields = utl.ExecuteScalar("sp_GetFieldName 'e_staffundergoing'");
            tpl_fields_new = tpl_fields.Replace("StaffId", "'" + insertedStaffID + "'");

            query = "INSERT INTO " + dyntpl_cbse + " (" + tpl_fields + ") SELECT " + tpl_fields_new + " FROM " + dyntpl_schl + " where StaffId=" + staffID + "";
            utl.ExecuteQuery(query);


            query = "update e_staffinfo set IsActive=0, TransferRefID = '" + insertedStaffID + "'  where StaffId=" + staffID + "";

            string strQueryStatus = utl.ExecuteQuery(query);
            if (strQueryStatus == "")
                return "Transfer";
            else
                return "Transfer Failed";
            
        }

        catch (Exception ex)
        {
            return ex.Message;
        }

    }

    
}




