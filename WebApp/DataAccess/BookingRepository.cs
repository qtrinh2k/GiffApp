using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace WebApp.DataAccess
{
       
    public class BookingRepository : DataAccessBase
    {
        public DataTable GetBookingByUsername(string userName)
        {
            SqlCommand cmd = new SqlCommand("GetBookingByUserName");
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@userName", userName);
            return this.FillDataTable(cmd);
        }
    }
}