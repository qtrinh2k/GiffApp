﻿//------------------------------------------------------------------------------
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
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class GiffiDBEntities : DbContext
    {
        public GiffiDBEntities()
            : base("name=GiffiDBEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<AccountingCode> AccountingCodes { get; set; }
        public virtual DbSet<User> Users { get; set; }
        public virtual DbSet<FreightCharge> FreightCharges { get; set; }
        public virtual DbSet<Freight> Freights { get; set; }
        public virtual DbSet<BillingItem> BillingItems { get; set; }
        public virtual DbSet<Company> Companies { get; set; }
        public virtual DbSet<Container> Containers { get; set; }
        public virtual DbSet<Booking> Bookings { get; set; }
        public virtual DbSet<BookingReference> BookingReferences { get; set; }
        public virtual DbSet<BookingView> BookingViews { get; set; }
    
        public virtual ObjectResult<GetFreightByBookingId_Result> GetFreightByBookingId(Nullable<int> bookingId)
        {
            var bookingIdParameter = bookingId.HasValue ?
                new ObjectParameter("bookingId", bookingId) :
                new ObjectParameter("bookingId", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<GetFreightByBookingId_Result>("GetFreightByBookingId", bookingIdParameter);
        }
    
        public virtual ObjectResult<GetFreightById_Result> GetFreightById(Nullable<int> param1, Nullable<int> param2)
        {
            var param1Parameter = param1.HasValue ?
                new ObjectParameter("param1", param1) :
                new ObjectParameter("param1", typeof(int));
    
            var param2Parameter = param2.HasValue ?
                new ObjectParameter("param2", param2) :
                new ObjectParameter("param2", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<GetFreightById_Result>("GetFreightById", param1Parameter, param2Parameter);
        }
    
        public virtual int InsertFreight(Nullable<int> bookingId, string code, string bS, string pC, Nullable<int> units, Nullable<decimal> rate, Nullable<decimal> amtPPD, Nullable<decimal> amtCOL, Nullable<decimal> brkRate, Nullable<decimal> brkAmt, string createdBy)
        {
            var bookingIdParameter = bookingId.HasValue ?
                new ObjectParameter("BookingId", bookingId) :
                new ObjectParameter("BookingId", typeof(int));
    
            var codeParameter = code != null ?
                new ObjectParameter("Code", code) :
                new ObjectParameter("Code", typeof(string));
    
            var bSParameter = bS != null ?
                new ObjectParameter("BS", bS) :
                new ObjectParameter("BS", typeof(string));
    
            var pCParameter = pC != null ?
                new ObjectParameter("PC", pC) :
                new ObjectParameter("PC", typeof(string));
    
            var unitsParameter = units.HasValue ?
                new ObjectParameter("Units", units) :
                new ObjectParameter("Units", typeof(int));
    
            var rateParameter = rate.HasValue ?
                new ObjectParameter("Rate", rate) :
                new ObjectParameter("Rate", typeof(decimal));
    
            var amtPPDParameter = amtPPD.HasValue ?
                new ObjectParameter("AmtPPD", amtPPD) :
                new ObjectParameter("AmtPPD", typeof(decimal));
    
            var amtCOLParameter = amtCOL.HasValue ?
                new ObjectParameter("AmtCOL", amtCOL) :
                new ObjectParameter("AmtCOL", typeof(decimal));
    
            var brkRateParameter = brkRate.HasValue ?
                new ObjectParameter("BrkRate", brkRate) :
                new ObjectParameter("BrkRate", typeof(decimal));
    
            var brkAmtParameter = brkAmt.HasValue ?
                new ObjectParameter("BrkAmt", brkAmt) :
                new ObjectParameter("BrkAmt", typeof(decimal));
    
            var createdByParameter = createdBy != null ?
                new ObjectParameter("CreatedBy", createdBy) :
                new ObjectParameter("CreatedBy", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("InsertFreight", bookingIdParameter, codeParameter, bSParameter, pCParameter, unitsParameter, rateParameter, amtPPDParameter, amtCOLParameter, brkRateParameter, brkAmtParameter, createdByParameter);
        }
    }
}
