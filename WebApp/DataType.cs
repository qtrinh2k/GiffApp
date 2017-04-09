using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApp
{
    public enum SearchType
    {
        GiffiRef = 1,
        ShipperRef = 2,
        ContainerNo = 3
    }
    public class DataType
    {
    }

    public enum ComanyType
    {
        Customer = 0,
        Vendor = 1,
        Both = 2, //customer and vendor
        Consignee = 3,
        Supplier = 4,
        Warehouse = 5        
    }
}