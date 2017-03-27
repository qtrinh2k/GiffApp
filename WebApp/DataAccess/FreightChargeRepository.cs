using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace WebApp.DataAccess
{
    public class FreightChargeRepository : DataAccessBase
    {
        public DataTable GetFreightCharge()
        {
            SqlCommand cmd = new SqlCommand("GetFreightCharge");
            cmd.CommandType = CommandType.StoredProcedure;
            return this.FillDataTable(cmd);
        }
    }
}