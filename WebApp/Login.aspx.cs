using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApp
{
    using DataAccess;
    using System.Web.Security;

    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void userLogin_Authenticate(object sender, AuthenticateEventArgs e)
        {
            UserRepository repo = new UserRepository();
            int userId = repo.ValidateUser(userLogin.UserName, userLogin.Password);

            switch (userId)
            {
                case -1:
                    userLogin.FailureText = "Username and/or password is incorrect.";
                    break;
                case -2:
                    userLogin.FailureText = "Account has not been activated.";
                    break;
                default:
                    //userLogin.DestinationPageUrl = "~/index.aspx";
                    FormsAuthentication.RedirectFromLoginPage(userLogin.UserName, userLogin.RememberMeSet);
                    break;
            }
        }
    }
}