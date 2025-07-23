using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;
using CodingChallenge.Interfaces;
using CodingChallenge.Models;

namespace CodingChallenge.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class FruitsController : ControllerBase
    {
        private readonly IFruitsRepository _fruitsRepository;

        public FruitsController(IFruitsRepository fruitsRepository)
        {
            _fruitsRepository = fruitsRepository;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Fruit>>> GetFruits()
        {
            var fruits = await _fruitsRepository.GetAllFruitsAsync();
            return Ok(fruits);
        }
    }
}