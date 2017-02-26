namespace BusinessObjects
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class GiffDBModel : DbContext
    {
        public GiffDBModel()
            : base("name=GiffDBModel")
        {
        }

        public virtual DbSet<Booking> Booking { get; set; }
        public virtual DbSet<Company> Company { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Booking>()
                .Property(e => e.CreatedBy)
                .IsFixedLength();

            modelBuilder.Entity<Booking>()
                .Property(e => e.VSL)
                .IsFixedLength();

            modelBuilder.Entity<Booking>()
                .Property(e => e.Temp)
                .IsFixedLength();

            modelBuilder.Entity<Booking>()
                .Property(e => e.Vents)
                .IsFixedLength();

            modelBuilder.Entity<Booking>()
                .Property(e => e.Status)
                .IsFixedLength();

            modelBuilder.Entity<Company>()
                .Property(e => e.Address2)
                .IsFixedLength();

            modelBuilder.Entity<Company>()
                .Property(e => e.State)
                .IsFixedLength();

            modelBuilder.Entity<Company>()
                .Property(e => e.ZipCode)
                .HasPrecision(5, 0);

            modelBuilder.Entity<Company>()
                .Property(e => e.ZipCode2)
                .HasPrecision(5, 0);

            modelBuilder.Entity<Company>()
                .HasMany(e => e.Booking)
                .WithRequired(e => e.Company)
                .HasForeignKey(e => e.BillToId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Company>()
                .HasMany(e => e.Booking1)
                .WithRequired(e => e.Company1)
                .HasForeignKey(e => e.ShipperId)
                .WillCascadeOnDelete(false);
        }
    }
}
