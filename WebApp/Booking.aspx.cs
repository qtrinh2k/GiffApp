using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Services;
using System.Web.Services;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;

namespace WebApp
{
    public partial class Booking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            List<string> companyNames = new List<string>();

            txtDate.Text = DateTime.Now.ToString("d");
            txtDate.DataBind();

            txtCreatedBy.Focus();
            txtCreatedBy.DataBind();
        }


        protected void btnNext_Click(object sender, EventArgs e)
        {
            Response.Redirect(string.Format("Container.aspx?ref={0}&cusId={1}", txtGiffRef.Text, DataUtil.GetCompanyIdFromName(txtBillTo.Text)));
        }

        protected void AddNewBooking_Click(object sender, EventArgs e)
        {
            long giffiRef = -1;

            DataAccessBase dbAccess = new DataAccessBase();

            using (SqlConnection con = new SqlConnection(dbAccess.ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("InsertBooking", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@createdBy", SqlDbType.NVarChar).Value = txtCreatedBy.Text.Trim();
                    cmd.Parameters.Add("@createdTime", SqlDbType.DateTime).Value = txtDate.Text.Trim();
                    cmd.Parameters.Add("@modifiedTime", SqlDbType.DateTime).Value = txtDate.Text.Trim();
                    cmd.Parameters.Add("@billToId", SqlDbType.Int).Value = DataUtil.GetCompanyIdFromName(txtBillTo.Text.Trim());
                    cmd.Parameters.Add("@shipperId", SqlDbType.Int).Value = DataUtil.GetCompanyIdFromName(txtShipper.Text.Trim());
                    cmd.Parameters.Add("@carrierId", SqlDbType.Int).Value = DataUtil.GetCompanyIdFromCode(txtCarrier.Text.Trim());
                    cmd.Parameters.Add("@vessel", SqlDbType.NVarChar).Value = txtVessel.Text.Trim();
                    cmd.Parameters.Add("@vsl", SqlDbType.NVarChar).Value = txtVSL.Text.Trim();
                    cmd.Parameters.Add("@origin", SqlDbType.NVarChar).Value = txtOrigin.Text.Trim();
                    cmd.Parameters.Add("@load", SqlDbType.NVarChar).Value = txtLoad.Text.Trim();
                    cmd.Parameters.Add("@destination", SqlDbType.NVarChar).Value = txtDest.Text.Trim();                    
                    cmd.Parameters.Add("@discharge", SqlDbType.NVarChar).Value = txtDischarge.Text.Trim();
                    cmd.Parameters.Add("@commodity", SqlDbType.NVarChar).Value = txtCommod.Text.Trim();
                    cmd.Parameters.Add("@equipment", SqlDbType.NVarChar).Value = txtEquiq1.Text.Trim() + txtEquiq2.Text.Trim();
                    cmd.Parameters.Add("@temp", SqlDbType.NChar).Value = txtTemp.Text.Trim();
                    cmd.Parameters.Add("@vents", SqlDbType.NChar).Value = txtVents.Text.Trim();
                    cmd.Parameters.Add("@status", SqlDbType.NChar).Value = "CREATED";
                    cmd.Parameters.Add("@notes", SqlDbType.NVarChar).Value = txtNotes.Text.Trim();
                    cmd.Parameters.Add("@CutOffDate", SqlDbType.DateTime).Value = DateTime.Parse(txtCutOffDate.Text.Trim());
                    cmd.Parameters.Add("@DOC", SqlDbType.DateTime).Value = DateTime.Parse(txtDOC.Text.Trim());
                    cmd.Parameters.Add("@CargoCut", SqlDbType.DateTime).Value = DateTime.Parse(txtCargoCut.Text.Trim());
                    cmd.Parameters.Add("@VGM", SqlDbType.Float).Value = float.Parse(txtVGM.Text.Trim());
                    cmd.Parameters.Add("@ReturnValue", SqlDbType.BigInt).Direction = ParameterDirection.ReturnValue;
                    con.Open();
                    var result = cmd.ExecuteNonQuery();
                    if(!long.TryParse(cmd.Parameters["@ReturnValue"].Value.ToString(), out giffiRef))
                    {
                        ClientScript.RegisterStartupScript(GetType(), "alert", "alert('Error occured when Submit data to SQL Database!!!');", true);
                    }
                    
                }
            }

            if (giffiRef > 10000)
            {
                txtGiffRef.Text = giffiRef.ToString();
                txtGiffRef.DataBind();

                //TODO: create submition page and return reference no.

                ClientScript.RegisterStartupScript(GetType(), "alert", string.Format("alert('Successfully Submit Reference#{0}');", giffiRef), true);

                var tboxControls = this.Controls.FindAll().OfType<TextBox>();
                foreach (TextBox item in tboxControls)
                {
                    item.Enabled = false;
                }

                //btnSubmitBooking.Enabled = false;
                btnSubmitBooking.Visible = false;
                btnClose.Visible = true;
                btnNext.Visible = true;
            }
            else
            {
                ClientScript.RegisterStartupScript(GetType(), "alert", "alert('Error occured when Submit data');", true);
            }
        }


        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<string> GetCompanyName(string pre)
        {
            List<string> allCompanyName = new List<string>();

            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                if (pre.Equals("*") || pre.Equals("."))
                {
                    allCompanyName = (from c in dc.Companies
                                      select c.CompanyName).Distinct().ToList();
                }
                else
                {
                    allCompanyName = (from c in dc.Companies
                                      where c.CompanyName.StartsWith(pre)
                                      select c.CompanyName).Distinct().ToList();
                }
            }

            return allCompanyName;
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<string> GetCarrierCode(string pre)
        {
            List<string> carrierNames = new List<string>();

            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                if (pre.Equals("*") || pre.Equals("."))
                {
                    carrierNames = (from c in dc.Companies
                                    where c.CompanyType.Equals("Carrier", StringComparison.InvariantCultureIgnoreCase)
                                    select c.Code).Distinct().ToList();
                }
                else
                {
                    carrierNames = (from c in dc.Companies
                                    where c.Code.StartsWith(pre) && c.CompanyType.Equals("Carrier", StringComparison.InvariantCultureIgnoreCase)
                                    select c.Code).Distinct().ToList();
                }
            }

            return carrierNames;
        }

    }
}