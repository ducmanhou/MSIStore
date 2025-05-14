using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class Feedback
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public int OrderId { get; set; }
        public string Comment { get; set; }

        public DateTime CreatedAt { get; set; }

        public Feedback(int id, int userId, int orderId, string comment, DateTime createdAt)
        {
            Id = id;
            UserId = userId;
            OrderId = orderId;
            Comment = comment;
            CreatedAt = createdAt;
        }
    }
}
