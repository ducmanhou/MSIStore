using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using DTO;
using DAL;

namespace DAL
{
    public class UserDL : DataAccess
    {
        public List<Account> GetAccounts()
        {
            string sql = "SELECT * FROM msistoredb.[user]";
            string username, password;
            List<Account> accounts = new List<Account>();

            try
            {
                Connect();
                SqlDataReader reader = MyExecuteReader(sql, CommandType.Text);

                while (reader.Read())
                {
                    username = reader["Username"].ToString();
                    password = reader["Password"].ToString();

                    Account acc = new Account(username, password);
                    accounts.Add(acc);
                }

                reader.Close();
                return accounts;
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

        public List<Account> GetAccounts_ID()
        {
            string sql = "SELECT * FROM msistoredb.[user]";
            string username, password;
            int id;
            List<Account> accounts = new List<Account>();

            try
            {
                Connect();
                SqlDataReader reader = MyExecuteReader(sql, CommandType.Text);

                while (reader.Read())
                {
                    id = int.Parse(reader[0].ToString());
                    username = reader["Username"].ToString();
                    password = reader["Password"].ToString();

                    Account acc = new Account(id, username, password);
                    accounts.Add(acc);
                }

                reader.Close();
                return accounts;
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


        public int Add(Account account)
        {
            string sql = "INSERT INTO msistoredb.[user](Username, Password) VALUES('"+account.Username+"','"+account.Password+"')";
            try
            {
                return MyExcuteNonQuery(sql, CommandType.Text);
            }
            catch (SqlException ex) { throw ex; }
        }
        public int Delete(string username)
        {
            string sql = "DELETE FROM msistoredb.[user] WHERE Username = '" + username + "'";
            try
            {
                return MyExcuteNonQuery(sql, CommandType.Text);
            }
            catch (SqlException ex) { throw ex; }
        }
        public int CountAccounts()
        {
            string sql = "SELECT COUNT(*) FROM msistoredb.[user]";
            try
            {
                Connect();
                object result = MyExecuteScalar(sql, CommandType.Text);
                return Convert.ToInt32(result);
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
        public int Update(Account account)
        {
            string sql = "UPDATE msistoredb.[user] SET Password = '" + account.Password + "' WHERE Username = '" + account.Username + "'";
            try
            {
                return MyExcuteNonQuery(sql, CommandType.Text);
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }
    }
}