using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace BookLibrary_Fill_Rouge.Models
{
    public class Payment
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public string Id { get; set; }

        public DateTime PayDate { get; set; }
        public string Details { get; set; }
        public decimal Total { get; set; }
        public User User { get; set; }
        public ICollection<Book> Books { get; set; }
    }
}
