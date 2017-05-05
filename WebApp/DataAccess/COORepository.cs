using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace WebApp.DataAccess
{
    public class COORepository : DataAccessBase
    {
        public bool InsertUpdate(CertOfOrigin coo)
        {
            if (coo == null)
                return false;

            SqlCommand cmd = new SqlCommand("InsertUpdateCOO");
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@Id", SqlDbType.Int).Value = coo.Id;
            cmd.Parameters.Add("@BookingId", SqlDbType.Int).Value = coo.BookingId;
            cmd.Parameters.Add("@BOLRef", SqlDbType.NVarChar).Value = coo.BOLRef;
            cmd.Parameters.Add("@CertificateRef", SqlDbType.NVarChar).Value = coo.CertificateRef;
            cmd.Parameters.Add("@ConsigneeAddress", SqlDbType.NVarChar).Value = coo.ConsigneeAddress;
            cmd.Parameters.Add("@ConsigneeRef", SqlDbType.NVarChar).Value = coo.ConsigneeRef;
            cmd.Parameters.Add("@PlaceOfReceipt", SqlDbType.NVarChar).Value = coo.PlaceOfReceipt;
            cmd.Parameters.Add("@NotifyAddress", SqlDbType.NVarChar).Value = coo.NotifyAddress;
            cmd.Parameters.Add("@PlaceOfDelivery", SqlDbType.NVarChar).Value = coo.PlaceOfDelivery;
            cmd.Parameters.Add("@SupplierAddress", SqlDbType.NVarChar).Value = coo.SupplierAddress;
            cmd.Parameters.Add("@WarehouseAddress", SqlDbType.NVarChar).Value = coo.WarehouseAddress;
            cmd.Parameters.Add("@Notes", SqlDbType.NVarChar).Value = coo.Notes;
            cmd.Parameters.Add("@PlaceOfIssue", SqlDbType.NVarChar).Value = coo.PlaceOfIssue;
            cmd.Parameters.Add("@DateOfIssue", SqlDbType.DateTime).Value = coo.DateOfIssue;
            cmd.Parameters.Add("@CreatedDate", SqlDbType.DateTime).Value = DateTime.Now;
            cmd.Parameters.Add("@ModifiedDate", SqlDbType.DateTime).Value = DateTime.Now;
            cmd.Parameters.Add("@ReturnValue", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
            return this.ExecuteNonQuery(cmd) > 0;            
        }
    }
}