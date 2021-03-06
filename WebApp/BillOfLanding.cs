//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace WebApp
{
    using System;
    using System.Collections.Generic;
    
    public partial class BillOfLanding
    {
        public int Id { get; set; }
        public int BookingId { get; set; }
        public string BOLRef { get; set; }
        public string ConsigneeAddress { get; set; }
        public string ConsigneeRef { get; set; }
        public string PlaceOfReceipt { get; set; }
        public string NotifyAddress { get; set; }
        public string PlaceOfDelivery { get; set; }
        public string SupplierAddress { get; set; }
        public string WarehouseAddress { get; set; }
        public string Notes { get; set; }
        public string PlaceOfIssue { get; set; }
        public Nullable<System.DateTime> DateOfIssue { get; set; }
        public Nullable<System.DateTime> CreatedDate { get; set; }
        public Nullable<System.DateTime> ModifiedDate { get; set; }
    
        public virtual Booking Booking { get; set; }
    }
}
