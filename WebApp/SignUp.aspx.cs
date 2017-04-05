using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApp
{
    using DataAccess;
    public partial class SignUp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Submit_SignUp(object sender, EventArgs e)
        {
            UserRepository repo = new UserRepository();

            var userId= repo.InsertUser(txtUsername.Text, txtPassword.Text, txtEmail.Text);

            string message = string.Empty;
            switch (userId)
            {
                case -1:
                    message = "Username already exists.\\nPlease choose a different username.";
                    break;
                case -2:
                    message = "Supplied email address has already been used.";
                    break;
                default:
                    message = "Registration successful.\\nUser Id: " + userId.ToString();
                    Response.Redirect("Login.aspx");
                    break;
            }
            ClientScript.RegisterStartupScript(GetType(), "alert", "alert('" + message + "');", true);
        }
    }
}