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
    public class UserController : ControllerBase
    {
        private readonly IUserService _userService;
        private readonly IAuthService _authService;


        public UserController(IUserService userService, IAuthService authService)
        {
            _userService = userService;
            _authService = authService;
        }


        [HttpGet("Users")]
        public async Task<IEnumerable<Register>> GetUser()
        {
            return await _userService.GetUser();
        }

        [HttpPost("CreateUser")]
        public async Task<IActionResult> CreateUser([FromForm] Register register, IFormFile image)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var isRegistered = await _authService.Register(register, image);
            if (!isRegistered.IsAuthenticated)
            {
                return BadRequest(isRegistered.Message);
            }

            return Ok(isRegistered);
        }

        [HttpPut("EditUser/{id}")]
        public async Task<IActionResult> EditUser([FromBody] Register register, string id)
        {
            var user = await _userService.EditUser(register, id);
            return Ok(user);
        }

        [HttpDelete("{id}")]
        public async Task<string> DeleteUser(string id)
        {
            return await _userService.DeleteUser(id);
        }
    }
}
