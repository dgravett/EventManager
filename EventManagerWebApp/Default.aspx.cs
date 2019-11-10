using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace EventManagerWebApp
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (GlobalUserPassport.globalUserPassport != null)
                LabelUserLevel.Text = ((DBEnum.User.Type)GlobalUserPassport.globalUserPassport.userType).ToString();
        }
    }
}