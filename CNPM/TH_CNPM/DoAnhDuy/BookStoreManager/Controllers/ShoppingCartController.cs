using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;
using BookStoreManager.Models;

namespace BookStoreManager.Controllers
{
    public class ShoppingCartController : Controller
    {
        BookStoreEntities db = new BookStoreEntities();
        // GET: ShoppingCart
        public ActionResult ShowCart()
        {
            if (Session["Cart"] == null)
                return View("EmptyCart");
            Cart cart = Session["Cart"] as Cart;
            return View(cart);
        }

        //Action tạo mới giỏ hàng
        public Cart GetCart()
        {
            Cart cart = Session["Cart"] as Cart;
            if(cart==null || Session["Cart"] == null)
            {
                cart = new Cart();
                Session["Cart"] = cart;
            }
            return cart;
        }

        //Action thêm sách vào giỏ hàng
        public ActionResult AddToCart(int id)
        {
            var sach = db.SACHes.SingleOrDefault(s => s.MaSach == id); //lấy sách theo id
            if (sach != null)
            {
                GetCart().AddbookToCart(sach);
            }
            return RedirectToAction("ShowCart", "ShoppingCart");
        }

        //Cập nhật lại quantity rồi tính lại total
        public ActionResult UpdateCartQuantity (FormCollection form)
        {
            Cart cart = Session["Cart"] as Cart;
            int _idSach = int.Parse(form["maSach"]);
            int _quantity = int.Parse(form["cartQuantity"]);
            cart.UpdateQuantity(_idSach, _quantity);
            return RedirectToAction("ShowCart", "ShoppingCart");
        }

        //Remove item in cart
        public ActionResult RemoveItemInCart(int id)
        {
            Cart cart = Session["Cart"] as Cart;
            cart.RemoveCartItem(id);
            return RedirectToAction("ShowCart", "ShoppingCart");
        }

        public PartialViewResult BagCart()
        {
            int total_quantity_item = 0;
            Cart cart = Session["Cart"] as Cart;
            if (cart != null)
            {
                total_quantity_item = cart.TotalQuantity();
                
            }
            ViewBag.QuantityCart = total_quantity_item;
            return PartialView("BagCart");
        }

        //Đặt hàng và chi tiết đặt hàng
        public ActionResult CheckOut(FormCollection formCollection)
        {
            try
            {
                Cart cart = Session["Cart"] as Cart;
                DATSACH datsach = new DATSACH(); // bảng hóa đơn sản phẩm
                datsach.NgayDat = DateTime.Now;
                datsach.DiaChiGiaoHang = formCollection["AddressDelivery"];
                datsach.MaKhachHang = int.Parse(formCollection["CodeCustomer"]);
                db.DATSACHes.Add(datsach);
                foreach(var item in cart.Items)
                {
                    CHITTIETDATSACH bookdetail = new CHITTIETDATSACH(); // lưu sách vào chi tiết hóa đơn
                    bookdetail.MADATSACH = datsach.MaDatSach;
                    bookdetail.MaSach = item.sach.MaSach;
                    bookdetail.UnitPrice = (double)item.sach.Price;
                    bookdetail.Soluong = item.quantity;
                    db.CHITTIETDATSACHes.Add(bookdetail);
                    // xu ly cap nhat lai sl ton trong danh sach sach
                    foreach (var p in db.SACHes.Where(s=>s.MaSach==bookdetail.MaSach))
                    {
                        if (p.SoLuongTon > 0)
                        {
                            var update_quantity_book = p.SoLuongTon - item.quantity; // so luong moi = sl cu - sl mua
                            p.SoLuongTon = update_quantity_book; // cap nhat lai sl ton
                        }
                        else 
                            return Content(p.TenSach + " đã hết" +", số lượng sách còn lại: " + p.SoLuongTon);
                    }
                }
                db.SaveChanges();
                cart.ClearCart();
                return RedirectToAction("CheckOutSuccess", "ShoppingCart");
            }
            catch
            {
                return Content("Error checkout. Please check infomation of customer...thanks.");
            }
        }


        //Trang checkout cusscessfully
        public ActionResult CheckOutSuccess()
        {
            return View();
        }

        public ActionResult SendEmail()
        {
            return View();
        }
        [HttpPost]
        public ActionResult SendEmail(string userEmail)
        {
            string subject = "BookStore";
            string body = "Đơn hàng của bạn đã được nhận thành công!";
            WebMail.Send(userEmail, subject, body, null, null, null, true, null, null, null, null, null, null);
            ViewBag.msg = "Email sent successfully!";
            return Content("Send to mail {0} successfully",userEmail);
        }
    }
}