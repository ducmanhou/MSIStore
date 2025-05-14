using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class DataAccess
    {
        public SqlConnection cn;
        private SqlCommand cmd;

        public DataAccess()
        {
            string cnStr = "Data Source=LEGION5PRO\\SQLEXPRESS;Initial Catalog=msistoredb;Integrated Security=True;";
            this.cn = new SqlConnection(cnStr);
        }

        public void Connect()
        {
            try
            {
                if (cn != null && cn.State == ConnectionState.Closed)
                {
                    cn.Open();
                }
            }
            catch (SqlException ex)
            {

                throw ex;
            }
        }
        public void DisConnect()
        {
            try
            {
                if (cn != null && cn.State == ConnectionState.Open)
                {
                    cn.Close();
                }
            }
            catch (SqlException ex)
            {

                throw ex;
            }
        }
        public object MyExecuteScalar(string sql, CommandType type)
        {
            try
            {
                Connect();
                cmd = new SqlCommand(sql, cn);
                cmd.CommandType = type;

                return (cmd.ExecuteScalar());
            }
            catch (Exception ex)
            {

                throw ex;

            }
            finally
            {
                DisConnect();
            }
        }
        public SqlDataReader MyExecuteReader(string sql, CommandType type)
        {
            SqlCommand cmd = new SqlCommand(sql, cn);
            cmd.CommandType = type;
            try
            {
                return (cmd.ExecuteReader());
            }
            catch (SqlException ex)
            {

                throw ex;
            }
        }
        public int MyExcuteNonQuery(string sql, CommandType type, List<SqlParameter> parameters = null)
        {
            try
            {
                Connect();
                SqlCommand cmd = new SqlCommand(sql, cn);
                cmd.CommandType = type;

                if (parameters != null)
                {
                    foreach (var parameter in parameters)
                    {
                        cmd.Parameters.Add(parameter);
                    }
                }

                return cmd.ExecuteNonQuery();
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