using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class Product
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string Detail { get; set; }
        public int OldPrice { get; set; }
        public int NewPrice { get; set; }
        public int CateId { get; set; }
        public int BrandId { get; set; }

        public Product(int id, string name, string description, string detail, int oldPrice, int newPrice, int cateId, int brandId)
        {
            Id = id;
            Name = name;
            Description = description;
            Detail = detail;
            OldPrice = oldPrice;
            NewPrice = newPrice;
            CateId = cateId;
            BrandId = brandId;
        }

        public Product(string name, string description, string detail, int oldPrice, int newPrice, int cateId, int brandId)
        {
            Name = name;
            Description = description;
            Detail = detail;
            OldPrice = oldPrice;
            NewPrice = newPrice;
            CateId = cateId;
            BrandId = brandId;
        }
    }
}
