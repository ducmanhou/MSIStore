using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL;
using DTO;
namespace BLL
{
    public class OrderItemsBL
    {
        private OrderItemsDL orderItemsDL;

        public OrderItemsBL()
        {
            orderItemsDL = new OrderItemsDL();
        }

        public List<OrderItems> GetOrderItems()
        {
            try
            {
                return orderItemsDL.GetOrderItems();
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }

        public int Add(OrderItems orderItem)
        {
            try
            {
                return orderItemsDL.Add(orderItem);
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }
        public decimal GetTotalAmountFromDb()
        {
            try
            {
                return orderItemsDL.GetTotalAmountFromDb();
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }
        public List<BestSellingProduct> GetAllSoldProducts()
        {
            return orderItemsDL.GetAllSoldProducts();
        }

    }
}