using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApp
{
    using DataAccess;
    using System.Data.SqlClient;

    public class InvoiceAmount
    {
       public int FreightId { get; set; }
        public int Code { get; set; }
        public string CodeName { get; set; }
        public decimal Amount { get; set; }
    }

    public partial class Invoice1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            long giffiRef = -1;
            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(txtSearchBox.Text) && long.TryParse(txtSearchBox.Text, out giffiRef) && giffiRef > 10000)
                {
                    if (gvInvoice.FooterRow != null)
                    {
                        DropDownList ddlCodes = gvInvoice.FooterRow.FindControl("ddlCode") as DropDownList;
                        ddlCodes.DataSource = GetAcctCodeMapIdWithName();
                        ddlCodes.DataTextField = "Key";
                        ddlCodes.DataValueField = "Key";
                        ddlCodes.DataBind();
                        ddlCodes.Items.Insert(0, new ListItem("--Select--", "0"));
                    }

                    ddlAddCode.DataSource = GetAcctCodeMapIdWithName();
                    ddlAddCode.DataTextField = "Key";
                    ddlAddCode.DataValueField = "Key";
                    ddlAddCode.DataBind();
                    ddlAddCode.Items.Insert(0, new ListItem("--Select--", "0"));

                    ddlAddVendor.DataSource = GetVendorInfo();
                    ddlAddVendor.DataBind();
                }
            }
        }

        protected void SelectedSearch_Click(object sender, EventArgs e)
        {

            long giffiRef = -1;
            BillingRepository repo = new BillingRepository();

            if (!string.IsNullOrEmpty(txtSearchBox.Text) && long.TryParse(txtSearchBox.Text, out giffiRef) && giffiRef > 10000)
            {
                lblGiffiRef.Text = txtSearchBox.Text;
                lblGiffiRef.DataBind();

                Company c = GetCompanyInfo(giffiRef);
                Booking b = GetBookingInfo(giffiRef);

                string cityZip = string.Join(", ", c.City.Trim(), c.State.Trim(), c.ZipCode.Trim());
                string cpInfo = string.Join("</br>", c.CompanyName, c.Address, cityZip, c.Country);

                lblBillTo.Text = cpInfo;
                lblBillTo.DataBind();

                lblDescription.Text = b.Commodity.Trim();

                lblYourRef.Text = b.ShipperRefNo;
                lblInvoiceDate.Text = b.CreatedTime.ToString("d");

                lblVoyage.Text = b.Voyage;
                lblOrigin.Text = b.Origin;
                lblDestination.Text = b.Destination;

                gvInvoice.DataSource = DataUtil.GetBillingItems(giffiRef);
                gvInvoice.DataBind();

                ddlAddCode.DataSource = GetAcctCodeMapIdWithName();
                ddlAddCode.DataTextField = "Key";
                ddlAddCode.DataValueField = "Key";                                
                ddlAddCode.DataBind();
                ddlAddCode.Items.Insert(0, new ListItem("--Select--", "0"));

                ddlAddVendor.DataSource = GetVendorInfo();
                ddlAddVendor.DataTextField = "Value";
                ddlAddVendor.DataValueField = "Key";
                ddlAddVendor.DataBind();

                tbAddBilling.Visible = true;
                tbAddBilling.DataBind();

                btnPreviewInvoice.Visible = true;
                btnPayoutPreview.Visible = true;

                txtSearchBox.Text = string.Empty;
            }
        }


        protected void gvInvoice_RowEditing(object sender, GridViewEditEventArgs e)
        {
            int bookingId = DataUtil.GetBookingFromGiffiRef(long.Parse(lblGiffiRef.Text));
            gvInvoice.DataSource = DataUtil.GetBillingItems(bookingId);
            gvInvoice.EditIndex = e.NewEditIndex;
            gvInvoice.DataBind();
        }

        protected void gvInvoice_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string erroMsg = string.Empty;

            GridViewRow row = gvInvoice.Rows[e.RowIndex];
            int billingItemId = (int)gvInvoice.DataKeys[e.RowIndex].Value;
            int bookingId = DataUtil.GetBookingFromGiffiRef(long.Parse(lblGiffiRef.Text));

            BillingItem bi = null;

            try
            {
                bi = new BillingItem
                {
                    Id = billingItemId,
                    BookingId = bookingId,
                    CodeId = int.Parse((row.FindControl("txtCodeId") as TextBox).Text.Trim()),
                    Description = (row.FindControl("txtDescription") as TextBox).Text.Trim(),
                    BillingAmount = decimal.Parse((row.FindControl("txtBillingAmount") as TextBox).Text.Trim()),
                    PayoutAmount = decimal.Parse((row.FindControl("txtPayoutAmount") as TextBox).Text.Trim())
                };

                BillingRepository repo = new BillingRepository();
                if(repo.UpdateBillingItem(bi))
                {
                    gvInvoice.EditIndex = -1;
                    gvInvoice.DataSource = DataUtil.GetBillingItems(bookingId);
                    gvInvoice.DataBind();                    
                }

            }
            catch (SqlException se)
            {
                erroMsg = string.Format("Unable to insert freight to database. SQLException={0}", bookingId, se.Message);
                AlertMessage(erroMsg);
            }
            catch (Exception ex)
            {
                erroMsg = string.Format("Unable to insert freight due to an invalid entry. Exception={0}", bookingId, ex.Message);
                AlertMessage(erroMsg);
            }

        }

        protected void gvInvoice_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            int bookingId = DataUtil.GetBookingFromGiffiRef(long.Parse(lblGiffiRef.Text));
            gvInvoice.DataSource = DataUtil.GetBillingItems(bookingId);
            gvInvoice.EditIndex = -1;
            gvInvoice.DataBind();
        }

        protected void gvInvoice_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int bookingId = DataUtil.GetBookingFromGiffiRef(long.Parse(lblGiffiRef.Text));

            int billingItemId = (int)gvInvoice.DataKeys[e.RowIndex].Value;

            BillingRepository repo = new BillingRepository();
            repo.DeleteItem(billingItemId, bookingId);

            gvInvoice.DataSource = DataUtil.GetBillingItems(bookingId);
            gvInvoice.EditIndex = -1;
            gvInvoice.DataBind();

        }


        private Dictionary<int, string> GetAcctCode()
        {
            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                var results = (from a in dc.AccountingCodes
                               select new { a.Id, a.Name });

                if (results == null || !results.Any())
                    return null;

                return results.ToDictionary(a => a.Id, a => string.Format("{0}, {1}", a.Id, a.Name));
            }

        }
        private Dictionary<int, string> GetAcctCodeWithName()
        {
            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                var results = (from a in dc.AccountingCodes
                               select new { a.Id, a.Name });

                if (results == null || !results.Any())
                    return null;

                return results.ToDictionary(a => a.Id, a => a.Name);
            }

        }

        private Dictionary<string, string> GetAcctCodeMapIdWithName()
        {
            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                var results = (from a in dc.AccountingCodes
                               select new { a.Id, a.MapId, a.Name });

                if (results == null || !results.Any())
                    return null;

                return results.ToDictionary(a => string.Join(",", a.Id, a.MapId), a => a.Name);
            }

        }

        private Tuple<decimal, decimal> GetTotal(int bookingId)
        {
            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                var results = (from b in dc.BillingItems
                               where b.BookingId == bookingId
                               select new { b.BillingAmount, b.PayoutAmount });


                if (results == null || !results.Any())
                    return null;

                decimal billing = results.AsEnumerable().Sum(a => a.BillingAmount);
                decimal payout = results.AsEnumerable().Sum(a => a.PayoutAmount);

                return new Tuple<decimal, decimal> (billing, payout);
            }
        }

        private Booking GetBookingInfo(long giffiRef)
        {
            int bookingId = DataUtil.GetBookingFromGiffiRef(giffiRef);

            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                var results = (from b in dc.Bookings
                               where b.Id == bookingId
                               select b);

                if (results == null || results.Count() == 0)
                {
                    return null;
                }

                return results.First();
            }
        }

        private Dictionary<int, string> GetVendorInfo()
        {
            List<string> carrierNames = new List<string>();

            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                var results = (from c in dc.Companies
                                where c.CompanyType.Equals("Vendor", StringComparison.InvariantCultureIgnoreCase)
                                select new { c.Id, c.Code });

                return results.ToDictionary(a => a.Id, a => a.Code);
            }

        }

        private string GetCarrierNameByCarrierId(int carrierId)
        {
            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                var results = (from c in dc.Companies
                               where c.Id == carrierId
                               select c.CompanyName);

                return results.FirstOrDefault();
            }
        }
        private Company GetCompanyInfo(long giffiRef)
        {
            int bookingId = DataUtil.GetBookingFromGiffiRef(giffiRef);

            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                var results = (from b in dc.Bookings
                               where b.Id == bookingId
                               select b.BillToId);

                if(results == null || results.Count() == 0)
                {
                    return null;
                }

                int billToId = results.First();
                var cp = (from c in dc.Companies
                          where c.Id == billToId
                          select c);

                return cp.First();
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


        protected void btnUpdateTotal_Click(object sender, EventArgs e)
        {
            gvInvoice_DataBound(sender, e);
        }
        protected void gvInvoice_DataBound(object sender, EventArgs e)
        {
            int bookingId = DataUtil.GetBookingFromGiffiRef(long.Parse(lblGiffiRef.Text));
            Tuple<decimal, decimal> totals = GetTotal(bookingId);
            if (totals != null)
            {
                TextBox txbControlBillingAmount = gvInvoice.FooterRow.FindControl("txtBillingAmount") as TextBox;
                TextBox txbControlPayoutAmount = gvInvoice.FooterRow.FindControl("txtPayOutAmount") as TextBox;
                txbControlBillingAmount.Text = string.Format("{0:0.00}", totals.Item1);
                txbControlPayoutAmount.Text = string.Format("{0:0.00}", totals.Item2);
            }
        }

        protected void ddlCode_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddlCodes = gvInvoice.FooterRow.FindControl("ddlCode") as DropDownList;
            TextBox txtCodeName = gvInvoice.FooterRow.FindControl("txtCodeName") as TextBox;
            var dictCodeName = GetAcctCodeWithName();

            int codeId = -1;
            if (int.TryParse(ddlCodes.SelectedValue, out codeId) && codeId > 4000)
            {
                txtCodeName.Text = dictCodeName[codeId];
                txtCodeName.DataBind();
            }

        }

        protected void btnAddBillingItem_Click(object sender, EventArgs e)
        {
            int bookingId = DataUtil.GetBookingFromGiffiRef(long.Parse(lblGiffiRef.Text));

            BillingRepository repo = new BillingRepository();
            var arrCodeMap = ddlAddCode.SelectedValue.Split(',');
            decimal billingAmount = 0;
            decimal payoutAmount = 0;

            string errorMsg = string.Empty;

            int codeId = 0;
            if(bookingId < Constants.InitBookingId)
            {
                errorMsg = string.Format("ERROR!!! Invalid bookingId={0}.", bookingId);
                AlertMessage(errorMsg);
            }
            else if(arrCodeMap == null || arrCodeMap.Count() == 0 || !int.TryParse(arrCodeMap[0], out codeId))
            {
                errorMsg = string.Format("ERROR!!! Parsing AccountingCode from input.");
                AlertMessage(errorMsg);

            }
            else if(!decimal.TryParse(txtAddBillingAmount.Text, out billingAmount) ||
                !decimal.TryParse(txtAddPayoutAmount.Text, out payoutAmount))
            {
                errorMsg = string.Format("ERROR!!! INVALID Billing={0} or Payout={1}.", txtAddBillingAmount.Text, txtAddPayoutAmount.Text);
                AlertMessage(errorMsg);
            }
            else if (payoutAmount > billingAmount)
            {
                errorMsg = string.Format("ERROR!!! Payout={1} cannot greater than Billing={0} amount.", txtAddBillingAmount.Text, txtAddPayoutAmount.Text);
                AlertMessage(errorMsg);
            }
            else if(billingAmount <= 0 || payoutAmount < 0)
            {
                errorMsg = string.Format("ERROR!!! Billing={0} or Payout={1} invalid amount.", txtAddBillingAmount.Text, txtAddPayoutAmount.Text);
                AlertMessage(errorMsg);
            }
            else if(ddlAddVendor.SelectedValue == "0")
            {
                errorMsg = string.Format("ERROR!!! Need to choose a vendor.");
                AlertMessage(errorMsg);
            }
            else
            {
                if(repo.InsertBillingItem(bookingId, int.Parse(arrCodeMap[0]), 1, txtAddDescription.Text, billingAmount, payoutAmount, int.Parse(ddlAddVendor.SelectedValue.ToString())))
                {
                    gvInvoice.DataSource = DataUtil.GetBillingItems(bookingId);
                    gvInvoice.DataBind();

                    ddlAddCode.SelectedIndex = -1;
                    txtAddDescription.Text = "";
                    txtAddBillingAmount.Text = "";
                    txtAddBillingAmount.Enabled = true;
                    txtAddPayoutAmount.Text = "";
                    txtAddPayoutAmount.Enabled = true;
                }
            }
            
            
        }


        protected void ddlAddCode_SelectedIndexChanged(object sender, EventArgs e)
        {
            var dictCodeName = GetAcctCodeMapIdWithName();

            if(dictCodeName.ContainsKey(ddlAddCode.SelectedValue))
            {
                txtAddDescription.Text = dictCodeName[ddlAddCode.SelectedValue];
                txtAddDescription.DataBind();
            }


            if(ddlAddCode.SelectedValue.Contains("4310"))
            {
                txtAddPayoutAmount.Text = "0.00";
                txtAddPayoutAmount.Enabled = false;
            }

        }


        private void AlertMessage(string msg)
        {
            this.Page.AlertMessage(GetType(), msg);
        }

        protected void btnPreviewInvoice_Click(object sender, EventArgs e)
        {
            Response.Redirect(string.Format("PreviewInvoice.aspx?ref={0}", lblGiffiRef.Text));
        }

        protected void btnPreviewPayout_Click(object sender, EventArgs e)
        {
            Response.Redirect(string.Format("PayoutPreview.aspx?ref={0}", lblGiffiRef.Text));
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<string> GetVendor(string pre)
        {
            List<string> carrierNames = new List<string>();

            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                if (pre.Equals("*") || pre.Equals("."))
                {
                    carrierNames = (from c in dc.Companies
                                    where c.CompanyType.Equals("Vendor", StringComparison.InvariantCultureIgnoreCase)
                                    select c.Code).Distinct().ToList();
                }
                else
                {
                    carrierNames = (from c in dc.Companies
                                    where c.Code.StartsWith(pre) && c.CompanyType.Equals("Vendor", StringComparison.InvariantCultureIgnoreCase)
                                    select c.Code).Distinct().ToList();
                }
            }

            return carrierNames;
        }
    }
}