using BookStore.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BookStore.Controllers
{
    public class HomeController : Controller
    {
        BookStoreEntities1 dBBookStore = new BookStoreEntities1();
        // GET: Home
        public ActionResult Index()
        {
            return View(dBBookStore.SACHes.ToList());
        }
        public ActionResult Create()
        {
            SACH sach = new SACH();
            return View(sach);
        }

        public ActionResult SelectCate()
        {
            THELOAI theloai = new THELOAI();
            theloai.ListCategory = dBBookStore.THELOAIs.ToList<THELOAI>();
            return PartialView(theloai);
        }

        [HttpPost]
        public ActionResult Create(SACH sach)
        {
            try
            {
                if (sach.UploadImage != null)
                {
                    string filename = Path.GetFileNameWithoutExtension(sach.UploadImage.FileName);
                    string extent = Path.GetExtension(sach.UploadImage.FileName);
                    filename = filename + extent;
                    sach.ImageBook = "~/Content/image/" + filename;
                    sach.UploadImage.SaveAs(Path.Combine(Server.MapPath("~/Content/image/"), filename));
                }
                dBBookStore.SACHes.Add(sach);
                dBBookStore.SaveChanges();
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}