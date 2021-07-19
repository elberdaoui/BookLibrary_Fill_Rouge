using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace BookLibrary_Fill_Rouge.Models
{
    public class Rate
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public string Id { get; set; }

        public string Title { get; set; }

        public DateTime RatingDate { get; set; }
        public string Description { get; set; }
        public int RatingValue { get; set; }
        public Book Book { get; set; }
        public ICollection<User> Users { get; set; }
    }
}
