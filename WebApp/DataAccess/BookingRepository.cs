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

        public bool InsertUpdateBooking(Booking b, out long giffiRef)
        {
            giffiRef = -1;
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@Id", SqlDbType.NVarChar).Value = b.Id;
            cmd.Parameters.Add("@createdBy", SqlDbType.NVarChar).Value = b.CreatedBy;
            cmd.Parameters.Add("@createdTime", SqlDbType.DateTime).Value = DateTime.Now;
            cmd.Parameters.Add("@modifiedTime", SqlDbType.DateTime).Value = DateTime.Now;
            cmd.Parameters.Add("@billToId", SqlDbType.Int).Value = b.BillToId;
            cmd.Parameters.Add("@shipperId", SqlDbType.Int).Value = b.ShipperId;
            cmd.Parameters.Add("@shipperRefNo", SqlDbType.NVarChar).Value = b.ShipperRefNo;
            cmd.Parameters.Add("@carrierId", SqlDbType.Int).Value = b.CarrierId;
            cmd.Parameters.Add("@vessel", SqlDbType.NVarChar).Value = b.Vessel;
            cmd.Parameters.Add("@voyage", SqlDbType.NChar).Value = b.Voyage;
            cmd.Parameters.Add("@origin", SqlDbType.NVarChar).Value = b.Origin;
            cmd.Parameters.Add("@load", SqlDbType.NVarChar).Value = b.Load;
            cmd.Parameters.Add("@destination", SqlDbType.NVarChar).Value = b.Destination;
            cmd.Parameters.Add("@discharge", SqlDbType.NVarChar).Value = b.Discharge;
            cmd.Parameters.Add("@commodity", SqlDbType.NVarChar).Value = b.Commodity;
            cmd.Parameters.Add("@equipment", SqlDbType.NVarChar).Value = b.Equipment;
            cmd.Parameters.Add("@temp", SqlDbType.NChar).Value = b.Temp;
            cmd.Parameters.Add("@vents", SqlDbType.NChar).Value = b.Vents;
            cmd.Parameters.Add("@status", SqlDbType.NChar).Value = "CREATED";
            cmd.Parameters.Add("@notes", SqlDbType.NVarChar).Value = b.Notes;
            cmd.Parameters.Add("@CutOffDate", SqlDbType.DateTime).Value = b.CutOffDate.Value;
            cmd.Parameters.Add("@DOC", SqlDbType.DateTime).Value = b.DOC;
            cmd.Parameters.Add("@CargoCut", SqlDbType.DateTime).Value = b.CargoCut;
            cmd.Parameters.Add("@VGM", SqlDbType.DateTime).Value = b.VGM;
            cmd.Parameters.Add("@ETD", SqlDbType.DateTime).Value = b.ETD;
            cmd.Parameters.Add("@ETA", SqlDbType.DateTime).Value = b.ETA;

            int result = 0;
            if (b.Id <= 0)
            {
                cmd.CommandText = "InsertBooking";
                cmd.Parameters.Add("@ReturnValue", SqlDbType.BigInt).Direction = ParameterDirection.ReturnValue;
                this.ExecuteNonQuery(cmd);

                long.TryParse(cmd.Parameters["@ReturnValue"].Value.ToString(), out giffiRef);
            }
            else
            {
                cmd.CommandText = "UpdateBooking";
                cmd.Parameters.Add("@Id", SqlDbType.NVarChar).Value = b.Id;
                result = this.ExecuteNonQuery(cmd);
            }

            return result > 0;
        }
    }
}