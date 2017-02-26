﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GiffiEZApp.BusinessObjects;
using System.Data;
using System.Data.Sql;
using System.Data.SqlTypes;
using System.Data.SqlClient;
namespace WebApp
{
    public partial class Company : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void AddNewCompany_Click(object sender, EventArgs e)
        {

            DataAccessBase dbAccess = new DataAccessBase();

            using (SqlConnection con = new SqlConnection(dbAccess.ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("InsertCompany", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@companyName", SqlDbType.NVarChar).Value = txtCompanyName.Text.Trim();
                    cmd.Parameters.Add("@attention", SqlDbType.NVarChar).Value = "";
                    cmd.Parameters.Add("@address1", SqlDbType.NVarChar).Value = txtAddress1.Text.Trim();
                    cmd.Parameters.Add("@address2", SqlDbType.NVarChar).Value = txtAddress2.Text.Trim();
                    cmd.Parameters.Add("@city", SqlDbType.NVarChar).Value = txtCity.Text.Trim();
                    cmd.Parameters.Add("@state", SqlDbType.NChar).Value = txtState.Text.Trim();
                    cmd.Parameters.Add("@zipCode", SqlDbType.Int).Value = txtZip.Text.Trim();
                    cmd.Parameters.Add("@zipCode2", SqlDbType.Int).Value = "0000";
                    cmd.Parameters.Add("@country", SqlDbType.NVarChar).Value = txtCountry.Text.Trim();
                    cmd.Parameters.Add("@phone", SqlDbType.NVarChar).Value = txtCountry.Text.Trim();
                    cmd.Parameters.Add("@email", SqlDbType.NVarChar).Value = txtCountry.Text.Trim();
                    con.Open();
                    var result = cmd.ExecuteNonQuery();
                }
            }

            ClientScript.RegisterStartupScript(GetType(), "alert", "alert('Successfully Submit');", true);
        }
    }
}