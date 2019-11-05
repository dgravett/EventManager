using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EventManagerWebApp
{
    public partial class LoginPage : System.Web.UI.Page
    {
        SqlConnection conn;

        protected void Page_Load(object sender, EventArgs e)
        {
            conn = new SqlConnection(ConnectionString.connectionString);

            if (GlobalUserPassport.globalUserPassport != null)
                Login1.Visible = false;
            else
                Login1.Authenticate += Login1_Authenticate;
        }

        private void Login1_Authenticate(object sender, AuthenticateEventArgs e)
        {
            Tuple<int, int> UserInfo = AttemptLogin(Login1.UserName, Login1.Password);
            if (UserInfo.Item1 != -1)
            {
                GlobalUserPassport.globalUserPassport = new UserPassport(UserInfo.Item1, Login1.UserName, UserInfo.Item2,0);
                e.Authenticated = true;
                Response.Redirect("Events.aspx");
            }
            else
            {
                e.Authenticated = false;
            }
        }

        private Tuple<int, int> AttemptLogin(string UserName, string Password)
        {
            using (SqlCommand sqlCmd = new SqlCommand())
            {
                conn.Open();

                sqlCmd.Connection = conn;
                sqlCmd.CommandText = @"SELECT [User].id, User_UserType.id_UserType 
                                       FROM [User]
                                            LEFT JOIN User_UserType on [User].id = User_UserType.id_User
                                       WHERE userName = @userName AND password = @password
                                    ";

                sqlCmd.Parameters.Add(new SqlParameter("@userName", UserName));
                sqlCmd.Parameters.Add(new SqlParameter("@password", Password));

                DataTable dt = new DataTable();

                using (SqlDataReader sqldr = sqlCmd.ExecuteReader())
                {
                    dt.Load(sqldr);
                }

                conn.Close();

                if (dt.Rows.Count > 0)
                {
                    return new Tuple<int, int>((int)dt.Rows[0]["id"], (int)dt.Rows[0]["id_UserType"]);
                }
                else
                {
                    return new Tuple<int, int>(-1, -1);
                }
            }
        }
    }
}