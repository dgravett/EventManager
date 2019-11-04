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
    public partial class User : System.Web.UI.Page
    {
        SqlConnection conn;
        public string userName = (GlobalUserPassport.globalUserPassport.userName).ToString();
        public int userID = (GlobalUserPassport.globalUserPassport.userId);
        public string userLevel = ((DBEnum.User.Type)GlobalUserPassport.globalUserPassport.userType).ToString();
        public string userUni = "";
        DataTable dtRSO;

        protected void Page_Load(object sender, EventArgs e)
        {
            conn = new SqlConnection(ConnectionString.connectionString);

            using (SqlCommand sqlCmd = new SqlCommand())
            {
                conn.Open();

                sqlCmd.Connection = conn;
                sqlCmd.CommandText = @"SELECT B.name FROM User_University A, University B WHERE A.id_User = @userID";

                sqlCmd.Parameters.AddWithValue("@userID", userID);

                DataTable dt = new DataTable();

                using (SqlDataReader sqldr = sqlCmd.ExecuteReader())
                {
                    dt.Load(sqldr);
                }
                userUni = dt.Rows[0]["name"] as String;

                conn.Close();
            }

            LabelHeader.Text = "Account Info";
            LabelUserName.Text = userName;
            LabelUserLevel.Text = userLevel;
            LabelUserUni.Text = userUni;

            LoadRSO(userID);
        }

        private void LoadRSO(int UserID) 
        {
            using (SqlCommand sqlCmd = new SqlCommand())
            {
                conn.Open();

                sqlCmd.Connection = conn;
                sqlCmd.CommandText = @"SELECT DISTINCT B.name, B.description FROM User_RSO A, RSO B WHERE A.id_User = @UserID";

                sqlCmd.Parameters.AddWithValue("@UserID", UserID);

                dtRSO = new DataTable();

                using (SqlDataReader sqldr = sqlCmd.ExecuteReader())
                {
                    dtRSO.Load(sqldr);
                }

                conn.Close();

                RepeaterDiv.Style.Add("height", dtRSO.Rows.Count * 150 + 150 + "px");
                RepeaterRSO.DataSource = dtRSO;
                RepeaterRSO.DataBind();
            }
        }
    }

}