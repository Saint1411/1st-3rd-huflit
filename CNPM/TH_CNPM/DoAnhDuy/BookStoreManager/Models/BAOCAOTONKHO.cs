//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace BookStoreManager.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class BAOCAOTONKHO
    {
        public int MaBaoCao { get; set; }
        public Nullable<int> Thang { get; set; }
        public Nullable<int> MaSach { get; set; }
        public Nullable<int> SoLuongTonDau { get; set; }
        public Nullable<int> SoLuongTonPhatSinh { get; set; }
        public Nullable<int> SoLuongTonCuoi { get; set; }
    
        public virtual SACH SACH { get; set; }
    }
}
