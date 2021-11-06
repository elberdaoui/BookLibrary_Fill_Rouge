using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using BookLibrary_Fill_Rouge.Interfaces;
using BookLibrary_Fill_Rouge.Models;

namespace BookLibrary_Fill_Rouge.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BooksController : ControllerBase
    {
        private readonly IBookService _bookService;

        public BooksController(IBookService bookService)
        {
            _bookService = bookService;
        }

        [HttpGet("Books")]
        public List<Book> GetBooks()
        {
            return _bookService.GetBooks();
        }

        [HttpPost( "CreateBook")]
        public IActionResult CreateBook([FromForm]Book book, IFormFile image)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            _bookService.CreateBook(book, image);
            return Ok(book);
        }


        [HttpPut("EditBook/{id}")]
        public IActionResult EditBook(string id, [FromForm]Book book, IFormFile image)
        {
            _bookService.EditBook(book, id, image);
            return Ok(book);
        }

        [HttpDelete("DeleteBook/{id}")]
        public IActionResult DeleteBook(string id)
        {
            _bookService.DeleteBook(id);
            return Ok("Deleted successfully");
        }
    }
}
