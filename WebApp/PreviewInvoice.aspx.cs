using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApp
{
    public partial class PreviewInvoice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            double giffiRef = -1;
            if (!Page.IsPostBack)
            {
                if (Request.Params.HasKeys())
                {
                    if (!string.IsNullOrEmpty(Request.QueryString["ref"]) &&
                        double.TryParse(Request.QueryString["ref"].ToString(), out giffiRef))
                    {
                        lblInvoiceNo.Text = giffiRef.ToString();
                        lblInvoiceNo.DataBind();

                        Company c = DataUtil.GetCompanyInfo(giffiRef);
                        Booking b = DataUtil.GetBookingFromGiffiId(giffiRef);

                        if(b == null)
                        {
                            this.Page.AlertMessage(GetType(), string.Format("System Error!!! Unable to find booking data for GiffiRef={0}", giffiRef));
                            return;
                        }

                        string cityZip = string.Join(", ", c.City.Trim(), c.State.Trim(), c.ZipCode.Trim());
                        string cpInfo = string.Join("</br>", c.CompanyName, c.Address, cityZip, c.Country);
                        #region Invoice
                        lblBillTo.Text = cpInfo;
                        lblBillTo.DataBind();

                        lblDescription.Text = b.Commodity.Trim();

                        lblYourRef.Text = b.ShipperRefNo;
                        lblInvoiceDate.Text = b.CreatedTime.ToString("d");

                        lblCarrier.Text = DataUtil.GetCarrierNameByCarrierId(b.CarrierId);
                        lblOrigin.Text = b.Origin;
                        lblDestination.Text = b.Destination;

                        
                        rptInvoice.DataSource = DataUtil.GetBillingItems(b.Id);
                        rptInvoice.DataBind();

                        var controlTotal = rptInvoice.FindControlInFooter("lblTotal") as Label;
                        controlTotal.Text = string.Format("{0:0.00}", GetInvoiceTotal(b.Id));
                        controlTotal.DataBind();
                        #endregion
                    }
                }
            }
        }

        private decimal GetInvoiceTotal(int bookingId)
        {
            decimal billing = 0;
            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                var results = (from b in dc.BillingItems
                               where b.BookingId == bookingId
                               select new {b.BillingAmount});


                if (results == null || !results.Any())
                    return billing;

                billing = results.AsEnumerable().Sum(a => a.BillingAmount);

                return billing;
            }
        }

        private decimal GetPayoutTotal(int bookingId)
        {
            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                var results = (from b in dc.BillingItems
                               where b.BookingId == bookingId
                               select new {b.PayoutAmount });


                if (results == null || !results.Any())
                    return 0;

                decimal payout = results.AsEnumerable().Sum(a => a.PayoutAmount);

                return payout;
            }
        }

        protected void btnPrintInvoice_Click(object sender, EventArgs e)
        {

        }
    }
}