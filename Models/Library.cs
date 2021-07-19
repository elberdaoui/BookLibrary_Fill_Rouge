using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace BookLibrary_Fill_Rouge.Models
{
    public class Library
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public string Id { get; set; }

        public bool Isloan { get; set; }

        public string LoanPeriod { get; set; }

        public bool IsSold { get; set; }

        public ICollection<Book> Books { get; set; }

        public User User { get; set; }

    }
}
