using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Data.SqlTypes;
using System.Data.SqlClient;
namespace WebApp
{
    using DataAccess;

    public partial class Company : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void AddNewCompany_Click(object sender, EventArgs e)
        {
            string errMsg = string.Empty;
            Company c = null;
            try
            {
                c = new Company()
                {
                    Code = txtCode.Text.Trim(),
                    CompanyName = txtCompanyName.Text.Trim(),
                    CompanyType = ddlType.SelectedValue,
                    FederalNumber = txtFederalNum.Text.Trim(),
                    Address = txtAddress1.Text.Trim(),
                    City = txtCity.Text.Trim(),
                    ZipCode = txtZip.Text.Trim(),
                    Country = txtCountry.Text.Trim(),
                    Phone = txtPhone.Text.Trim(),
                    Email = txtEmail.Text.Trim()
                };

                CompanyRepository cr = new CompanyRepository();
                cr.Insert(c);
                ClientScript.RegisterStartupScript(GetType(), "alert", "alert('Successfully Submit');", true);
            }
            catch (SqlException se)
            {
                errMsg = string.Format("Unable to insert Company to database. Name={0}, SQLException={1}'", c.CompanyName, se.Message);
                AlertMessage(errMsg);
            }
            catch (Exception ex)
            {
                errMsg = string.Format("Unable to insert Company due to an invalid entry. Name={0}, Exception={1}", c.CompanyName, ex.Message);
                AlertMessage(errMsg);
            }
        }

        private void AlertMessage(string msg)
        {
            string script = string.Format("alert(\"{0}!\");", msg);
            ScriptManager.RegisterStartupScript(this, GetType(),
                                  "ServerControlScript", script, true);
        }
    }
}