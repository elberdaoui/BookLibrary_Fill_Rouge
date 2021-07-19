using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using BookLibrary_Fill_Rouge.Models;

namespace BookLibrary_Fill_Rouge.Interfaces
{
    interface IAuthService
    {
        Task<Auth> Register(Register register);
        Task<Auth> Login(Login login);
        Task<string> UserToRoleAssign(UserToRole userRole);
    }
}
