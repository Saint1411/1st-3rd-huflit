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
    
    public partial class tbl_SACH
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public tbl_SACH()
        {
            this.tbl_BAOCAOTONKHO = new HashSet<tbl_BAOCAOTONKHO>();
            this.tbl_ChiTietDatSach = new HashSet<tbl_ChiTietDatSach>();
            this.tbl_CHITIETHOADON = new HashSet<tbl_CHITIETHOADON>();
        }
    
        public int MaSach { get; set; }
        public string Catelogy { get; set; }
        public string TacGia { get; set; }
        public Nullable<int> SoLuongTon { get; set; }
        public Nullable<decimal> Price { get; set; }
        public string ImageBook { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_BAOCAOTONKHO> tbl_BAOCAOTONKHO { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_ChiTietDatSach> tbl_ChiTietDatSach { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_CHITIETHOADON> tbl_CHITIETHOADON { get; set; }
        public virtual tbl_THELOAI tbl_THELOAI { get; set; }
    }
}
