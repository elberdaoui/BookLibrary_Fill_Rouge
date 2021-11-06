using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using BookLibrary_Fill_Rouge.Models;
using Microsoft.AspNetCore.Http;

namespace BookLibrary_Fill_Rouge.Interfaces
{
    public interface IAuthService
    {
        Task<Auth> Register(Register register, IFormFile image);
        Task<Auth> Login(Login login);
        Task<string> UserToRoleAssign(UserToRole userRole);
    }
}
