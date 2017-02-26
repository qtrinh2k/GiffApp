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
            //using (MyDatabaseEntities dc = new MyDatabaseEntities())
            //{
            //    allCompanyName = (from a in dc.TopCompanies
            //                      where a.CompanyName.StartsWith(pre)
            //                      select a.CompanyName).ToList();
            //}
            return allCompanyName;
        }

        protected void AddNewBooking_Click(object sender, EventArgs e)
        {
            DataAccessBase dbAccess = new DataAccessBase();

            using (SqlConnection con = new SqlConnection(dbAccess.ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("InsertCompany", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@createdBy", SqlDbType.NVarChar).Value = txtCreatedBy.Text.Trim();
                    cmd.Parameters.Add("@createdTime", SqlDbType.NVarChar).Value = txtDate.Text.Trim();
                    cmd.Parameters.Add("@companyName", SqlDbType.NVarChar).Value = txtBillTo.Text.Trim();
                    cmd.Parameters.Add("@companyName", SqlDbType.NVarChar).Value = txtBillTo.Text.Trim();
                    cmd.Parameters.Add("@companyName", SqlDbType.NVarChar).Value = txtBillTo.Text.Trim();
                    cmd.Parameters.Add("@companyName", SqlDbType.NVarChar).Value = txtBillTo.Text.Trim();
                    cmd.Parameters.Add("@companyName", SqlDbType.NVarChar).Value = txtBillTo.Text.Trim();
                    cmd.Parameters.Add("@companyName", SqlDbType.NVarChar).Value = txtBillTo.Text.Trim();
                    cmd.Parameters.Add("@companyName", SqlDbType.NVarChar).Value = txtBillTo.Text.Trim();
                    cmd.Parameters.Add("@companyName", SqlDbType.NVarChar).Value = txtBillTo.Text.Trim();
                    con.Open();
                    var result = cmd.ExecuteNonQuery();
                }
            }

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

    }
}