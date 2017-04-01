using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApp.DataAccess;

namespace WebApp
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (this.Page.User == null || !this.Page.User.Identity.IsAuthenticated)
                {
                    FormsAuthentication.RedirectToLoginPage();
                }
                else
                {

                    string userName = this.Page.User.Identity.Name;
                    BookingRepository repo = new BookingRepository();
                    var results = repo.GetBookingByUsername(userName);
                    gvIndex.DataSource = results;
                    gvIndex.DataBind();
                }

            }

        }
        protected void SelectedSearch_Click(object sender, EventArgs e)
        {
            //long giffiRef = -1;
            //if (!string.IsNullOrEmpty(txtSearchBox.Text) && long.TryParse(txtSearchBox.Text, out giffiRef) && giffiRef > 10000)
            //{
            //    txtGiffRef.Text = txtSearchBox.Text;
            //    txtGiffRef.DataBind();

            //    txtSearchBox.Text = string.Empty;

            //}
        }
        #region WebMethod
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<string> SearchFor(string pre, int option)
        {
            List<string> results = new List<string>();

            if (option == 1)
            {
                using (GiffiDBEntities dc = new GiffiDBEntities())
                {
                    if (pre.Equals("*") || pre.Equals("."))
                    {
                        results = (from c in dc.BookingReferences
                                   select c.GiffiId.ToString()).Distinct().ToList();
                    }
                    else
                    {
                        results = (from c in dc.BookingReferences
                                   where c.GiffiId.ToString().StartsWith(pre)
                                   select c.GiffiId.ToString()).Distinct().ToList();
                    }
                }
            }


            return results;
        }
        #endregion

        protected void btlGiffiRef_Click(object sender, EventArgs e)
        {
            var lbGiffiRef = sender as LinkButton;


            Response.Redirect(string.Format("Booking.aspx?ref={0}", lbGiffiRef.Text));
        }
    }
}