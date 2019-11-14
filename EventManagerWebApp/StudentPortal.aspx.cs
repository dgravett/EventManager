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
        public string userName;
        public int userID;
        public string userLevel;
        public string userUni = "";
        DataTable dtRSOJoined, dtAvailable;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (GlobalUserPassport.globalUserPassport == null)
                Response.Redirect("Default.aspx");

            conn = new SqlConnection(ConnectionString.connectionString);
            userName = (GlobalUserPassport.globalUserPassport.userName).ToString();
            userID = (GlobalUserPassport.globalUserPassport.userId);
            userLevel = ((DBEnum.User.Type)GlobalUserPassport.globalUserPassport.userType).ToString();

            using (SqlCommand sqlCmd = new SqlCommand())
            {
                conn.Open();

                sqlCmd.Connection = conn;
                sqlCmd.CommandText = @"SELECT name
                                       FROM University
                                       WHERE University.id = @idUniversity";

                sqlCmd.Parameters.AddWithValue("@idUniversity", GlobalUserPassport.globalUserPassport.universityId);

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

            JoinedRSO();
            AvailableRSO();
        }

        private void JoinedRSO()
        {
            using (SqlCommand sqlCmd = new SqlCommand())
            {
                conn.Open();

                sqlCmd.Connection = conn;

                sqlCmd.CommandText = @"SELECT 
                                            RSO.id, 
                                            RSO.name,
                                            RSO.description,
                                            COUNT(User_RSO.id_User) as NumMembers
                                      FROM RSO 
                                           INNER JOIN User_RSO on RSO.id = User_RSO.id_RSO
                                      WHERE RSO.id in (SELECT
                                                            RSO.id
                                                       FROM RSO
                                                            INNER JOIN RSO_University on RSO.id = RSO_University.id_RSO
                                                            INNER JOIN User_RSO on RSO.id = User_RSO.id_RSO
                                                       WHERE
                                                            RSO_University.id_University = @idUniversity
                                                            AND User_RSO.id_User = @idUser)
                                      GROUP BY RSO.id, RSO.name, RSO.description
                                      ";

                sqlCmd.Parameters.AddWithValue("@idUser", GlobalUserPassport.globalUserPassport.userId);
                sqlCmd.Parameters.AddWithValue("@idUniversity", GlobalUserPassport.globalUserPassport.universityId);
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

                conn.Close();

                JoinedRSO();

                AvailableRSO();
            }
        }

        private void AvailableRSO() 
        {
            using (SqlCommand sqlCmd = new SqlCommand())
            {
                conn.Open();

                sqlCmd.Connection = conn;

                sqlCmd.CommandText = @"SELECT 
                                            RSO.id, 
                                            RSO.name,
                                            RSO.description,
                                            COUNT(User_RSO.id_User) as NumMembers
                                      FROM RSO 
                                           INNER JOIN User_RSO on RSO.id = User_RSO.id_RSO
                                           LEFT JOIN RSO_University on RSO.id = RSO_University.id_RSO
                                      WHERE RSO_University.id_University = @idUniversity
                                           AND RSO.id not in (SELECT
                                                            RSO.id
                                                       FROM RSO
                                                            INNER JOIN RSO_University on RSO.id = RSO_University.id_RSO
                                                            INNER JOIN User_RSO on RSO.id = User_RSO.id_RSO
                                                       WHERE
                                                            RSO_University.id_University = @idUniversity
                                                            AND User_RSO.id_User = @idUser)
                                      GROUP BY RSO.id, RSO.name, RSO.description
                                      ";

                sqlCmd.Parameters.AddWithValue("@idUser", GlobalUserPassport.globalUserPassport.userId);
                sqlCmd.Parameters.AddWithValue("@idUniversity", GlobalUserPassport.globalUserPassport.universityId);

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

                conn.Close();

                JoinedRSO();

                AvailableRSO();
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
                sqlCmd.CommandText = @"INSERT INTO RSO (name, description, approved) 
                                       VALUES (@RSOName,@RSOD, 0) 

                                       DECLARE @idRSO int = SCOPE_IDENTITY()

                                       INSERT INTO RSO_University
                                       VALUES (@idRSO, @idUniversity)
        
                                       INSERT INTO User_RSO
                                       VALUES (@UserID, @idRSO)

                                       UPDATE User_UserType
                                       SET id_UserType = 2
                                       WHERE id_User = @UserID";

                sqlCmd.Parameters.AddWithValue("@RSOName", RSOName);
                sqlCmd.Parameters.AddWithValue("@RSOD", RSODescription);
                sqlCmd.Parameters.AddWithValue("@UserID", userID);
                sqlCmd.Parameters.AddWithValue("@idUniversity", GlobalUserPassport.globalUserPassport.universityId);

                sqlCmd.ExecuteNonQuery();

                conn.Close();

                JoinedRSO();

                AvailableRSO();

                GlobalUserPassport.globalUserPassport.userType = 2;
            }

        }
    }
}