using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace WebApp.DataAccess
{
    public class BOLRepository : DataAccessBase
    {
        public bool InsertUpdate(BillOfLanding bol)
        {
            if (bol == null)
                return false;

            SqlCommand cmd = new SqlCommand("InsertUpdateBOL");
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@Id", SqlDbType.Int).Value = bol.Id;
            cmd.Parameters.Add("@BookingId", SqlDbType.Int).Value = bol.BookingId;
            cmd.Parameters.Add("@BOLRef", SqlDbType.NVarChar).Value = bol.BOLRef;
            cmd.Parameters.Add("@ConsigneeAddress", SqlDbType.NVarChar).Value = bol.ConsigneeAddress;
            cmd.Parameters.Add("@ConsigneeRef", SqlDbType.NVarChar).Value = bol.ConsigneeRef;
            cmd.Parameters.Add("@PlaceOfReceipt", SqlDbType.NVarChar).Value = bol.PlaceOfReceipt;
            cmd.Parameters.Add("@NotifyAddress", SqlDbType.NVarChar).Value = bol.NotifyAddress;
            cmd.Parameters.Add("@PlaceOfDelivery", SqlDbType.NVarChar).Value = bol.PlaceOfDelivery;
            cmd.Parameters.Add("@SupplierAddress", SqlDbType.NVarChar).Value = bol.SupplierAddress;
            cmd.Parameters.Add("@WarehouseAddress", SqlDbType.NVarChar).Value = bol.WarehouseAddress;
            cmd.Parameters.Add("@Notes", SqlDbType.NVarChar).Value = bol.Notes;
            cmd.Parameters.Add("@PlaceOfIssue", SqlDbType.NVarChar).Value = bol.PlaceOfIssue;
            cmd.Parameters.Add("@DateOfIssue", SqlDbType.DateTime).Value = bol.DateOfIssue;
            cmd.Parameters.Add("@CreatedDate", SqlDbType.DateTime).Value = DateTime.Now;
            cmd.Parameters.Add("@ModifiedDate", SqlDbType.DateTime).Value = DateTime.Now;
            cmd.Parameters.Add("@ReturnValue", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
            return this.ExecuteNonQuery(cmd) > 0;            
        }
    }
}