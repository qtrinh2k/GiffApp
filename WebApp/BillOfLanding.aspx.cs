using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
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

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<string> SearchBy(string pre, int option)
        {
            var regex = new Regex(pre, RegexOptions.IgnoreCase);
            List<string> results = new List<string>();
            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                switch (option)
                {
                    case 1:
                        results = DataUtil.SearchBookingReferenceFor(pre);
                        break;
                    case 2:
                        if (pre.Equals("*") || pre.Equals("."))
                            results = dc.BookingViews.ToList<BookingView>().Select(x => x.CarrierRefNo.TrimEnd()).ToList();
                        else
                            results = dc.BookingViews.ToList<BookingView>().Where(x => x.CarrierRefNo.StartsWith(pre)).Select(x => x.CarrierRefNo.TrimEnd()).ToList();
                        break;
                    case 3:
                        if (pre.Equals("*") || pre.Equals("."))
                            results = dc.BookingViews.ToList<BookingView>().Select(x => x.ShipperRefNo.TrimEnd()).ToList();
                        else
                            results = dc.BookingViews.ToList<BookingView>().Where(x => x.ShipperRefNo.StartsWith(pre)).Select(x => x.ShipperRefNo.TrimEnd()).ToList();
                        break;
                    case 4:
                        //TODO
                        break;
                    default:
                        results = DataUtil.SearchBookingReferenceFor(pre);
                        break;
                }
            }
            return results;
        }

        #endregion

        protected void btnSelectedSearch_Click(object sender, EventArgs e)
        {
            int option = int.Parse(ddlSearchOption.SelectedValue.ToString());
            string searchPhase = txtSearchBox.Text.Trim();
            var regex = new Regex(searchPhase, RegexOptions.IgnoreCase);
            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                switch (option)
                {
                    case 1:
                        if (!dc.BookingViews.Any() && !dc.BookingViews.Any(x => x.GiffiId.Value.ToString().Trim().Equals(searchPhase)))
                        {
                            this.AlertMessage(GetType(), string.Format("SYSTEM ERROR!!! INVALID GiffRef#{0}", searchPhase));
                            return;
                        }

                        lblGiffiRef.Text = searchPhase;
                        PopulateBookingData(searchPhase);
                            
                        break;
                    case 2:
                        break;
                    case 3:
                        break;
                    default:
                        break;
                }
            }
        }

        private void PopulateBookingData(string giffiReNo)
        {
            int bookingId = DataUtil.GetBookingIdFromGiffiId(double.Parse(giffiReNo));
            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                BookingView view = dc.BookingViews.ToList<BookingView>().Where(x => x.BookingId == bookingId).FirstOrDefault();

                if (view != null)
                {

                    Company c = DataUtil.GetBillToCompany(double.Parse(giffiReNo)); //using

                    string cityZip = string.Join(", ", c.City.Trim(), c.State.Trim(), c.ZipCode.Trim());
                    string cpInfo = string.Join("</br>", c.CompanyName, c.Address, cityZip, c.Country);

                    lblShipper.Text = cpInfo;
                    lblCarrierRef.Text = view.CarrierRefNo;
                }

            }
                

        }
    }
}