using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using BookLibrary_Fill_Rouge.Models;

namespace BookLibrary_Fill_Rouge.Interfaces
{
    public interface ICategoryService
    {
        List<Category> getCategories();
        Category createCategory(Category category);
        Category updatCategory(string id, Category category);
        Task<string> DeleteCategory(string id);
    }
}
