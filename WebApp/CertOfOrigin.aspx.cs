﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApp.DataAccess;

namespace WebApp
{
    public partial class CertOfOrigin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                List<Company> cp = DataUtil.GetCompanyByType(CompanyType.Consignee);
                cp.Insert(0, new Company { Id = 0, CompanyName = "--Select--" });

                ddlConsignee.DataSource = cp;
                ddlConsignee.DataTextField = "CompanyName";
                ddlConsignee.DataValueField = "Id";
                ddlConsignee.DataBind();

                ddlNotify.DataSource = cp;
                ddlNotify.DataTextField = "CompanyName";
                ddlNotify.DataValueField = "Id";
                ddlNotify.DataBind();

                List<Company> cpSuppliers = DataUtil.GetCompanyByType(CompanyType.Supplier);
                cpSuppliers.Insert(0, new Company { Id = 0, CompanyName = "--Select--" });

                ddlSupplier.DataSource = cpSuppliers;
                ddlSupplier.DataTextField = "CompanyName";
                ddlSupplier.DataValueField = "Id";
                ddlSupplier.DataBind();

                List<Company> cpWarehouses = DataUtil.GetCompanyByType(CompanyType.Warehouse);
                cpWarehouses.Insert(0, new Company { Id = 0, CompanyName = "--Select--" });

                ddlWarehouse.DataSource = cpWarehouses;
                ddlWarehouse.DataTextField = "CompanyName";
                ddlWarehouse.DataValueField = "Id";
                ddlWarehouse.DataBind();
            }
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
            string giffiRefNo = searchPhase;

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

                        PopulateBookingData(giffiRefNo);

                        break;
                    case 2: //ShipperRef
                        double? dGiffiRef = dc.BookingViews.Where(x => x.ShipperRefNo.Equals(searchPhase, StringComparison.InvariantCultureIgnoreCase)).Select(x => x.GiffiId).FirstOrDefault();

                        if (!dGiffiRef.HasValue)
                        {
                            this.AlertMessage(GetType(), string.Format("SYSTEM ERROR!!! INVALID GiffRef#{0}", searchPhase));
                            return;
                        }

                        PopulateBookingData(dGiffiRef.Value.ToString());
                        break;
                    case 3: //CarrierRef
                        double? dGiffiRef2 = dc.BookingViews.Where(x => x.CarrierRefNo.Equals(searchPhase, StringComparison.InvariantCultureIgnoreCase)).Select(x => x.GiffiId).FirstOrDefault();

                        if (!dGiffiRef2.HasValue)
                        {
                            this.AlertMessage(GetType(), string.Format("SYSTEM ERROR!!! INVALID GiffRef#{0}", searchPhase));
                            return;
                        }

                        PopulateBookingData(dGiffiRef2.Value.ToString());

                        break;
                    default:
                        break;
                }
            }
        }

        private void PopulateBookingData(string giffiReNo)
        {
            int bookingId = DataUtil.GetBookingIdFromGiffiId(double.Parse(giffiReNo));

            lblGiffiRef.Text = giffiReNo;
            hfSearchBookingId.Value = bookingId.ToString();
            hfBOLId.Value = "-1";
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

                Container cont = dc.Containers.Where(x => x.BookingId == bookingId).FirstOrDefault();
                if (cont != null)
                {
                    txtContainerNo.Text = cont.ContainerNo;
                    txtSEALNo.Text = cont.SealNo;
                }

                if (dc.CertOfOrigins.Any(x => x.BookingId == bookingId))
                {
                    var bol = dc.CertOfOrigins.Where(x => x.BookingId == bookingId).FirstOrDefault();
                    hfBOLId.Value = bol.Id.ToString();

                    txtConsignee.Text = bol.ConsigneeAddress;
                    txtConsigneeRef.Text = bol.ConsigneeRef;
                    txtBLNo.Text = bol.BOLRef.ToString();
                    txtNotify.Text = bol.NotifyAddress;
                    txtDateOfIssue.Text = (bol.DateOfIssue.HasValue) ? bol.DateOfIssue.Value.ToString("d") : "";
                    txtPlaceOfIssue.Text = bol.PlaceOfIssue;
                    txtPlaceOfDelivery.Text = bol.PlaceOfDelivery;
                    txtPlaceOfReceipt.Text = bol.PlaceOfReceipt;
                    txtSupplier.Text = bol.SupplierAddress;
                    txtWarehouse.Text = bol.WarehouseAddress;
                    txtNotes.Text = bol.Notes;
                }
            }
        }

        protected void ddlNotify_SelectedIndexChanged(object sender, EventArgs e)
        {
            int id = int.Parse(ddlNotify.SelectedValue);
            txtNotify.Text = DataUtil.GetCompanyAsText(id);
        }

        protected void ddlSupplier_SelectedIndexChanged(object sender, EventArgs e)
        {
            int id = int.Parse(ddlSupplier.SelectedValue);
            txtSupplier.Text = DataUtil.GetCompanyAsText(id);

        }

        protected void ddlConsignee_SelectedIndexChanged(object sender, EventArgs e)
        {
            int id = int.Parse(ddlConsignee.SelectedValue);
            txtConsignee.Text = DataUtil.GetCompanyAsText(id);
        }

        protected void ddlWarehouse_SelectedIndexChanged(object sender, EventArgs e)
        {
            int id = int.Parse(ddlWarehouse.SelectedValue);
            txtWarehouse.Text = DataUtil.GetCompanyAsText(id);
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            int bookingId = -1;
            if (!int.TryParse(hfSearchBookingId.Value, out bookingId))
            {
                this.AlertMessage(GetType(), "Required a valid GiffiId before insert BOL info");
                return;
            }

            CertOfOrigin coo = new CertOfOrigin
            {
                Id = string.IsNullOrWhiteSpace(hfBOLId.Value) ? -1 : int.Parse(hfBOLId.Value),
                BookingId = bookingId,
                BOLRef = txtBLNo.Text.Trim(),
                CertificateRef = txtCertRef.Text.Trim(),
                ConsigneeAddress = txtConsignee.Text,
                ConsigneeRef = txtConsigneeRef.Text,
                NotifyAddress = txtNotify.Text,
                PlaceOfDelivery = txtPlaceOfDelivery.Text,
                PlaceOfReceipt = txtPlaceOfReceipt.Text,
                PlaceOfIssue = txtPlaceOfIssue.Text,
                DateOfIssue = (!string.IsNullOrWhiteSpace(txtDateOfIssue.Text)) ? DateTime.Parse(txtDateOfIssue.Text.Trim()) : DateTime.Now,
                SupplierAddress = txtSupplier.Text,
                WarehouseAddress = txtWarehouse.Text,
                Notes = txtNotes.Text.Trim()
            };

            COORepository repo = new COORepository();
            if (repo.InsertUpdate(coo))
            {
                ClearAllText();
                this.AlertMessage(GetType(), string.Format("Successfully Update BOL for bookingId={0}!!!", bookingId));
            }
        }

        private void ClearAllText()
        {
            var txtBoxes = this.Controls.FindAll().OfType<TextBox>();
            foreach (var item in txtBoxes)
            {
                item.Text = "";
            }

            hfBOLId.Value = "-1";
            lblCarrierRef.Text = "";
            lblGiffiRef.Text = "";
            lblShipper.Text = "";
            ddlConsignee.TabIndex = -1;
            ddlNotify.TabIndex = -1;
            ddlSupplier.TabIndex = -1;
            ddlWarehouse.TabIndex = -1;
        }

    }
}