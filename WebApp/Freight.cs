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
    
    public partial class Freight
    {
        public int Id { get; set; }
        public int BookingId { get; set; }
        public string Code { get; set; }
        public string BS { get; set; }
        public string PC { get; set; }
        public int Units { get; set; }
        public decimal Rate { get; set; }
        public decimal AmtPPD { get; set; }
        public decimal AmtCOL { get; set; }
        public decimal BrkRate { get; set; }
        public decimal BrkAmt { get; set; }
        public Nullable<System.DateTime> CreatedDate { get; set; }
        public Nullable<System.DateTime> ModifiedDate { get; set; }
        public string CreatedBy { get; set; }
    
        public virtual Booking Booking { get; set; }
    }
}
