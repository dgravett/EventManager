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
                liSuperAdmin.Visible = false;
                liAdmin.Visible = false;
            }
            else
            {
                if(GlobalUserPassport.globalUserPassport.userType == 1)
                {
                    liSuperAdmin.Visible = true;
                    liAdmin.Visible = false;
                }
                else if (GlobalUserPassport.globalUserPassport.userType == 2)
                {
                    liAdmin.Visible = true;
                    liSuperAdmin.Visible = false;
                }
                else
                {
                    liSuperAdmin.Visible = false;
                    liAdmin.Visible = false;
                }
                liLogin.Visible = false;
                liSignup.Visible = false;
            }

        }

        private void LogoutButton_Click(object sender, EventArgs e)
        {
            GlobalUserPassport.globalUserPassport = null;
            Response.Redirect("Default.aspx");
        }
    }
}