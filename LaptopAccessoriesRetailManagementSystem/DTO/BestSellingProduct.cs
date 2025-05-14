using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class BestSellingProduct
    {
        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public int TotalSold { get; set; }

        public BestSellingProduct(int productId, string productName, int totalSold)
        {
            ProductId = productId;
            ProductName = productName;
            TotalSold = totalSold;
        }
    }
}
