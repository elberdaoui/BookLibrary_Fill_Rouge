using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using BookLibrary_Fill_Rouge.Models;
using Microsoft.AspNetCore.Http;

namespace BookLibrary_Fill_Rouge.Interfaces
{
    public interface IAuthorService
    {
        public List<Author> Authors();
        public Author CreateAuthor(Author author, IFormFile image);
        public Task<Author> EditAuthor(string id, Author author, IFormFile image);
        public string DeleteAuthor(string id);
    }
}
