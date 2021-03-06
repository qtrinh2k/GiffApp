﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApp
{
    public partial class PayoutPreview : System.Web.UI.Page
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

                        Company c = DataUtil.GetBillToCompany(giffiRef);
                        Booking b = DataUtil.GetBookingFromGiffiId(giffiRef);

                        string cityZip = string.Join(", ", c.City.Trim(), c.State.Trim(), c.ZipCode.Trim());
                        string cpInfo = string.Join("</br>", c.CompanyName, c.Address, cityZip, c.Country);

                        #region Payout
                        lblBillTo2.Text = cpInfo;
                        lblBillTo2.DataBind();

                        lblDescription2.Text = b.Commodity.Trim();

                        lblYourRef2.Text = b.ShipperRefNo;
                        lblInvoiceDate2.Text = b.CreatedTime.ToString("d");

                        lblCarrier2.Text = DataUtil.GetCarrierNameByCarrierId(b.CarrierId);
                        lblOrigin2.Text = b.Origin;
                        lblDestination2.Text = b.Destination;

                        int bookingId = DataUtil.GetBookingIdFromGiffiId(giffiRef);
                        rptPayout.DataSource = DataUtil.GetPayoutItems(bookingId);
                        rptPayout.DataBind();

                        var controlPayoutTotal = rptPayout.FindControlInFooter("lblPayoutTotal") as Label;
                        controlPayoutTotal.Text = string.Format("{0:0.00}", GetPayoutTotal(bookingId));

                        var controlNETTotal = rptPayout.FindControlInFooter("lblNETTotal") as Label;
                        controlNETTotal.Text = string.Format("{0:0.00}", GetNETTotal(bookingId));
                        controlPayoutTotal.DataBind();
                        #endregion
                    }
                }
            }
        }

        private decimal GetPayoutTotal(int bookingId)
        {
            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                var results = (from b in dc.BillingItems
                               where b.BookingId == bookingId
                               select new { b.PayoutAmount });


                if (results == null || !results.Any())
                    return 0;

                decimal payout = results.AsEnumerable().Sum(a => a.PayoutAmount);

                return Math.Round(payout, 2, MidpointRounding.AwayFromZero);
            }
        }

        private decimal GetNETTotal(int bookingId)
        {
            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                var results = (from b in dc.BillingItems
                               where b.BookingId == bookingId
                               select new {b.BillingAmount, b.PayoutAmount });


                if (results == null || !results.Any())
                    return 0;

                decimal billing = results.AsEnumerable().Sum(a => a.BillingAmount);
                decimal payout = results.AsEnumerable().Sum(a => a.PayoutAmount);
                return Math.Round(billing - payout, 2, MidpointRounding.AwayFromZero);
            }
        }
    }
}