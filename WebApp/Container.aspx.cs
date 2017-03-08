using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApp
{
    using DataAccess;

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

                        txtNewCreatedDate.Text = DateTime.Now.ToString("d");

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
            Container cont = new Container()
            {
                BookingId = DataUtil.GetBookingFromGiffiRef(long.Parse(txtGiffRef.Text)),
                ContainerNo = txtNewContainerNo.Text.Trim(),
                SealNo = long.Parse(txtNewSealNo.Text.Trim()),
                PkgsWeight = double.Parse(txtNewPackage.Text.Trim()),
                NetWeight = double.Parse(txtNewNet.Text.Trim()),
                GRS = float.Parse(txtNewGRS.Text.Trim()),
                Truck = txtNewTruck.Text.Trim(),
                Invoice = long.Parse(txtNewInvoice.Text.Trim()),
                CreatedDate = DateTime.Now                
            };

            ContainerRepository cRepo = new ContainerRepository();
            if(cRepo.InsertContainer(cont))
            {
                lblAlertSucess.Visible = true;
                lblAlertSucess.Text = string.Format("<strong>Success!</strong> Container No. {0} added GIFFI Ref={1}", cont.ContainerNo, txtGiffRef.Text);

                gvContainer.DataSource = GetContainers(long.Parse(txtGiffRef.Text));
                gvContainer.Visible = true;
                gvContainer.DataBind();

                ClearContainerInput();

            }
            else
            {
                lblAlertFailure.Visible = true;
                lblAlertFailure.Text = string.Format("<strong>Error!</strong> Unable to add Container No. {0} added GIFFI Ref={1}", cont.ContainerNo, txtGiffRef.Text);
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

            if(option == 1)
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

        protected void Insert(object sender, EventArgs e)
        {

        }

        protected void gvContainer_RowEditing(object sender, GridViewEditEventArgs e)
        {

        }

        protected void gvContainer_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {

        }

        protected void gvContainer_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

        }
    }
}