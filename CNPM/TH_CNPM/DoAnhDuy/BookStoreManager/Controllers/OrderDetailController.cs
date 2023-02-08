using BookStoreManager.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BookStoreManager.Controllers
{
    public class OrderDetailController : Controller
    {
        // GET: OrderDetail
        BookStoreEntities db = new BookStoreEntities();
        public ActionResult GroupByTop10()
        {
            List<CHITTIETDATSACH> orderdetail = db.CHITTIETDATSACHes.ToList();
            List<SACH> booklist = db.SACHes.ToList();
            var query = from od in orderdetail
                        join p in booklist on od.MaSach equals p.MaSach into tbl
                        group od by new
                        {
                            id_book = od.MaSach,
                            name_book = od.SACH.TenSach,
                            img_book = od.SACH.ImageBook,
                            _price = od.SACH.Price
                        } into gr
                        orderby gr.Sum(s => s.Soluong) descending
                        select new ViewModel
                        {
                            idbook = gr.Key.id_book,
                            nameBook = gr.Key.name_book,
                            imageBook = gr.Key.img_book,
                            price = (decimal)gr.Key._price,
                            SumQuantity = gr.Sum(s => s.Soluong)
                        };
            return View(query.Take(10).ToList());
        }
    }
}