using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;

namespace WebApp.DataAccess
{
    public class BillingRepository : DataAccessBase
    {
         
        public bool InsertBillingItem(int bookingId, int codeId, int quantity, string description, decimal amount, int vendorId)
        {
            SqlCommand cmd = new SqlCommand("InsertBillingItem");
            cmd.Parameters.AddWithValue("@BookingId", bookingId);
            cmd.Parameters.AddWithValue("@CodeId", codeId);
            cmd.Parameters.AddWithValue("@quantity", quantity);
            cmd.Parameters.AddWithValue("@Description", description);
            cmd.Parameters.AddWithValue("@Amount", amount);
            cmd.Parameters.AddWithValue("@VendorId", vendorId);
            return base.ExecuteNonQuery(cmd) > 0;

        }

        public DataTable GetBillingItem(int bookingId)
        {
            SqlCommand cmd = new SqlCommand("GetBillingItemsByBookingId");
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@bookingId", bookingId);
            return this.FillDataTable(cmd);
        }

        public DataTable GetPayoutItems(int bookingId)
        {
            SqlCommand cmd = new SqlCommand("GetPayoutItemsByBookingId");
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@bookingId", bookingId);
            return this.FillDataTable(cmd);
        }

        internal bool InsertBillingItem(int bookingId, int codeId, int quantity, string description, decimal billingAmount, decimal payoutAmount, int vendorId)
        {
            SqlCommand cmd = new SqlCommand("InsertBillingItem");
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@BookingId", SqlDbType.Int).Value = bookingId;
            cmd.Parameters.Add("@CodeId", SqlDbType.Int).Value = codeId;
            cmd.Parameters.Add("@quantity", SqlDbType.Int).Value= quantity;
            cmd.Parameters.Add("@Description", SqlDbType.NVarChar).Value= description;
            cmd.Parameters.Add("@BillingAmount", SqlDbType.Money).Value= billingAmount;
            cmd.Parameters.Add("@PayoutAmount", SqlDbType.Money).Value= payoutAmount;
            cmd.Parameters.Add("@VendorId", SqlDbType.Int).Value = vendorId;
            return base.ExecuteNonQuery(cmd) > 0;

        }

        internal bool DeleteItem(int billingItemId, int bookingId)
        {
            SqlCommand cmd = new SqlCommand("DeleteBillingItem");
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@BillingItemId", SqlDbType.Int).Value = billingItemId;
            cmd.Parameters.Add("@BookingId", SqlDbType.Int).Value = bookingId;
            return base.ExecuteNonQuery(cmd) > 0;
        }

        internal bool UpdateBillingItem(BillingItem bi)
        {
            SqlCommand cmd = new SqlCommand("UpdateBillingItem");
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@Id", SqlDbType.Int).Value = bi.Id;
            cmd.Parameters.Add("@BookingId", SqlDbType.Int).Value = bi.BookingId;
            cmd.Parameters.Add("@CodeId", SqlDbType.Int).Value = bi.CodeId;
            cmd.Parameters.Add("@quantity", SqlDbType.Int).Value = 1;
            cmd.Parameters.Add("@Description", SqlDbType.NVarChar).Value = bi.Description;
            cmd.Parameters.Add("@BillingAmount", SqlDbType.Money).Value = bi.BillingAmount;
            cmd.Parameters.Add("@PayoutAmount", SqlDbType.Money).Value = bi.PayoutAmount;
            cmd.Parameters.Add("@VendorId", SqlDbType.Int).Value = bi.VendorId;
            return base.ExecuteNonQuery(cmd) > 0;
        }
    }
}