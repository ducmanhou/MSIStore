using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;
using DTO;

namespace DAL
{
    public class OrderDL:DataAccess
    {
        public List<Order> GetOrders()
        {
            string sql = "SELECT * FROM msistoredb.[order]";
            int id, UserId;
            List<Order> orders = new List<Order>();
            try
            {
                Connect();
                SqlDataReader reader = MyExecuteReader(sql, CommandType.Text);
                while (reader.Read())
                {
                    id = int.Parse(reader["id"].ToString());
                    UserId = int.Parse(reader[3].ToString());
                    Order order = new Order(id, UserId);
                    orders.Add(order);

                }
                reader.Close();
                return orders;
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

        public int Add(Order order)
        {
            string sql = "uspAddOrder";
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@UserId", order.UserId));

            try
            {
                return MyExcuteNonQuery(sql, CommandType.StoredProcedure, parameters);
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }
    }
}
