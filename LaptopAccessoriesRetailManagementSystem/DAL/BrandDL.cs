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
    public class BrandDL:DataAccess
    {
        public List<Brand> GetBrands()
        {
            string sql = "SELECT * FROM msistoredb.[brand]";
            string name;
            int id;
            List<Brand> brands = new List<Brand>();
            try
            {
                Connect();
                SqlDataReader reader = MyExecuteReader(sql, CommandType.Text);
                while (reader.Read())
                {
                    id = int.Parse(reader["id"].ToString());
                    name = reader["Name"].ToString();
                    Brand brand = new Brand(id, name);
                    brands.Add(brand);

                }
                reader.Close();
                return brands;
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
