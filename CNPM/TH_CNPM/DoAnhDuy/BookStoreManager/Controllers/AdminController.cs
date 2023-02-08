using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Mvc;
using BookStoreManager.Models;

namespace BookStoreManager.Controllers
{
    public class AdminController : Controller
    {
        private BookStoreEntities db = new BookStoreEntities();

        // GET: Admin
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult LoginAccount(ADMINUSER _user)
        {
            var f_password = GetMD5(_user.PasswordUser);
            var check = db.ADMINUSERs.Where(s => s.NameUser == _user.NameUser && s.PasswordUser == f_password).FirstOrDefault();
            if (check == null) //login sai thông tin
            {
                ViewBag.ErroInfor = "Login Failed";
                return View("Index");
            }
            else
            {
                db.Configuration.ValidateOnSaveEnabled = false;
                Session["NameUser"] = _user.NameUser;
                Session["PasswordUser"] = _user.PasswordUser;
                if(_user.NameUser=="Admin")
                    return RedirectToAction("Index", "Book");
                else
                {
                    return RedirectToAction("Index", "Customer");
                }
                //if (_user.ID == 5)
                //{
                //    db.Configuration.ValidateOnSaveEnabled = false;
                //    Session["NameUser"] = _user.NameUser;
                //    Session["PasswordUser"] = _user.PasswordUser;
                //    return RedirectToAction("Index", "Book");
                //}
                //else
                //{
                //    db.Configuration.ValidateOnSaveEnabled = false;
                //    Session["NameUser"] = _user.NameUser;
                //    Session["PasswordUser"] = _user.PasswordUser;
                //    return RedirectToAction("Index", "Customer");
                //}
            }
        }

        [HttpGet]
        public ActionResult RegisterUser()
        {
            return View();
        }

        [HttpPost]
        public ActionResult RegisterUser(ADMINUSER user)
        {
            if (ModelState.IsValid)
            {
                var checkId = db.ADMINUSERs.FirstOrDefault(s => s.ID == user.ID);
                if (checkId == null)
                {
                    user.PasswordUser = GetMD5(user.PasswordUser);
                    db.Configuration.ValidateOnSaveEnabled = false;
                    db.ADMINUSERs.Add(user);
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
                else
                {
                    ViewBag.ErrorRegister = "*ID is exists";
                    return View();
                }

            }
            return View();
        }
        public ActionResult Logout()
        {
            Session.Clear();//remove session
            return RedirectToAction("Index");
        }

        //create a string MD5
        public static string GetMD5(string str)
        {
            MD5 md5 = new MD5CryptoServiceProvider();
            byte[] fromData = Encoding.UTF8.GetBytes(str);
            byte[] targetData = md5.ComputeHash(fromData);
            string byte2String = null;

            for (int i = 0; i < targetData.Length; i++)
            {
                byte2String += targetData[i].ToString("x2");

            }
            return byte2String;
        }
    }
}
