using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace BookLibrary_Fill_Rouge.Models
{
    public class Register
    {
        [Required]
        public string FirstName { get; set; }

        [Required]
        public string LastName { get; set; }

        [Required]
        public string UserName { get; set; }

        [Required]
        public string Email { get; set; }

        [Required, JsonIgnore]
        public string Password { get; set; }

        //[Required]
        [JsonIgnore]
        public byte[] Photo { get; set; }
    }
}
