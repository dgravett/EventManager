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
    public partial class StudentPortal : System.Web.UI.Page
    {
        SqlConnection conn;
        public string userName = (GlobalUserPassport.globalUserPassport.userName).ToString();
        public int userID = (GlobalUserPassport.globalUserPassport.userId);
        public string userLevel = ((DBEnum.User.Type)GlobalUserPassport.globalUserPassport.userType).ToString();
        public string userUni = "";
        DataTable dtRSOJoined, dtRSOJoined2, dtAvailable, dtAvailable2;

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

            LabelHeader.Text = userName;
            LabelUserLevel.Text = userLevel;
            LabelUserUni.Text = userUni;

            JoinedRSO(userID);
            AvailableRSO(userID);
        }

        private void JoinedRSO(int UserID)
        {
            using (SqlCommand sqlCmd = new SqlCommand())
            {
                conn.Open();

                sqlCmd.Connection = conn;

                /*                sqlCmd.CommandText = @"SELECT A.* 
                                                       FROM RSO A
                                                       WHERE A.id NOT IN 
                                                                 (SELECT B.id 
                                                                 FROM User_RSO A, RSO B 
                                                                 WHERE (A.id_User = @UserID AND A.id_RSO = B.id))";*/

                sqlCmd.CommandText = @"SELECT B.id, B.name, B.description FROM User_RSO A, RSO B WHERE (A.id_User = @UserID AND A.id_RSO = B.id)";
                sqlCmd.Parameters.AddWithValue("@UserID", UserID);
                dtRSOJoined = new DataTable();

                using (SqlDataReader sqldr = sqlCmd.ExecuteReader())
                {
                    dtRSOJoined.Load(sqldr);
                }

                conn.Close();

                RepeaterRSOJoined.DataSource = dtRSOJoined;
                RepeaterRSOJoined.DataBind();
            }
        }

        protected void ButtonModalOpen_Click(object sender, EventArgs e)
        {

        }

        protected void ButtonLeave_Click(object sender, EventArgs e) 
        {
            using (SqlCommand sqlCmd = new SqlCommand())
            {
                Button button = sender as Button;
                String RSOID = button.CommandArgument;
                RepeaterRSOJoined.DataSource = null;
                RepeaterRSOAvailable.DataSource = null;
                dtAvailable.Rows.Clear();
                dtRSOJoined.Rows.Clear();

                conn.Open();

                sqlCmd.Connection = conn;
                sqlCmd.CommandText = @"DELETE FROM User_RSO WHERE (id_RSO = @RSOID AND id_User = @UserID)";
                sqlCmd.Parameters.AddWithValue("@RSOID", int.Parse(RSOID));
                sqlCmd.Parameters.AddWithValue("@UserID", userID);
                sqlCmd.ExecuteNonQuery();

                sqlCmd.CommandText = @"SELECT B.id, B.name, B.description FROM User_RSO A, RSO B WHERE (A.id_User = @UserID AND A.id_RSO = B.id)";
                dtRSOJoined = new DataTable();
                using (SqlDataReader sqldr = sqlCmd.ExecuteReader())
                {
                    dtRSOJoined.Load(sqldr);
                }

                sqlCmd.CommandText = @"SELECT A.* 
                                       FROM RSO A
                                       WHERE A.id NOT IN 
			                                     (SELECT B.id 
			                                     FROM User_RSO A, RSO B 
			                                     WHERE (A.id_User = @UserID AND A.id_RSO = B.id))";
                using (SqlDataReader sqldr = sqlCmd.ExecuteReader())
                {
                    dtAvailable.Load(sqldr);
                }

                conn.Close();

                RepeaterRSOJoined.DataSource = dtRSOJoined;
                RepeaterRSOJoined.DataBind();
                RepeaterRSOAvailable.DataSource = dtAvailable;
                RepeaterRSOAvailable.DataBind();
            }
        }

        private void AvailableRSO(int UserID) 
        {
            using (SqlCommand sqlCmd = new SqlCommand())
            {
                conn.Open();

                sqlCmd.Connection = conn;

                sqlCmd.CommandText = @"SELECT A.* 
                                       FROM RSO A
                                       WHERE A.id NOT IN 
			                                     (SELECT B.id 
			                                     FROM User_RSO A, RSO B 
			                                     WHERE (A.id_User = @UserID AND A.id_RSO = B.id))";

/*                sqlCmd.CommandText = @"SELECT B.id, B.name, B.description FROM User_RSO A, RSO B WHERE (A.id_User = @UserID AND A.id_RSO = B.id)";
*/                sqlCmd.Parameters.AddWithValue("@UserID", UserID);

                dtAvailable = new DataTable();

                using (SqlDataReader sqldr = sqlCmd.ExecuteReader())
                {
                    dtAvailable.Load(sqldr);
                }

                conn.Close();

                RepeaterRSOAvailable.DataSource = dtAvailable;
                RepeaterRSOAvailable.DataBind();
            }
        }

        protected void ButtonJoin_Click(object sender, EventArgs e)
        {
            using (SqlCommand sqlCmd = new SqlCommand())
            {
                Button button = sender as Button;
                String RSOID = button.CommandArgument;
                RepeaterRSOJoined.DataSource = null;
                RepeaterRSOAvailable.DataSource = null;
                dtAvailable.Rows.Clear();
                dtRSOJoined.Rows.Clear();

                conn.Open();

                sqlCmd.Connection = conn;
                sqlCmd.CommandText = @"INSERT INTO User_RSO (id_User, id_RSO) VALUES (@UserID, @RSOID)";
                sqlCmd.Parameters.AddWithValue("@RSOID", int.Parse(RSOID));
                sqlCmd.Parameters.AddWithValue("@UserID", userID);
                sqlCmd.ExecuteNonQuery();

                sqlCmd.CommandText = @"SELECT B.id, B.name, B.description FROM User_RSO A, RSO B WHERE (A.id_User = @UserID AND A.id_RSO = B.id)";
                dtRSOJoined = new DataTable();
                using (SqlDataReader sqldr = sqlCmd.ExecuteReader())
                {
                    dtRSOJoined.Load(sqldr);
                }

                sqlCmd.CommandText = @"SELECT A.* 
                                       FROM RSO A
                                       WHERE A.id NOT IN 
			                                     (SELECT B.id 
			                                     FROM User_RSO A, RSO B 
			                                     WHERE (A.id_User = @UserID AND A.id_RSO = B.id))";
                using (SqlDataReader sqldr = sqlCmd.ExecuteReader())
                {
                    dtAvailable.Load(sqldr);
                }

                conn.Close();

                RepeaterRSOJoined.DataSource = dtRSOJoined;
                RepeaterRSOJoined.DataBind();
                RepeaterRSOAvailable.DataSource = dtAvailable;
                RepeaterRSOAvailable.DataBind();
            }
        }

        protected void ButtonCreateRSO_Click(object sender, EventArgs e) 
        {
            string RSOName = TextBoxRSOName.Text;
            string RSODescription = TextBoxRSODescription.Text;

            using (SqlCommand sqlCmd = new SqlCommand())
            {
                RepeaterRSOJoined.DataSource = null;
                RepeaterRSOAvailable.DataSource = null;
                dtAvailable.Rows.Clear();
                dtRSOJoined.Rows.Clear();

                conn.Open();

                sqlCmd.Connection = conn;
                sqlCmd.CommandText = @"INSERT INTO RSO (name, description) VALUES (@RSOName,@RSOD)";
                sqlCmd.Parameters.AddWithValue("@RSOName", RSOName);
                sqlCmd.Parameters.AddWithValue("@RSOD", RSODescription);

                sqlCmd.ExecuteNonQuery();

                sqlCmd.CommandText = @"SELECT B.id, B.name, B.description FROM User_RSO A, RSO B WHERE (A.id_User = @UserID AND A.id_RSO = B.id)";
                sqlCmd.Parameters.AddWithValue("@UserID", userID);
                dtRSOJoined = new DataTable();
                using (SqlDataReader sqldr = sqlCmd.ExecuteReader())
                {
                    dtRSOJoined.Load(sqldr);
                }

                sqlCmd.CommandText = @"SELECT A.* 
                                       FROM RSO A
                                       WHERE A.id NOT IN 
			                                     (SELECT B.id 
			                                     FROM User_RSO A, RSO B 
			                                     WHERE (A.id_User = @UserID AND A.id_RSO = B.id))";
                using (SqlDataReader sqldr = sqlCmd.ExecuteReader())
                {
                    dtAvailable.Load(sqldr);
                }

                conn.Close();

                RepeaterRSOJoined.DataSource = dtRSOJoined;
                RepeaterRSOJoined.DataBind();
                RepeaterRSOAvailable.DataSource = dtAvailable;
                RepeaterRSOAvailable.DataBind();
            }

        }
    }
}