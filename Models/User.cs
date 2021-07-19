using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;

namespace BookLibrary_Fill_Rouge.Models
{
    public class User : IdentityUser
    {
        [Display(Name = "First Name")]
        [Required]
        public string FirstName { get; set; }


        [Display(Name = "Last Name")]
        [Required]
        public string LastName { get; set; }


        [Display(Name = "Phone Number")]
        [Required]
        public string Phone { get; set; }


        [Required]
        public string Address { get; set; }
    }
}
