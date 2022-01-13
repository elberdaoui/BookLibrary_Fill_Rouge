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

        public List<Book> GetBooksByCategory(string id)
        {
            var booksByCat = _context.Categories
                .Include(b => b.Books)
                .ThenInclude(y => y.Book).FirstOrDefault(x => x.Id == id);
            //var booksByCat = _context.Books.Include(b => b.Categories)
            //    .ThenInclude(y => y.Book)
            //    .Where(x => x.CategoriesId == id).ToList();
            //var booksByCat = _context.Books.Include(b => b.Categories).ToList();
            //var booksByCat = _context.Categories.Include(b => b.Id == id).FirstOrDefault();
            //var booksss = booksByCat.ForEach((e) => e.Books);
            //var bbg = _context.BookCategory.Where(bc => bc.CategoriesId == id).ToList();
            //var books = _context.Books.FirstOrDefault(b => b.Id == booksByCat.)
            List<Book> books = new();
            foreach (var bookCategory in booksByCat.Books)
            {
                books.Add(_context.Books.FirstOrDefault(b => b.Id == bookCategory.BooksId));
                //books.Add(bookCategory.);

            }

            return books;
        }

        public Book CreateBook(Book book, IFormFile image)
        {
            BookCategory bc = new();
            if (book != null)
            {
                MemoryStream ms = new MemoryStream();
                 image.CopyToAsync(ms);
                book.PhotoCover = ms.ToArray();
                //book.CategoriesId ;
                //bk.Id = book.Id;
                
                _context.Add(book);
                bc.CategoriesId = book.CategoriesId;
                bc.BooksId = book.Id;
                _context.Add(bc);
                _context.SaveChanges();
                return book;
                
            }
            else
            {
                return null;
            }

        }

        public Book EditBook(Book book, string id, IFormFile image)
        {
            if (id == null)
            {
                return null;
            }
            var findBook = _context.Books.FirstOrDefault(b => b.Id == id);
            var findCategory = _context.BookCategory.FirstOrDefault(bc => bc.BooksId == id);

            if (findBook != null)
            {
                MemoryStream ms = new MemoryStream();
                image.CopyToAsync(ms);
                findBook.PhotoCover = ms.ToArray();
                findBook.BookName = book.BookName;
                findBook.Description = book.Description;
                findBook.Price = book.Price;
                //findBook.CategoriesId = findBook.CategoriesId; //await _context.Categories.FirstOrDefaultAsync(c => c.Id == book.Id);
                _context.Update(findBook);
                //findCategory.CategoriesId = findBook.CategoriesId;
                //findCategory.BooksId = findBook.Id;
                
                //_context.Update(findCategory);
                _context.SaveChanges();
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

        public string DeleteBook(string id)
        {
            //var books = new Book();
            var book = _context.Books.FirstOrDefault(b =>b.Id == id);
            if (book != null)
            {
                var del = _context.Remove(book);
                _context.SaveChanges();
                return del.State == EntityState.Deleted ? $"the Book {book.BookName} has been deleted" : $"Something went wrong";
            }
            else
            {
                return null;
            }

        }
    }
}
