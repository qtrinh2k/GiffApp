using System;
using System.Linq;
using System.Collections.Generic;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
//using System.Data.Entity;
//using System.Data.Entity.Infrastructure;

namespace WebApp
{
    using DataAccess;
    using System.Data;
    using System.Web.UI;

    public class DataUtil
    {
        public static int GetCompanyIdFromName(string companyName)
        {
            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                var allCompanyId = (from c in dc.Companies
                                    where c.CompanyName.Equals(companyName, StringComparison.InvariantCultureIgnoreCase)
                                    select c.Id).Distinct().ToList();

                return allCompanyId.First();
            }

        }

        public static int GetCompanyIdFromCode(string carrierCode)
        {
            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                var allCompanyId = (from c in dc.Companies
                                    where c.Code.Equals(carrierCode, StringComparison.InvariantCultureIgnoreCase)
                                    select c.Id).Distinct().ToList();

                return allCompanyId.First();
            }

        }

        public static string GetCompanyNameById(int companyId)
        {
            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                var results = (from c in dc.Companies
                               where c.Id == companyId
                               select c.CompanyName);

                return results.FirstOrDefault();
            }
        }

        public static string GetCarrierNameByCarrierId(int carrierId)
        {
            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                var results = (from c in dc.Companies
                               where c.Id == carrierId
                               select c.CompanyName);

                return results.FirstOrDefault();
            }
        }

        public static int GetBookingFromGiffiRef(long giffiRef)
        {
            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                var results = from bf in dc.BookingReferences
                where bf.GiffiId == giffiRef
                select bf.BookingId;

                return (int)results.First();
            }
        }

        public static Company GetCompanyInfo(long giffiRef)
        {
            int bookingId = DataUtil.GetBookingFromGiffiRef(giffiRef);

            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                var results = (from b in dc.Bookings
                               where b.Id == bookingId
                               select b.BillToId);

                if (results == null || results.Count() == 0)
                {
                    return null;
                }

                int billToId = results.First();
                var cp = (from c in dc.Companies
                          where c.Id == billToId
                          select c);

                return cp.First();
            }
        }


        public static Booking GetBookingInfo(long giffiRef)
        {
            int bookingId = DataUtil.GetBookingFromGiffiRef(giffiRef);

            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                var results = (from b in dc.Bookings
                               where b.Id == bookingId
                               select b);

                if (results == null || results.Count() == 0)
                {
                    return null;
                }

                return results.First();
            }
        }

        public static DataTable GetPayoutItems(int bookingId)
        {
            BillingRepository repo = new BillingRepository();
            return repo.GetPayoutItems(bookingId);
        }

        public static List<BillingItem> GetBillingItems(int bookingId)
        {
            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                var results = (from a in dc.BillingItems
                               where a.BookingId == bookingId
                               select a);


                if (results == null || !results.Any())
                    return null;

                return results.ToList();
            }
        }

        public static List<BillingItem> GetBillingItems(long giffiRef)
        {
            int bookingId = DataUtil.GetBookingFromGiffiRef(giffiRef);

            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                var results = (from b in dc.BillingItems
                               where b.BookingId == bookingId
                               select b);

                if (results == null || results.Count() == 0)
                {
                    return null;
                }

                return results.ToList();
            }
        }

    }
}
