using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace BookLibrary_Fill_Rouge.Models
{
    public class Book
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public string Id { get; set; }

        [Required, Display(Name = "Book Name")]
        public string BookName { get; set; }

        [Required]
        public string Description { get; set; }

        [Required, Display(Name = "Published Date")]
        public DateTimeOffset PublishedDate { get; set; }

        [Required]
        public decimal Price { get; set; }

        [Display(Name = "Photo Cover")]
        public byte[] PhotoCover { get; set; }

        public bool IsFav { get; set; }

        public float Rating { get; set; }

        public int Quantity { get; set; }
        public ICollection<Category> Categories { get; set; }

        [NotMapped]
        public string CategoriesId { get; set; }
    }
}
