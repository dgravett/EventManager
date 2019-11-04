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
                sqlCmd.CommandText = @"SELECT B.id, B.name, B.description FROM User_RSO A, RSO B WHERE (A.id_User = @UserID AND A.id_RSO = B.id)";

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

        protected void ButtonLeave_Click(object sender, EventArgs e) 
        {
            using (SqlCommand sqlCmd = new SqlCommand())
            {
                Button button = sender as Button;
                String RSOID = button.CommandArgument;

                conn.Open();

                sqlCmd.Connection = conn;
                sqlCmd.CommandText = @"DELETE FROM User_RSO WHERE (id_RSO = @RSOID AND id_User = @UserID)";

                sqlCmd.Parameters.AddWithValue("@RSOID", int.Parse(RSOID));
                sqlCmd.Parameters.AddWithValue("@UserID", userID);

                sqlCmd.ExecuteNonQuery();

                conn.Close();

                for (int i = 0; i < dtRSO.Rows.Count; i++)
                {
                    DataRow dr = dtRSO.Rows[i];

                    if (dr["id"].ToString() == RSOID)
                    {
                        dtRSO.Rows.Remove(dr);
                        break;
                    }
                }

                RepeaterDiv.Style.Add("height", dtRSO.Rows.Count * 150 + 150 + "px");
                RepeaterRSO.DataSource = dtRSO;
                RepeaterRSO.DataBind();
            }
        }
    }

}