using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using BookStoreManager.Models;

namespace BookStoreManager.Controllers
{
    public class BillDetailController : Controller
    {
        private BookStoreEntities db = new BookStoreEntities();

        // GET: BillDetail
        public ActionResult Index()
        {
            var cHITTIETDATSACHes = db.CHITTIETDATSACHes.Include(c => c.SACH).Include(c => c.DATSACH);
            return View(cHITTIETDATSACHes.ToList());
        }

        // GET: BillDetail/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            CHITTIETDATSACH cHITTIETDATSACH = db.CHITTIETDATSACHes.Find(id);
            if (cHITTIETDATSACH == null)
            {
                return HttpNotFound();
            }
            return View(cHITTIETDATSACH);
        }

        // GET: BillDetail/Create
        public ActionResult Create()
        {
            ViewBag.MaSach = new SelectList(db.SACHes, "MaSach", "TenSach");
            ViewBag.MADATSACH = new SelectList(db.DATSACHes, "MaDatSach", "MaDatSach");
            return View();
        }

        // POST: BillDetail/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "MaChiTietDatSach,MaSach,Soluong,UnitPrice,MADATSACH")] CHITTIETDATSACH cHITTIETDATSACH)
        {
            if (ModelState.IsValid)
            {
                db.CHITTIETDATSACHes.Add(cHITTIETDATSACH);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.MaSach = new SelectList(db.SACHes, "MaSach", "TenSach", cHITTIETDATSACH.MaSach);
            ViewBag.MADATSACH = new SelectList(db.DATSACHes, "MaDatSach", "MaDatSach", cHITTIETDATSACH.MADATSACH);
            return View(cHITTIETDATSACH);
        }

        // GET: BillDetail/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            CHITTIETDATSACH cHITTIETDATSACH = db.CHITTIETDATSACHes.Find(id);
            if (cHITTIETDATSACH == null)
            {
                return HttpNotFound();
            }
            ViewBag.MaSach = new SelectList(db.SACHes, "MaSach", "TenSach", cHITTIETDATSACH.MaSach);
            ViewBag.MADATSACH = new SelectList(db.DATSACHes, "MaDatSach", "DiaChiGiaoHang", cHITTIETDATSACH.MADATSACH);
            return View(cHITTIETDATSACH);
        }

        // POST: BillDetail/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "MaChiTietDatSach,MaSach,Soluong,UnitPrice,MADATSACH")] CHITTIETDATSACH cHITTIETDATSACH)
        {
            if (ModelState.IsValid)
            {
                db.Entry(cHITTIETDATSACH).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.MaSach = new SelectList(db.SACHes, "MaSach", "TenSach", cHITTIETDATSACH.MaSach);
            ViewBag.MADATSACH = new SelectList(db.DATSACHes, "MaDatSach", "DiaChiGiaoHang", cHITTIETDATSACH.MADATSACH);
            return View(cHITTIETDATSACH);
        }

        // GET: BillDetail/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            CHITTIETDATSACH cHITTIETDATSACH = db.CHITTIETDATSACHes.Find(id);
            if (cHITTIETDATSACH == null)
            {
                return HttpNotFound();
            }
            return View(cHITTIETDATSACH);
        }

        // POST: BillDetail/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            CHITTIETDATSACH cHITTIETDATSACH = db.CHITTIETDATSACHes.Find(id);
            db.CHITTIETDATSACHes.Remove(cHITTIETDATSACH);
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
