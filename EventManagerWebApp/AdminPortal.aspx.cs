using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;


namespace EventManagerWebApp
{
    public partial class AdminPortal : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            conn = new SqlConnection(@"Data Source=LAPTOP-QD6F9K1Q\SQLEXPRESS;Initial Catalog=EventManager;Integrated Security=True");

            Bind_Repeater();
        }

        protected void createEvent_Click(object sender, EventArgs e)
        {

            string msg = string.Format("New Event Created!");
            ltMessage.Text = msg;

            using (SqlCommand sqlCmd = new SqlCommand())
            {
                conn.Open();
                sqlCmd.Connection = conn;

                sqlCmd.CommandText = "insert into Event (name,description,time,contactPhoneNumber,contactEmail,restriction) values('"+eventName.Text+"','"+eventDescription.Text+"','"+eventDate.SelectedDate+"','"+eventNumber.Text+ "','" + eventEmail.Text + "','"+ddlType.Text+"')";
                //sqlCmd.CommandText = "insert into Event()" + "(name,description,time,contactPhoneNumber,contactEmail,restriction)";
                //sqlCmd.Parameters.AddWithValue("@name",eventName.Text);
                //sqlCmd.Parameters.AddWithValue("@description", eventDescription.Text);
                //sqlCmd.Parameters.AddWithValue("@time", eventDate.SelectedDate);
                //sqlCmd.Parameters.AddWithValue("@contactPhoneNumber", 0);
                //sqlCmd.Parameters.AddWithValue("@contactEmail", "a");
                //sqlCmd.Parameters.AddWithValue("@restriction", "a");
                sqlCmd.ExecuteNonQuery();

                conn.Close();
            }

            Bind_Repeater();
        }

        private void Bind_Repeater()
        {
            using (SqlCommand sqlCmd = new SqlCommand())
            {
                conn.Open();

                sqlCmd.Connection = conn;
                sqlCmd.CommandText = "SELECT name, description, time,0 as location FROM Event ORDER BY time DESC";

                DataTable dt = new DataTable();

                using (SqlDataReader sqldr = sqlCmd.ExecuteReader())
                {
                    dt.Load(sqldr);
                }

                conn.Close();

                RepeaterDiv.Style.Add("height", dt.Rows.Count * 125 + "px");
                Repeater1.DataSource = dt;
                Repeater1.DataBind();
            }
        }


    }
}