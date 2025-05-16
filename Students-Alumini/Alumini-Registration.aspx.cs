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

public partial class Students_Alumini_Alumini_Registration : System.Web.UI.Page
{
    Utilities utl = null;
    string sqlstr = "";
    public static int Userid = 0;
    private static int PageSize = 10;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.RequestType == "POST")
        {
            if (Request.Files["AluminiImage"] != null && Request.Files["AluminiImage"].ContentLength > 0 && Request.Form["aluminiID"] != null && Request.Form["aluminiID"].Length > 0)
            {
                HttpPostedFile PostedFile = Request.Files["AluminiImage"];
                string id = Request.Form["aluminiID"].ToString();
                utl = new Utilities();
                string extension = PostedFile.FileName.Substring(PostedFile.FileName.LastIndexOf('.'));
                if (File.Exists(Server.MapPath("~/Students-Alumini/Uploads/ProfilePhotos/" + Request.Form["aluminiID"] + extension)))
                {
                    File.Delete(Server.MapPath("~/Students-Alumini/Uploads/ProfilePhotos/" + Request.Form["aluminiID"] + extension));
                }
                PostedFile.SaveAs(Server.MapPath("~/Students-Alumini/Uploads/ProfilePhotos/" + Request.Form["aluminiID"] + extension));

            }
            return;
        }
        Master.chkUser();
        if (Session["UserId"] == null || Session["AcademicID"] == null)
        {
            Response.Redirect("Default.aspx?ses=expired");
        }
        else
        {
            if (Session["UserId"] != null)
                hdnUserId.Value = Session["UserId"].ToString();
            if (Request.Params["alumniID"] != null)
                hfAlumniID.Value = Request.Params["alumniID"].ToString();

            else
                hfAlumniID.Value = "";
        }
        if (!IsPostBack)
        {
            BindBatch();
            BindDummyRow();
        }
    }
    private void BindDummyRow()
    {
        HiddenField hdnID = (HiddenField)Page.Master.FindControl("hfViewPrm");

        if (hdnID.Value.ToLower() == "true")
        {
            DataTable dummy = new DataTable();
            dummy.Columns.Add("Course");
            dummy.Columns.Add("board_univ");
            dummy.Columns.Add("year_of_complete");
            dummy.Columns.Add("id");
            dummy.Rows.Add();
            dgGraduation.DataSource = dummy;
            dgGraduation.DataBind();
        }
    }

    private void BindBatch()
    {
        ddlBatch.Items.Clear();
        for (int i = 1994; i < Convert.ToInt32(System.DateTime.Now.Year); i++)
        {
            ddlBatch.Items.Add(i.ToString() + " - " + (i + 1).ToString());
            ddlYOC.Items.Add(i.ToString());
            if (i.ToString().Trim() == System.DateTime.Now.Year.ToString().Trim())
            {
                ddlBatch.SelectedIndex = i;
                ddlYOC.SelectedIndex = i;
            }
        }
    }

    [WebMethod]
    public static string GetGraduationInfo(int alumniID)
    {
        Utilities utl = new Utilities();
        DataSet ds = new DataSet();
        string query = "";

        query = "sp_GetGraduationInfo " + alumniID + "";

        return utl.GetDatasetTable(query,  "others", "GraduationInfo").GetXml();
    }


    [WebMethod]
    public static string GetAluminiInfo(int alumniID)
    {
        Utilities utl = new Utilities();
        DataSet ds = new DataSet();
        string query = "";

        query = "sp_GetAluminiInfo " + alumniID + "";

        return utl.GetDatasetTable(query,  "others", "AluminiInfo").GetXml();
    }

    [WebMethod]
    public static string SaveAlumini(string aluminiid, string name, string classfrom, string classto, string batch, string dob, string father, string mother, string maritalstatus, string religion, string address, string landline, string mobile, string email, string ename, string eaddress, string edesignation, string photopath, string photofile, string Status)
    {
        Utilities utl = new Utilities();
        string sqlstr = string.Empty;
        string strQueryStatus = string.Empty;
        string message = string.Empty;
        Userid = Convert.ToInt32(HttpContext.Current.Session["UserId"]);
        if (dob != "")
        {
            string[] myDateTimeString = dob.Split('/');
            dob = "'" + myDateTimeString[2] + "-" + myDateTimeString[1] + "-" + myDateTimeString[0] + "'";
        }
        string fileExtension = photofile.Substring(photofile.LastIndexOf('.') + 1);


        sqlstr = "sp_SaveAlumini " + "'" + aluminiid + "','" + name.Replace("'", "''") + "','" + classfrom + "','" + classto + "','" + batch + "'," + dob + ",'" + father + "','" + mother + "','" + maritalstatus + "','" + religion + "','" + address + "','" + landline + "','" + mobile + "','" + email + "','" + ename + "','" + eaddress + "','" + edesignation + "','" + Userid + "','" + Status + "'";
        strQueryStatus = utl.ExecuteScalar(sqlstr);

        sqlstr = "select isnull(count(*),0) from a_addressbook where Name='" + name.Replace("'", "''") + "' and AddressType='Alumni' and Email='" + email.Replace("'", "''") + "' and MobileNo1='" + mobile.Replace("'", "''") + "'  and isactive=1";
            string iCount = Convert.ToString(utl.ExecuteScalar(sqlstr));
            if (iCount == "0")
            {
                sqlstr = "sp_InsertAddress '','" + name.Replace("'", "''") + "','" + address.Replace("'", "''") + "','Alumni','Alumni','" + email.Replace("'", "''") + "','" + mobile.Replace("'", "''") + "','','','" + Userid + "'";
                utl.ExecuteQuery(sqlstr);
            }
        string aluminino = strQueryStatus;
        string pwd = Convert.ToString(utl.ExecuteScalar("SELECT LEFT(NEWID(), 6)"));
        if (photofile != "")
        {
            string extension = photofile.Substring(photofile.LastIndexOf('.'));

            sqlstr = "update amp_alumni set photoUpload= convert(varchar,'" + aluminino + extension + "'), aluminicode = ('AL'+'-'+ convert(varchar, year(GETDATE())) +'-'+  REPLACE(STR(" + aluminino + ",3),' ','0')), alumnipwd='" + pwd + "'  where alumniID='" + aluminino + "'";
            utl.ExecuteQuery(sqlstr);
        }
        else
        {
            string alumnipwd = utl.ExecuteScalar("select alumnipwd from amp_alumni where alumniID='" + aluminino + "'");
            if (alumnipwd == "" || alumnipwd == null)
            {
                sqlstr = "update amp_alumni set  aluminicode = ('AL'+'-'+ convert(varchar, year(GETDATE())) +'-'+  REPLACE(STR(" + aluminino + ",3),' ','0')), alumnipwd='" + pwd + "' where alumniID='" + aluminino + "'";
                utl.ExecuteQuery(sqlstr);
            }

        }

        if (strQueryStatus != "")
        {
            return strQueryStatus;
        }
        else
        {
            return "Update Failed";
        }

    }

    [WebMethod]

    public static string SaveGraduationdetails(string AluminiID, string Course, string Board, string YOC)
    {
        Utilities utl = new Utilities();
        string sqlstr = string.Empty;
        string strQueryStatus = string.Empty;
        string message = string.Empty;
        Userid = Convert.ToInt32(HttpContext.Current.Session["UserId"]);


        sqlstr = "sp_UpdateGraduationInfo " + "'" + AluminiID + "','" + Course.Replace("'", "''") + "','" + Board + "','" + YOC + "'";
        strQueryStatus = utl.ExecuteQuery(sqlstr);
        if (strQueryStatus == "")
            return "Updated";
        else
            return "Update Failed";

    }

    [WebMethod]

    public static string DeleteGraduationdetails(string id)
    {
        Utilities utl = new Utilities();
        string sqlstr = string.Empty;
        string strQueryStatus = string.Empty;
        string message = string.Empty;
        Userid = Convert.ToInt32(HttpContext.Current.Session["UserId"]);

        sqlstr = "sp_DeleteGraduationInfo " + "'" + id + "'";
        strQueryStatus = utl.ExecuteQuery(sqlstr);
        if (strQueryStatus == "")
            return "Deleted";
        else
            return "Delete Fail";

    }

}