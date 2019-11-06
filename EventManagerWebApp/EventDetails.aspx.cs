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
    public partial class EventDetails : System.Web.UI.Page
    {
        SqlConnection conn;
        protected float lat, lng;
        protected string locationName;
        DataTable dtComments;
        int EventId;

        protected void Page_Load(object sender, EventArgs e)
        {
            conn = new SqlConnection(ConnectionString.connectionString);

            
            EventId = int.Parse(Request.QueryString["EventId"]);

            LoadEventDetails(EventId);
            LoadComments(EventId);
        }

        private void LoadEventDetails(int EventId)
        {
            using (SqlCommand sqlCmd = new SqlCommand())
            {
                conn.Open();

                sqlCmd.Connection = conn;
                sqlCmd.CommandText = @"SELECT 
                                            Event.id, 
                                            Event.name,   
                                            Event.description, 
                                            EventType.description as EventType,
                                            Event.time, 
                                            Location.name as locationName,
                                            Location.latitude,
                                            Location.longitude
                                      FROM Event 
                                            LEFT JOIN Event_EventType on Event.id = Event_EventType.id_Event
                                            LEFT JOIN EventType on Event_EventType.id_EventType = EventType.id
                                            LEFT JOIN Event_Location on Event.id = Event_Location.id_Event
                                            LEFT JOIN Location on Event_Location.id_Location = Location.id
                                      WHERE Event.id = @EventId";

                sqlCmd.Parameters.AddWithValue("@EventId", EventId);

                DataTable dt = new DataTable();

                using (SqlDataReader sqldr = sqlCmd.ExecuteReader())
                {
                    dt.Load(sqldr);
                }

                conn.Close();

                LabelHeader.Text = dt.Rows[0]["name"] as String;
                LabelDescription.Text = "Description: " + dt.Rows[0]["description"] as String;
                LabelType.Text = "Type: " + dt.Rows[0]["EventType"] as String;
                LabelTime.Text = "Time: " + dt.Rows[0]["time"].ToString();
                locationName = dt.Rows[0]["locationName"].ToString();
                lat = float.Parse(dt.Rows[0]["latitude"].ToString());
                lng = float.Parse(dt.Rows[0]["longitude"].ToString());
            }
        }

        private void LoadComments(int EventId)
        {
            using (SqlCommand sqlCmd = new SqlCommand())
            {
                conn.Open();

                sqlCmd.Connection = conn;
                sqlCmd.CommandText = @"SELECT 
                                            Comment.id,
                                            Comment.commentText,
                                            Comment.date,
                                            Comment.rating,
                                            [User].userName
                                      FROM Comment
                                            INNER JOIN User_Comment_Event on Comment.id = User_Comment_Event.id_Comment
                                            INNER JOIN Event on User_Comment_Event.id_Event = Event.id
                                            INNER JOIN [User] on User_Comment_Event.id_User = [User].id
                                      WHERE Event.id = @EventId
                                      ORDER BY Comment.date ASC";

                sqlCmd.Parameters.AddWithValue("@EventId", EventId);

                dtComments = new DataTable();

                using (SqlDataReader sqldr = sqlCmd.ExecuteReader())
                {
                    dtComments.Load(sqldr);
                }

                conn.Close();

                RepeaterDiv.Style.Add("height", dtComments.Rows.Count * 150 + 150 + "px");
                RepeaterComments.DataSource = dtComments;
                RepeaterComments.DataBind();
            }
        }

        protected void ButtonEditComment_Click(object sender, EventArgs e)
        {

        }

        protected void ButtonDeleteComment_Click(object sender, EventArgs e)
        {
            using (SqlCommand sqlCmd = new SqlCommand())
            {
                Button button = sender as Button;
                String[] input = button.CommandArgument.Split(';');
                String CommentId = input[0];
                String UserName = input[1];

                if (UserName != GlobalUserPassport.globalUserPassport.userName)
                    return;

                conn.Open();

                sqlCmd.Connection = conn;
                sqlCmd.CommandText = @"DELETE FROM User_Comment_Event
                                       WHERE id_Comment = @CommentId

                                       DELETE FROM Comment
                                       WHERE id = @CommentId";

                sqlCmd.Parameters.AddWithValue("@CommentId", int.Parse(CommentId));

                sqlCmd.ExecuteNonQuery();

                conn.Close();

                for(int i = 0; i < dtComments.Rows.Count; i++)
                {
                    DataRow dr = dtComments.Rows[i];

                    if(dr["id"].ToString() == CommentId)
                    {
                        dtComments.Rows.Remove(dr);
                        break;
                    }
                }

                RepeaterDiv.Style.Add("height", dtComments.Rows.Count * 150 + 150 + "px");
                RepeaterComments.DataSource = dtComments;
                RepeaterComments.DataBind();
            }
        }

        protected void ButtonAddComment_Click(object sender, EventArgs e)
        {
            using (SqlCommand sqlCmd = new SqlCommand())
            {
                int rating = 0;
                if (star1.Checked) rating = 1;
                else if (star2.Checked) rating = 2;
                else if (star3.Checked) rating = 3;
                else if (star4.Checked) rating = 4;
                else if (star5.Checked) rating = 5;

                conn.Open();

                sqlCmd.Connection = conn;
                sqlCmd.CommandText = @"EXEC sp_Comment_Insert @UserId, @EventId, @commentText, @rating";

                sqlCmd.Parameters.AddWithValue("@UserId", GlobalUserPassport.globalUserPassport.userId);
                sqlCmd.Parameters.AddWithValue("@EventId", EventId);
                sqlCmd.Parameters.AddWithValue("@commentText", TextBoxComment.Text);
                sqlCmd.Parameters.AddWithValue("@rating", rating);

                sqlCmd.ExecuteNonQuery();

                conn.Close();

                DataRow dr = dtComments.NewRow();
                dr["commentText"] = TextBoxComment.Text;
                dr["date"] = DateTime.UtcNow;
                dr["rating"] = rating;
                dr["userName"] = GlobalUserPassport.globalUserPassport.userName;

                dtComments.Rows.Add(dr);

                RepeaterDiv.Style.Add("height", dtComments.Rows.Count * 150 + 150 + "px");
                RepeaterComments.DataSource = dtComments;
                RepeaterComments.DataBind();
            }
        }
    }
}