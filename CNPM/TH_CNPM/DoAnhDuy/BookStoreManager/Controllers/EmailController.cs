using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Helpers;


namespace BookStoreManager.Controllers
{
    public class EmailController : Controller
    {
        // GET: Email
        public ActionResult SendEmail()
        {
            return View();
        }
            [HttpPost]
        public ActionResult SendEmail(string usermail)
        {
            string subject = "Bookstore";
            string body = "Đơn hàng của bạn đã được thanh toán...cảm ơn đã mua hàng";
            WebMail.Send(usermail, subject, body, null, null, null, true, null, null, null, null, null, null);
            ViewBag.msg = "Email sent Successfully...";
            return View();
        }
    }
}