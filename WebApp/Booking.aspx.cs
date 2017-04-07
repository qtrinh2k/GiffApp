using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Services;
using System.Web.Services;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;

namespace WebApp
{
    using DataAccess;

    public partial class Booking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int bookingId = -1;
            if (!IsPostBack && Request.Params.HasKeys())
            {
                if (!string.IsNullOrEmpty(Request.QueryString["ref"]) &&
                    int.TryParse(Request.QueryString["bid"].ToString(), out bookingId))
                {
                    txtGiffRef.Text = Request.QueryString["ref"];
                    txtGiffRef.DataBind();
                    hfBookingId.Value = Request.QueryString["bid"].ToString();
                    PopulateData(bookingId);

                    btnClone.Visible = true;
                    return;
                }
            }

            if (!IsPostBack)
            {
                txtDate.Text = DateTime.Now.ToString("d");
                txtDate.DataBind();

                txtCreatedBy.Text = this.Page.User.Identity.Name.ToUpper();

                txtCreatedBy.Focus();
                txtCreatedBy.DataBind();
            }
        }
       
        private void PopulateData(int bookingId)
        {
            Booking r = DataUtil.GetBookingInfo(bookingId);
            txtCreatedBy.Text = r.CreatedBy;
            txtDate.Text = r.CreatedTime.ToString("d");
            txtBillTo.Text = DataUtil.GetCompanyNameById(r.BillToId);
            txtShipper.Text = DataUtil.GetCompanyNameById(r.ShipperId);
            txtShipperRef.Text = r.ShipperRefNo;
            txtCarrier.Text = DataUtil.GetCompanyCodeById(r.CarrierId);
            txtCarrierRef.Text = r.CarrierRefNo;
            txtVessel.Text = r.Vessel;
            txtVoyage.Text = r.Voyage;
            txtOrigin.Text = r.Origin;
            txtLoad.Text = r.Load;
            txtDest.Text = r.Destination;
            txtDischarge.Text = r.Discharge;
            txtCommod.Text = r.Commodity;
            txtEquiq1.Text = r.Equipment.Split('|').First();
            txtEquiq2.Text = r.Equipment.Split('|').Skip(1).First();
            txtTemp.Text = r.Temp;
            txtVents.Text = r.Vents;
            txtNotes.Text = r.Notes;
            txtCutOffDate.Text = (r.CutOffDate.HasValue) ? r.CutOffDate.Value.ToString("d") : "";
            txtDOC.Text = (r.DOC.HasValue) ? r.DOC.Value.ToString("d") : "";
            txtCargoCut.Text = (r.CargoCut.HasValue) ? r.CargoCut.Value.ToString("d") : "";
            txtVGM.Text = (r.VGM.HasValue) ? r.VGM.Value.ToString("d") : "";
            txtETD.Text = (r.ETD.HasValue) ? r.ETD.Value.ToString("d") : "";
            txtETA.Text = (r.ETA.HasValue) ? r.ETD.Value.ToString("d") : "";
        }

        private Booking CreateBooking()
        {
            double giffiRef = -1;
            int bookingId = -1;
            if(double.TryParse(txtGiffRef.Text, out giffiRef))
            {
                bookingId = DataUtil.GetBookingIdFromGiffiId(giffiRef);
            }

            Booking b = new Booking
            {
                Id = bookingId,
                CreatedBy = txtCreatedBy.Text,
                CreatedTime = DateTime.Now,
                ModifiedTime = DateTime.Now,
                BillToId = DataUtil.GetCompanyIdFromName(txtBillTo.Text.Trim()),
                ShipperId = DataUtil.GetCompanyIdFromName(txtShipper.Text.Trim()),
                ShipperRefNo = txtShipperRef.Text.Trim(),
                CarrierId = DataUtil.GetCompanyIdFromCode(txtCarrier.Text.Trim()),
                CarrierRefNo = txtCarrierRef.Text.Trim(),
                Vessel = txtVessel.Text,
                Voyage = txtVoyage.Text,
                Origin = txtOrigin.Text,
                Load = txtLoad.Text,
                Destination = txtDest.Text,
                Discharge = txtDischarge.Text,
                Commodity = txtCommod.Text,
                Equipment = string.Join("|", txtEquiq1.Text.Trim(), txtEquiq2.Text.Trim()),
                Temp = txtTemp.Text,
                Status = "CREATED",
                Vents = txtVents.Text,
                Notes = txtNotes.Text,
                CutOffDate = DateTime.Parse(txtCutOffDate.Text.Trim()),
                DOC = DateTime.Parse(txtDOC.Text.Trim()),
                CargoCut = DateTime.Parse(txtCargoCut.Text.Trim()),
                VGM = DateTime.Parse(txtVGM.Text.Trim()),
                ETD = DateTime.Parse(txtETD.Text.Trim()),
                ETA = DateTime.Parse(txtETA.Text.Trim())
            };

            return b;
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            Response.Redirect(string.Format("Container.aspx?ref={0}&bid={1}", txtGiffRef.Text, hfBookingId.Value));
        }

        protected void AddNewBooking_Click(object sender, EventArgs e)
        {
            BookingRepository bRepo = new BookingRepository();
            double giffiRef = -1;

            try
            {
                Booking booking = CreateBooking();

                //update booking info only, use exist giffiRefNo
                if (double.TryParse(txtGiffRef.Text, out giffiRef))
                {
                    double ignoreNo = -1;
                    bRepo.InsertUpdateBooking(booking, out ignoreNo);
                }
                else
                {
                    bRepo.InsertUpdateBooking(booking, out giffiRef);
                }

                 if (giffiRef > 10000)
                {
                    txtGiffRef.Text = giffiRef.ToString();
                    txtGiffRef.DataBind();

                    this.Page.AlertMessage(GetType(), string.Format("Successfully Submit Reference#{0}", giffiRef));

                    var tboxControls = this.Controls.FindAll().OfType<TextBox>();
                    foreach (TextBox item in tboxControls)
                    {
                        item.Enabled = false;
                    }

                    btnSubmitBooking.Visible = false;
                    btnClose.Visible = true;
                    btnNext.Visible = true;
                    btnClone.Visible = true;
                }
                else
                {
                    this.Page.AlertMessage(GetType(), string.Format("Error occured when Submit data bookingId={0}", booking.Id));
                }
            }
            catch (SqlException se)
            {
                string outMsg = string.Format("Unable to insert booking to database. SQLException={0}'", se.Message);
                this.Page.AlertMessage(GetType(), outMsg);
            }
            catch (Exception ex)
            {
                string outMsg = string.Format("Unable to insert booking due to an invalid entry. Exception={0}", ex.Message);
                this.Page.AlertMessage(GetType(), outMsg);
            }
        }


        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<string> GetCompanyName(string pre)
        {
            List<string> allCompanyName = new List<string>();

            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                if (pre.Equals("*") || pre.Equals("."))
                {
                    allCompanyName = (from c in dc.Companies
                                      select c.CompanyName).Distinct().ToList();
                }
                else
                {
                    allCompanyName = (from c in dc.Companies
                                      where c.CompanyName.StartsWith(pre)
                                      select c.CompanyName).Distinct().ToList();
                }
            }

            return allCompanyName;
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<string> GetCarrierCode(string pre)
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

        protected void btnClose_Click(object sender, EventArgs e)
        {
            Response.Redirect("Index.aspx");
        }

        protected void btnClone_Click(object sender, EventArgs e)
        {
            BookingRepository bRepo = new BookingRepository();
            double giffiRef = -1;
            //clone data
            
            if(!double.TryParse(txtGiffRef.Text, out giffiRef))
            {
                this.Page.AlertMessage(GetType(), string.Format("INVALID GiffiRefId={0}", giffiRef));
                return;
            }

            try
            {
                int bookingId = DataUtil.GetBookingIdFromGiffiId(giffiRef);
                //popular with new giffiId
                int newBookingId = -1;
                string newGiffiId = string.Empty;
                if (bRepo.CloneBooking(bookingId, out newBookingId, out newGiffiId))
                {
                    txtGiffRef.Text = newGiffiId;
                    txtGiffRef.DataBind();

                    PopulateData(newBookingId);

                    this.Page.AlertMessage(GetType(), string.Format("Successfully clone booking data to new GiffiRef={0}.", giffiRef.ToString("R")));

                    btnClone.Visible = false;
                    btnNext.Visible = true;
                    btnClose.Visible = true;
                }
                else
                {
                    this.Page.AlertMessage(GetType(), "Failed to Clone existing record!!!");
                }
            }
            catch (SqlException se)
            {
                this.Page.AlertMessage(GetType(), string.Format("Failed to Clone existing record!!! With SQLError={0}", se.Message));
            }
            catch(Exception ex)
            {
                this.Page.AlertMessage(GetType(), string.Format("Failed to Clone existing record!!! Error={0}", ex.Message));
            }

        }
    }
}
 