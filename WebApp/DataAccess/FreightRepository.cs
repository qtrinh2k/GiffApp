
namespace WebApp.DataAccess
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Web;
    using System.Data;
    using System.Data.SqlClient;
    using System.Globalization;

    public class FreightRepository : DataAccessBase
    {
        public bool UpdateFreight(Freight fr)
        {
            SqlCommand cmd = new SqlCommand("UpdateFreight");
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@Id", SqlDbType.Int).Value = fr.Id;
            cmd.Parameters.Add("@BookingId", SqlDbType.Int).Value = fr.BookingId;
            cmd.Parameters.Add("@Code", SqlDbType.NChar).Value = fr.Code;
            cmd.Parameters.Add("@BS", SqlDbType.NChar).Value = fr.BS;
            cmd.Parameters.Add("@PC", SqlDbType.NChar).Value = fr.PC;
            cmd.Parameters.Add("@Units", SqlDbType.Int).Value = fr.Units;
            cmd.Parameters.Add("@Rate", SqlDbType.Money).Value = fr.Rate;
            cmd.Parameters.Add("@AmtPPD", SqlDbType.Money).Value = fr.AmtPPD;
            cmd.Parameters.Add("@AmtCOL", SqlDbType.Money).Value = fr.AmtCOL;
            cmd.Parameters.Add("@BrkRate", SqlDbType.Money).Value = fr.BrkRate;
            cmd.Parameters.Add("@BrkAmt", SqlDbType.Money).Value = fr.BrkAmt;
            cmd.Parameters.Add("@ModifiedDate", SqlDbType.DateTime).Value = DateTime.Now;
            return base.ExecuteNonQuery(cmd) > 0;

        }
        public bool InsertFreight(Freight fr)
        {
            SqlCommand cmd = new SqlCommand("InsertFreight");
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@BookingId", SqlDbType.Int).Value = fr.BookingId;
            cmd.Parameters.Add("@Code", SqlDbType.NChar).Value = fr.Code;
            cmd.Parameters.Add("@BS", SqlDbType.NChar).Value = fr.BS;
            cmd.Parameters.Add("@PC", SqlDbType.NChar).Value = fr.PC;
            cmd.Parameters.Add("@Units", SqlDbType.Int).Value = fr.Units;
            cmd.Parameters.Add("@Rate", SqlDbType.Money).Value = fr.Rate;
            cmd.Parameters.Add("@AmtPPD", SqlDbType.Money).Value = fr.AmtPPD;
            cmd.Parameters.Add("@AmtCOL", SqlDbType.Money).Value = fr.AmtCOL;
            cmd.Parameters.Add("@BrkRate", SqlDbType.Money).Value = fr.BrkRate;
            cmd.Parameters.Add("@BrkAmt", SqlDbType.Money).Value = fr.BrkAmt;
            cmd.Parameters.Add("@CreatedBy", SqlDbType.NVarChar).Value = "";
            return base.ExecuteNonQuery(cmd) > 0;

        }

        public bool DeleteFreight(int freightId)
        {
            SqlCommand cmd = new SqlCommand("DeleteFreight");
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@Id", SqlDbType.Int).Value = freightId;
            return base.ExecuteNonQuery(cmd) > 0;
        }

        public List<Freight> GetFreightByBookingId(int bookingId)
        {

            SqlCommand cmd = new SqlCommand("GetFreightByBookingId");
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@bookingId", SqlDbType.Int).Value = bookingId;
            DataTable result = base.FillDataTable(cmd);

            List<Freight> listFr = new List<Freight>();

            foreach(DataRow r in result.Rows)
            {
                Freight f = new Freight
                {
                    Id = int.Parse(r["Id"].ToString()),
                    BookingId = int.Parse(r["BookingId"].ToString()),
                    Code = r["Code"].ToString(),
                    BS = r["BS"].ToString(),
                    PC = r["PC"].ToString(),
                    Units = int.Parse(r["Units"].ToString()),
                    Rate = decimal.Parse(r["Rate"].ToString(), NumberStyles.Currency),
                    AmtPPD = decimal.Parse(r["AmtPPD"].ToString(), NumberStyles.Currency),
                    AmtCOL = decimal.Parse(r["AmtCOL"].ToString(), NumberStyles.Currency),
                    BrkRate = decimal.Parse(r["BrkRate"].ToString(), NumberStyles.Currency),
                    BrkAmt = decimal.Parse(r["BrkAmt"].ToString(), NumberStyles.Currency)
                };
                listFr.Add(f);
            }

            return listFr;
        }
    }

}