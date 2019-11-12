using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
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
                btnLogin.Visible = false;
        }

        private List<int> AttemptLogin(string UserName, string Password)
        {
            using (SqlCommand sqlCmd = new SqlCommand())
            {
                conn.Open();

                sqlCmd.Connection = conn;
                sqlCmd.CommandText = @"SELECT [User].id, User_UserType.id_UserType, User_University.id_University 
                                       FROM [User]
                                            LEFT JOIN User_UserType on [User].id = User_UserType.id_User
                                            LEFT JOIN User_University on [User].id = User_University.id_User
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
                List<int> userInfo = new List<int>();
                if (dt.Rows.Count > 0)
                {
                    userInfo.Add((int)dt.Rows[0]["id"]);
                    userInfo.Add((int)dt.Rows[0]["id_UserType"]);
                    userInfo.Add((int)dt.Rows[0]["id_University"]);
                }
                return userInfo;
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            List<int> UserInfo = AttemptLogin(txtUsername.Text, txtPassword.Text);
            if (UserInfo.Count != 0)
            {
                GlobalUserPassport.globalUserPassport = new UserPassport(UserInfo[0], txtUsername.Text, UserInfo[1], UserInfo[2]);
                Response.Redirect("Events.aspx");
            }
            else
            {
                lblError.Text = "Invalid Login";
            }
        }
    }
}