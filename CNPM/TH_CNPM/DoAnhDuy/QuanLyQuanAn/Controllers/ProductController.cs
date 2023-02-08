using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using QuanLyQuanAn.Models;

namespace QuanLyQuanAn.Controllers
{
    public class ProductController : Controller
    {
        private QuanLyQuanAnEntities db = new QuanLyQuanAnEntities();

        // GET: Product
        public ActionResult Index()
        {
            var sANPHAMs = db.SANPHAMs.Include(s => s.LOAISANPHAM);
            return View(sANPHAMs.ToList());
        }

        // GET: Product/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SANPHAM sANPHAM = db.SANPHAMs.Find(id);
            if (sANPHAM == null)
            {
                return HttpNotFound();
            }
            return View(sANPHAM);
        }

        // GET: Product/Create
        public ActionResult Create()
        {
            ViewBag.LOAISP = new SelectList(db.LOAISANPHAMs, "MALOAI", "TENLOAI");
            return View();
        }

        // POST: Product/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "MASP,TENSP,LOAISP,DONGIA,hinhanh")] SANPHAM sANPHAM)
        {
            if (ModelState.IsValid)
            {
                sANPHAM.MASP = "";
                db.SANPHAMs.Add(sANPHAM);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.LOAISP = new SelectList(db.LOAISANPHAMs, "MALOAI", "TENLOAI", sANPHAM.LOAISP);
            return View(sANPHAM);
        }

        // GET: Product/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SANPHAM sANPHAM = db.SANPHAMs.Find(id);
            if (sANPHAM == null)
            {
                return HttpNotFound();
            }
            ViewBag.LOAISP = new SelectList(db.LOAISANPHAMs, "MALOAI", "TENLOAI", sANPHAM.LOAISP);
            return View(sANPHAM);
        }

        // POST: Product/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "MASP,TENSP,LOAISP,DONGIA")] SANPHAM sANPHAM)
        {
            if (ModelState.IsValid)
            {
                db.Entry(sANPHAM).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.LOAISP = new SelectList(db.LOAISANPHAMs, "MALOAI", "TENLOAI", sANPHAM.LOAISP);
            return View(sANPHAM);
        }

        // GET: Product/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SANPHAM sANPHAM = db.SANPHAMs.Find(id);
            if (sANPHAM == null)
            {
                return HttpNotFound();
            }
            return View(sANPHAM);
        }

        // POST: Product/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            SANPHAM sANPHAM = db.SANPHAMs.Find(id);
            db.SANPHAMs.Remove(sANPHAM);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
