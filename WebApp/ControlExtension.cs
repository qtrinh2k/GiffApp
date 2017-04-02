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
        public static void AlertMessage(this Page page, Type type, string msg)
        {
            string script = string.Format("alert(\"{0}!\");", msg);
            ScriptManager.RegisterStartupScript(page, type,
                                  "ServerControlScript", script, true);
        }

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

        public static Control FindControlInHeader(this Repeater repeater, string controlName)
        {
            return repeater.Controls[0].Controls[0].FindControl(controlName);
        }

        public static Control FindControlInFooter(this Repeater repeater, string controlName)
        {
            return repeater.Controls[repeater.Controls.Count - 1].Controls[0].FindControl(controlName);
        }
    }
}