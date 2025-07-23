using CodingChallenge.Models;

namespace CodingChallenge.Interfaces
{
    public interface IFruitsRepository
    {
        Task<IEnumerable<Fruit>> GetAllFruitsAsync();
    }
}