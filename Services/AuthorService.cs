using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using BookLibrary_Fill_Rouge.Interfaces;
using BookLibrary_Fill_Rouge.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;

namespace BookLibrary_Fill_Rouge.Services
{
    public class AuthorService : IAuthorService
    {
        private readonly UserContext _context;

        public AuthorService(UserContext context)
        {
            _context = context;
        }

        public List<Author> Authors()
        {
            return _context.Authors.ToList();
        }

        public Author CreateAuthor(Author author, IFormFile image)
        {
            if (author != null && image != null)
            {
                MemoryStream ms = new MemoryStream();
                image.CopyToAsync(ms);
                author.Photo = ms.ToArray();
                _context.Add(author);
                _context.SaveChanges();
                return author;
            }
            else
            {
                return null;
            }
        }

        public Author EditAuthor(string id, Author author, IFormFile image)
        {
            var findAuthor = _context.Authors.FirstOrDefault(a => a.Id == id);
            if (findAuthor != null)
            {
                findAuthor.AuthorName = author.AuthorName;
                findAuthor.Bio = author.Bio;
                findAuthor.Birthdate = author.Birthdate;
                MemoryStream ms = new MemoryStream();
                image.CopyToAsync(ms);
                findAuthor.Photo = ms.ToArray();
                _context.Update(findAuthor);
                _context.SaveChanges();
                return findAuthor;

            }
            else
            {
                return null;
            }
        }

        public string DeleteAuthor(string id)
        {
            var findAuthor = _context.Authors.FirstOrDefault(a => a.Id == id);
            _context.Authors.Remove(findAuthor);
            _context.SaveChanges();
            return $"Author {findAuthor.AuthorName} has been deleted";
        }
    }
}
