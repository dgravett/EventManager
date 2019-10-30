﻿using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace EventManagerWebApp
{
    public partial class _Default : Page
    {
        SqlConnection conn;

        protected void Page_Load(object sender, EventArgs e)
        {
            conn = new SqlConnection("Data Source=.;Initial Catalog=EventManager;Integrated Security=True");

            Bind_Repeater();
        }

        private void Bind_Repeater()
        {
            using (SqlCommand sqlCmd = new SqlCommand())
            {
                conn.Open();

                sqlCmd.Connection = conn;
                sqlCmd.CommandText = "SELECT name, description, time, (CONVERT(VARCHAR(100), latitude) + ' ' + CONVERT(VARCHAR(100), longitude)) as location FROM Event ORDER BY time DESC";

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