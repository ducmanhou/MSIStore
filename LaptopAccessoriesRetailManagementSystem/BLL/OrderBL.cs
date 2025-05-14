using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL;
using DTO;
using System.Data;
using System.Data.SqlClient;

namespace BLL
{
    public class OrderBL
    {
        private OrderDL orderDL;
        public OrderBL()
        {
            orderDL = new OrderDL();
        }
        public List<Order> GetOrders()
        {
            try
            {
                return orderDL.GetOrders();
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }

        public int Add(Order order)
        {
            try
            {
                return orderDL.Add(order);
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }
        public int CountOrders()
        {
            try
            {
                return orderDL.GetOrders().Count();
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }
    }
}
