using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApp
{
    public enum BillingType
    {
        Receivable,
        Payable
    }

    public enum CompanyType
    {
        Vendor,
        Customer,
        Consignee,
        Warehouse,
        Supplier
    }

    public class Constants
    {
        public const int InitBookingId = 86000;
    }
}