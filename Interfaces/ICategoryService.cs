using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using BookLibrary_Fill_Rouge.Models;

namespace BookLibrary_Fill_Rouge.Interfaces
{
    public interface ICategoryService
    {
        List<Category> GetCategories();
        Category CreateCategory(Category category);
        Category UpdateCategory(string id, Category category);
        Task<string> DeleteCategory(string id);
    }
}
