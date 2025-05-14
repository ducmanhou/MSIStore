using DAL;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DTO;

namespace BLL
{
    public class ProductBL
    {
        private ProductDL productDL;
        public ProductBL()
        {
            productDL = new ProductDL();
        }
        public List<Product> GetProducts()
        {
            try
            {
                return productDL.GetProducts();
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }
        public int Add(Product product)
        {
            try
            {
                return productDL.Add(product);
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }
        public int Delete(int id)
        {
            try
            {
                return productDL.Delete(id);
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }
        public List<Product> SearchProductsByName(string keyword)
        {
            return productDL.SearchByName(keyword);
        }
        public int Update(Product product)
        {
            try
            {
                return productDL.Update(product);
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }
        public int CountProducts()
        {
            try
            {
                return productDL.GetProducts().Count;
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }
    }
}
