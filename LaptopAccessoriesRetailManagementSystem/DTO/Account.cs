using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class Account
    {
        public int Id { get; set; }

        public string Username { get; set; }
        public string Password { get; set; }

        public Account(string username, string password)
        {
            Username = username;
            Password = password;
        }

        public Account(int id, string username, string password)
        {
            Id = id;
            Username = username;
            Password = password;
        }
    }
}
