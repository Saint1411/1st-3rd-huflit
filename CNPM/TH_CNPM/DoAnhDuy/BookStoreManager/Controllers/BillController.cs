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
    public class BillController : Controller
    {
        private BookStoreEntities db = new BookStoreEntities();

        // GET: Bill
        public ActionResult Index()
        {
            var dATSACHes = db.DATSACHes.Include(d => d.KHACHHANG);
            return View(dATSACHes.ToList());
        }

        // GET: Bill/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DATSACH dATSACH = db.DATSACHes.Find(id);
            if (dATSACH == null)
            {
                return HttpNotFound();
            }
            return View(dATSACH);
        }

        // GET: Bill/Create
        public ActionResult Create()
        {
            ViewBag.MaKhachHang = new SelectList(db.KHACHHANGs, "MaKhachHang", "HoTen");
            return View();
        }

        // POST: Bill/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "MaDatSach,NgayDat,MaKhachHang,DiaChiGiaoHang")] DATSACH dATSACH)
        {
            if (ModelState.IsValid)
            {
                db.DATSACHes.Add(dATSACH);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.MaKhachHang = new SelectList(db.KHACHHANGs, "MaKhachHang", "HoTen", dATSACH.MaKhachHang);
            return View(dATSACH);
        }

        // GET: Bill/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DATSACH dATSACH = db.DATSACHes.Find(id);
            if (dATSACH == null)
            {
                return HttpNotFound();
            }
            ViewBag.MaKhachHang = new SelectList(db.KHACHHANGs, "MaKhachHang", "HoTen", dATSACH.MaKhachHang);
            return View(dATSACH);
        }

        // POST: Bill/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "MaDatSach,NgayDat,MaKhachHang,DiaChiGiaoHang")] DATSACH dATSACH)
        {
            if (ModelState.IsValid)
            {
                db.Entry(dATSACH).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.MaKhachHang = new SelectList(db.KHACHHANGs, "MaKhachHang", "HoTen", dATSACH.MaKhachHang);
            return View(dATSACH);
        }

        // GET: Bill/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DATSACH dATSACH = db.DATSACHes.Find(id);
            if (dATSACH == null)
            {
                return HttpNotFound();
            }
            return View(dATSACH);
        }

        // POST: Bill/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            DATSACH dATSACH = db.DATSACHes.Find(id);
            db.DATSACHes.Remove(dATSACH);
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
