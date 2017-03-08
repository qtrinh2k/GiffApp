using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApp.DataAccess
{
    /*
    public partial class Booking
    {
        public int Id { get; set; }
        public string CreatedBy { get; set; }
        public System.DateTime CreatedTime { get; set; }
        public System.DateTime ModifiedTime { get; set; }
        public int BillToId { get; set; }
        public int ShipperId { get; set; }
        public int CarrierId { get; set; }
        public string Vessel { get; set; }
        public string VSL { get; set; }
        public string Origin { get; set; }
        public string Load' { get; set; }
        public string Discharge { get; set; }
        public string Destination { get; set; }
        public string Commodity { get; set; }
        public string Equiment { get; set; }
        public string Temp { get; set; }
        public string Vents { get; set; }
        public string Notes { get; set; }
        public string Status { get; set; }
    }
    */       
    public class BookingRepository : DataAccessBase
    {
    /*
	@createdBy NCHAR(50),
	@createdTime DateTime,
	@modifiedTime DateTime,
	@billToId int,
	@shipperId int,
	@carrierId int,
	@vessel nvarchar(50),
	@vsl nchar(10),
	@origin nvarchar(50),
	@load nvarchar(50),
	@discharge nvarchar(50),
	@destination nvarchar(50),
	@commodity nvarchar(200),
	@equiment nvarchar(100),
	@temp nchar(10),
	@vents nchar(10),
	@status nchar(10),
	@notes ntext      
    */

    public string Insert(Booking b)
        {
            return string.Empty;
        }
    }
}