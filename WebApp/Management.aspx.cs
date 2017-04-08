using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApp
{
    public partial class Management : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                PopulateData();
            }
        }

        protected void btnName_Click(object sender, EventArgs e)
        {
            GridViewRow clickedRow = ((LinkButton)sender).NamingContainer as GridViewRow;
            HiddenField hfCompanyId = (HiddenField)clickedRow.FindControl("hiddenCompanyId");

            Response.Redirect(string.Format("Company.aspx?id={0}", hfCompanyId.Value));
        }

        private void PopulateData()
        {
            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                var results = (from c in dc.Companies
                           orderby c.CompanyName
                           select new { c.Id, c.CompanyName, c.Code, c.FederalNumber, c.CompanyType, c.Address, c.City, c.State, c.ZipCode, c.Phone }).ToList();

                gvMgmt.DataSource = results;
                gvMgmt.DataBind();
            }
        }
    }
}