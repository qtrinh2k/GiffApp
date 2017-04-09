using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApp
{
    public partial class BillOfLanding : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        #region WebMethod
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<string> SearchFor(string pre, int option)
        {
            List<string> allCompanyName = new List<string>();

            ComanyType companyType;
            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                switch (option)
                {
                    case 3:
                        companyType = ComanyType.Consignee;
                        break;
                    case 4:
                        companyType = ComanyType.Supplier;
                        break;
                    case 5:
                        companyType = ComanyType.Warehouse;
                        break;
                    default:
                        companyType = ComanyType.Consignee;
                        break;
                }

                if (pre.Equals("*") || pre.Equals("."))
                {
                    allCompanyName = (from c in dc.Companies
                                      where c.CompanyType.Equals(companyType.ToString())
                                      select c.CompanyName).Distinct().ToList();
                }
                else
                {
                    allCompanyName = (from c in dc.Companies
                                      where c.CompanyType.Equals(companyType.ToString()) && c.CompanyName.StartsWith(pre)
                                      select c.CompanyName).Distinct().ToList();
                }
            }

            return allCompanyName;
        }
        
        #endregion
    }
}