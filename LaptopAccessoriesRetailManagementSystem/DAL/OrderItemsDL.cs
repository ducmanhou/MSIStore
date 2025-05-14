using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DTO;

namespace DAL
{
    public class OrderItemsDL : DataAccess
    {
        public List<OrderItems> GetOrderItems()
        {
            string sql = "SELECT * FROM msistoredb.[orderitem]";
            List<OrderItems> orderItemsList = new List<OrderItems>();
            try
            {
                Connect();
                SqlDataReader reader = MyExecuteReader(sql, CommandType.Text);
                while (reader.Read())
                {
                    int id = int.Parse(reader[0].ToString());
                    int quantity = Convert.ToInt32(reader[1]);
                    int OrderId = int.Parse(reader[2].ToString());
                    int ProductId = int.Parse(reader[3].ToString());
                    int unitPrice = Convert.ToInt32(reader[4]);

                    OrderItems orderItem = new OrderItems(id, quantity, OrderId, ProductId, unitPrice);
                    orderItemsList.Add(orderItem);
                }
                reader.Close();
                return orderItemsList;
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            finally
            {
                DisConnect();
            }
        }

        public int Add(OrderItems orderItem)
        {
            string sql = "uspAddOrderItem";
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@Quantity", orderItem.Quatity));
            parameters.Add(new SqlParameter("OrderId", orderItem.OrderId));
            parameters.Add(new SqlParameter("@ProductId", orderItem.ProductId));
            parameters.Add(new SqlParameter("@UnitPrice", orderItem.UnitPrice));

            try
            {
                return MyExcuteNonQuery(sql, CommandType.StoredProcedure, parameters);
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }
        public decimal GetTotalAmountFromDb()
        {
            string sql = "SELECT SUM(Quantity * UnitPrice) FROM msistoredb.[orderitem]";
            try
            {
                object result = MyExecuteScalar(sql, CommandType.Text);
                return (result != DBNull.Value) ? Convert.ToDecimal(result) : 0;
            }
            catch (SqlException ex)
            {
                throw;
            }
        }
        public List<BestSellingProduct> GetAllSoldProducts()
        {
            string sql = @"
        SELECT 
            p.id AS ProductId, 
            p.Name AS ProductName, 
            SUM(oi.Quantity) AS TotalSold
        FROM msistoredb.orderitem oi
        JOIN msistoredb.product p ON oi.ProductId = p.id
        GROUP BY p.id, p.Name
        ORDER BY p.Name";

            List<BestSellingProduct> result = new List<BestSellingProduct>();
            try
            {
                Connect();
                SqlDataReader reader = MyExecuteReader(sql, CommandType.Text);
                while (reader.Read())
                {
                    int productId = Convert.ToInt32(reader["ProductId"]);
                    string productName = reader["ProductName"].ToString();
                    int totalSold = Convert.ToInt32(reader["TotalSold"]);

                    result.Add(new BestSellingProduct(productId, productName, totalSold));
                }
                reader.Close();
                return result;
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            finally
            {
                DisConnect();
            }
        }
      
    }    

}