//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace QuanLyQuanAn.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class CHITIETHOADONBAN
    {
        public string MACTHDB { get; set; }
        public string MAHDBAN { get; set; }
        public string MASP { get; set; }
        public Nullable<int> SLBAN { get; set; }
        public Nullable<double> THANHTIEN { get; set; }
    
        public virtual HOADONBAN HOADONBAN { get; set; }
        public virtual SANPHAM SANPHAM { get; set; }
    }
}
