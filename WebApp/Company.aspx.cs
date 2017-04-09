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
    using System.Web.Script.Services;
    using System.Web.Services;

    public partial class Company : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int companyId = -1;
            if (!IsPostBack && Request.Params.HasKeys())
            {
                if (!string.IsNullOrEmpty(Request.QueryString["id"]) &&
                    int.TryParse(Request.QueryString["id"].ToString(), out companyId))
                {
                    Company c = DataUtil.GetCompanyById(companyId);
                    PopulateData(c);
                }
            }
        }
        protected void btnSelectedSearch_Click(object sender, EventArgs e)
        {
            string companyName = txtSearchBox.Text;
            
            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
               var results = (from c in dc.Companies
                           where c.CompanyName.Equals(companyName.Trim(), StringComparison.InvariantCultureIgnoreCase)
                           select c);

                if (results == null || !results.Any())
                    this.Page.AlertMessage(GetType(), string.Format("Unexpected Error while search database for name={0}. Please try again!!!", companyName));
                else
                {
                    Company c = results.First();

                    PopulateData(c);
                    //clear search field
                    txtSearchBox.Text = "";
                }

            }
        }

        protected void AddNewCompany_Click(object sender, EventArgs e)
        {
            string errMsg = string.Empty;
            int id = -1;

            Company c = null;
            try
            {
                c = new Company()
                {
                    Id = int.TryParse(HiddenCompanyId.Value, out id) ? id : -1,
                    Code = txtCode.Text.Trim(),
                    CompanyName = txtCompanyName.Text.Trim(),
                    CompanyType = ddlType.SelectedValue,
                    FederalNumber = txtFederalNum.Text.Trim(),
                    Address = txtAddress1.Text.Trim(),
                    City = txtCity.Text.Trim(),
                    State = txtState.Text.Trim(),
                    ZipCode = txtZip.Text.Trim(),
                    Country = txtCountry.Text.Trim(),
                    Phone = txtPhone.Text.Trim(),
                    Email = txtEmail.Text.Trim()
                };

                CompanyRepository cr = new CompanyRepository();
                cr.Insert(c);
                ClientScript.RegisterStartupScript(GetType(), "alert", "alert('Successfully Submit');", true);

                var allTextBoxes = this.Page.Form.Controls.FindAll().OfType<TextBox>();
                foreach(var txtbox in allTextBoxes)
                {
                    txtbox.Text = "";
                }
            }
            catch (SqlException se)
            {
                errMsg = string.Format("Unable to insert Company to database. Name={0}, SQLException={1}'", c.CompanyName, se.Message);
                this.Page.AlertMessage(GetType(), errMsg);
            }
            catch (Exception ex)
            {
                errMsg = string.Format("Unable to insert Company due to an invalid entry. Name={0}, Exception={1}", c.CompanyName, ex.Message);
                this.Page.AlertMessage(GetType(), errMsg);
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<string> SearchFor(string pre, int option)
        {
            List<string> results = new List<string>();

            switch (option)
            {
                case 1:
                    using (GiffiDBEntities dc = new GiffiDBEntities())
                    {
                        if (pre.Equals("*") || pre.Equals("."))
                        {
                            results = (from c in dc.Companies
                                       select c.CompanyName).ToList();
                        }
                        else
                        {
                            results = (from c in dc.Companies
                                       where c.CompanyName.StartsWith(pre)
                                       select c.CompanyName).ToList();
                        }
                    }
                    break;
                default:
                    break;
            }

            return results;
        }

        private void PopulateData(Company c)
        {
            HiddenCompanyId.Value = c.Id.ToString();
            txtCode.Text = c.Code;
            txtCompanyName.Text = c.CompanyName;
            ddlType.SelectedValue = c.CompanyType;
            txtFederalNum.Text = c.FederalNumber;
            txtAddress1.Text = c.Address;
            txtCity.Text = c.City;
            txtState.Text = c.State;
            txtZip.Text = c.ZipCode;
            txtCountry.Text = c.Country;
            txtPhone.Text = c.Phone;
            txtEmail.Text = c.Email;
        }

        protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(ddlType.SelectedValue.ToString().Equals("Consignee") ||
               ddlType.SelectedValue.ToString().Equals("Supplier") ||
               ddlType.SelectedValue.ToString().Equals("Warehouse"))
            {
                txtCode.Text = "NA";
                txtFederalNum.Text = "NA";
            }
        }
    }
}