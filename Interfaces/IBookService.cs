using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using BookLibrary_Fill_Rouge.Models;
using Microsoft.AspNetCore.Http;

namespace BookLibrary_Fill_Rouge.Interfaces
{
    public interface IBookService
    {
        List<Book> GetBooks();
        Book CreateBook(Book book, IFormFile image);
        //Task<Book> CreateOrUpdate(string? id);
        string DeleteBook(string id);
        //Task<Book> EditBook(Book book, string id, IFormFile image);
        Book EditBook(Book book, string id, IFormFile image);
    }
}
