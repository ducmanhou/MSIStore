using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class OrderItems
    {
        public int Id { get; set; }
        public int Quatity {  get; set; }
        public int OrderId {  get; set; }
        public int ProductId { get; set; }
        public int UnitPrice {  get; set; }

        public OrderItems(int quatity, int orderId, int productId, int unitPrice)
        {
            Quatity = quatity;
            OrderId = orderId;
            ProductId = productId;
            UnitPrice = unitPrice;
        }

        public OrderItems(int id, int quatity, int orderId, int productId, int unitPrice)
        {
            Id = id;
            Quatity = quatity;
            OrderId = orderId;
            ProductId = productId;
            UnitPrice = unitPrice;
        }
    }
}
