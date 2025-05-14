using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DTO;
using DAL;
using System.Data.SqlClient;
using System.Data;
using System.Net.Http.Headers;
namespace DAL
{
    public class ProductDL : DataAccess

    {
        public List<Product> GetProducts()
        {
            string sql = "SELECT * FROM msistoredb.[product]";
            string name, description, detail;
            int oldprice,newprice, id, CateId, BrandId;
            List<Product> products = new List<Product>();
            try
            {
                Connect();
                SqlDataReader reader = MyExecuteReader(sql, CommandType.Text);
                while (reader.Read())
                {
                    id = int.Parse(reader["id"].ToString());
                    name = reader["Name"].ToString();
                    description = reader["Description"].ToString();
                    detail = reader["Detail"].ToString();
                    oldprice = Convert.ToInt32(reader["Oldprice"]);
                    newprice = Convert.ToInt32(reader["Newprice"]);
                    CateId = int.Parse(reader["CategoryId"].ToString());
                    BrandId = int.Parse(reader["brand_id"].ToString());
                    Product product = new Product(id, name, description, detail, oldprice, newprice, CateId, BrandId);
                    products.Add(product);

                }
                reader.Close();
                return products;
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

        public int Add(Product product)
        {
            string sql = "uspAddProduct";
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@Name", product.Name));
            parameters.Add(new SqlParameter("@Description", product.Description));
            parameters.Add(new SqlParameter("@Detail", product.Detail));
            parameters.Add(new SqlParameter("@PldPrice", product.OldPrice));
            parameters.Add(new SqlParameter("@NewPrice", product.NewPrice));
            parameters.Add(new SqlParameter("@CategoryId", product.CateId));
            parameters.Add(new SqlParameter("@Brand_id", product.BrandId));

            try
            {
                return MyExcuteNonQuery(sql, CommandType.StoredProcedure, parameters);
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }

        public int Update(Product product)
        {
            string sql = "uspUpdateProduct";
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@id", product.Id));
            parameters.Add(new SqlParameter("@Name", product.Name));
            parameters.Add(new SqlParameter("@Description", product.Description));
            parameters.Add(new SqlParameter("@Detail", product.Detail));
            parameters.Add(new SqlParameter("@PldPrice", product.OldPrice));
            parameters.Add(new SqlParameter("@NewPrice", product.NewPrice));
            parameters.Add(new SqlParameter("@CategoryId", product.CateId));
            parameters.Add(new SqlParameter("@Brand_id", product.BrandId));

            Connect();
            int result = MyExcuteNonQuery(sql, CommandType.StoredProcedure, parameters);
            DisConnect();
            return result;
        }


        public int Delete(int id)
        {
            string sql = "uspDeleteProduct";
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@id", id));
            Connect();
            int result = MyExcuteNonQuery(sql, CommandType.StoredProcedure, parameters);
            DisConnect();
            return result;

        }
        public List<Product> SearchByName(string keyword)
        {
            string sql = "SELECT * FROM msistoredb.[product] WHERE Name LIKE @keyword";
            List<Product> products = new List<Product>();

            try
            {
                Connect();
                SqlCommand cmd = new SqlCommand(sql, cn); 
                cmd.Parameters.AddWithValue("@keyword", "%" + keyword + "%");

                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    int id = int.Parse(reader["id"].ToString());
                    string name = reader["Name"].ToString();
                    string description = reader["Description"].ToString();
                    string detail = reader["Detail"].ToString();
                    int oldprice = Convert.ToInt32(reader["Oldprice"]);
                    int newprice = Convert.ToInt32(reader["Newprice"]);
                    int CateId = int.Parse(reader["CategoryId"].ToString());
                    int BrandId = int.Parse(reader["brand_id"].ToString());

                    Product product = new Product(id, name, description, detail, oldprice, newprice, CateId, BrandId);
                    products.Add(product);
                }
                reader.Close();
                return products;
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