using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BookStoreManager.Models
{
    public class CartItem
    {
        public SACH sach { get; set; }
        public int quantity { get; set; }

    }
    public class Cart
    {
        List<CartItem> items = new List<CartItem>();
        public IEnumerable<CartItem> Items
        {
            get { return items; }
        }

        public void AddbookToCart(SACH _sach, int _quantity = 1)
        {
            var item = Items.FirstOrDefault(s => s.sach.MaSach == _sach.MaSach);
            if (item == null)
                items.Add(new CartItem
                {
                    sach = _sach,
                    quantity = _quantity
                });
            else item.quantity += _quantity; /// Tổng số trọng lượng trong giỏ được cộng đồn
        }

        //Tổng số lượng trong giỏ hàng
        public int TotalQuantity()
        {
            return items.Sum(s => s.quantity);
        }

        //Tính tổng tiền cho mỗi dòng sản phẩm
        public decimal TotalMoney()
        {
            var total = items.Sum(s => s.quantity * s.sach.Price);
            return (decimal)total;
        }

        //Cập nhật lại quantity khi tăng hoặc giảm số lượng
        public void UpdateQuantity(int id, int newQuantity)
        {
            var item = items.Find(s => s.sach.MaSach == id);
            if (item != null)
            {
                if (items.Find(s => s.sach.SoLuongTon > newQuantity) != null) // nếu số lượng mua nhỏ hơn sl tồn
                    item.quantity = newQuantity; // chấp nhận sl mua
                else
                    item.quantity = 1; // ngược lại sl mua trả về 1
            }    
        }

        //Remove item in cart
        public void RemoveCartItem(int id)
        {
            items.RemoveAll(s => s.sach.MaSach == id);
        }
        //clear cart
        public void ClearCart()
        {
            items.Clear();
        }
    }


}