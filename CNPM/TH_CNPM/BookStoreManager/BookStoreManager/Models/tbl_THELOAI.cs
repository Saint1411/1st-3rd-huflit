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
    
    public partial class tbl_THELOAI
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public tbl_THELOAI()
        {
            this.tbl_SACH = new HashSet<tbl_SACH>();
        }
    
        public int ID { get; set; }
        public string IDCate { get; set; }
        public string NameCate { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_SACH> tbl_SACH { get; set; }
    }
}
