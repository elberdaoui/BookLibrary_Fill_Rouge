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
    public class AuthorsController : ControllerBase
    {
        private readonly IAuthorService _author;

        public AuthorsController(IAuthorService author)
        {
            _author = author;
        }

        [HttpGet("Authors")]
        public List<Author> authors()
        {
            return _author.Authors();
        }

        [HttpPost("CreateAuthor")]
        public ActionResult<Author> CreateAuthor([FromForm]Author author, IFormFile image)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            else
            {
                _author.CreateAuthor(author, image);
                return Ok(author);
            }
        }

        [HttpPut("EditAuthor/{id}")]
        public ActionResult<Author> EditAuthor(string id, [FromForm] Author author, IFormFile image)
        {
            _author.EditAuthor(id, author, image);
            return Ok(author);
        }

        [HttpDelete("DeleteAuthor/{id}")]
        public async Task<IActionResult> DeleteAuthor(string id)
        {
            _author.DeleteAuthor(id);
            return Ok("Delete successfully");
        }
    }
}
