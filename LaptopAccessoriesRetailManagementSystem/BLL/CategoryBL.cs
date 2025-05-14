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
    public class CategoryBL
    {
        private CategoryDL cateDL;
        public CategoryBL()
        {
            cateDL = new CategoryDL();
        }
        public List<Category> GetCategorys()
        {
            try
            {
                return cateDL.GetCategorys();
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }
    }
}
