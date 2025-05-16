using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data;
using System.IO;
using System.Xml.Serialization;
using System.Text;
using System.Xml;
using System.Data.OleDb;

public partial class Performance_SalaryEntry : System.Web.UI.Page
{
    Utilities utl = null;
    public static int Userid = 0;
    public static int AcademicID = 0;
    public static string UserName = string.Empty;
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
            AcademicID = Convert.ToInt32(Session["AcademicID"]);
            hfUserId.Value = Userid.ToString();
            if (!IsPostBack)
            {
                ddlMonth.SelectedIndex = 0;
                BindAcademicMonths();
                BindPlaceofwork();
                BindDepartment();
                BindDummyRow();
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
    private void BindPlaceofwork()
    {
        Utilities utl = new Utilities();
        string query;
        query = "select  Placeofwork,PlaceofworkID from  m_placeofwork  where IsActive=1 ";

        DataTable dt = new DataTable();
        dt = utl.GetDataTable(query);


        if (dt != null && dt.Rows.Count > 0)
        {
            ddlPlaceofwork.DataSource = dt;
            ddlPlaceofwork.DataTextField = "Placeofwork";
            ddlPlaceofwork.DataValueField = "PlaceofworkID";
            ddlPlaceofwork.DataBind();
        }
        else
        {
            ddlPlaceofwork.DataSource = null;
            ddlPlaceofwork.DataBind();
            ddlPlaceofwork.SelectedIndex = -1;
        }

    }

    private void BindDepartment()
    {
        Utilities utl = new Utilities();
        string query;
        query = "select DepartmentId,DepartmentName from m_departments where IsActive=1";

        DataTable dt = new DataTable();
        dt = utl.GetDataTable(query);

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
            ddlDepartment.SelectedIndex = -1;
        }

    }


    [WebMethod]
    public static string GetMaxsalarys(string query)
    {
        Utilities utl = new Utilities();
        DataSet ds = new DataSet();
        return utl.GetDatasetTable(query,  "others", "Salary").GetXml();
    }
    private void BindDummyRow()
    {
        HiddenField hdnID = (HiddenField)Page.Master.FindControl("hfViewPrm");
        if (hdnID.Value.ToLower() == "true")
        {
            DataTable dummy = new DataTable();
            dummy.Columns.Add("EmpCode");
            dummy.Columns.Add("Name");
            dummy.Rows.Add();
            grdList.DataSource = dummy;
            grdList.DataBind();
        }
    }


    [WebMethod]
    public static string GetList(string placeofwork, string departmentid, string academicId, string formonth)
    {
        string text = string.Empty;
        text = @"<?xml version=""1.0"" encoding=""utf-16""?>";


        Utilities utl = new Utilities();
        DataSet ds = new DataSet();
        string query = "[SP_GetSalaryHeadList] ";
        ds = utl.GetDataset(query);

        Utilities utld = new Utilities();
        DataTable dt = new DataTable();
        string qry = "sp_getStafflistforsalary  " + academicId + ",'" + placeofwork + "','" + departmentid + "','" + formonth + "'";
        dt = utl.GetDataTable(qry);
        ds.Tables.Add(dt);

        return ds.GetXml();
    }

    public static string ToXml(DataSet ds)
    {
        using (var memoryStream = new MemoryStream())
        {
            using (TextWriter streamWriter = new StreamWriter(memoryStream))
            {
                var xmlSerializer = new XmlSerializer(typeof(DataSet));
                xmlSerializer.Serialize(streamWriter, ds);
                return Encoding.UTF8.GetString(memoryStream.ToArray());
            }
        }
    }

    [WebMethod]
    public static string SaveSalary(List<SalaryList> salarylist)
    {
        if (salarylist != null && salarylist.Count > 0)
        {
            Utilities utl = new Utilities();
            string query = string.Empty;

            foreach (SalaryList salary in salarylist)
            {
                string[] salaryid = salary.salaryheadid.Split(new[] { '|' }, StringSplitOptions.RemoveEmptyEntries);
                string[] salaries = salary.salary.Split('|');

                int i = 0;
                foreach (string str in salaryid)
                {
                    string replace = salaries[i];
                    if (salaries[i] == string.Empty)
                        replace = "null";

                    string qry = utl.ExecuteScalar("ISStaffSalaryEXISTS " + salary.staffid + ",'" + salary.formonth + "'," + salary.academicId + "," + str + "");

                    if (qry == "1")
                    {
                        query += "UPDATE e_staffsalaryinfo SET Salary=" + replace + ",modifieddate='" + System.DateTime.Now.ToString("yyyy-MM-dd") + "' WHERE SalaryHeadID=" + str + " and StaffID=" + salary.staffid + " and ForMonth='" + salary.formonth + "'  and AcademicID='" + salary.academicId + "'";
                    }
                    else
                    {
                        query += "INSERT INTO [e_staffsalaryinfo]([SalaryHeadID],[StaffID],[ForMonth],[Salary],[AcademicID]" +
          ",[UserId],[IsActive],createddate)VALUES(" + str + "," + salary.staffid + ",'" + salary.formonth + "'" +
          "," + replace + ",'" + salary.academicId + "'," + salary.userId + ",1,'" + System.DateTime.Now.ToString("yyyy-MM-dd") + "')";
                    }
                    i++;

                }
            }
            string err = utl.ExecuteQuery(query);

        }
        return "";
    }

    public class SalaryList
    {
        public string formonth { get; set; }
        public string staffid { get; set; }
        public string salaryheadid { get; set; }
        public string salary { get; set; }
        public string academicId { get; set; }
        public string userId { get; set; }
    }

    static void DisplayData()
    {
        var reader = OleDbEnumerator.GetRootEnumerator();

        var list = new List<String>();
        while (reader.Read())
        {
            for (var i = 0; i < reader.FieldCount; i++)
            {
                if (reader.GetName(i) == "SOURCES_NAME")
                {
                    HttpContext.Current.Response.Write(reader.GetValue(i).ToString());
                }
            }
            
        }
        reader.Close();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        utl = new Utilities();
        try
        {
            if (!FileUpload1.HasFile)
            {
                return;
            }
            if (File.Exists(Server.MapPath(".//") + FileUpload1.PostedFile.FileName) == true)
            {
                File.Delete(Server.MapPath(".//") + FileUpload1.PostedFile.FileName);
            }
            FileUpload1.SaveAs(Server.MapPath(".//") + System.DateTime.Now.ToString("yyyyMMddhhmmss") + FileUpload1.PostedFile.FileName);

            string path = Server.MapPath(".//") + System.DateTime.Now.ToString("yyyyMMddhhmmss") + FileUpload1.PostedFile.FileName;
          //  DisplayData();

            string excelConnectionString = "";
            OleDbConnection excelConnection = null;
            OleDbCommand cmd = null;
            try
            {
                excelConnectionString = @"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + path + ";Extended Properties='Excel 8.0;HDR=Yes'";
                excelConnection = new OleDbConnection(excelConnectionString);
                cmd = new OleDbCommand("Select sno,empcode,month,BASIC,BASICDA,HRA,TA,PBA,PBADA,DSA,MNA,ARR,BONUS,DEDN,NETGROSS,GROSS,EPF,ESI,LIC,TAX from [sheet1$]", excelConnection);
                cmd.CommandTimeout = 50000;
                excelConnection.Open();
            }
            catch
            {
                excelConnectionString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + path + ";Extended Properties='Excel 8.0;HDR=No'";
                excelConnection = new OleDbConnection(excelConnectionString);
                cmd = new OleDbCommand("Select sno,empcode,month,BASIC,BASICDA,HRA,TA,PBA,PBADA,DSA,MNA,ARR,BONUS,DEDN,NETGROSS,GROSS,EPF,ESI,LIC,TAX from [sheet1$]", excelConnection);
                cmd.CommandTimeout = 50000;
                excelConnection.Open();
            }
            OleDbDataAdapter da = new OleDbDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            excelConnection.Close();
            if (ds.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    string sqlstr = "";
                    string id = ds.Tables[0].Rows[i]["empcode"].ToString();
                    string sno = ds.Tables[0].Rows[i]["sno"].ToString();
                    string month = ds.Tables[0].Rows[i]["month"].ToString();

                    sqlstr = "select staffid from e_staffinfo where empcode='" + id + "'";
                    string staffid = utl.ExecuteScalar(sqlstr);

                    if (staffid != "")
                    {
                        for (int j = 2; j < ds.Tables[0].Columns.Count - 1; j++)
                        {
                            string salaryheadid = utl.ExecuteScalar("select salaryheadid from m_salaryheadmaster where SalaryHead='" + ds.Tables[0].Columns[j + 1].ColumnName.Trim() + "'");
                            if (salaryheadid != "")
                            {
                                string qry = utl.ExecuteScalar("SELECT count(*) FROM e_staffsalaryinfo WHERE StaffID='" + staffid + "' and ForMonth='" + month + "' and AcademicID='" + Session["AcademicID"] + "' and SalaryHeadID= '" + salaryheadid + "' and IsActive=1 ");

                                if (qry == "0" || qry == "")
                                {
                                    sqlstr = "insert into e_staffsalaryinfo(staffid,formonth,salaryheadid,salary,academicid,userid,isactive)values('" + staffid + "','" + month + "','" + salaryheadid + "','" + ds.Tables[0].Rows[i].ItemArray[j + 1].ToString() + "','" + Session["AcademicID"] + "',1,1)";
                                    try
                                    {
                                        utl.ExecuteQuery(sqlstr);
                                    }
                                    catch (Exception)
                                    {

                                        throw;
                                    }
                                }
                            }
                        }
                    }
                }
            }

            FileUpload1.Dispose();
            File.Delete(path);
            utl.ShowMessage("Uploaded Successfully", this.Page);
        }
        catch (Exception ex)
        {
            FileUpload1.Dispose();
            utl.ShowMessage("File content problem, cant upload the file. kindly check it" + ex, this.Page);

        }
    }
}