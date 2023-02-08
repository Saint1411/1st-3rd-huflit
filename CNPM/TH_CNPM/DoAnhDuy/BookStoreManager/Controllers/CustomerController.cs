using BookStoreManager.Models;
using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace BookStoreManager.Controllers
{
    public class CustomerController : Controller
    {
        private BookStoreEntities db = new BookStoreEntities();


        //Xử lý phân trang nâng cao
        //public ActionResult Index(string category, int? page, double min = double.MinValue, double max = double.MaxValue, int categoryID = 0)
        //{
        //    //1.3. Tìm kiếm theo searchString
        //    ViewBag.Subject = categoryID;
        //    ViewBag.CategoryID = new SelectList(db.THELOAIs, "IDCate", "NameCate"); // danh sách Category            
        //    int pageSize = 4;
        //    int numPage = (page ?? 1);
        //    if (category == null)
        //    {
        //        var listBook = db.SACHes.OrderByDescending(x => x.TenSach);
        //        return View(listBook.ToPagedList(numPage, pageSize));
        //    }
        //    else
        //    {
        //         var list = db.SACHes.OrderByDescending(x => x.TenSach).Where(p => p.Catelogy == category);
        //        return View(list);
        //    }
        //}
        // GET: Book
        public ActionResult Index(string category, int? page, double min = double.MinValue, double max = double.MaxValue)
        {
            int pageSize = 4;
            int numPage = (page ?? 1);
            if (category == null)
            {
                var listBook = db.SACHes.OrderByDescending(x => x.TenSach);
                return View(listBook.ToPagedList(numPage, pageSize));
            }
            else
            {
                var listBook = db.SACHes.OrderByDescending(x => x.TenSach)
                    .Where(p => p.Catelogy == category);
                return View(listBook);
            }
        }

        // GET: Book/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SACH sACH = db.SACHes.Find(id);
            if (sACH == null)
            {
                return HttpNotFound();
            }
            return View(sACH);
        }
        //Timf kiem
        public ActionResult SearchOption(double min = double.MinValue, double max = double.MaxValue)
        {
            var list = db.SACHes.Where(p => (double)p.Price >= min && (double)p.Price <= max).ToList();
            return View(list);
        }

        //[HttpGet]
        //public ActionResult Index(string name)
        //{
        //    if (name == null)
        //    {
        //        return View(db.SACHes.ToList());
        //    }
        //    else
        //        return View(db.SACHes.Where(s => s.TenSach.Contains(name)).ToList());
        //}
    }
}