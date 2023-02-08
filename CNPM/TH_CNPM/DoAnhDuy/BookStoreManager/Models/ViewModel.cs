using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace BookStoreManager.Models
{
    public class ViewModel
    {
        public KHACHHANG kHACHHANG { get; set; }

        public NHANVIEN nHANVIEN { get; set; }
        public SACH sach { get; set; }
        [DisplayFormat (DataFormatString ="{0:0.##0}")]
        public double ThanhTien { get; set; }

        public string nameBook { get; set; }
        public string imageBook { get; set; }
        public decimal price { get; set; }
        public int? idbook { get; set; }
        public IEnumerable<SACH> ListBook { get; set; }
        public int? Top5Quantity { get; set; }
        public int? SumQuantity { get; set; }
    }
}