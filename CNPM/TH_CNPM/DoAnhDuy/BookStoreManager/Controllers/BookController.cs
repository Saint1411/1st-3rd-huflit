using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using BookStoreManager.Models;
using PagedList;
using PagedList.Mvc;

namespace BookStoreManager.Controllers
{
    public class BookController : Controller
    {
        private BookStoreEntities db = new BookStoreEntities();

        //GET: Book
        public ActionResult Index(string category, double min = double.MinValue, double max = double.MaxValue)
        {
            //int pageSize = 4;
            //int numPage = (page ?? 1);
            //if (category == null)
            //{
            //    var listBook = db.SACHes.OrderByDescending(x => x.TenSach);
            //    return View(listBook.ToPagedList(numPage, pageSize));
            //}
            //else
            //{
            //    //var listBook = db.SACHes.Where(s => s.TenSach.Contains(category));
            //    //var listBook = db.SACHes.OrderByDescending(x => x.TenSach).Where(p => p.Catelogy == category);
            //    return View(db.SACHes.Where(s => s.TenSach.Contains(category)).ToList());
            //}
            if (category == null)
                return View(db.SACHes.ToList());
            else
                return View(db.SACHes.Where(s => s.TenSach.Contains(category) | s.TacGia.Contains(category) | s.THELOAI.NameCate.Contains(category)).ToList());
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

        // GET: Book/Create
        public ActionResult Create()
        {
            ViewBag.Catelogy = new SelectList(db.THELOAIs, "IDCate", "NameCate");
            return View();
        }

        // POST: Book/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "MaSach,TenSach,Catelogy,TacGia,SoLuongTon,Price,ImageBook")] SACH sACH)
        {
            if (ModelState.IsValid)
            {
                db.SACHes.Add(sACH);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.Catelogy = new SelectList(db.THELOAIs, "IDCate", "NameCate", sACH.Catelogy);
            return View(sACH);
        }

        //[HttpPost]
        //[ValidateAntiForgeryToken]
        //[ValidateInput(false)]
        //public ActionResult Create([Bind(Include = "MaSach,TenSach,Catelogy,TacGia,SoLuongTon,Price,ImageBook")] SACH sach, HttpPostedFileBase ImageBook)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        try
        //        {
        //            if (ImageBook.ContentLength > 0)
        //            {
        //                string _FileName = Path.GetFileName(ImageBook.FileName);
        //                string _path = Path.Combine(Server.MapPath("~Public/image"), _FileName);
        //                ImageBook.SaveAs(_path);
        //                sach.ImageBook = _FileName;

        //            }
        //            db.SACHes.Add(sach);
        //            db.SaveChanges();
        //            return RedirectToAction("Index");
        //        }
        //        catch
        //        {
        //            ViewBag.Message = "không thành công!!";
        //        }

        //    }

        //    ViewBag.Catelogy = new SelectList(db.THELOAIs, "IDCate", "NameCate", sach.Catelogy);
        //    return View(sach);
        //}


        //public ActionResult SelectCate()
        //{
        //    THELOAI theloai = new THELOAI();
        //    theloai.ListCate = db.THELOAIs.ToList<THELOAI>();
        //    return PartialView(theloai);
        //}
        //[HttpPost]
        //public ActionResult Create(SACH sach)
        //{
        //    try
        //    {
        //        if (sach.UploadImage != null)
        //        {
        //            string filename = Path.GetFileNameWithoutExtension(sach.UploadImage.FileName);
        //            string extent = Path.GetExtension(sach.UploadImage.FileName);
        //            filename = filename + extent;
        //            sach.ImageBook = "~/Public/image/" + filename;
        //            sach.UploadImage.SaveAs(Path.Combine(Server.MapPath("~/Public/image/"), filename));
        //        }
        //        db.SACHes.Add(sach);
        //        db.SaveChanges();
        //        return RedirectToAction("Index");
        //    }
        //    catch
        //    {
        //        return View();
        //    }
        //}

        // GET: Book/Edit/5
        public ActionResult Edit(int? id)
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
            ViewBag.Catelogy = new SelectList(db.THELOAIs, "IDCate", "NameCate", sACH.Catelogy);
            return View(sACH);
        }

        // POST: Book/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "MaSach,TenSach,Catelogy,TacGia,SoLuongTon,Price,ImageBook")] SACH sACH)
        {
            if (ModelState.IsValid)
            {
                db.Entry(sACH).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.Catelogy = new SelectList(db.THELOAIs, "IDCate", "NameCate", sACH.Catelogy);
            return View(sACH);
        }

        // GET: Book/Delete/5
        public ActionResult Delete(int? id)
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

        // POST: Book/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            try
            {
                SACH sACH = db.SACHes.Find(id);
                db.SACHes.Remove(sACH);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            catch
            {
                return Content("Xóa thất bại, vi phạm ràng buộc: mã sách tồn tại trong bảng hóa đơn");
            }
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        //Timf kiem
        public ActionResult SearchOption(double min= double.MinValue, double max = double.MaxValue)
        {
            var list = db.SACHes.Where(p => (double)p.Price >= min && (double)p.Price <= max).ToList();
            return View(list);
        }

        //[HttpPost]
        //public ActionResult Index(string searchString)
        //{
        //    if (searchString==null)
        //    {
        //        return View(db.SACHes.ToList());
        //    }

        //    return View(db.SACHes.Where(s=>s.TenSach.Contains(searchString)).ToList());
        //}
    }
}
