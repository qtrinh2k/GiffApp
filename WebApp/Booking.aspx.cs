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
            long giffiRef = -1;
            if (!IsPostBack && Request.Params.HasKeys())
            {
                if (!string.IsNullOrEmpty(Request.QueryString["ref"]) &&
                    long.TryParse(Request.QueryString["ref"].ToString(), out giffiRef))
                {
                    txtGiffRef.Text = giffiRef.ToString();
                    txtGiffRef.DataBind();

                    PopulateData(giffiRef);
                    return;
                }
            }

            txtDate.Text = DateTime.Now.ToString("d");
            txtDate.DataBind();

            txtCreatedBy.Text = this.Page.User.Identity.Name;

            txtCreatedBy.Focus();
            txtCreatedBy.DataBind();
        }
       
        private void PopulateData(long giffiRef)
        {
            Booking r = DataUtil.GetBookingInfo(giffiRef);
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
            long giffiRef = -1;
            int bookingId = -1;
            if(long.TryParse(txtGiffRef.Text, out giffiRef))
            {
                bookingId = DataUtil.GetBookingFromGiffiRef(giffiRef);
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
            Response.Redirect(string.Format("Container.aspx?ref={0}&cusId={1}", txtGiffRef.Text, DataUtil.GetCompanyIdFromName(txtBillTo.Text)));
        }

        protected void AddNewBooking_Click(object sender, EventArgs e)
        {
            BookingRepository bRepo = new BookingRepository();
            long giffiRef = -1;
            /*
                        DataAccessBase dbAccess = new DataAccessBase();

                        using (SqlConnection con = new SqlConnection(dbAccess.ConnectionString))
                        {
                            using (SqlCommand cmd = new SqlCommand("InsertBooking", con))
                            {
                                cmd.CommandType = CommandType.StoredProcedure;

                                cmd.Parameters.Add("@createdBy", SqlDbType.NVarChar).Value = txtCreatedBy.Text.Trim();
                                cmd.Parameters.Add("@createdTime", SqlDbType.DateTime).Value = txtDate.Text.Trim();
                                cmd.Parameters.Add("@modifiedTime", SqlDbType.DateTime).Value = txtDate.Text.Trim();
                                cmd.Parameters.Add("@billToId", SqlDbType.Int).Value = DataUtil.GetCompanyIdFromName(txtBillTo.Text.Trim());
                                cmd.Parameters.Add("@shipperId", SqlDbType.Int).Value = DataUtil.GetCompanyIdFromName(txtShipper.Text.Trim());
                                cmd.Parameters.Add("@shipperRefNo", SqlDbType.NVarChar).Value = txtShipperRef.Text.Trim();
                                cmd.Parameters.Add("@carrierId", SqlDbType.Int).Value = DataUtil.GetCompanyIdFromCode(txtCarrier.Text.Trim());
                                cmd.Parameters.Add("@vessel", SqlDbType.NVarChar).Value = txtVessel.Text.Trim();
                                cmd.Parameters.Add("@voyage", SqlDbType.NChar).Value = txtVoyage.Text.Trim();
                                cmd.Parameters.Add("@origin", SqlDbType.NVarChar).Value = txtOrigin.Text.Trim();
                                cmd.Parameters.Add("@load", SqlDbType.NVarChar).Value = txtLoad.Text.Trim();
                                cmd.Parameters.Add("@destination", SqlDbType.NVarChar).Value = txtDest.Text.Trim();
                                cmd.Parameters.Add("@discharge", SqlDbType.NVarChar).Value = txtDischarge.Text.Trim();
                                cmd.Parameters.Add("@commodity", SqlDbType.NVarChar).Value = txtCommod.Text.Trim();
                                cmd.Parameters.Add("@equipment", SqlDbType.NVarChar).Value = txtEquiq1.Text.Trim() + txtEquiq2.Text.Trim();
                                cmd.Parameters.Add("@temp", SqlDbType.NChar).Value = txtTemp.Text.Trim();
                                cmd.Parameters.Add("@vents", SqlDbType.NChar).Value = txtVents.Text.Trim();
                                cmd.Parameters.Add("@status", SqlDbType.NChar).Value = "CREATED";
                                cmd.Parameters.Add("@notes", SqlDbType.NVarChar).Value = txtNotes.Text.Trim();
                                cmd.Parameters.Add("@CutOffDate", SqlDbType.DateTime).Value = DateTime.Parse(txtCutOffDate.Text.Trim());
                                cmd.Parameters.Add("@DOC", SqlDbType.DateTime).Value = DateTime.Parse(txtDOC.Text.Trim());
                                cmd.Parameters.Add("@CargoCut", SqlDbType.DateTime).Value = DateTime.Parse(txtCargoCut.Text.Trim());
                                cmd.Parameters.Add("@VGM", SqlDbType.DateTime).Value = DateTime.Parse(txtVGM.Text.Trim());
                                cmd.Parameters.Add("@ETD", SqlDbType.DateTime).Value = DateTime.Parse(txtETD.Text.Trim());
                                cmd.Parameters.Add("@ETA", SqlDbType.DateTime).Value = DateTime.Parse(txtETA.Text.Trim());
                                cmd.Parameters.Add("@ReturnValue", SqlDbType.BigInt).Direction = ParameterDirection.ReturnValue;
                                con.Open();
                                var result = cmd.ExecuteNonQuery();
                                if (!long.TryParse(cmd.Parameters["@ReturnValue"].Value.ToString(), out giffiRef))
                                {
                                    ClientScript.RegisterStartupScript(GetType(), "alert", "alert('Error occured when Submit data to SQL Database!!!');", true);
                                }

                            }
                        }
            */
            try
            {
                Booking booking = CreateBooking();

                //update booking info only, use exist giffiRefNo
                if (long.TryParse(txtGiffRef.Text, out giffiRef))
                {
                    long ignoreNo = -1;
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
    }
}
 