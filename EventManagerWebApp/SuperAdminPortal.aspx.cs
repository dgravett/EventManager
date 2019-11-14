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
    public partial class SuperAdminPortal : System.Web.UI.Page
    {
        SqlConnection conn;
        public string university = "";
        DataTable dtPendingEvents, dtApprovedEvents;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (GlobalUserPassport.globalUserPassport == null)
                Response.Redirect("Default.aspx");

            conn = new SqlConnection(ConnectionString.connectionString);

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
                university = dt.Rows[0]["name"] as String;

                conn.Close();
            }

            lblUserName.Text = GlobalUserPassport.globalUserPassport.userName.ToString();
            lblUserType.Text = ((DBEnum.User.Type)GlobalUserPassport.globalUserPassport.userType).ToString();
            lblUniversity.Text = university;

            EventsPending();
            EventsApproved();
        }

        private void EventsPending()
        {
            using (SqlCommand sqlCmd = new SqlCommand())
            {
                conn.Open();

                sqlCmd.Connection = conn;

                sqlCmd.CommandText = @"SELECT Event.*
                                       FROM Event 
                                           LEFT JOIN Event_EventType on Event.id = Event_EventType.id_Event
                                           LEFT JOIN EventType on Event_EventType.id_EventType = EventType.id
                                       WHERE approved = 0
                                       AND EventType.id <> 3";

                dtPendingEvents = new DataTable();

                using (SqlDataReader sqldr = sqlCmd.ExecuteReader())
                {
                    dtPendingEvents.Load(sqldr);
                }

                conn.Close();

                rptrPending.DataSource = dtPendingEvents;
                rptrPending.DataBind();
            }
        }

        private void EventsApproved()
        {
            using (SqlCommand sqlCmd = new SqlCommand())
            {
                conn.Open();

                sqlCmd.Connection = conn;

                sqlCmd.CommandText = @"SELECT Event.*
                                       FROM Event 
                                           LEFT JOIN Event_EventType on Event.id = Event_EventType.id_Event
                                           LEFT JOIN EventType on Event_EventType.id_EventType = EventType.id
                                       WHERE approved = 1
                                       AND EventType.id <> 3";

                dtApprovedEvents = new DataTable();

                using (SqlDataReader sqldr = sqlCmd.ExecuteReader())
                {
                    dtApprovedEvents.Load(sqldr);
                }

                conn.Close();

                rptrApproved.DataSource = dtApprovedEvents;
                rptrApproved.DataBind();
            }
        }

        protected void btnApprove_Click(object sender, EventArgs e)
        {
            using (SqlCommand sqlCmd = new SqlCommand())
            {
                Button button = sender as Button;
                String EventID = button.CommandArgument;
                rptrPending.DataSource = null;
                rptrApproved.DataSource = null;
                dtPendingEvents.Rows.Clear();
                dtApprovedEvents.Rows.Clear();

                conn.Open();

                sqlCmd.Connection = conn;
                sqlCmd.CommandText = @"UPDATE Event SET approved = 1 WHERE id = @EventID";
                sqlCmd.Parameters.AddWithValue("@EventID", int.Parse(EventID));
                sqlCmd.ExecuteNonQuery();

                conn.Close();

                EventsApproved();
                EventsPending();

                rptrPending.DataSource = dtPendingEvents;
                rptrPending.DataBind();
                rptrApproved.DataSource = dtApprovedEvents;
                rptrApproved.DataBind();
            }
        }

        protected void btnRevoke_Click(object sender, EventArgs e)
        {
            using (SqlCommand sqlCmd = new SqlCommand())
            {
                Button button = sender as Button;
                String EventID = button.CommandArgument;
                rptrPending.DataSource = null;
                rptrApproved.DataSource = null;
                dtPendingEvents.Rows.Clear();
                dtApprovedEvents.Rows.Clear();

                conn.Open();

                sqlCmd.Connection = conn;
                sqlCmd.CommandText = @"UPDATE Event SET approved = 0 WHERE id = @EventID";
                sqlCmd.Parameters.AddWithValue("@EventID", int.Parse(EventID));
                sqlCmd.ExecuteNonQuery();

                conn.Close();

                EventsPending();
                EventsApproved();

                rptrPending.DataSource = dtPendingEvents;
                rptrPending.DataBind();
                rptrApproved.DataSource = dtApprovedEvents;
                rptrApproved.DataBind();
            }
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            using (SqlCommand sqlCmd = new SqlCommand())
            {
                conn.Open();

                sqlCmd.Connection = conn;
                sqlCmd.CommandText = @"INSERT INTO University (name, location, description, numStudents)
                                       VALUES (@universityName, @universityLocation, @universityDescription, @maximumStudents)";

                sqlCmd.Parameters.Add(new SqlParameter("@universityName", txtUniversityName.Text));
                sqlCmd.Parameters.Add(new SqlParameter("@universityLocation", txtUniversityLocation.Text));
                sqlCmd.Parameters.Add(new SqlParameter("@universityDescription", txtUniversityDescription.Text));
                sqlCmd.Parameters.Add(new SqlParameter("@maximumStudents", txtMaximumStudents.Text));
                sqlCmd.ExecuteReader();

                conn.Close();
            }
        }
    }
}