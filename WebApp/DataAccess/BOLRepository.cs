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
            int bolId = -1;

            if (bol == null)
                return false;

            SqlCommand cmd = new SqlCommand("InsertUpdateBOL");
            cmd.Parameters.Add("@Id", SqlDbType.Int).Value = bol.Id;
            cmd.Parameters.Add("@BookingId", SqlDbType.Int).Value = bol.BookingId;
            cmd.Parameters.Add("@BOLRef", SqlDbType.NVarChar).Value = bol.BOLRef;
            cmd.Parameters.Add("@ConsigneeId", SqlDbType.Int).Value = bol.ConsigneeId;
            cmd.Parameters.Add("@ConsigneeAddress", SqlDbType.NVarChar).Value = bol.ConsigneeAddress;
            cmd.Parameters.Add("@ConsigneeRef", SqlDbType.NVarChar).Value = bol.ConsigneeRef;
            cmd.Parameters.Add("@PlaceOfReceipt", SqlDbType.NVarChar).Value = bol.PlaceOfReceipt;
            cmd.Parameters.Add("@NotifyId", SqlDbType.Int).Value = bol.NotifyId;
            cmd.Parameters.Add("@NotifyAddress", SqlDbType.NVarChar).Value = bol.NotifyAddress;
            cmd.Parameters.Add("@PlaceOfDelivery", SqlDbType.NVarChar).Value = bol.PlaceOfDelivery;
            cmd.Parameters.Add("@SupplierId", SqlDbType.Int).Value = bol.SupplierId;
            cmd.Parameters.Add("@SupplierAddress", SqlDbType.NVarChar).Value = bol.SupplierAddress;
            cmd.Parameters.Add("@WarehouseId", SqlDbType.Int).Value = bol.WarehouseId;
            cmd.Parameters.Add("@WarehouseAddress", SqlDbType.NVarChar).Value = bol.WarehouseAddress;
            cmd.Parameters.Add("@Notes", SqlDbType.NVarChar).Value = bol.Notes;
            cmd.Parameters.Add("@PlaceOfIssue", SqlDbType.NVarChar).Value = bol.PlaceOfIssue;
            cmd.Parameters.Add("@CreatedDate", SqlDbType.DateTime).Value = DateTime.Now;
            cmd.Parameters.Add("@ModifiedDate", SqlDbType.DateTime).Value = DateTime.Now;
            cmd.Parameters.Add("@ReturnValue", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
            this.ExecuteNonQuery(cmd);

            int.TryParse(cmd.Parameters["@ReturnValue"].Value.ToString(), out bolId);

            return bolId > 0;           
        }
    }
}