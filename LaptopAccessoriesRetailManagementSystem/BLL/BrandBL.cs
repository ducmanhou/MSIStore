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
    public class BrandBL
    {
        private BrandDL brandDL;
        public BrandBL()
        {
            brandDL = new BrandDL();
        }
        public List<Brand> GetBrands()
        {
            try
            {
                return brandDL.GetBrands();
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }
    }
}
