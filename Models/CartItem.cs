using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace BookLibrary_Fill_Rouge.Models
{
    public class CartItem
    {
        //[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        //public string Id { get; set; }

        public string CartId { get; set; }
        public int Quantity { get; set; }
        public string bookId { get; set; }
        public virtual Book Book { get; set; }
    }
}
