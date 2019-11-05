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
        DataTable dtEvents;

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
                                            EventType.id as id_EventType,
                                            EventType.description as EventType,
                                            Event.time
                                      FROM Event 
                                            LEFT JOIN Event_EventType on Event.id = Event_EventType.id_Event
                                            LEFT JOIN EventType on Event_EventType.id_EventType = EventType.id
                                            LEFT JOIN Event_RSO on Event.id = Event_RSO.id_Event
                                            LEFT JOIN User_RSO on Event_RSO.id_RSO = User_RSO.id_RSO
                                      WHERE
                                            Event_RSO.id_RSO IS NULL OR User_RSO.id_User = @UserId
                                      ORDER BY time ASC";
                dtEvents = new DataTable();

                sqlCmd.Parameters.Add(new SqlParameter("@UserId", GlobalUserPassport.globalUserPassport.userId));

                using (SqlDataReader sqldr = sqlCmd.ExecuteReader())
                {
                    dtEvents.Load(sqldr);
                }

                conn.Close();

                RepeaterDiv.Style.Add("height", dtEvents.Rows.Count * 155 + "px");
                Repeater1.DataSource = dtEvents;
                Repeater1.DataBind();
            }
        }

        protected void ButtonViewEvent_Click(object sender, EventArgs e)
        {
            Button button = sender as Button;
            String EventId = button.CommandArgument;

            Response.Redirect("EventDetails.aspx?EventId=" + EventId);
        }

        protected void ButtonFilter_Click(object sender, EventArgs e)
        {
            String filterText = TextBoxFilter.Text;
            bool publicEvent = CheckBoxPublic.Checked;
            bool privateEvent = CheckBoxPrivate.Checked;
            bool rsoEvent = CheckBoxRSO.Checked;

            DataTable filteredTable = dtEvents.AsEnumerable().Where(r => r.Field<string>("name").Contains(filterText)).CopyToDataTable();
            if (publicEvent || privateEvent || rsoEvent)
            {
                if (!publicEvent)
                    filteredTable = filteredTable.AsEnumerable().Where(r => r.Field<int>("id_EventType") != 2).CopyToDataTable();
                if (!privateEvent)
                    filteredTable = filteredTable.AsEnumerable().Where(r => r.Field<int>("id_EventType") != 1).CopyToDataTable();
                if (!rsoEvent)
                    filteredTable = filteredTable.AsEnumerable().Where(r => r.Field<int>("id_EventType") != 3).CopyToDataTable();
            }

            Repeater1.DataSource = filteredTable;
            Repeater1.DataBind();
        }
    }
}