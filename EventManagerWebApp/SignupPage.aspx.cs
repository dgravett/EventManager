﻿using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace EventManagerWebApp
{
    public partial class SignupPage : System.Web.UI.Page
    {
        SqlConnection conn;

        protected void Page_Load(object sender, EventArgs e)
        {
            conn = new SqlConnection(ConnectionString.connectionString);

            if (!Page.IsPostBack)
            {
                Bind_ddlUniversity();
            }
        }

        protected void btnSignup_Click(object sender, EventArgs e)
        {
            using (SqlCommand sqlCommand = new SqlCommand())
            {
                conn.Open();

                sqlCommand.Connection = conn;
                sqlCommand.CommandText = @"INSERT INTO [User] VALUES (@userName, @password)
                                           DECLARE @UserID int
                                           SELECT @UserID = id FROM [User] WHERE userName = @userName
                                           INSERT INTO User_University (id_User,id_University) VALUES (@UserID, @UniversityID)
                                           INSERT INTO User_UserType VALUES (@UserID, 3)
                                        ";
                sqlCommand.Parameters.Add(new SqlParameter("@userName", txtUsername.Text));
                sqlCommand.Parameters.Add(new SqlParameter("@password", BCrypt.Net.BCrypt.HashPassword(txtPassword.Text)));
                sqlCommand.Parameters.Add(new SqlParameter("@UniversityID", ddlUniversity.SelectedValue));

                sqlCommand.ExecuteReader();
                Response.Redirect("LoginPage.aspx");
            }
        }

        private void Bind_ddlUniversity()
        {
            using (SqlCommand sqlCmd = new SqlCommand())
            {
                conn.Open();

                sqlCmd.Connection = conn;
                sqlCmd.CommandText = @"SELECT id, name
                                      FROM University";
                DataTable dtUniversities = new DataTable();

                using (SqlDataReader sqldr = sqlCmd.ExecuteReader())
                {
                    dtUniversities.Load(sqldr);
                }

                conn.Close();

                ddlUniversity.DataSource = dtUniversities;
                ddlUniversity.DataBind();
            }
        }
    }
}