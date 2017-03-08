using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApp.DataAccess
{
    public class MyContainer
    {
        public int Id { get; set; }
        public string ContainerNo { get; set; }
        public long SealNo { get; set; }
        public double PkgsWeight { get; set; }
        public double NetWeight { get; set; }
        public float GRS { get; set; }
        public string Truck { get; set; }
        public long Invoice { get; set; }
        public DateTime CreatedDate { get; set; }
    }
}