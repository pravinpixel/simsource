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


public partial class Reports_Staffdatasheet : System.Web.UI.Page
{
    Utilities utl = null;
    public static int Userid = 0;
    public static int AcademicID = 0;
    public static string UserName = string.Empty;
    private static int PageSize = 10;
    string sqlstr = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.chkUser();
        if (Session["UserId"] == null || Session["AcademicID"] == null)
        {
            Response.Redirect("Default.aspx?ses=expired");
        }

        else
        {
            AcademicID = Convert.ToInt32(Session["AcademicID"]);
            Userid = Convert.ToInt32(Session["UserId"]);
        }

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            LOAD_RESULT();
        }

        catch (Exception ex)
        {
            //Response.Write("<script>alert('"+ex.Message+"')</script>");
            ClientScript.RegisterClientScriptBlock(this.GetType(), "bnn", "<script>jAlert('" + ex.Message + "')</script>");
        }
    }
    private void LOAD_RESULT()
    {
        utl = new Utilities();
        DataSet dsGetStaffID = new DataSet();
        string sqlstaffid;

        sqlstaffid = "sp_stafflistreport '" + ddlType.SelectedValue + "','" + txtSearch.Text + "'";
        dsGetStaffID = utl.GetDataset(sqlstaffid);


        StringBuilder str = new StringBuilder();

        if (dsGetStaffID != null && dsGetStaffID.Tables.Count > 0 && dsGetStaffID.Tables[0].Rows.Count > 0)
        {
            for (int i = 0; i < dsGetStaffID.Tables[0].Rows.Count; i++)
            {
                str.Append("<table width='800' align='center'><tr><td align='left' width='30%'>HAIL MARY !</td><td width='40%'>&nbsp;</td><td align='right' width='30%'>PRAISE THE LORD !</td></tr><tr><td align='center' colspan='3' style='font-size: large;font-weight: bold;'>AMALORPAVAM HIGHER SECONDARY SCHOOL, PUDUCHERRY</td></tr><tr><td align='center' colspan='3'  style='font-size: large;'>STAFF DATA SHEET</td></tr><tr><td align='left' colspan='3'>Note: The data that you furnish below are most important. In case of any change, (particularly address, mobile number) to be intimated to office in person</td></tr><tr><td align='left' colspan='3'><u><b>Please fillup all the categories WITHOUT FAIL IN CAPITAL LETTERS</b></u></td></tr><tr><td align='center' valign='bottom' style='padding:0px;'></tr></table><br/>");


                string tblpersonalinfo = string.Empty;
                DataSet dsGetStaffPersonalInfo = new DataSet();
                string sqlstaffpersonalinfo;
                sqlstaffpersonalinfo = "sp_GetStaffPersonalInfo " + dsGetStaffID.Tables[0].Rows[i]["StaffID"].ToString();
                dsGetStaffPersonalInfo = utl.GetDataset(sqlstaffpersonalinfo);

                if (dsGetStaffPersonalInfo != null && dsGetStaffPersonalInfo.Tables.Count > 0 && dsGetStaffPersonalInfo.Tables[0].Rows.Count > 0)
                {
                    str.Append("<table width='800' align='center'>");
                    for (int p = 0; p < dsGetStaffPersonalInfo.Tables[0].Rows.Count; p++)
                    {

                        str.Append("<tr><td><b>Staff Name : </b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["StaffName"].ToString() + "</td><td  colspan='2' rowspan='3' align='right'><img src='../Staffs/Uploads/ProfilePhotos/" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["PhotoFile"].ToString() + "' width='114'  /></td></tr><tr><td><b>Emp Code : </b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["EmpCode"].ToString() + "</td></tr><tr><td><b>Date of Birth : </b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["DOBFORMAT"].ToString() + "</td></tr><tr><td><b>Date of Joining : </b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["DOJFORMAT"].ToString() + "</td><td><b>Gender :</b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["Sex"].ToString() + "</td><tr><td><b>Mother Tongue :</b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["MotherTongue"].ToString() + "</td><td><b>Place Of Birth :</b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["PlaceOfBirth"].ToString() + "</td></tr><tr><tr><td><b>Religion : </b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["ReligionName"].ToString() + "</td><td><b> Nationality : </b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["Nationality"].ToString() + "</td></tr><tr><td><b>Caste : </b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["CasteName"].ToString() + "</td><td><b>Marital Status : </b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["MaritalStatus"].ToString() + "</td></tr><tr colspan='2'><td><b>Permanent Address : </b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["PermAddress"].ToString() + "</td></tr><tr colspan='2'><td><b>Contact Address : </b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["ContactAddress"].ToString() + "</td></tr><tr><td><b>EmailId : </b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["EmailId"].ToString() + "</td><td><b>Community :</b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["CommunityName"].ToString() + "</td></tr><tr><td><b>Phone No : </b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["PhoneNo"].ToString() + "</td><td><b>Pan Card No : </b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["PanCardNo"].ToString() + "</td></tr><tr><td><b>Mobile No : </b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["MobileNo"].ToString() + "</td><td><b>Aadhaar No : </b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["AadhaarNo"].ToString() + "</td></tr><tr><td><b>Date Of Retirement : </b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["DateOfRetirementFormat"].ToString() + "</td><td><b>Present Status : </b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["PresentStatus"].ToString() + "</td></tr><tr><td><b>Ration Card No : </b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["RationCardNo"].ToString() + "</td><td><b>Smart Card No : </b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["SmartCardNo"].ToString() + "</td></tr><tr><td><b>File No : </b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["FileNo"].ToString() + "</td><td><b>Locker No : </b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["LockerNo"].ToString() + "</td></tr><tr><td><b>Working Count : </b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["WorkingCount"].ToString() + "</td><td><b>Sisters Count : </b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["SistersCount"].ToString() + "</td></tr><tr><td><b>Blood Group : </b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["BloodGroupName"].ToString() + "</td><td><b>Dis orders : </b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["Disorders"].ToString() + "</td></tr><tr><td><b>Height : </b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["Height"].ToString() + "</td><td><b>Weight : </b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["Weight"].ToString() + "</td></tr><tr><td><b>Emergency Ph. No : </b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["EmergencyPhNo"].ToString() + "</td><td><b>Doctor : </b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["Doctor"].ToString() + "</td></tr><tr><td ><b>Doc Addr. : </b></td><td >" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["DocAddr"].ToString() + "</td><td><b>Doc Ph. No : </b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["DocPhNo"].ToString() + "</td></tr><tr><td><b>Id Marks : </b></td><td colspan='3'>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["IdMarks"].ToString() + "</td></tr><tr><td><b>Handicap Details : </b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["HandicapDetails"].ToString() + "</td><td><b>Bank Status : </b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["BankStatus"].ToString() + "</td></tr><tr><td><b>Bank Name : </b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["BankName"].ToString() + "</td></tr><tr><td><b>Bank Branch Code : </b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["BankBranchCode"].ToString() + "</td><td><b>Acc No : </b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["AccNo"].ToString() + "</td></tr><tr><td><b>EPF Code : </b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["EPFCode"].ToString() + "</td><td><b>UAN Code : </b></td><td>" + dsGetStaffPersonalInfo.Tables[0].Rows[p]["UAN"].ToString() + "</td></tr></table>");
                    }
                }
                str.Append(@"<p class='pagebreakhere' style='page-break-after: always; color: Red;'></p>");

                //AcademicDetails
                DataSet dsGetStaffAcademic = new DataSet();
                string sqlstaffacademic;
                sqlstaffacademic = "sp_GetStaffAcademicInfo " + dsGetStaffID.Tables[0].Rows[i]["StaffID"].ToString();
                dsGetStaffAcademic = utl.GetDataset(sqlstaffacademic);

                str.Append("<table width='800' align='center' border='1' align='left' cellspacing='0' cellpadding='0' ><tr><td><b>Academic Details</b></td><tr/></table><table width='800' align='center' border='1' cellspacing='0' cellpadding='0' ><thead><tr><th>Course Completed</th><th>Board/University</th><th>Year Of Completion</th><th>Main Subject</th><th>Ancillary Subject</th><th>Certificate No</th><th>Submitted Date</th><th>Returned Date</th><th>Academic Type</th></tr></thead><tbody>");

                if (dsGetStaffAcademic != null && dsGetStaffAcademic.Tables.Count > 0 && dsGetStaffAcademic.Tables[0].Rows.Count > 0)
                {

                    for (int p = 0; p < dsGetStaffAcademic.Tables[0].Rows.Count; p++)
                    {
                        str.Append("<tr><td>" + dsGetStaffAcademic.Tables[0].Rows[p]["CourseCompleted"].ToString() + "</td><td>" + dsGetStaffAcademic.Tables[0].Rows[p]["BoardOrUniv"].ToString() + "</td><td>" + dsGetStaffAcademic.Tables[0].Rows[p]["YOCFORMAT"].ToString() + "</td><td>" + dsGetStaffAcademic.Tables[0].Rows[p]["MainSubName"].ToString() + "</td><td>" + dsGetStaffAcademic.Tables[0].Rows[p]["AncillarySubName"].ToString() + "</td><td>" + dsGetStaffAcademic.Tables[0].Rows[p]["CertNo"].ToString() + "</td><td>" + dsGetStaffAcademic.Tables[0].Rows[p]["SDFORMAT"].ToString() + "</td><td>" + dsGetStaffAcademic.Tables[0].Rows[p]["RDFORMAT"].ToString() + "</td><td>" + dsGetStaffAcademic.Tables[0].Rows[p]["Type"].ToString() + "</td></tr>");
                    }

                    str.Append("</tbody></table>");
                }
                else
                {
                    str.Append("<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>");
                    str.Append("</tbody></table>");
                }
                str.Append("<br/>");
                //FamilyDetails
                DataSet dsGetStaffFamily = new DataSet();
                string sqlstafffamily;
                sqlstafffamily = "GetStaffFamilyById " + dsGetStaffID.Tables[0].Rows[i]["StaffID"].ToString();
                dsGetStaffFamily = utl.GetDataset(sqlstafffamily);

                str.Append("<table width='800' align='center' border='1' align='left' cellspacing='0' cellpadding='0' ><tr><td><b>Family Details</b></td><tr/></table><table width='800' align='center' border='1' align='left' cellspacing='0' cellpadding='0' ><thead><tr><th>Name</th><th>Relationship</th><th>ContactNo</th><th>Occupation</th><th>Qualification</th></tr></thead><tbody>");

                if (dsGetStaffFamily != null && dsGetStaffFamily.Tables.Count > 0 && dsGetStaffFamily.Tables[0].Rows.Count > 0)
                {
                    for (int p = 0; p < dsGetStaffFamily.Tables[0].Rows.Count; p++)
                    {
                        str.Append("<tr><td>" + dsGetStaffFamily.Tables[0].Rows[p]["Name"].ToString() + "</td><td>" + dsGetStaffFamily.Tables[0].Rows[p]["RelationShipName"].ToString() + "</td><td>" + dsGetStaffFamily.Tables[0].Rows[p]["ContactNo"].ToString() + "</td><td>" + dsGetStaffFamily.Tables[0].Rows[p]["Occupation"].ToString() + "</td><td>" + dsGetStaffFamily.Tables[0].Rows[p]["Qualification"].ToString() + "</td></tr>");
                    }

                    str.Append("</tbody></table>");
                }
                else
                {
                    str.Append("<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>");
                    str.Append("</tbody></table>");
                }
                str.Append("<br/>");
                //NomineeDetails -START
                DataSet dsGetStaffnominee = new DataSet();
                string sqlstaffnominee;
                sqlstaffnominee = "GetStaffNomineeById " + dsGetStaffID.Tables[0].Rows[i]["StaffID"].ToString();
                dsGetStaffnominee = utl.GetDataset(sqlstaffnominee);

                str.Append("<table width='800' align='center' border='1' align='left' cellspacing='0' cellpadding='0' ><tr><td><b>Nominee Details</b></td><tr/></table><table width='800' align='center' border='1' cellspacing='0' cellpadding='0' ><thead><tr><th>Nominee Name</th><th>ContactNo</th><th>Relationship</th><th>Address</th><th>Nominee Type</th><th>Share%</th></tr></thead><tbody>");
                if (dsGetStaffnominee != null && dsGetStaffnominee.Tables.Count > 0 && dsGetStaffnominee.Tables[0].Rows.Count > 0)
                {

                    for (int p = 0; p < dsGetStaffnominee.Tables[0].Rows.Count; p++)
                    {
                        str.Append("<tr><td>" + dsGetStaffnominee.Tables[0].Rows[p]["Name"].ToString() + "</td><td>" + dsGetStaffnominee.Tables[0].Rows[p]["ContactNo"].ToString() + "</td><td>" + dsGetStaffnominee.Tables[0].Rows[p]["RelationshipName"].ToString() + "</td><td>" + dsGetStaffnominee.Tables[0].Rows[p]["Address"].ToString() + "</td><td>" + dsGetStaffnominee.Tables[0].Rows[p]["Type"].ToString() + "</td><td>" + dsGetStaffnominee.Tables[0].Rows[p]["Share"].ToString() + "</td></tr>");
                    }

                    str.Append("</tbody></table>");
                }
                else
                {
                    str.Append("<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>");
                    str.Append("</tbody></table>");
                }

                str.Append("<br/>");
                //MedicalRemarks -START
                DataSet dsGetStaffmedicalrecords = new DataSet();
                string sqlstaffmedicalrecords;
                sqlstaffmedicalrecords = "sp_GetStaffMedicalRecords " + dsGetStaffID.Tables[0].Rows[i]["StaffID"].ToString();
                dsGetStaffmedicalrecords = utl.GetDataset(sqlstaffmedicalrecords);

                str.Append("<table width='800' align='center' border='1' align='left' cellspacing='0' cellpadding='0' ><tr><td><b>Medical Remarks Details</b></td><tr/></table><table border='1' width='800' align='center'  cellspacing='0' cellpadding='0' ><thead><tr><th>Date</th><th>Reason</th></tr></thead><tbody>");
                if (dsGetStaffmedicalrecords != null && dsGetStaffmedicalrecords.Tables.Count > 0 && dsGetStaffmedicalrecords.Tables[0].Rows.Count > 0)
                {
                    for (int p = 0; p < dsGetStaffmedicalrecords.Tables[0].Rows.Count; p++)
                    {
                        str.Append("<tr><td>" + dsGetStaffmedicalrecords.Tables[0].Rows[p]["DateFormat"].ToString() + "</td><td>" + dsGetStaffmedicalrecords.Tables[0].Rows[p]["Reason"].ToString() + "</td></tr>");
                    }
                    str.Append("</tbody></table>");
                }
                else
                {
                    str.Append("<tr><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td></tr>");
                    str.Append("</tbody></table>");
                }


                //ServiceDetails -START                

                //ServiceDetails_Intial Appoinments -START

                str.Append("<br/>");

                DataSet dsGetStaffservdetAPP = new DataSet();
                string sqlstaffservdetAPP;
                sqlstaffservdetAPP = "sp_GetServiceAppDetails " + dsGetStaffID.Tables[0].Rows[i]["StaffID"].ToString();
                dsGetStaffservdetAPP = utl.GetDataset(sqlstaffservdetAPP);

                str.Append("<table width='800' align='center' border='1' align='left' cellspacing='0' cellpadding='0' ><tr><td><b>Service Details</b></td><tr/></table><table border='1' width='800' align='center' cellspacing='0' cellpadding='0' ><thead><tr><th>Intital Joining Date</th><th>Designation</th><th>Department</th><th>Place Of Work</th><th>Subject Handling Type</th><th>Class Allocated</th><th>Mode</th></tr></thead><tbody>");

                if (dsGetStaffservdetAPP != null && dsGetStaffservdetAPP.Tables.Count > 0 && dsGetStaffservdetAPP.Tables[0].Rows.Count > 0)
                {

                    for (int p = 0; p < dsGetStaffservdetAPP.Tables[0].Rows.Count; p++)
                    {
                        str.Append("<tr><td>" + dsGetStaffservdetAPP.Tables[0].Rows[p]["DOJ"].ToString() + "</td><td>" + dsGetStaffservdetAPP.Tables[0].Rows[p]["DesignationName"].ToString() + "</td><td>" + dsGetStaffservdetAPP.Tables[0].Rows[p]["DepartmentName"].ToString() + "</td><td>" + dsGetStaffservdetAPP.Tables[0].Rows[p]["PlaceOfWork"].ToString() + "</td><td>" + dsGetStaffservdetAPP.Tables[0].Rows[p]["SubHandling"].ToString() + "</td><td>" + dsGetStaffservdetAPP.Tables[0].Rows[p]["ClassName"].ToString() + "</td><td>" + dsGetStaffservdetAPP.Tables[0].Rows[p]["ModeName"].ToString() + "</td></tr>");
                    }

                    str.Append("</tbody></table>");
                }
                else
                {
                    str.Append("<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>");
                    str.Append("</tbody></table>");
                }

                str.Append(@"<p class='pagebreakhere' style='page-break-after: always; color: Red;'></p>");
                DataSet dsGetStaffservdetSUBJ = new DataSet();
                string sqlstaffservdetSUBJ;
                sqlstaffservdetSUBJ = "sp_GetStaffSubjectDetails " + dsGetStaffID.Tables[0].Rows[i]["StaffID"].ToString();
                dsGetStaffservdetSUBJ = utl.GetDataset(sqlstaffservdetSUBJ);

                str.Append("<table width='800' align='center' border='1' align='left' cellspacing='0' cellpadding='0' ><tr><td><b>Subject Details</b></td><tr/></table><table border='1' width='800' align='center' cellspacing='0' cellpadding='0' ><thead><tr><th>Subjects</th><th>Studied Upto</th></tr></thead><tbody>");

                if (dsGetStaffservdetSUBJ != null && dsGetStaffservdetSUBJ.Tables.Count > 0 && dsGetStaffservdetSUBJ.Tables[0].Rows.Count > 0)
                {
                    for (int p = 0; p < dsGetStaffservdetSUBJ.Tables[0].Rows.Count; p++)
                    {
                        str.Append("<tr><td>" + dsGetStaffservdetSUBJ.Tables[0].Rows[p]["SubExperienceName"].ToString() + "</td><td>" + dsGetStaffservdetSUBJ.Tables[0].Rows[p]["StudiedUpto"].ToString() + "</td></tr>");
                    }

                    str.Append("</tbody></table>");
                }
                else
                {
                    str.Append("<tr><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td></tr>");
                    str.Append("</tbody></table>");
                }

                str.Append("<br/>");
                //ServiceDetails -START       

                //ServiceDetails_Language -START

                DataSet dsGetStaffservdetLANG = new DataSet();
                string sqlstaffservdetLANG;
                sqlstaffservdetLANG = "sp_GetStaffLangKnownDetails " + dsGetStaffID.Tables[0].Rows[i]["StaffID"].ToString();
                dsGetStaffservdetLANG = utl.GetDataset(sqlstaffservdetLANG);

                str.Append("<table width='800' align='center' border='1' align='left' cellspacing='0' cellpadding='0' ><tr><td><b>Language Details</b></td><tr/></table><table border='1' width='800' align='center' cellspacing='0' cellpadding='0' ><thead><tr><th>Language Known</th><th>Read</th><th>Write</th><th>Speak</th></tr></thead><tbody>");

                if (dsGetStaffservdetLANG != null && dsGetStaffservdetLANG.Tables.Count > 0 && dsGetStaffservdetLANG.Tables[0].Rows.Count > 0)
                {
                    for (int p = 0; p < dsGetStaffservdetLANG.Tables[0].Rows.Count; p++)
                    {
                        str.Append("<tr><td>" + dsGetStaffservdetLANG.Tables[0].Rows[p]["LanguageName"].ToString() + "</td><td>" + dsGetStaffservdetLANG.Tables[0].Rows[p]["Read"].ToString() + "</td><td>" + dsGetStaffservdetLANG.Tables[0].Rows[p]["Write"].ToString() + "</td><td>" + dsGetStaffservdetLANG.Tables[0].Rows[p]["Speak"].ToString() + "</td></tr>");
                    }
                    str.Append("</tbody></table>");
                }
                else
                {
                    str.Append("<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>");
                    str.Append("</tbody></table>");
                }
               
                //ServiceDetails_Language -END 
                str.Append("<br/>");
                //ServiceDetails_Regularization -START
                DataSet dsGetStaffservdetRegularization = new DataSet();
                string sqlstaffservdetRegularization;
                sqlstaffservdetRegularization = "sp_GetStaffCareerDetails " + dsGetStaffID.Tables[0].Rows[i]["StaffID"].ToString();
                dsGetStaffservdetRegularization = utl.GetDataset(sqlstaffservdetRegularization);

                str.Append("<table width='800' align='center' border='1' align='left' cellspacing='0' cellpadding='0' ><tr><td><b>Regularization Details</b></td><tr/></table><table  width='800' align='center' border='1' cellspacing='0' cellpadding='0' ><thead><tr><th>Date</th><th>Order No</th><th>Designation</th><th>Placeofwork</th><th>Probation Period</th><th>Completion Date</th><th>Completion Order</th><th>From</th><th>To</th></tr></thead><tbody>");

                if (dsGetStaffservdetRegularization != null && dsGetStaffservdetRegularization.Tables.Count > 0 && dsGetStaffservdetRegularization.Tables[0].Rows.Count > 0)
                {
                    for (int p = 0; p < dsGetStaffservdetRegularization.Tables[0].Rows.Count; p++)
                    {
                        str.Append("<tr><td>" + dsGetStaffservdetRegularization.Tables[0].Rows[p]["CSFORMAT"].ToString() + "</td><td>" + dsGetStaffservdetRegularization.Tables[0].Rows[p]["OrderNo"].ToString() + "</td><td>" + dsGetStaffservdetRegularization.Tables[0].Rows[p]["DesignationName"].ToString() + "</td><td>" + dsGetStaffservdetRegularization.Tables[0].Rows[p]["Placeofwork"].ToString() + "</td><td>" + dsGetStaffservdetRegularization.Tables[0].Rows[p]["ProbationPeriod"].ToString() + "</td><td>" + dsGetStaffservdetRegularization.Tables[0].Rows[p]["CompletionDateFormat"].ToString() + "</td><td>" + dsGetStaffservdetRegularization.Tables[0].Rows[p]["CompletionOrderNo"].ToString() + "</td><td>" + dsGetStaffservdetRegularization.Tables[0].Rows[p]["AcdFromDate"].ToString() + "</td><td>" + dsGetStaffservdetRegularization.Tables[0].Rows[p]["AcdToDate"].ToString() + "</td></tr>");
                    }
                    str.Append("</tbody></table>");
                }
                else
                {
                    str.Append("<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>");
                    str.Append("</tbody></table>");
                }

                //ServiceDetails_Regularization -END 

                str.Append("<br/>");

                //ServiceDetails_Invigilation -START
                DataSet dsGetStaffservdetInvigilation = new DataSet();
                string sqlstaffservdetInvigilation;
                sqlstaffservdetInvigilation = "sp_GetStaffInvigilationDetails " + dsGetStaffID.Tables[0].Rows[i]["StaffID"].ToString();
                dsGetStaffservdetInvigilation = utl.GetDataset(sqlstaffservdetInvigilation);

                str.Append("<table width='800' align='center' border='1' align='left' cellspacing='0' cellpadding='0' ><tr><td><b>Invigilation Details</b></td><tr/></table><table border='1'  width='800' align='center' cellspacing='0' cellpadding='0' ><thead><tr><th>Year</th><th>School</th><th>Place</th><th>Invigilation Type</th></tr></thead><tbody>");
                if (dsGetStaffservdetInvigilation != null && dsGetStaffservdetInvigilation.Tables.Count > 0 && dsGetStaffservdetInvigilation.Tables[0].Rows.Count > 0)
                {

                    for (int p = 0; p < dsGetStaffservdetInvigilation.Tables[0].Rows.Count; p++)
                    {
                        str.Append("<tr><td>" + dsGetStaffservdetInvigilation.Tables[0].Rows[p]["Year"].ToString() + "</td><td>" + dsGetStaffservdetInvigilation.Tables[0].Rows[p]["SchoolName"].ToString() + "</td><td>" + dsGetStaffservdetInvigilation.Tables[0].Rows[p]["Place"].ToString() + "</td><td>" + dsGetStaffservdetInvigilation.Tables[0].Rows[p]["InvigilationType"].ToString() + "</td></tr>");
                    }

                    str.Append("</tbody></table>");
                }
                else
                {
                    str.Append("<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>");
                    str.Append("</tbody></table>");
                }

                str.Append("<br/>");

                ////ServiceDetails_Invigilation -END 

                ////ServiceDetails_Resignation -START

                //DataSet dsGetStaffservdetResignation = new DataSet();
                //string sqlstaffservdetResignation;
                //sqlstaffservdetResignation = "sp_GetStaffResignDetails " + dsGetStaffID.Tables[0].Rows[i]["StaffID"].ToString();
                //dsGetStaffservdetResignation = utl.GetDataset(sqlstaffservdetResignation);

                //str.Append("<table width='800' align='center' border='1' align='left' cellspacing='0' cellpadding='0' ><tr><td><b>Resignation Details</b></td><tr/></table><table border='1'  width='800' align='center' cellspacing='0' cellpadding='0' ><thead><tr><th>Year</th><th>Reason</th><th>Certificate Issued On</th><th>Resigned On</th></tr></thead><tbody>");

                //if (dsGetStaffservdetResignation != null && dsGetStaffservdetResignation.Tables.Count > 0 && dsGetStaffservdetResignation.Tables[0].Rows.Count > 0)
                //{

                //    for (int p = 0; p < dsGetStaffservdetResignation.Tables[0].Rows.Count; p++)
                //    {
                //        str.Append("<tr><td>" + dsGetStaffservdetResignation.Tables[0].Rows[p]["Year"].ToString() + "</td><td>" + dsGetStaffservdetResignation.Tables[0].Rows[p]["Reason"].ToString() + "</td><td>" + dsGetStaffservdetResignation.Tables[0].Rows[p]["CERTFORMAT"].ToString() + "</td><td>" + dsGetStaffservdetResignation.Tables[0].Rows[p]["RESFORMAT"].ToString() + "</td></tr>");
                //    }
                //    str.Append("</tbody></table>");
                //}
                //else
                //{
                //    str.Append("<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>");
                //    str.Append("</tbody></table>");
                //}

                //ServiceDetails_Resignation -END 

                //ServiceDetails -END 


                //RemarksDetails -START

                DataSet dsGetStaffremarkdet = new DataSet();
                string sqlstaffremarkdet;
                sqlstaffremarkdet = "sp_GetStaffRemark " + dsGetStaffID.Tables[0].Rows[i]["StaffID"].ToString();
                dsGetStaffremarkdet = utl.GetDataset(sqlstaffremarkdet);

                str.Append("<table width='800' align='center' border='1' align='left' cellspacing='0' cellpadding='0' ><tr><td><b>Remarks Details</b></td><tr/></table><table border='1'  width='800' align='center' cellspacing='0' cellpadding='0' ><thead><tr><th>Date</th><th>Title</th><th>Reason</th></tr></thead><tbody>");

                if (dsGetStaffremarkdet != null && dsGetStaffremarkdet.Tables.Count > 0 && dsGetStaffremarkdet.Tables[0].Rows.Count > 0)
                {

                    for (int p = 0; p < dsGetStaffremarkdet.Tables[0].Rows.Count; p++)
                    {
                        str.Append("<tr><td>" + dsGetStaffremarkdet.Tables[0].Rows[p]["RemarkDateFormat"].ToString() + "</td><td>" + dsGetStaffremarkdet.Tables[0].Rows[p]["RemarkTitle"].ToString() + "</td><td>" + dsGetStaffremarkdet.Tables[0].Rows[p]["Reason"].ToString() + "</td></tr>");
                    }
                    str.Append("</tbody></table>");
                }
                else
                {
                    str.Append("<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>");
                    str.Append("</tbody></table>");
                }

                //RemarksDetails -END 

                str.Append("<br/>");

                //RetriementDetails -START
                //DataSet dsGetStaffretriementdet = new DataSet();
                //string sqlstaffretriementdet;
                //sqlstaffretriementdet = "sp_GetStaffRetire " + dsGetStaffID.Tables[0].Rows[i]["StaffID"].ToString();
                //dsGetStaffretriementdet = utl.GetDataset(sqlstaffretriementdet);

                //str.Append("<table width='800' align='center' border='1' align='left' cellspacing='0' cellpadding='0' ><tr><td><b>Retirement Details</b></td><tr/></table><table border='1'  width='800' align='center' cellspacing='0' cellpadding='0' ><thead><tr><th>Retr.Date</th><th>Title</th><th>Reason</th></tr></thead><tbody>");

                //if (dsGetStaffretriementdet != null && dsGetStaffretriementdet.Tables.Count > 0 && dsGetStaffretriementdet.Tables[0].Rows.Count > 0)
                //{

                //    for (int p = 0; p < dsGetStaffretriementdet.Tables[0].Rows.Count; p++)
                //    {
                //        str.Append("<tr><td>" + dsGetStaffretriementdet.Tables[0].Rows[p]["RetirementDateFormat"].ToString() + "</td><td>" + dsGetStaffretriementdet.Tables[0].Rows[p]["RetirementTitle"].ToString() + "</td><td>" + dsGetStaffretriementdet.Tables[0].Rows[p]["RetirementReason"].ToString() + "</td></tr>");
                //    }
                //    str.Append("</tbody></table>");
                //}
                //else
                //{
                //    str.Append("<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>");
                //    str.Append("</tbody></table>");
                //}

                //RetriementDetails -END 

                //RelativeStaffDetails -START
                DataSet dsGetStaffrelativestaffdet = new DataSet();
                string sqlstaffrelativestaffdet;

                sqlstaffrelativestaffdet = "sp_GetStaffRelationInfo " + "''" + "," + "''" + "," + "" + dsGetStaffID.Tables[0].Rows[i]["StaffID"].ToString() + "";
                dsGetStaffrelativestaffdet = utl.GetDataset(sqlstaffrelativestaffdet);

                str.Append("<table width='800' align='center' border='1' align='left' cellspacing='0' cellpadding='0' ><tr><td><b>Relationship Details</b></td><tr/></table><table border='1'  width='800' align='center' cellspacing='0' cellpadding='0' ><thead><tr><th>Relation Name</th><th>Relationship</th></tr></thead><tbody>");

                if (dsGetStaffrelativestaffdet != null && dsGetStaffrelativestaffdet.Tables.Count > 0 && dsGetStaffrelativestaffdet.Tables[0].Rows.Count > 0)
                {
                    for (int p = 0; p < dsGetStaffrelativestaffdet.Tables[0].Rows.Count; p++)
                    {
                        str.Append("<tr><td>" + dsGetStaffrelativestaffdet.Tables[0].Rows[p]["RelationName"].ToString() + "</td><td>" + dsGetStaffrelativestaffdet.Tables[0].Rows[p]["Relationship"].ToString() + "</td></tr>");
                    }
                    str.Append("</tbody></table>");
                }
                else
                {
                    str.Append("<tr><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td></tr>");
                    str.Append("</tbody></table>");
                }

                //RelativeStaffDetails -END 


                str.Append("<br/>");

                string sqlstaffeducation = string.Empty;
                string staffeducation = string.Empty;
                sqlstaffeducation = "select dbo.[fn_getStaffCompleteQualification](" + dsGetStaffID.Tables[0].Rows[i]["StaffID"].ToString() + ")";
                staffeducation = utl.ExecuteScalar(sqlstaffeducation);
                str.Append("<table width='800' align='center' border='1' align='left' cellspacing='0' cellpadding='0' ><tr><td><b>Qualification Details</b></td><tr/></table><table border='1' width='800' align='center' cellspacing='0' cellpadding='0' ><thead><tr><th>Present Qualification Details</th></tr></thead><tbody>");
                if (staffeducation != "")
                {
                    str.Append("<tr><td>" + staffeducation.ToString() + "</td></tr>");
                    str.Append("</tbody></table>");
                }
                else
                {
                    str.Append("<tr><td>&nbsp;</td></tr><tr><td>&nbsp;</td></tr><tr><td>&nbsp;</td></tr><tr><td>&nbsp;</td></tr>");
                    str.Append("</tbody></table>");
                }

                str.Append(@"<p class='pagebreakhere' style='page-break-after: always; color: Red;'></p>");
            }
            dvCard.InnerHtml = str.ToString();
        }
    }
}

    







