//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace BookStore.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class DATSACH
    {
        public int MaDatSach { get; set; }
        public Nullable<System.DateTime> NgayDat { get; set; }
        public Nullable<int> MaKhachHang { get; set; }
    
        public virtual KHACHHANG KHACHHANG { get; set; }
    }
}
