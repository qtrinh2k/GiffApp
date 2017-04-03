using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Sql;
using System.Data;

namespace WebApp
{
    using DataAccess;
    using System.Data.SqlClient;

    public partial class Container : System.Web.UI.Page
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

                        tbNewContainer.Visible = true;
                        tbNewContainer.DataBind();

                        gvContainer.DataSource = GetContainers(long.Parse(txtGiffRef.Text));
                        gvContainer.DataBind();
                    }
                    else
                    {
                        tbNewContainer.Visible = false;
                        tbNewContainer.DataBind();
                    }

                }
            }
            
            txtDate.Text = DateTime.Now.ToString("d");
            txtGiffRef.DataBind();
        }

        protected void AddNewContainer_Click(object sender, EventArgs e)
        {
            Container cont = null;
            try
            {
                cont = new Container()
                {
                    BookingId = DataUtil.GetBookingFromGiffiRef(long.Parse(txtGiffRef.Text)),
                    ContainerNo = txtNewContainerNo.Text.Trim(),
                    SealNo = txtNewSealNo.Text.Trim(),
                    NumOfPkgs = int.Parse(txtNewNumOfPkgs.Text.Trim()),
                    NetWeight = double.Parse(txtNewNet.Text.Trim()),
                    GRS = float.Parse(txtNewGRS.Text.Trim()),
                    Truck = txtNewTruck.Text.Trim(),
                    Invoice = long.Parse(txtNewTruckInvoice.Text.Trim()),
                    CreatedDate = DateTime.Now
                };

                ContainerRepository cRepo = new ContainerRepository();

                if (cRepo.InsertContainer(cont))
                {
                    //lblAlertSucess.Visible = true;
                    //lblAlertSucess.Text = string.Format("<strong>Success!</strong> Container No. {0} added GIFFI Ref={1}", cont.ContainerNo, txtGiffRef.Text);

                    gvContainer.DataSource = GetContainers(long.Parse(txtGiffRef.Text));
                    gvContainer.Visible = true;
                    gvContainer.DataBind();

                    ClearContainerInput();                    
                }
                else
                {
                    lblAlertFailure.Visible = true;
                    lblAlertFailure.Text = string.Format("<strong>Error!</strong> Unable to add ContainerNo={0} to GIFFI Ref={1}", cont.ContainerNo, txtGiffRef.Text);
                }
            }
            catch(SqlException sex)
            {
                this.Page.AlertMessage(GetType(), string.Format("SQL Error!!! Unable to add ContainerNo={0} to GIFFI Ref={1}, EXCEPTION={2}", txtNewContainerNo, txtGiffRef.Text, sex.Message));
            }
            catch(Exception ex)
            {                
                this.Page.AlertMessage(GetType(), string.Format("Error!!! Unable to add ContainerNo={0} to GIFFI Ref={1}, EXCEPTION={2}", txtNewContainerNo, txtGiffRef.Text, ex.Message));
            }

        }
        protected void SelectedSearch_Click(object sender, EventArgs e)
        {
            long giffiRef = -1;
            if (!string.IsNullOrEmpty(txtSearchBox.Text) && long.TryParse(txtSearchBox.Text, out giffiRef) && giffiRef > 10000)
            {
                txtGiffRef.Text = txtSearchBox.Text;
                txtGiffRef.DataBind();

                txtSearchBox.Text = string.Empty;

                //populate existing containers
                gvContainer.DataSource = GetContainers(giffiRef);
                gvContainer.DataBind();

                tbNewContainer.Visible = true;
                tbNewContainer.DataBind();
            }
        }


        protected void gvContainer_RowEditing(object sender, GridViewEditEventArgs e)
        {
            long giffiRef = -1;
            if (long.TryParse(txtGiffRef.Text, out giffiRef))
            {
                gvContainer.DataSource = GetContainers(giffiRef);
                gvContainer.EditIndex = e.NewEditIndex;
                gvContainer.DataBind();
            }
        }

        protected void gvContainer_RowCancelEditing(object sender, GridViewCancelEditEventArgs e)
        {
            long giffiRef = -1;
            if (long.TryParse(txtGiffRef.Text, out giffiRef))
            {
                gvContainer.DataSource = GetContainers(giffiRef);
                gvContainer.EditIndex = -1;
                gvContainer.DataBind();
            }
        }

        protected void gvContainer_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = gvContainer.Rows[e.RowIndex];
            int containerId = (int)gvContainer.DataKeys[e.RowIndex].Value;

            Container cont = new Container()
            {
                Id = containerId,
                BookingId = DataUtil.GetBookingFromGiffiRef(long.Parse(txtGiffRef.Text)),
                ContainerNo = (row.FindControl("txtContainerNo") as TextBox).Text.Trim(),
                SealNo = (row.FindControl("txtSealNo") as TextBox).Text.Trim(),
                NumOfPkgs = int.Parse((row.FindControl("txtNumOfPkgs") as TextBox).Text.Trim()),
                NetWeight = double.Parse((row.FindControl("txtNetWeight") as TextBox).Text.Trim()),
                GRS = float.Parse((row.FindControl("txtGRS") as TextBox).Text.Trim()),
                Truck = (row.FindControl("txtTruck") as TextBox).Text.Trim(),
                Invoice = long.Parse((row.FindControl("txtTruckInvoice") as TextBox).Text.Trim()),
                CreatedDate = DateTime.Now
            };

            ContainerRepository cr = new ContainerRepository();
            cr.UpdateContainer(cont);

            gvContainer.EditIndex = -1;

            gvContainer.DataSource = GetContainers(long.Parse(txtGiffRef.Text));
            gvContainer.DataBind();
        }


        protected void gvContainer_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int containerId = (int)gvContainer.DataKeys[e.RowIndex].Value;
            ContainerRepository cr = new ContainerRepository();
            cr.Delete(containerId);

            gvContainer.EditIndex = -1;
            gvContainer.DataSource = GetContainers(long.Parse(txtGiffRef.Text));
            gvContainer.DataBind();
        }

        private void ClearContainerInput()
        {
            var txtBoxes = tbNewContainer.Controls.FindAll().OfType<TextBox>();
            foreach(var item in txtBoxes)
            {
                item.Text = "";
            }
        }

        private List<Container> GetContainers(long giffiRef)
        {
            ContainerRepository cr = new ContainerRepository();

            int bookingId = DataUtil.GetBookingFromGiffiRef(long.Parse(txtGiffRef.Text));
            return cr.GetContainerByBookingId(bookingId);

        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<string> SearchFor(string pre, int option)
        {
            List<string> results = new List<string>();

            switch(option)
            {
                case 1:
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
                    break;
                case 2:
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
                    break;
                case 3:
                    break;
                default:
                    break;
            }

            return results;
        }

    }
}