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
    public partial class Container : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            long giffRef = -1;

            if (!Page.IsPostBack)
            {
                if (Request.Params.HasKeys())
                {
                    if (!string.IsNullOrEmpty(Request.QueryString["ref"]) && long.TryParse(Request.QueryString["ref"].ToString(), out giffRef))
                    {
                        txtGiffRef.Text = giffRef.ToString();
                        txtGiffRef.DataBind();

                        panelNewContainer.Visible = true;
                        panelNewContainer.DataBind();
                    }
                    else
                    {
                        panelNewContainer.Visible = false;
                        panelNewContainer.DataBind();
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
                ContainerNumber = txtContainerNo.Text.Trim(),
                SealNumber = long.Parse(txtSealNo.Text.Trim()),
                PackagesWeight = double.Parse(txtPackages.Text.Trim()),
                NetWeight = double.Parse(txtNet.Text.Trim()),
                GRS = txtGiffRef.Text.Trim(),
                Truck = txtTruck.Text.Trim(),
                Invoice = txtInvoice.Text.Trim()                
            };

            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                dc.Containers.Add(cont);
                dc.SaveChanges();
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

                panelNewContainer.Visible = true;
                panelNewContainer.DataBind();

            }
        }

        private List<Container> GetContainers(long giffiRef)
        {
            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
               var results = (from c in dc.Containers
                           join bf in dc.BookingReferences on c.BookingId equals bf.BookingId
                           where bf.GiffiId == giffiRef
                           select new Container
                           {
                               ContainerNumber = c.ContainerNumber,
                               SealNumber = c.SealNumber,
                               PackagesWeight = c.PackagesWeight,
                               NetWeight = c.NetWeight,
                               GRS = c.GRS,
                               Truck = c.Truck,
                               Invoice = c.Invoice
                           });

                if (results != null || results.Count() == 0)
                    return null;
                else
                    return results.ToList();
            }
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
    }
}