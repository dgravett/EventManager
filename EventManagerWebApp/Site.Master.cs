using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EventManagerWebApp
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LogoutButton.Click += LogoutButton_Click;

            if (GlobalUserPassport.globalUserPassport == null)
            {
                liLogout.Visible = false;
                liEvents.Visible = false;
                liUser.Visible = false;
                liStudent.Visible = false;
            }
            else
            {
                liLogin.Visible = false;
                liSignup.Visible = false;
                //not a student, dont show student portal
                if (GlobalUserPassport.globalUserPassport.userType != 3)
                {
                    liStudent.Visible = false;
                }
            }

        }

        private void LogoutButton_Click(object sender, EventArgs e)
        {
            GlobalUserPassport.globalUserPassport = null;
            Response.Redirect("Default.aspx");
        }
    }
}