using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI;
namespace WebApp
{
    public static class ControlExtension
    {
        public static IEnumerable<Control> FindAll(this ControlCollection collection)
        {
            foreach(Control item in collection)
            {
                yield return item;

                if(item.HasControls())
                {
                    foreach(Control subItem in item.Controls.FindAll())
                    {
                        yield return subItem;
                    }
                }
            }

        }
    }
}