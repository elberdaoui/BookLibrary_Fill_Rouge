using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using BookLibrary_Fill_Rouge.Interfaces;
using BookLibrary_Fill_Rouge.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace BookLibrary_Fill_Rouge.Services
{
    public class BookService : IBookService
    {
        private readonly UserContext _context;
        public Book Book { get; set; }

        public BookService(UserContext context)
        {
            _context = context;
        }

        public List<Book> GetBooks()
        {
            return _context.Books.ToList();
        }

        public Book CreateBook(Book book)
        {
            if (book == null)
            {
                return null;
            }
            else
            {
                _context.Add(book);
                _context.SaveChanges();
                return book;
            }

        }

        public async Task<Book> EditBook(Book book, string id, IFormFile image)
        {
            var findBook = _context.Books.FirstOrDefault(b => b.Id == id);

            if (findBook != null)
            {
                findBook.BookName = book.BookName;
                findBook.Description = book.Description;
                findBook.Price = book.Price;
                findBook.CategoriesId = findBook.CategoriesId; //await _context.Categories.FirstOrDefaultAsync(c => c.Id == book.Id);
                MemoryStream ms = new MemoryStream();
                await image.CopyToAsync(ms);
                findBook.PhotoCover = ms.ToArray();
                _context.Update(findBook);
                await _context.SaveChangesAsync();
                return findBook;

            }
            else
            {
                return null;
            }
        }

        //public Task<Book> CreateOrUpdate(string? id)
        //{
        //    Book = new Book();
            
        //        if (Book.Id == null)
        //        {
        //            _context.Add(Book);
        //        }
        //        else
        //        {
        //            _context.Update(Book);
        //        }
        //        _context.SaveChanges();
        //        return Book;
        //    throw new NotImplementedException();
        //}

        public async Task<string> DeleteBook(string id)
        {
            //var books = new Book();
            var book = _context.Books.FirstOrDefault(b =>b.Id == id);
            if (book != null)
            {
                var del = _context.Remove(book);
                await _context.SaveChangesAsync();
                return del.State == EntityState.Deleted ? $"the Book {book.BookName} has been deleted" : $"Something went wrong";
            }
            else
            {
                return null;
            }

        }
    }
}
