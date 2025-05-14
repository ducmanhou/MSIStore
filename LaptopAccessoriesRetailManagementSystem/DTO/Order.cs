using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class Order
    {
        public int Id { get; set; }
        public int UserId { get; set; }

        public Order(int id, int userId)
        {
            Id = id;
            UserId = userId;
        }

        public Order(int userId)
        {
            UserId = userId;
        }
    }
}
