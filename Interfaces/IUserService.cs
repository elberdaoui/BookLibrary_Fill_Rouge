using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using BookLibrary_Fill_Rouge.Models;

namespace BookLibrary_Fill_Rouge.Interfaces
{
    interface IUserService
    {
        Task<IEnumerable<Register>> GetUser();
        Task<Register> EditUser(Register register, string id);
        Task<string> DeleteUser(string id);
    }
}
