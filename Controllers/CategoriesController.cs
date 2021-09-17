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
    public class CategoriesController : ControllerBase
    {
        private readonly ICategoryService _categoryService;

        public CategoriesController(ICategoryService categoryService)
        {
            _categoryService = categoryService;
        }

        [HttpGet("Categories")]
        public List<Category> GetCategories()
        {
            return _categoryService.GetCategories();
        }

        [HttpPost("CreateCategory")]
        public IActionResult CreateCategory(Category category)
        {
            if (TryValidateModel(!ModelState.IsValid))
            {
                return BadRequest(ModelState);
            }
            _categoryService.CreateCategory(category);
            return Ok(category);
        }

        [HttpPut("EditCategory/{id}")]
        public IActionResult EditCategory(string id, [FromBody] Category category)
        {
            if (ModelState.IsValid)
            {
                _categoryService.UpdateCategory(id, category);
                return Ok(category);
            }
            else
            {
                return BadRequest(ModelState);
            }
        }

        [HttpDelete("DeleteCategory/{id}")]
        public IActionResult DeleteCategory(string id)
        {
            _categoryService.DeleteCategory(id);
            return Ok("Category deleted successfully");
        }
    }
}
