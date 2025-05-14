using DTO;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class LoginDL:DataAccess
    {
        public bool Login(Account account)
        {
            string sql = "SELECT COUNT(Username) FROM msistoredb.[user] WHERE Username = '" + account.Username + "' AND password = '" + account.Password + "'";
            try
            {
                return ((int)MyExecuteScalar(sql, CommandType.Text) > 0);
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }
    }
}
