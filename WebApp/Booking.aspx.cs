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
using GiffiEZApp.BusinessObjects;

namespace WebApp
{
    public partial class Booking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            List<string> companyNames = new List<string> { "Giffi", "HM Freight", "ABC" };
            //ddlBillTo.DataSource = companyNames;
            //ddlBillTo.DataBind();
            txtDate.Text = DateTime.Now.ToString("d");
            txtDate.DataBind();

            //txtshipper.DataSource = companyNames;
            //txtshipper.DataBind();

            //txtCarrier.DataSource = companyNames;
            //txtCarrier.DataBind();

        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<string> GetCompanyName(string pre)
        {
            List<string> allCompanyName = new List<string>(); //{ "Giffi", "HM Freight", "ABC" };

            using (GiffiCompanyEntities dc = new GiffiCompanyEntities())
            {
                allCompanyName = (from c in dc.Companies
                                  where c.CompanyName.StartsWith(pre)
                                  select c.CompanyName).Distinct().ToList();
            }

            return allCompanyName;
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<string> GetCarrierName(string pre)
        {
            List<string> carrierNames = new List<string>(); //{ "AZ Carrier", "HM Freight", "MTV Carrier" };

            using (var dc = new GiffiCarrierEntities())
            {
                carrierNames = (from c in dc.Carriers
                                 where c.CarrierName.StartsWith(pre)
                                 select c.CarrierName).Distinct().ToList();
            }

            return carrierNames;
        }

        protected void AddNewBooking_Click(object sender, EventArgs e)
        {
            DataAccessBase dbAccess = new DataAccessBase();

            using (SqlConnection con = new SqlConnection(dbAccess.ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("InsertBooking", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@createdBy", SqlDbType.NVarChar).Value = txtCreatedBy.Text.Trim();
                    cmd.Parameters.Add("@createdTime", SqlDbType.NVarChar).Value = txtDate.Text.Trim();
                    cmd.Parameters.Add("@modifyTime", SqlDbType.NVarChar).Value = txtDate.Text.Trim();
                    cmd.Parameters.Add("@billToId", SqlDbType.Int).Value = GetCompanyIdFromName(txtBillTo.Text.Trim());
                    cmd.Parameters.Add("@shipperId", SqlDbType.Int).Value = GetCompanyIdFromName(txtShipper.Text.Trim());
                    cmd.Parameters.Add("@carrierId", SqlDbType.Int).Value = GetCarrierIdFromName(txtCarrier.Text.Trim());
                    cmd.Parameters.Add("@vessel", SqlDbType.NVarChar).Value = txtVessel.Text.Trim();
                    cmd.Parameters.Add("@vsl", SqlDbType.NVarChar).Value = txtVSL.Text.Trim();
                    cmd.Parameters.Add("@origin", SqlDbType.NVarChar).Value = txtOrigin.Text.Trim();
                    cmd.Parameters.Add("@load", SqlDbType.NVarChar).Value = txtLoad.Text.Trim();
                    cmd.Parameters.Add("@discharge", SqlDbType.NVarChar).Value = txtDischarge.Text.Trim();
                    cmd.Parameters.Add("@commodity", SqlDbType.NVarChar).Value = txtCommod.Text.Trim();
                    cmd.Parameters.Add("@equiqment", SqlDbType.NVarChar).Value = txtEquiq1.Text.Trim() + txtEquiq2.Text.Trim();
                    cmd.Parameters.Add("@temp", SqlDbType.NChar).Value = txtTemp.Text.Trim();
                    cmd.Parameters.Add("@vents", SqlDbType.NChar).Value = txtVents.Text.Trim();
                    cmd.Parameters.Add("@status", SqlDbType.NChar).Value = 1;
                    cmd.Parameters.Add("@nottes", SqlDbType.NText).Value = txtNotes.Text.Trim();
                    con.Open();
                    var result = cmd.ExecuteNonQuery();
                }
            }

            //TODO: create submition page and return reference no.
            ClientScript.RegisterStartupScript(GetType(), "alert", "alert('Successfully Submit');", true);
        }

        private int GetCompanyIdFromName(string companyName)
        {
            using (GiffiCompanyEntities dc = new GiffiCompanyEntities())
            {
                var allCompanyId = (from c in dc.Companies
                                  where c.CompanyName.Equals(companyName, StringComparison.InvariantCultureIgnoreCase)
                                  select c.Id).Distinct().ToList();

                return allCompanyId.FirstOrDefault();
            }
            
        }

        private int GetCarrierIdFromName(string carrierName)
        {
            using (var dc = new GiffiCarrierEntities())
            {
                var carrierId = (from c in dc.Carriers
                                    where c.CarrierName.Equals(carrierName, StringComparison.InvariantCultureIgnoreCase)
                                    select c.Id).Distinct().ToList();

                return carrierId.FirstOrDefault();
            }

        }
    }
}