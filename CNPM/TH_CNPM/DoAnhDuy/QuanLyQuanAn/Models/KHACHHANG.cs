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
    
    public partial class KHACHHANG
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public KHACHHANG()
        {
            this.HOADONBANs = new HashSet<HOADONBAN>();
        }
    
        public string MAKH { get; set; }
        public string HOTEN { get; set; }
        public Nullable<System.DateTime> NAMSINH { get; set; }
        public string SDT { get; set; }
        public string DIACHI { get; set; }
        public string EMAIL { get; set; }
        public Nullable<int> SLDONDAMUA { get; set; }
        public string LOAIKH { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<HOADONBAN> HOADONBANs { get; set; }
    }
}