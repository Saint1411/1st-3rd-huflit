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
    
    public partial class GIAOHANG
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public GIAOHANG()
        {
            this.CHITIETGIAOHANGs = new HashSet<CHITIETGIAOHANG>();
        }
    
        public string MAGH { get; set; }
        public string MAHDBAN { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<CHITIETGIAOHANG> CHITIETGIAOHANGs { get; set; }
        public virtual HOADONBAN HOADONBAN { get; set; }
    }
}
