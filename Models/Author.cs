using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace BookLibrary_Fill_Rouge.Models
{
    public class Author
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public string Id { get; set; }

        [Required, Display(Name = "Author Name")]
        public string AuthorName { get; set; }

        [Required, Display(Name = "Biography")]
        public string Bio { get; set; }

        [Required]
        public DateTimeOffset Birthdate { get; set; }

        [Required]
        public string Photo { get; set; }


        public ICollection<Book> Books { get; set; }
    }
}
