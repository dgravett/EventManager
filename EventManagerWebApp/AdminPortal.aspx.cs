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
        protected float lat, lng;
        protected string locationName;
        protected void Page_Load(object sender, EventArgs e)
        {
            conn = new SqlConnection(ConnectionString.connectionString);

            if (!Page.IsPostBack)
            {
                Bind_DropDownList();
                //lat = hf_Lat.Value;
                //lng = hf_Lng.Value;
            }
                
        }

        protected void createEvent_Click(object sender, EventArgs e)
        {

            string msg = string.Format("New Event Created!");
            ltMessage.Text = msg;

            using (SqlCommand sqlCmd = new SqlCommand())
            {
                conn.Open();
                sqlCmd.Connection = conn;

                sqlCmd.CommandText = @"exec usp_Event_Insert 
	                                            @eventName ,
	                                            @description ,
	                                            @time ,
	                                            @phoneNumber,
	                                            @email ,
	                                            @idUniversity ,
	                                            @idRSO,
	                                            @locationName,
	                                            @latitude ,
	                                            @longitude ,
	                                            @eventType ";

                sqlCmd.Parameters.AddWithValue("@eventName", eventName.Text);
                sqlCmd.Parameters.AddWithValue("@description", eventDescription.Text);
                sqlCmd.Parameters.AddWithValue("@time", eventDate.SelectedDate);
                sqlCmd.Parameters.AddWithValue("@phoneNumber", eventNumber.Text);
                sqlCmd.Parameters.AddWithValue("@email", eventEmail.Text);
                sqlCmd.Parameters.AddWithValue("@idUniversity",GlobalUserPassport.globalUserPassport.universityId);
                if (int.Parse(ddlType.SelectedValue) == (int) DBEnum.Event.Type.RSO)
                {
                    sqlCmd.Parameters.AddWithValue("@idRSO", DropDownList.SelectedValue);
                }
                else
                {
                    sqlCmd.Parameters.AddWithValue("@idRSO", -1);
                }
                sqlCmd.Parameters.AddWithValue("@locationName", eventLocation.Text);
                sqlCmd.Parameters.AddWithValue("@latitude", float.Parse(hf_Lat.Value));
                sqlCmd.Parameters.AddWithValue("@longitude", float.Parse(hf_Lng.Value));
                sqlCmd.Parameters.AddWithValue("@eventType", int.Parse(ddlType.SelectedValue));
                
                sqlCmd.ExecuteNonQuery();

                conn.Close();
            }

            Response.Redirect("Events.aspx");
        }

        private void Bind_DropDownList()
        {
            using (SqlCommand sqlCmd = new SqlCommand())
            {
                conn.Open();

                sqlCmd.Connection = conn;
                sqlCmd.CommandText = @"SELECT id, name
                                      FROM RSO 
                                       inner join User_RSO on RSO.id = User_RSO.id_RSO
                                        where User_RSO.id_User = @idUser";
                sqlCmd.Parameters.AddWithValue("@idUser", GlobalUserPassport.globalUserPassport.userId);
                DataTable dtRSO = new DataTable();

                using (SqlDataReader sqldr = sqlCmd.ExecuteReader())
                {
                    dtRSO.Load(sqldr);
                }

                conn.Close();

                DropDownList.DataSource = dtRSO;
                DropDownList.DataBind();
            }
        }
    }
}