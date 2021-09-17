using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using BookLibrary_Fill_Rouge.Interfaces;
using BookLibrary_Fill_Rouge.Models;
using Microsoft.EntityFrameworkCore;

namespace BookLibrary_Fill_Rouge.Services
{
    public class CategoryService : ICategoryService
    {
        private readonly UserContext _context;

        public CategoryService(UserContext context)
        {
            _context = context;
        }

        public List<Category> GetCategories()
        {
            return _context.Categories.ToList();
        }

        public Category CreateCategory(Category category)
        {
            if (category != null)
            {
                _context.Add(category);
                _context.SaveChanges();
                return category;
            }
            else
            {
                return null;
            }
        }

        public Category UpdateCategory(string id, Category category)
        {
            var fingCategory = _context.Categories.FirstOrDefault(c => c.Id == id);
            if (fingCategory != null)
            {
                fingCategory.CategoryName = category.CategoryName;
                fingCategory.Description = category.Description;
                fingCategory.BooksId = fingCategory.BooksId;
                _context.Update(fingCategory);
                _context.SaveChanges();
                return fingCategory;
            }
            else
            {
                return null;
            }
        }

        public async Task<string> DeleteCategory(string id)
        {
            var category = _context.Categories.FirstOrDefault(b => b.Id == id);
            if (category != null)
            {
                var delCat = _context.Categories.Remove(category);
                await _context.SaveChangesAsync();
                return delCat.State == EntityState.Deleted ? $"the Book {category.CategoryName} has been deleted" : $"Something went wrong";
            }
            else
            {
                return null;
            }
        }
    }
}
