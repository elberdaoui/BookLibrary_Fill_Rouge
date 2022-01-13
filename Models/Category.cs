using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace BookLibrary_Fill_Rouge.Models
{
    public class Category
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public string Id { get; set; }

        [Required, Display(Name = "Category Name")]
        public string CategoryName { get; set; }

        [Required]
        public string Description { get; set; }

        public Author Author { get; set; }

        public virtual ICollection<BookCategory> Books { get; set; }

        [NotMapped]
        public string BooksId { get; set; }
    }
}
