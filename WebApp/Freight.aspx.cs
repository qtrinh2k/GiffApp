﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.Script.Services;
using System.Globalization;
namespace WebApp
{
    using DataAccess;

    public partial class Freight : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            long giffRef = -1;

            if (!Page.IsPostBack)
            {
                if (Request.Params.HasKeys())
                {
                    if (!string.IsNullOrEmpty(Request.QueryString["ref"]) &&
                        long.TryParse(Request.QueryString["ref"].ToString(), out giffRef))
                    {
                        txtGiffRef.Text = giffRef.ToString();
                        txtGiffRef.DataBind();

                        tbAddFreight.Visible = true;
                        tbAddFreight.DataBind();

                        gvFreight.DataSource = GetFreights(long.Parse(txtGiffRef.Text));
                        gvFreight.DataBind();
                    }
                    else
                    {
                        tbAddFreight.Visible = false;
                        tbAddFreight.DataBind();
                    }

                }

                ddlNewCode.DataSource = GetAcctCode();
                ddlNewCode.DataBind();
            }


            txtDate.Text = DateTime.Now.ToString("d");
            txtDate.DataBind();
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

        #region PrivateMethods

        private List<string> GetAcctCode()
        {
            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                var results = (from a in dc.AccountingCodes
                               select a.Code);

                return (results.Any()) ? results.ToList<string>() : null;
            }

        }

        private List<Freight> GetFreights(long giffiRef)
        {
            int bookingId = DataUtil.GetBookingFromGiffiRef(giffiRef);

            if (bookingId < Constants.InitBookingId)
            {
                return null;
            }

            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                var results = (from f in dc.Freights
                               where f.BookingId == bookingId
                               select f);

                return (results.Any()) ? results.ToList() : null;
            }
        }

        private List<Freight> GetFreightByBookingId(int bookingId)
        {
            FreightRepository repo = new FreightRepository();
            return repo.GetFreightByBookingId(bookingId);
        }

        private DataTable CreateEmptyFreightRows(int numOfRow, int bookingId)
        {
            DataTable dt = new DataTable();
            DataRow dr = null;
            dt.Columns.Add(new DataColumn("Id", typeof(int)));
            dt.Columns.Add(new DataColumn("BookingId", typeof(int)));
            dt.Columns.Add(new DataColumn("Code", typeof(string)));
            dt.Columns.Add(new DataColumn("BS", typeof(string)));
            dt.Columns.Add(new DataColumn("PC", typeof(string)));
            dt.Columns.Add(new DataColumn("Units", typeof(int)));
            dt.Columns.Add(new DataColumn("Rate", typeof(double)));
            dt.Columns.Add(new DataColumn("AmtPPD", typeof(double)));
            dt.Columns.Add(new DataColumn("COLAmt", typeof(double)));
            dt.Columns.Add(new DataColumn("BrkRate", typeof(double)));
            dt.Columns.Add(new DataColumn("BrkAmt", typeof(double)));
            for (int i = 0; i < 5; i++)
            {
                dr = dt.NewRow();
                dr["Id"] = -1;
                dr["BookingId"] = bookingId;
                dr["Code"] = string.Empty;
                dr["BS"] = string.Empty;
                dr["PC"] = string.Empty;
                dr["Units"] = 0;
                dr["Rate"] = 0;
                dr["AmtPPD"] = 0;
                dr["COLAmt"] = 0;
                dr["BrkRate"] = 0;
                dr["BrkAmt"] = 0;
                dt.Rows.Add(dr);
            }
            return dt;
        }

        private bool TryGetGiffiRef(out long giffiRef)
        {
            return long.TryParse(txtSearchBox.Text, out giffiRef);
        }

        #endregion

        #region EventMethods

        protected void AddNewFreight_Click(object sender, EventArgs e)
        {
            Freight fr = null;
            int bookingId = DataUtil.GetBookingFromGiffiRef(long.Parse(txtGiffRef.Text));
            if (bookingId < Constants.InitBookingId)
            {
                lblAlertFailure.Text = string.Format("Invalid bookingId={0}", bookingId);
                return;
            }

            try
            {
                fr = new Freight
                {
                    BookingId = bookingId,
                    Code = ddlNewCode.SelectedValue,
                    BS = txtNewBS.Text.Trim(),
                    PC = ddlNewPC.SelectedValue,
                    Units = int.Parse(txtNewUnits.Text.Trim()),
                    Rate = decimal.Parse(txtNewRate.Text.Trim(), NumberStyles.Currency),
                    AmtPPD = decimal.Parse(txtNewAmtPPD.Text.Trim(), NumberStyles.Currency),
                    AmtCOL = decimal.Parse(txtNewAmtCOL.Text.Trim(), NumberStyles.Currency),
                    BrkRate = decimal.Parse(txtNewBrkRate.Text.Trim(), NumberStyles.Currency),
                    BrkAmt = decimal.Parse(txtNewBrkAmt.Text.Trim(), NumberStyles.Currency)
                };

                FreightRepository repo = new FreightRepository();
                if (repo.InsertFreight(fr))
                {
                    //lblAlertSucess.Text = string.Format("Record successfully added!!!");
                    //lblAlertSucess.Visible = true;
                    string script = string.Format("alert('<strong><font color='green'>Unable to insert freight to database. BookingId={0}'</font></strong>);", bookingId);
                    ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "ClientScript", script, true);
                    lblAlertSucess.DataBind();

                    ClearFreightTextFields();

                    List<Freight> results = GetFreightByBookingId(bookingId);
                    gvFreight.DataSource = results;
                    gvFreight.DataBind();
                }

            }
            catch (SqlException se)
            {
                //lblAlertFailure.Text = string.Format("Unable to insert freight to database. BookingId={0}, SQLException={1}", bookingId, se.Message);
                //lblAlertFailure.Visible = true;
                //lblAlertFailure.DataBind();
                string script = string.Format("alert('<strong><font color='red'>Unable to insert freight to database. BookingId={0}, SQLException={1}'</font></strong>);", bookingId, se.Message);
                ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "ClientScript", script, true);
            }
            catch (Exception ex)
            {
                //lblAlertFailure.Text = string.Format("Unable to insert freight due to an invalid entry. Bookinging={0}, Exception={1}", bookingId, ex.Message);
                //string msg = string.Format("Unable to insert freight due to an invalid entry. Bookinging={0}, Exception={1}", bookingId, ex.Message);
                string msg = "Error on the transaction!!!";
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append("<script type = 'text/javascript'>");
                sb.Append("window.onload=function(){");
                sb.Append("alert('");
                sb.Append(msg);
                sb.Append("')};");
                sb.Append("</script>");
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());

                //string script = string.Format("alert('<strong><font color='red'>Unable to insert freight to database. BookingId={0}, ErrorMessage={1}'</font></strong>);", bookingId, ex.Message);
                //ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "ClientScript", script, true);
                //lblAlertFailure.Visible = true;
                //lblAlertFailure.DataBind();
            }
        }

        private void ClearFreightTextFields()
        {
            txtNewBS.Text = string.Empty;
            txtNewUnits.Text = string.Empty;
            txtNewRate.Text = string.Empty;
            txtNewAmtPPD.Text = string.Empty;
            txtNewAmtCOL.Text = string.Empty;
            txtNewBrkRate.Text = string.Empty;
            txtNewBrkAmt.Text = string.Empty;
        }

        protected void SelectedSearch_Click(object sender, EventArgs e)
        {
            long giffiRef = -1;
            if (!string.IsNullOrEmpty(txtSearchBox.Text) && long.TryParse(txtSearchBox.Text, out giffiRef) && giffiRef > 10000)
            {
                txtGiffRef.Text = txtSearchBox.Text;
                txtGiffRef.DataBind();

                txtSearchBox.Text = string.Empty;

                gvFreight.DataSource = GetFreights(giffiRef);
                gvFreight.DataBind();

                tbAddFreight.Visible = true;
                tbAddFreight.DataBind();
            }
        }

        protected void gvFreight_RowEditing(object sender, GridViewEditEventArgs e)
        {
            int bookingId = DataUtil.GetBookingFromGiffiRef(long.Parse(txtGiffRef.Text));
            List<Freight> results = GetFreightByBookingId(bookingId);

            gvFreight.DataSource = results;
            gvFreight.EditIndex = e.NewEditIndex;
            gvFreight.DataBind();
        }

        protected void gvFreight_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = gvFreight.Rows[e.RowIndex];
            int freightId = (int)gvFreight.DataKeys[e.RowIndex].Value;

            int bookingId = DataUtil.GetBookingFromGiffiRef(long.Parse(txtGiffRef.Text));
            Freight fr = null;

            try
            {
                fr = new Freight
                {
                    Id = freightId,
                    BookingId = bookingId,
                    Code = (row.FindControl("txtCode") as TextBox).Text.Trim(),
                    BS = (row.FindControl("txtBS") as TextBox).Text.Trim(),
                    PC = (row.FindControl("txtPC") as TextBox).Text.Trim(),
                    Units = int.Parse((row.FindControl("txtUnits") as TextBox).Text.Trim()),
                    Rate = decimal.Parse((row.FindControl("txtRate") as TextBox).Text.Trim()),
                    AmtPPD = decimal.Parse((row.FindControl("txtAmtPPD") as TextBox).Text.Trim()),
                    AmtCOL = decimal.Parse((row.FindControl("txtAmtCOL") as TextBox).Text.Trim()),
                    BrkRate = decimal.Parse((row.FindControl("txtBrkRate") as TextBox).Text.Trim()),
                    BrkAmt = decimal.Parse((row.FindControl("txtBrkAmt") as TextBox).Text.Trim())
                };
                FreightRepository repo = new FreightRepository();
                repo.UpdateFreight(fr);

                gvFreight.EditIndex = -1;
                gvFreight.DataSource = GetFreightByBookingId(bookingId);
                gvFreight.DataBind();
            }
            catch (SqlException se)
            {
                lblAlertFailure.Text = string.Format("Unable to insert freight to database. SQLException={0}", bookingId, se.Message);
            }
            catch (Exception ex)
            {
                lblAlertFailure.Text = string.Format("Unable to insert freight due to an invalid entry. Exception={0}", bookingId, ex.Message);
            }
        }

        protected void gvFreight_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            int bookingId = DataUtil.GetBookingFromGiffiRef(long.Parse(txtGiffRef.Text));
            List<Freight> results = GetFreightByBookingId(bookingId);
            gvFreight.DataSource = results;
            gvFreight.EditIndex = -1;
            gvFreight.DataBind();
        }

        protected void gvFreight_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int bookingId = DataUtil.GetBookingFromGiffiRef(long.Parse(txtGiffRef.Text));

            int freightId = (int)gvFreight.DataKeys[e.RowIndex].Value;

            FreightRepository repo = new FreightRepository();
            repo.DeleteFreight(freightId);

            gvFreight.DataSource = GetFreightByBookingId(bookingId);
            gvFreight.EditIndex = -1;
            gvFreight.DataBind();

        }


        protected void txtNewRate_TextChanged(object sender, EventArgs e)
        {
            string pc = ddlNewPC.SelectedValue;
            int units = 0;
            decimal rate = 0;
            if (int.TryParse(txtNewUnits.Text, out units) &&
                decimal.TryParse(txtNewRate.Text, out rate) && rate > 0 && units > 0)
            {
                if (pc.Equals("C", StringComparison.InvariantCultureIgnoreCase))
                {
                    txtNewAmtCOL.Text = (units * rate).ToString("#.##");
                    txtNewAmtPPD.Text = "0";
                }
                else
                {
                    txtNewAmtPPD.Text = (units * rate).ToString("#.##");
                    txtNewAmtCOL.Text = "0";
                }

                txtNewAmtCOL.DataBind();
                txtNewAmtPPD.DataBind();
            }
        }

        protected void txtNewBrkRate_TextChanged(object sender, EventArgs e)
        {
            decimal amtPPD = 0;
            decimal brkRate = 0;

            string pc = ddlNewPC.SelectedValue;

            if (pc == "P" && decimal.TryParse(txtNewAmtPPD.Text, out amtPPD) &&
                decimal.TryParse(txtNewBrkRate.Text, out brkRate) && amtPPD > 0 && brkRate > 0)
            {
                txtNewBrkAmt.Text = (amtPPD * brkRate).ToString("#.##");
                txtNewBrkAmt.DataBind();
            }
        }
        #endregion

        protected void txtNewUnits_TextChanged(object sender, EventArgs e)
        {
            string pc = ddlNewPC.SelectedValue;
            int units = 0;
            decimal rate = 0;
            if (int.TryParse(txtNewUnits.Text, out units) &&
                decimal.TryParse(txtNewRate.Text, out rate) && rate > 0 && units > 0)
            {
                if (pc.Equals("C", StringComparison.InvariantCultureIgnoreCase))
                {
                    txtNewAmtCOL.Text = (units * rate).ToString("#.##");
                    txtNewAmtPPD.Text = "0";
                }
                else
                {
                    txtNewAmtPPD.Text = (units * rate).ToString("#.##");
                    txtNewAmtCOL.Text = "0";
                }

                //txtNewAmtCOL.DataBind();
                //txtNewAmtPPD.DataBind();
            }

            decimal amtPPD = 0;
            decimal brkRate = 0;

            if (pc == "P" && decimal.TryParse(txtNewAmtPPD.Text, out amtPPD) &&
                decimal.TryParse(txtNewBrkRate.Text, out brkRate) && amtPPD > 0 && brkRate > 0)
            {
                txtNewBrkAmt.Text = (amtPPD * brkRate).ToString("#.##");
                txtNewBrkAmt.DataBind();
            }
        }
    }
}