using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BookLibrary_Fill_Rouge.Models
{
    public class BookCategory
    {
        public string BooksId { get; set; }
        public Book Book { get; set; }
        public string CategoriesId { get; set; }
        public Category Category { get; set; }
    }
}
