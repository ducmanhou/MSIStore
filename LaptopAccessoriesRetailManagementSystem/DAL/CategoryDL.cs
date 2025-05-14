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
    public class CategoryDL:DataAccess
    {
        public List<Category> GetCategorys()
        {
            string sql = "SELECT * FROM msistoredb.[category]";
            string name;
            int id;
            List<Category> categorys = new List<Category>();
            try
            {
                Connect();
                SqlDataReader reader = MyExecuteReader(sql, CommandType.Text);
                while (reader.Read())
                {
                    id = int.Parse(reader["id"].ToString());
                    name = reader["Name"].ToString();
                    Category cate = new Category(id, name);
                    categorys.Add(cate);

                }
                reader.Close();
                return categorys;
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
