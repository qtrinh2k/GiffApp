namespace BusinessObjects
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Booking")]
    public partial class Booking
    {
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Id { get; set; }

        [Required]
        [StringLength(50)]
        public string CreatedBy { get; set; }

        public DateTime CreatedTime { get; set; }

        public DateTime ModifiedTime { get; set; }

        public int BillToId { get; set; }

        public int ShipperId { get; set; }

        public int CarrierId { get; set; }

        [Required]
        [StringLength(50)]
        public string Vessel { get; set; }

        [Required]
        [StringLength(10)]
        public string VSL { get; set; }

        public int OriginId { get; set; }

        public int LoadId { get; set; }

        public int DischargeId { get; set; }

        public int DestinationId { get; set; }

        [StringLength(200)]
        public string Commodity { get; set; }

        [Required]
        [StringLength(100)]
        public string Equiment { get; set; }

        [Required]
        [StringLength(10)]
        public string Temp { get; set; }

        [Required]
        [StringLength(10)]
        public string Vents { get; set; }

        [Column(TypeName = "ntext")]
        public string Notes { get; set; }

        [StringLength(10)]
        public string Status { get; set; }

        public virtual Company Company { get; set; }

        public virtual Company Company1 { get; set; }
    }
}
