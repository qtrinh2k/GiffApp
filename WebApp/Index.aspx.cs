using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
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
                    using (GiffiDBEntities dc = new GiffiDBEntities())
                    {
                        var results = (from d in dc.BookingViews
                                       where d.CreatedBy.Equals(userName, StringComparison.InvariantCultureIgnoreCase)
                                       orderby d.ModifiedTime descending
                                       select d).ToList();
                        gvIndex.DataSource = results;
                        gvIndex.DataBind();
                    }

                    //BookingRepository repo = new BookingRepository();
                    //var results = repo.GetBookingByUsername(userName);
                }

            }

        }
        protected void SelectedSearch_Click(object sender, EventArgs e)
        {
            int option = int.Parse(DropDownList1.SelectedValue.ToString());
            string searchPhase = txtSearchBox.Text;
            var regex = new Regex(searchPhase, RegexOptions.IgnoreCase);

            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                var bvList = dc.BookingViews.ToList<BookingView>();
                switch (option)
                {
                    case 1:
                        
                        if (searchPhase.Equals(".") || searchPhase.Equals("*"))
                        {
                            gvIndex.DataSource = bvList;
                        }
                        else
                        {                            
                            var results = bvList.Where(x => x.GiffiId.Value.ToString().StartsWith(searchPhase));
                            gvIndex.DataSource = results;
                        }
                        break;
                    case 2:
                        var shipperList = bvList.Where(x => regex.IsMatch(x.ShipperRefNo));
                        gvIndex.DataSource = shipperList;
                        break;
                    case 3:
                        var carrierList = bvList.Where(x => regex.IsMatch(x.CarrierRefNo));
                        gvIndex.DataSource = carrierList;
                        break;
                    default:
                        gvIndex.DataSource = bvList;
                        break;
                }
                gvIndex.DataBind();
            }
        }
        #region WebMethod
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<string> SearchFor(string pre, int option)
        {
            List<string> results = new List<string>();

            if (option == 1)
            {
                results = DataUtil.SearchBookingReferenceFor(pre);
            }

            return results;
        }
        #endregion

        protected void btlGiffiRef_Click(object sender, EventArgs e)
        {
            var lbGiffiRef = sender as LinkButton;
            GridViewRow clickedRow = ((LinkButton)sender).NamingContainer as GridViewRow;
            HiddenField hfBookingId = (HiddenField)clickedRow.FindControl("hiddenBookingId");
            
            Response.Redirect(string.Format("Booking.aspx?ref={0}&bid={1}", lbGiffiRef.Text, hfBookingId.Value));
        }

        protected void gvIndex_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = gvIndex.Rows[index];

            HiddenField hdnField = (HiddenField)row.FindControl("hiddenBookingId");
        }
    }
}