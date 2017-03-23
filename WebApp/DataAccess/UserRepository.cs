using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
namespace WebApp.DataAccess
{
    public class UserRepository : DataAccessBase
    {
        public int InsertUser(string userName, string password, string email)
        {
            SqlCommand cmd = new SqlCommand("InsertUser");
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@userName", userName);
            cmd.Parameters.AddWithValue("@password", password);
            cmd.Parameters.AddWithValue("@email", email);

            var result = Convert.ToInt32(base.ExecuteScalar(cmd));

            return result;
        }

        public int ValidateUser(string userName, string password)
        {
            SqlCommand cmd = new SqlCommand("ValidateUser");
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@userName", userName);
            cmd.Parameters.AddWithValue("@password", password);

            var result = Convert.ToInt32(base.ExecuteScalar(cmd));
            return result;
        }
    }
}