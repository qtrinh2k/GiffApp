﻿using System;
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
        public static string GetCompanyAsHtml(int compId)
        {
            if (compId <= 0)
                return string.Empty;

            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                Company cp = (from c in dc.Companies
                      where c.Id == compId
                      select c).FirstOrDefault();

                string cityZip = string.Join(", ", cp.City.Trim(), cp.State.Trim(), cp.ZipCode.Trim());
                string cpInfo = string.Join("</br>", cp.CompanyName, cp.Address, cityZip, cp.Country);
                return cpInfo;
            }

        }
        public static string GetCompanyAsText(int compId)
        {
            if (compId <= 0)
                return string.Empty;

            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                Company cp = (from c in dc.Companies
                              where c.Id == compId
                              select c).FirstOrDefault();

                string cityZip = string.Join(", ", cp.City.Trim(), cp.State.Trim(), cp.ZipCode.Trim());
                string cpInfo = string.Join("\n", cp.CompanyName, cp.Address, cityZip, cp.Country);
                return cpInfo;
            }

        }

        public static List<Company> GetCompanyByType(CompanyType type)
        {
            List<Company> cp = new List<Company>();
            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                cp = (from c in dc.Companies
                      where c.CompanyType.Equals(type.ToString(), StringComparison.InvariantCultureIgnoreCase)
                      select c).ToList();
            }
            return cp;
        }
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

        internal static Company GetCompanyById(int companyId)
        {
            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                var company = (from c in dc.Companies
                                    where c.Id == companyId
                                    select c).First();

                return company;
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

        internal static Booking GetBookingFromGiffiId(double giffiRef)
        {
            int bookingId = GetBookingIdFromGiffiId(giffiRef);
            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                var results = from b in dc.Bookings
                              where b.Id == bookingId
                              select b;

                return (results.Any()) ? results.First() : null;
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

        internal static string GetCompanyCodeById(int id)
        {
            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                var results = (from c in dc.Companies
                               where c.Id == id
                               select c.Code);

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

        public static int GetBookingIdFromGiffiId(double giffiRef)
        {
            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                var results = from bf in dc.BookingReferences
                where bf.GiffiId == giffiRef
                select bf.BookingId;

                return (results.Any()) ? (int)results.First() : -1;
            }
        }

        public static Company GetBillToCompany(double giffiRef)
        {
            int bookingId = DataUtil.GetBookingIdFromGiffiId(giffiRef);

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

        public static Booking GetBookingInfo(int bookingId)
        {
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

        public static DataTable GetBillingItems(int bookingId)
        {
            BillingRepository billRepo = new BillingRepository();
            return billRepo.GetBillingItem(bookingId);

        }

        public static DataTable GetBillingItems(double giffiRef)
        {
            int bookingId = DataUtil.GetBookingIdFromGiffiId(giffiRef);

            BillingRepository billRepo = new BillingRepository();
            return billRepo.GetBillingItem(bookingId);
        }

        public static List<string> SearchBookingReferenceFor(string pre)
        {
            List<string> results = new List<string>();

            using (GiffiDBEntities dc = new GiffiDBEntities())
            {
                List<double> giffiIds = (from c in dc.BookingReferences select c.GiffiId).ToList();
                List<string> listGiffiIds = giffiIds.Select(d => string.Format("{0:0.##}", d)).ToList();

                if (pre.Equals("*") || pre.Equals("."))
                {
                    results = listGiffiIds;
                }
                else
                {
                    results = listGiffiIds.Where(s => s.StartsWith(pre)).ToList();
                }
            }

            return results;
        }

    }
}
