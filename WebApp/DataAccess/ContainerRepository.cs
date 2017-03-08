

namespace WebApp.DataAccess
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Web;
    using System.Data;
    using System.Data.Sql;
    using System.Data.SqlClient;

    /*
     @BookingId int,
@ContainerNo nvarchar(15),
@SealNo bigint,
@PkgsWeight float,
@NetWeight float,
@GRS float,
@Truck nchar(10),
@Invoice bigint,
@CreatedDate datetime
*/ 
    public class ContainerRepository : DataAccessBase
    {
        public bool InsertContainer(Container c)
        {
            SqlCommand cmd = new SqlCommand("InsertContainer");
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@BookingId", SqlDbType.Int).Value = c.BookingId;
            cmd.Parameters.Add("@ContainerNo", SqlDbType.NVarChar).Value = c.ContainerNo;
            cmd.Parameters.Add("@SealNo", SqlDbType.BigInt).Value = c.SealNo;            
            cmd.Parameters.Add("@PkgsWeight", SqlDbType.Float).Value = c.PkgsWeight;
            cmd.Parameters.Add("@NetWeight", SqlDbType.Float).Value = c.NetWeight;
            cmd.Parameters.Add("@GRS", SqlDbType.Float).Value = c.GRS;
            cmd.Parameters.Add("@Truck", SqlDbType.NChar).Value = c.Truck;
            cmd.Parameters.Add("@Invoice", SqlDbType.BigInt).Value = c.Invoice;
            cmd.Parameters.Add("@CreatedDate", SqlDbType.DateTime).Value = DateTime.Now;
            return ExecuteNonQuery(cmd) > 0;
        }

        public List<Container> GetContainerByBookingId(int bookingId)
        {
            SqlCommand cmd = new SqlCommand("GetContainerByBookingId");
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@bookingId", SqlDbType.Int).Value = bookingId;
            DataTable result = base.FillDataTable(cmd);

            List<Container> containers = new List<Container>();
            
            foreach(DataRow row in result.Rows)
            {
                containers.Add(new Container
                {
                    Id = int.Parse(row["Id"].ToString()),
                    BookingId = int.Parse(row["BookingId"].ToString()),
                    ContainerNo = row["ContainerNo"].ToString(),
                    SealNo = long.Parse(row["SealNo"].ToString()),
                    PkgsWeight = float.Parse(row["PkgsWeight"].ToString()),
                    NetWeight = float.Parse(row["NetWeight"].ToString()),
                    GRS = float.Parse(row["GRS"].ToString()),
                    Truck = row["Truck"].ToString(),
                    Invoice = long.Parse(row["Invoice"].ToString()),
                    CreatedDate = DateTime.Parse(row["CreatedDate"].ToString())
                });
            }

            return containers;
        }
    }
}
 
 