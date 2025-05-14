using DAL;
using DTO;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class UserBL
    {

        private UserDL userDL;

        public UserBL()
        {
            userDL = new UserDL();
        }

        public List<Account> GetAccounts()
        {
            try
            {
                return userDL.GetAccounts();
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }

        public List<Account> GetAccounts_ID()
        {
            try
            {
                return userDL.GetAccounts_ID();
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }
        public int Add(Account account)
        {
            try
            {
                return userDL.Add(account);
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }
        public int Delete(string username)
        {
            try
            {
                return userDL.Delete(username); 
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }
        public int CountAccounts()
        {
            try
            {
                return userDL.CountAccounts();
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }
        public int Update(Account account)
        {
            try
            {
                return userDL.Update(account);
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }


    }
}