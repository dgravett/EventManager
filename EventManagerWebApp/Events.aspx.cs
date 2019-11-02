using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EventManagerWebApp
{
    public partial class Events : System.Web.UI.Page
    {
        SqlConnection conn;

        protected void Page_Load(object sender, EventArgs e)
        {
            conn = new SqlConnection(ConnectionString.connectionString);

            Bind_Repeater();
        }

        private void Bind_Repeater()
        {
            using (SqlCommand sqlCmd = new SqlCommand())
            {
                conn.Open();

                sqlCmd.Connection = conn;
                sqlCmd.CommandText = @"SELECT 
                                            Event.id, 
                                            Event.name,
                                            EventType.description as EventType,
                                            Event.time
                                      FROM Event 
                                            LEFT JOIN Event_EventType on Event.id = Event_EventType.id_Event
                                            LEFT JOIN EventType on Event_EventType.id_EventType = EventType.id
                                      ORDER BY time ASC";
                DataTable dt = new DataTable();

                using (SqlDataReader sqldr = sqlCmd.ExecuteReader())
                {
                    dt.Load(sqldr);
                }

                conn.Close();

                RepeaterDiv.Style.Add("height", dt.Rows.Count * 155 + "px");
                Repeater1.DataSource = dt;
                Repeater1.DataBind();
            }
        }

        protected void ButtonViewEvent_Click(object sender, EventArgs e)
        {
            Button button = sender as Button;
            String EventId = button.CommandArgument;

            Response.Redirect("EventDetails.aspx?EventId=" + EventId);
        }
    }
}