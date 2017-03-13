using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;

namespace WebApp.DataAccess
{
    public class CompanyRepository : DataAccessBase
    {
        public bool Insert(Company c)
        {
            SqlCommand cmd = new SqlCommand();

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "InsertCompany";
            cmd.Parameters.Add("@code", SqlDbType.NVarChar).Value = c.Code;
            cmd.Parameters.Add("@companyName", SqlDbType.NVarChar).Value = c.CompanyName;
            cmd.Parameters.Add("@companyType", SqlDbType.NVarChar).Value = c.CompanyType;
            cmd.Parameters.Add("@federalNumber", SqlDbType.NVarChar).Value = c.FederalNumber;
            cmd.Parameters.Add("@address", SqlDbType.NVarChar).Value = c.Address;
            cmd.Parameters.Add("@city", SqlDbType.NVarChar).Value = c.City;
            cmd.Parameters.Add("@state", SqlDbType.NChar).Value = c.State;
            cmd.Parameters.Add("@zipCode", SqlDbType.Int).Value = c.ZipCode;
            cmd.Parameters.Add("@country", SqlDbType.NVarChar).Value = c.Country;
            cmd.Parameters.Add("@phone", SqlDbType.NVarChar).Value = c.Phone;
            cmd.Parameters.Add("@email", SqlDbType.NVarChar).Value = c.Email;

            return ExecuteNonQuery(cmd) > 0;
        }
    }
}